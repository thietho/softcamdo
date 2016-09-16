<form action="" method="post" id="listitem" name="listitem">
    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
        <thead>
        <tr>
            <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
            <th>Mã phiếu</th>
            <th>Ngày cầm</th>
            <th>Ngày đến hạn</th>
            <th>Giá trị cầm</th>
            <th>Lãi xuất</th>
            <th>Tài sản cầm</th>
            <th>Khách hàng</th>

            <th>Control</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach($datas as $item){ ?>
        <tr>
            <td><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
            <td><?php echo $item['invoiceid']?></td>
            <td><?php echo $this->date->formatMySQLDate($item['createdate'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['deallinedate'])?></td>
            <td><?php echo $item['amount']?></td>
            <td><?php echo $item['rate']?></td>
            <td></td>
            <td>
                Tên: <?php echo $item['fullname']?><br>
                Số CMNDL<?php echo $item['idnumber']?><br>
                Ngày cấp: <?php echo $this->date->formatMySQLDate($item['iddate'])?><br>
                Nơi cấp: <?php echo $item['idlocation']?><br>
                Điện thoại: <?php echo $item['phone']?>
            </td>

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