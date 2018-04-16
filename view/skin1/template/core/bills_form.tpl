<?php if($_GET['type']!="popup"){ ?>
<div id="page-wrapper">
<?php } ?>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frmBills" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="alert alert-danger" style="display:none"></div>
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group" >
                        <label>Ngày</label>
                        <input type="text" name="createdate" value="<?php echo $this->date->formatMySQLDate(@$item['createdate'])?>" class="form-control datepicker"/>
                    </div>
                    <label>Thu/chi từ</label>
                    <div class="form-group input-group">

                        <input type="hidden" id="cardid" name="cardid" value="<?php echo @$item['cardid']?>">
                        <input type="text" id="fullname" name="fullname" value="<?php echo @$item['fullname']?>" class="form-control"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" id="btnSearchCustomer"><i class="fa fa-search"></i></button>
                        </span>
                    </div>
                    <div class="form-group">
                        <label>Loại phiếu</label>
                        <select id="billtype" name="billtype" class="form-control">
                            <?php foreach($this->document->billtype as $key => $type){ ?>
                            <option value="<?php echo $key?>"><?php echo $type?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tài khoản</label>
                        <select id="accountid" name="accountid" class="form-control">
                            <?php foreach($datas as $it){ ?>
                            <option value="<?php echo @$it['accountid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['accountid']?> - <?php echo @$it['accountname']?></option>
                            <?php } ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Số tiền</label>
                        <input type="text" name="amount" value="<?php echo @$item['amount']?>" class="form-control number"/>
                    </div>
                    <div class="form-group">
                        <label>Ghi chú</label>
                        <textarea class="form-control" name="notes"><?php echo @$item['notes']?></textarea>
                    </div>

                    <div class="form-group text-center">
                        <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                        <button type="button" onclick="window.location = '?route=core/bills'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>
                    </div>
                </div>




            </form>
        </div>
    </div>
<?php if($_GET['type']!="popup"){ ?>
</div>
<?php } ?>
<script language="javascript">
function save()
{
    $.blockUI({ message: "<h1>Please wait...</h1>" });

    $.post("?route=core/bills/save", $("#frmBills").serialize(),
            function(data){
                if(data == "true")
                {
                    window.location = "?route=core/bills";
                }
                else
                {

                    $('#error').html(data).show('slow');
                    $.unblockUI();

                }

            }
    );
}
function Bills()
{
    this.searchCustomer = function()
    {
        $("#customerpopup").modal({show: true});
        $("#customerpopup .modal-dialog").css("width","80%");
        $("#customerpopup .modal-body").html(loading);
        $("#customerpopup .modal-body").load("?route=core/cards&type=popup",function(){
            $( document ).ajaxComplete(function(){
                $(".selectCustomer").click(function(){
                    $("#frmBills #cardid").val($(this).attr('id'));
                    $("#frmBills #fullname").val($(this).attr('fullname'));

                });
            });

        });
    }
}
var bills = new Bills();
$('#accountid').val("<?php echo $item['accountid']?>");
$('#frmBills #btnSearchCustomer').click(function(){
    bills.searchCustomer();
});
</script>
<div class="modal fade" id="customerpopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>