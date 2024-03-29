<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\FlinkType;

/**
 * FlinkTypeSearch represents the model behind the search form about `common\models\FlinkType`.
 */
class FlinkTypeSearch extends FlinkType
{
    public function rules()
    {
        return [
            [['id'], 'integer'],
            [['typename'], 'safe'],
        ];
    }

    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    public function search($params)
    {
        $query = FlinkType::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        if (!($this->load($params) && $this->validate())) {
            return $dataProvider;
        }

        $query->andFilterWhere([
            'id' => $this->id,
        ]);

        $query->andFilterWhere(['like', 'typename', $this->typename]);

        return $dataProvider;
    }
}
