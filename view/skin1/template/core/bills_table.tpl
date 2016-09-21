<form action="" method="post" id="listitem" name="listitem">
    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
        <thead>
        <tr>
            <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
            <th>Mã phiếu</th>
            <th>Ngày tạo</th>
            <th>Tài khoản</th>
            <th>Thu</th>
            <th>Chi</th>
            <th>Ghi chú</th>
            <th>Control</th>
        </tr>
        </thead>
        <tbody>
        <?php foreach($datas as $item){ ?>
        <tr>
            <td><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
            <td><?php echo $item['billnumber']?></td>
            <td><?php echo $this->date->formatMySQLDate($item['createdate'])?></td>
            <td><?php echo $item['accountid']?> - <?php echo $this->document->getAccounts($item['accountid'])?></td>
            <td class="number"><?php if($item['billtype'] == 'collect') echo $this->string->numberFormate($item['amount']); ?></td>
            <td class="number"><?php if($item['billtype'] == 'pay') echo $this->string->numberFormate($item['amount'])?></td>
            <td><?php echo $item['notes']?></td>
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
<script language="JavaScript">

</script>