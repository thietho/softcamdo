<div class="row">
    <div class="form-group col-lg-6">
        <label>Biên nhận:</label>
        <?php echo $item['invoicenumber']?>
    </div>
    <div class="form-group col-lg-6">
        <label>Khách hàng:</label>
        <?php echo $item['fullname']?>
    </div>
    <div class="form-group col-lg-6">
        <label>Tài sản cầm:</label>
        <?php echo $item['itemname']?> <?php echo $item['itemnumber']?>
    </div>
    <div class="form-group col-lg-6">
        <label>Ngày lập phiếu:</label>
        <?php echo $this->date->formatMySQLDate($item['createdate'])?>
    </div>
    <div class="form-group col-lg-6">
        <label>Số tiền cầm:</label>
        <?php echo $this->string->numberFormate($item['amount'])?>
    </div>
</div>
<table class="table table-striped table-bordered table-hover" id="dataTables-example">
    <thead>
    <tr>
        <th>STT</th>
        <th>Thời gian</th>
        <th>Trạng thái</th>
        <th>Ghi chú</th>
    </tr>
    </thead>
    <tbody>
        <?php foreach($data_log as $key => $log ){ ?>
        <tr>
            <td class="text-center"><?php echo $key + 1?></td>
            <td><?php echo $this->date->formatMySQLDate($log['datelog'])?></td>
            <td><?php echo $this->document->invoicesstatus[$log['status']]?></td>
            <td><?php echo $log['notes']?></td>
        </tr>
        <?php } ?>
    </tbody>
</table>
<table class="table table-striped table-bordered table-hover" id="dataTables-example">
    <thead>
    <tr>
        <th>STT</th>
        <th>Thời gian</th>
        <th>Mã Phiếu</th>
        <th>Số tiền</th>
        <th>Ghi chú</th>
    </tr>
    </thead>
    <tbody>
    <?php $sum=0;?>
    <?php foreach($data_bills as $key => $bill ){ ?>
    <tr>
        <td class="text-center"><?php echo $key + 1?></td>
        <td><?php echo $this->date->formatMySQLDate($bill['createdate'])?></td>
        <td><?php echo $bill['billnumber']?></td>
        <td class="number"><?php echo $this->string->numberFormate($bill['amount'])?></td>
        <td><?php echo $bill['notes']?></td>
        <?php $sum +=$bill['amount'];?>
    </tr>
    <?php } ?>
    </tbody>
    <tfoot>
        <td colspan="3" class="text-right">Tổng cộng</td>
        <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
    </tfoot>
</table>
