<?php

use yii\helpers\Html;

/**
 * @var yii\web\View $this
 * @var common\models\FlinkType $model
 */

$this->title = Yii::t('backend', 'Create {modelClass}', [
    'modelClass' => 'Flink Type',
]);
$this->params['breadcrumbs'][] = ['label' => Yii::t('backend', 'Flink Types'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="flink-type-create">
    <div class="page-header">
        <h1><?= Html::encode($this->title) ?></h1>
    </div>
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
