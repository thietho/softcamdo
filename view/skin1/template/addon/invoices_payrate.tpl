<form id="frmPayRate" method="post" enctype="multipart/form-data">


    <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>

    <div id="error" class="alert alert-danger" style="display:none"></div>
    <div class="row">
        <div class="form-group col-lg-4">
            <label>Số tiền cầm</label>
            <?php echo $this->string->numberFormate($item['amount'])?>/VNĐ<br>
            <label>Lãi xuất</label>
            <?php echo $this->string->numberFormate($item['rate'])?>%
        </div>
        <div class="form-group col-lg-4">
            <label>Số ngày</label>
            <input type="text" id="numday" name="numday" value="<?php echo $this->string->numberFormate($numdate)?>" class="form-control number"/>
        </div>
        <div class="form-group col-lg-4">
            <label>Số tiền</label>
            <input type="text" id="amount" name="amount" value="" class="form-control number"/>
        </div>
        <div class="form-group col-lg-12">
            <label>Ghi chú</label>
            <textarea name="notes" class="form-control"></textarea>
        </div>
    </div>
</form>
<script language="JavaScript">
    var amount = <?php echo $item['amount']?>;
    var rate = <?php echo $item['rate']?>;
    $('#frmPayRate #amount').val();
    function calulateAmount()
    {
        var numdate = stringtoNumber($('#numday').val());
        return amount*rate/100*numdate/30;
    }
    $('#frmPayRate #amount').val(calulateAmount());
    $('#frmPayRate #numday').keyup(function (e) {
        $('#frmPayRate #amount').val(calulateAmount());
        numberReady();
    });
    numberReady();
</script>