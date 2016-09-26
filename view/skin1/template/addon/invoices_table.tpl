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
            <th>Trạng thái</th>
            <th>Control</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach($datas as $item){ ?>
        <tr>
            <td>
                <?php if($item['status'] == 'new'){ ?>
                <input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" >
                <?php } ?>
            </td>
            <td><button type="button" class="btn btn-default btn-bg btn-success" onclick="invoices.view(<?php echo @$item['id']?>)"><?php echo $item['invoicenumber']?></button></td>
            <td><?php echo $this->date->formatMySQLDate($item['startdate'])?></td>
            <td><?php echo $this->date->formatMySQLDate($item['enddate'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['amount'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['rate'])?>%</td>
            <td><?php echo $item['itemname']?> - <?php echo $item['itemnumber']?></td>
            <td>
                Tên: <?php echo $item['fullname']?><br>
                Số CMNDL<?php echo $item['idnumber']?><br>
                Ngày cấp: <?php echo $this->date->formatMySQLDate($item['iddate'])?><br>
                Nơi cấp: <?php echo $item['idlocation']?><br>
                Điện thoại: <?php echo $item['phone']?>
                Địa chỉ: <?php echo $item['address']?>
            </td>
            <td><?php echo $this->document->invoicesstatus[$item['status']]?></td>
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