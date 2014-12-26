<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "{{%flink_type}}".
 *
 * @property integer $id
 * @property string $typename
 */
class FlinkType extends \yii\db\ActiveRecord
{
    private static $_items=[];
    
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%flink_type}}';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['typename'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('common', 'ID'),
            'typename' => Yii::t('common', 'Typename'),
        ];
    }

    /**
     * Returns the items for the specified type.
     * @param string item type (e.g. 'PostStatus').
     * @return array item names indexed by item code. The items are order by their position values.
     * An empty array is returned if the item type does not exist.
     */
    public static function items($type)
    {
        if(!isset(self::$_items[$type]))
            self::loadItems($type);
        return self::$_items[$type];
    }
        
    /**
     * Loads the lookup items for the specified type from the database.
     * @param string the item type
     */
    private static function loadItems($type)
    {
        self::$_items[$type]=array();
        $models=self::find()->where(['id'=>$type])->all();
        foreach($models as $model)
            self::$_items[$type]=Yii::t('common', $model->typename);
    }
}
