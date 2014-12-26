<?php

use yii\helpers\Html;
use kartik\grid\GridView;
use yii\widgets\Pjax;
use yii\helpers\ArrayHelper;
use \common\models\FlinkType;
/**
 * @var yii\web\View $this
 * @var yii\data\ActiveDataProvider $dataProvider
 * @var common\models\FlinkSearch $searchModel
 */

$this->title = Yii::t('backend', 'Flinks');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="flink-index">
    <!--<div class="page-header">
            <h1><?= Html::encode($this->title) ?></h1>
    </div>-->
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?php /* echo Html::a(Yii::t('backend', 'Create {modelClass}', [
    'modelClass' => 'Flink',
]), ['create'], ['class' => 'btn btn-success'])*/  ?>
    </p>

    <?php Pjax::begin(); echo GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            [
                'class' => 'yii\grid\CheckboxColumn',
            ],

            'id',
            'webname',
            'url:url',
            //'weblogo',
            [
                'attribute' => 'weblogo',
                'format' => 'html',
                'value' => function($data) { return Html::img($data->weblogo, ['width'=>'100']); },
            ],
            //'dayip',
            'createtime:datetime',
//            'pr', 
//            'msg', 
//            'name', 
//            'qq', 
//            'email:email', 
            //'typeid', 
            [
                'attribute'=>'typeid',
                'value'=>function($data){
                    return FlinkType::items($data->typeid);
                },
                'filter'=> ArrayHelper::map(FlinkType::find()->all(), 'id', 'typename')
            ],
            //'ischeck', 
            [
                'class' => '\pheme\grid\ToggleColumn',
                'attribute' => 'ischeck',
                'filter' => [1 => Yii::t('common', 'Yes'), 0 => Yii::t('common', 'No')],
            ],
            'ordernumber', 
            [
                'class' => 'yii\grid\ActionColumn',
                'buttons' => [
                'update' => function ($url, $model) {
                                    return Html::a('<span class="glyphicon glyphicon-pencil"></span>', Yii::$app->urlManager->createUrl(['flink/view','id' => $model->id,'edit'=>'t']), [
                                                    'title' => Yii::t('yii', 'Edit'),
                                                  ]);}

                ],
            ],
        ],
        'responsive'=>true,
        'hover'=>true,
        'condensed'=>true,
        'floatHeader'=>true,
        'striped' => false,
        'pjax' => true,
        'pjaxSettings'=>[
            'neverTimeout'=>true,
            'beforeGrid'=>'My fancy content before.',
            'afterGrid'=>'My fancy content after.',
        ],
        'panel' => [
            'heading'=>'<h3 class="panel-title"><i class="glyphicon glyphicon-th-list"></i> '.Html::encode($this->title).' </h3>',
            'type'=>'info',
            //'after'=>Html::a('<i class="glyphicon glyphicon-plus"></i> Add Friend Links', ['create'], ['class' => 'btn btn-success']),
            'before'=>
            Html::a('<i class="glyphicon glyphicon-plus"></i> Create Friend Links', ['create'], ['class' => 'btn btn-success']). ' '.
            Html::a('<i class="glyphicon glyphicon-repeat"></i> Reset List', ['index'], ['class' => 'btn btn-info']),
            
        ],
    ]); Pjax::end(); ?>

</div>
