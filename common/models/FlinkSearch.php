<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Flink;

/**
 * FlinkSearch represents the model behind the search form about `common\models\Flink`.
 */
class FlinkSearch extends Flink
{
    public function rules()
    {
        return [
            [['id', 'pr', 'typeid', 'ischeck', 'ordernumber', 'createtime'], 'integer'],
            [['url', 'webname', 'weblogo', 'dayip', 'msg', 'name', 'qq', 'email'], 'safe'],
        ];
    }

    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    public function search($params)
    {
        $query = Flink::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            // Sort by order number ref : http://stackoverflow.com/questions/22993777/yii2-data-provider-default-sorting
            'sort'=> ['defaultOrder' => ['ordernumber'=>SORT_ASC]] 
        ]);

        if (!($this->load($params) && $this->validate())) {
            return $dataProvider;
        }

        $query->andFilterWhere([
            'id' => $this->id,
            'pr' => $this->pr,
            'typeid' => $this->typeid,
            'ischeck' => $this->ischeck,
            'ordernumber' => $this->ordernumber,
            'createtime' => $this->createtime,
        ]);

        $query->andFilterWhere(['like', 'url', $this->url])
            ->andFilterWhere(['like', 'webname', $this->webname])
            ->andFilterWhere(['like', 'weblogo', $this->weblogo])
            ->andFilterWhere(['like', 'dayip', $this->dayip])
            ->andFilterWhere(['like', 'msg', $this->msg])
            ->andFilterWhere(['like', 'name', $this->name])
            ->andFilterWhere(['like', 'qq', $this->qq])
            ->andFilterWhere(['like', 'email', $this->email]);

        return $dataProvider;
    }
}
