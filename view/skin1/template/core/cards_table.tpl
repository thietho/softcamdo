<form action="" method="post" id="listitem" name="listitem">
    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
        <thead>
        <tr>
            <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
            <th>Tên khách hàng</th>
            <th>Số CMND</th>
            <th>Ngày cấp</th>
            <th>Nơi cấp</th>
            <th>Địa chỉ</th>
            <th>Số điện thoại</th>
            <th>Control</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach($datas as $item){ ?>
        <tr>
            <td><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
            <td><?php echo $item['fullname']?></td>
            <td><?php echo $item['idnumber']?></td>
            <td><?php echo $item['iddate']?></td>
            <td><?php echo $item['idlocation']?></td>
            <td><?php echo $item['address']?></td>
            <td><?php echo $item['phone']?></td>
            <td class="text-center">
                <button type="button" onClick="window.location = '<?php echo @$item['link_edit']?>'" class="btn btn-default btn-bg btn-success"><span class="fa pencil-square-o"></span> <?php echo @$item['text_edit']?></button>
            </td>
        </tr>

        <?php } ?>

        </tbody>
    </table>
    <div class="text-right">
        <?php echo $pager?>
    </div>


</form>