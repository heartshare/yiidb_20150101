<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "{{%flink}}".
 *
 * @property integer $id
 * @property string $url
 * @property string $webname
 * @property string $weblogo
 * @property string $dayip
 * @property integer $pr
 * @property string $msg
 * @property string $name
 * @property string $qq
 * @property string $email
 * @property integer $typeid
 * @property integer $ischeck
 * @property integer $ordernumber
 * @property integer $createtime
 */
class Flink extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%flink}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['dayip', 'pr', 'name', 'qq', 'ordernumber', 'createtime'], 'required'],
            [['pr', 'typeid', 'ischeck', 'ordernumber', 'createtime'], 'integer'],
            [['url'], 'string', 'max' => 60],
            [['webname'], 'string', 'max' => 30],
            [['weblogo'], 'string', 'max' => 250],
            [['dayip'], 'string', 'max' => 20],
            [['msg'], 'string', 'max' => 200],
            [['name'], 'string', 'max' => 10],
            [['qq'], 'string', 'max' => 11],
            [['email'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('common', 'ID'),
            'url' => Yii::t('common', 'Url'),
            'webname' => Yii::t('common', 'Webname'),
            'weblogo' => Yii::t('common', 'Weblogo'),
            'dayip' => Yii::t('common', 'Dayip'),
            'pr' => Yii::t('common', 'Pr'),
            'msg' => Yii::t('common', 'Msg'),
            'name' => Yii::t('common', 'Name'),
            'qq' => Yii::t('common', 'Qq'),
            'email' => Yii::t('common', 'Email'),
            'typeid' => Yii::t('common', 'Typeid'),
            'ischeck' => Yii::t('common', 'Ischeck'),
            'ordernumber' => Yii::t('common', 'Ordernumber'),
            'createtime' => Yii::t('common', 'Createtime'),
        ];
    }
}
