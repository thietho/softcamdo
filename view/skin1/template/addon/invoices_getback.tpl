<form id="frmGetBack" method="post" enctype="multipart/form-data">


    <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>

    <div id="error" class="alert alert-danger" style="display:none"></div>
    <div class="row">
        <div class="form-group col-lg-6">
            <label>Số tiền cầm</label>
            <?php echo $this->string->numberFormate($item['amount'])?>/VNĐ<br>
            <label>Lãi xuất</label>
            <?php echo $this->string->numberFormate($item['rate'])?>%<br>
            <label>Số ngày</label>
            <?php echo $this->string->numberFormate($numdate)?><br>
            <label>Tiền lãi</label>
            <?php echo $this->string->numberFormate($item['amount']*$item['rate']/100/30*$numdate) ?>


        </div>

        <div class="form-group col-lg-6">
            <label>Số tiền chuộc</label>
            <input type="text" id="amount" name="amount" value="<?php echo $this->string->numberFormate($item['amount']*$item['rate']/100/30*$numdate + $item['amount']) ?>" class="form-control number"/>
        </div>
        <div class="form-group col-lg-12">
            <label>Ghi chú</label>
            <textarea name="notes" class="form-control"></textarea>
        </div>
    </div>
</form>
<script language="JavaScript">
    numberReady();
</script>