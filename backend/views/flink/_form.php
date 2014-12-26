<?php

use yii\helpers\Html;
use kartik\widgets\ActiveForm;
use kartik\builder\Form;
use kartik\datecontrol\DateControl;
use yii\helpers\ArrayHelper;
use common\models\FlinkType;
/**
 * @var yii\web\View $this
 * @var common\models\Flink $model
 * @var yii\widgets\ActiveForm $form
 */
?>

<div class="flink-form">

    <?php $form = ActiveForm::begin(['type'=>ActiveForm::TYPE_HORIZONTAL]); 

echo Form::widget([
    'model'=>$model,
    'form'=>$form,
    'columns'=>1,
    'attributes'=>[      
        'webname'=>['type'=>Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter password...']],
        'url'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Url...', 'maxlength'=>60]], 
        'weblogo'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Weblogo...', 'maxlength'=>250]], 
        'typeid'=>['type'=>Form::INPUT_DROPDOWN_LIST, 'items'=>ArrayHelper::map(FlinkType::find()->all(), 'id', 'typename'), 'hint'=>'Type and select state'],
        'ordernumber'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Ordernumber...'],'hint'=>'(数值越小，排列越靠前)'], 
        'ischeck'=>[
            'type'=>Form::INPUT_RADIO_LIST, 
            'items'=>[true=>'正常', false=>'待审'], 
            'options'=>['inline'=>true]
        ],
    
    ]
]);

    //echo Form::widget([

    //    'model' => $model,
    //    'form' => $form,
    //    'columns' => 1,
    //    'attributes' => [

    //            'dayip'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Dayip...', 'maxlength'=>20]], 

    //            'pr'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Pr...']], 

    //            'name'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Name...', 'maxlength'=>10]], 

    //            'qq'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Qq...', 'maxlength'=>11]], 

    //            'ordernumber'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Ordernumber...']], 

    //            'createtime'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Createtime...']], 

    //            'typeid'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Typeid...']], 
                   
    //            'ischeck'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Ischeck...']], 

    //            'url'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Url...', 'maxlength'=>60]], 

    //            'webname'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Webname...', 'maxlength'=>30]], 

    //            'weblogo'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Weblogo...', 'maxlength'=>250]], 

    //            'msg'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Msg...', 'maxlength'=>200]], 

    //            'email'=>['type'=> Form::INPUT_TEXT, 'options'=>['placeholder'=>'Enter Email...', 'maxlength'=>50]], 

    //    ]
    //]);
    
    echo Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']);
    ActiveForm::end(); ?>

</div>
