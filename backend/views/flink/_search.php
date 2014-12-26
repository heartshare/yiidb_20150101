<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/**
 * @var yii\web\View $this
 * @var common\models\FlinkSearch $model
 * @var yii\widgets\ActiveForm $form
 */
?>

<div class="flink-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'id') ?>

    <?= $form->field($model, 'url') ?>

    <?= $form->field($model, 'webname') ?>

    <?= $form->field($model, 'weblogo') ?>

    <?= $form->field($model, 'dayip') ?>

    <?php // echo $form->field($model, 'pr') ?>

    <?php // echo $form->field($model, 'msg') ?>

    <?php // echo $form->field($model, 'name') ?>

    <?php // echo $form->field($model, 'qq') ?>

    <?php // echo $form->field($model, 'email') ?>

    <?php // echo $form->field($model, 'typeid') ?>

    <?php // echo $form->field($model, 'ischeck') ?>

    <?php // echo $form->field($model, 'ordernumber') ?>

    <?php // echo $form->field($model, 'createtime') ?>

    <div class="form-group">
        <?= Html::submitButton(Yii::t('backend', 'Search'), ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton(Yii::t('backend', 'Reset'), ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
