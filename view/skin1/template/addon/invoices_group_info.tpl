<div class="panel panel-default">
    <div class="panel-heading">
        <?php echo $group['groupname']?>
    </div>
    <div class="panel-body">
        <?php foreach($infos as $key => $val){ ?>
        <div class="form-group">
            <?php $arr = explode(':',$key)?>
            <input type="text" name="info[<?php echo $arr[0]?>]" value="<?php echo $val?>" class="form-control <?php echo $arr[1]?>" placeholder="<?php echo $arr[0]?>"/>
        </div>
        <?php } ?>

    </div>

</div>