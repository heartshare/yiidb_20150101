<?php

use yii\helpers\Html;

/**
 * @var yii\web\View $this
 * @var common\models\Flink $model
 */

$this->title = Yii::t('backend', 'Create {modelClass}', [
    'modelClass' => 'Flink',
]);
$this->params['breadcrumbs'][] = ['label' => Yii::t('backend', 'Flinks'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="flink-create">
    <div class="page-header">
        <h1><?= Html::encode($this->title) ?></h1>
    </div>
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
