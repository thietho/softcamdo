<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frmInvoices" method="post" enctype="multipart/form-data">


                <input type="hidden" id="id" name="id" value="<?php echo @$item['id']?>"/>
                <input type="hidden" id="invoicenumber" name="invoices[invoicenumber]" value="<?php echo @$item['invoicenumber']?>"/>
                <div id="error" class="alert alert-danger" style="display:none"></div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin khách hàng
                        </div>
                        <div class="panel-body">
                            <div class="form-group input-group">
                                <input type="hidden" id="cardid" name="cards[id]" value="<?php echo @$item['cardid']?>"/>
                                <input type="text" id="fullname" name="cards[fullname]" value="<?php echo @$item['fullname']?>" class="form-control" placeholder="Họ và tên"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="btnSearchCustomer"><i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group input-group">

                                <input type="text" id="idnumber" name="cards[idnumber]" value="<?php echo @$item['idnumber']?>" class="form-control" placeholder="Số CMND"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="btnGetCustomerByIdNumber"><i class="fa fa-send"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group" >

                                <input type="text" id="iddate" name="cards[iddate]" value="<?php echo $this->date->formatMySQLDate(@$item['iddate'])?>" class="form-control datepicker" placeholder="Ngày cấp"/>
                            </div>
                            <div class="form-group">

                                <input type="text" id="idlocation" name="cards[idlocation]" value="<?php echo @$item['idlocation']?>" class="form-control" placeholder="Nơi cấp"/>
                            </div>
                            <div class="form-group">

                                <input type="text" id="phone" name="cards[phone]" value="<?php echo @$item['phone']?>" class="form-control" placeholder="Số điện thoại"/>
                            </div>
                            <div class="form-group">
                                <input type="text" id="address" name="cards[address]" value="<?php echo @$item['address']?>" class="form-control" placeholder="Địa chỉ"/>
                            </div>
                            <div class="form-group">

                                <input type="text" id="email" name="cards[email]" value="<?php echo @$item['email']?>" class="form-control" placeholder="Email"/>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin tài sản phẩm
                        </div>
                        <div class="panel-body">
                            <div class="form-group input-group">
                                <input type="hidden" id="itemid" name="invoices[itemid]" value="<?php echo @$item['itemid']?>"/>
                                <input type="text" id="itemname" name="invoices[itemname]" value="<?php echo @$item['itemname']?>" class="form-control" placeholder="Tên sản phẩm"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" id="btnSearchItems"><i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group">

                                <input type="text" id="itemnumber" name="invoices[itemnumber]" value="<?php echo @$item['itemnumber']?>" class="form-control" placeholder="Số IMEI"/>
                            </div>
                            <div class="form-group">
                                <label>Giá hiện tại</label>
                                <input type="text" id="pricenow" name="invoices[pricenow]" value="<?php echo @$item['pricenow']?>" class="form-control number"/>
                            </div>

                            <div class="form-group">

                                <select id="group" name="invoices[group]" class="form-control">
                                    <option value="">Nhóm sản phẩm</option>
                                    <?php foreach($groups as $group){ ?>
                                    <option value="<?php echo @$group['groupid']?>"><?php echo @$group['groupname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group">

                                <select id="status" name="invoices[status]" class="form-control">
                                    <option value="">Trạng thái</option>
                                    <?php foreach($status as $it){ ?>
                                    <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group">

                                <input type="text" id="link" name="invoices[link]" value="<?php echo @$item['link']?>" class="form-control" placeholder="Link thao khảo"/>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-lg-3" id="iteminfo">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin nhóm sản phẩm
                        </div>
                    </div>
                </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin phiếu
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label>Từ ngày</label>
                                <input type="text" id="createdate" name="invoices[createdate]" value="<?php echo $this->date->formatMySQLDate(@$item['createdate'])?>" class="form-control datepicker"/>
                            </div>
                            <div class="form-group">
                                <label>Đến ngày</label>
                                <input type="text" id="deallinedate" name="invoices[deallinedate]" value="<?php echo $this->date->formatMySQLDate(@$item['deallinedate'])?>" class="form-control datepicker"/>
                            </div>
                            <label>Lãi xuất</label>
                            <div class="form-group input-group" >

                                <input type="text" id="rate" name="invoices[rate]" value="<?php echo @$item['rate']?>" class="form-control number"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-percent"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Số tiền cầm</label>
                                <input type="text" id="amount" name="invoices[amount]" value="<?php echo @$item['amount']?>" class="form-control number"/>
                            </div>
                            <div class="form-group">
                                <label>Số tiền cầm</label>
                                <input type="text" id="numberexpirydate" name="invoices[numberexpirydate]" value="<?php echo @$item['numberexpirydate']?>" class="form-control number"/>
                            </div>
                            <div class="form-group">
                                <label>Ghi chú</label>
                                <textarea id="notes" name="invoices[notes]" class="form-control"><?php echo @$item['notes']?></textarea>
                            </div>
                            <div class="form-group">
                                <label>Lưu trữ</label>
                                <select id="storage" name="invoices[storage]" class="form-control">
                                    <option value="">Chọn tủ</option>
                                    <?php foreach($storage as $it){ ?>
                                    <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-12">

                    <div class="form-group text-center">
                        <button type="button" onClick="save('')" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                        <button type="button" onClick="save('print')" class="btn btn-default btn-bg btn-success"><span class="fa fa-print"></span> Print</button>
                        <button type="button" onclick="window.location = '?route=addon/invoices'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>
                    </div>
                </div>




            </form>
        </div>
    </div>
</div>
<?php if($item['itemid'] != ""){ ?>
<script language="JavaScript">
    $.getJSON("?route=core/items/getItems&id=<?php echo $item['itemid'] ?>", function (data) {
        $('#frmInvoices #status').val(data.status);
        $('#frmInvoices #link').val(data.link);
    });
</script>
<?php } ?>
<script language="javascript">
    function save(type)
    {
        $.blockUI({ message: "<h1>Please wait...</h1>" });
        $.post("?route=addon/invoices/save", $("#frmInvoices").serialize(),
                function(data){
                    var obj = $.parseJSON(data);
                    if(obj.error == "")
                    {
                        switch(type)
                        {
                            case "":
                                window.location = "?route=addon/invoices";
                                break;
                            case "print":
                                invoice.print(obj.id);

                                break;
                        }

                    }
                    else
                    {

                        $('#error').html(obj.error).show('slow');
                        $.unblockUI();

                    }

                }
        );
    }
    $('#brand').val("<?php echo $item['brand']?>");
    $('#group').val("<?php echo $item['group']?>");
    $('#status').val("<?php echo $item['status']?>");

    $('#group').change(function(){
        if(this.value!="")
        {
            $('#iteminfo').load("?route=addon/invoices/getItemGroupInfo&group="+this.value+"&invoiceid=<?php echo $item['id']?>",function(){
                numberReady();
            });
            $.getJSON("?route=addon/group/getGroup&groupid="+this.value, function (data) {
                $('#frmInvoices #rate').val(data.rate);
            });

        }
        else
        {
            $('#iteminfo').html('<div class="panel panel-default"><div class="panel-heading">Thông tin nhóm sản phẩm </div></div>')
        }
    });
function Invoices()
{
    this.searchItems = function ()
    {
        $("#customerpopup").modal({show: true});
        $("#customerpopup .modal-dialog").css("width","80%");
        $("#customerpopup .modal-body").html(loading);
        $("#customerpopup .modal-body").load("?route=core/items&type=popup",function(){
            $( document ).ajaxComplete(function(){
                $(".selectItems").click(function(){
                    $("#frmInvoices #itemid").val($(this).attr('id'));
                    $("#frmInvoices #itemname").val($(this).attr('itemname'));
                    $("#frmInvoices #pricenow").val($(this).attr('price'));

                    $("#frmInvoices #group").val($(this).attr('group')).change();
                    $("#frmInvoices #link").val($(this).attr('link'));
                    $("#frmInvoices #status").val($(this).attr('status'));
                    numberReady();
                });
            });

        });
    }
    this.searchCustomer = function()
    {
        $("#customerpopup").modal({show: true});
        $("#customerpopup .modal-dialog").css("width","80%");
        $("#customerpopup .modal-body").html(loading);
        $("#customerpopup .modal-body").load("?route=core/cards&type=popup",function(){
            $( document ).ajaxComplete(function(){
                $(".selectCustomer").click(function(){
                    $("#frmInvoices #cardid").val($(this).attr('id'));
                    $("#frmInvoices #fullname").val($(this).attr('fullname'));
                    $("#frmInvoices #idnumber").val($(this).attr('idnumber'));
                    $("#frmInvoices #idlocation").val($(this).attr('idlocation'));
                    $("#frmInvoices #iddate").val($(this).attr('iddate'));
                    $("#frmInvoices #phone").val($(this).attr('phone'));
                    $("#frmInvoices #address").val($(this).attr('address'));
                    $("#frmInvoices #email").val($(this).attr('email'));
                });
            });

        });
    }
    this.print = function(id)
    {
        $("#invoiceviewpopup").modal({show: true});
        $("#invoiceviewpopup .modal-dialog").css("width","80%");
        $("#invoiceviewpopup .modal-body").html(loading);
        $("#invoiceviewpopup .modal-body").load("?route=addon/invoices/view&id="+id+"&type=popup");
        $("#invoiceviewpopup").on('hidden.bs.modal', function () {
            $.unblockUI();
        });
    }
    this.getCustomerByIdNumber = function(idnumber)
    {
        $.getJSON("?route=core/cards/getCards&col=idnumber&val="+idnumber,function(data){
            if(data.length>0) {
                $("#frmInvoices #cardid").val(data[0].id);
                $("#frmInvoices #fullname").val(data[0].fullname);
                $("#frmInvoices #idnumber").val(data[0].idnumber);
                $("#frmInvoices #idlocation").val(data[0].idlocation);
                $("#frmInvoices #iddate").val(data[0].iddate);
                $("#frmInvoices #phone").val(data[0].phone);
                $("#frmInvoices #address").val(data[0].address);
                $("#frmInvoices #email").val(data[0].email);
            }
            else
            {
                alert("Không tồn tại số chứng minh này");
            }
        });
    }

}
    var invoice = new Invoices();
    $('#frmInvoices #btnSearchCustomer').click(function(){
        invoice.searchCustomer();
    });
    $('#frmInvoices #btnGetCustomerByIdNumber').click(function(){
        invoice.getCustomerByIdNumber($('#frmInvoices #idnumber').val());
    });
    $('#frmInvoices #idnumber').keyup(function(e){

        if(e.keyCode == 13)
        {
            invoice.getCustomerByIdNumber(this.value);
        }
    });
    $('#frmInvoices #btnSearchItems').click(function(){
        invoice.searchItems();
    });
    $("#frmInvoices #group").val("<?php echo $item['group']?>").change();
    $("#frmInvoices #storage").val("<?php echo $item['storage']?>");


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
<div class="modal fade" id="invoiceviewpopup" role="dialog">
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