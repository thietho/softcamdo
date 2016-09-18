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
            <td><?php echo $this->date->formatMySQLDate($item['iddate'])?></td>
            <td><?php echo $item['idlocation']?></td>
            <td><?php echo $item['address']?></td>
            <td><?php echo $item['phone']?></td>
            <td class="text-center">
                <?php if(@$_GET['type']=="popup"){ ?>
                <button type="button"
                        id="<?php echo @$item['id']?>"
                        fullname="<?php echo $item['fullname']?>"
                        idnumber="<?php echo $item['idnumber']?>"
                        iddate="<?php echo $this->date->formatMySQLDate($item['iddate'])?>"
                        idlocation="<?php echo $item['idlocation']?>"
                        address="<?php echo $item['address']?>"
                        phone="<?php echo $item['phone']?>"
                        email="<?php echo $item['email']?>"
                        data-dismiss="modal"
                        class="btn btn-default btn-bg btn-success selectCustomer" ><span class="fa fa-check"></span> Chọn</button>
                <?php } ?>
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
<script language="JavaScript">

</script>