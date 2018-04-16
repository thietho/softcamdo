<div class="panel panel-default">
    <div class="panel-heading">
        Điện thoại
    </div>
    <div class="panel-body">
        <div class="form-group">
            <input type="text" name="info[type]" value="<?php echo @$info['type']?>" class="form-control" placeholder="Loại xe"/>
        </div>
        <div class="form-group">

            <input type="text" name="info[carid]" value="<?php echo @$info['carid']?>" class="form-control" placeholder="Biển số xe"/>
        </div>
        <div class="form-group">

            <input type="text" name="info[dateregis]" value="<?php echo @$info['dateregis']?>" class="form-control datepicker" placeholder="Ngày đăng ký"/>
        </div>
        <div class="form-group">
            <input type="text" name="info[machineid]" value="<?php echo @$info['machineid']?>" class="form-control" placeholder="Số máy"/>
        </div>
        <div class="form-group">
            <input type="text" name="info[frameid]" value="<?php echo @$info['frameid']?>" class="form-control" placeholder="Số khung"/>
        </div>
        <div class="form-group">
            <input type="text" name="info[color]" value="<?php echo @$info['color']?>" class="form-control" placeholder="Màu sơn"/>
        </div>
        <div class="form-group">
            <input type="text" name="info[attach]" value="<?php echo @$info['attach']?>" class="form-control" placeholder="Kèm"/>
        </div>
    </div>

</div>