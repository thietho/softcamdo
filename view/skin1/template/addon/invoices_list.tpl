<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

                <?php foreach($groups as $group){ ?>
                <button class="btn btn-primary" onclick="window.location='?route=addon/invoices/insert&group=<?php echo $group['groupid']?>'"><span class="fa fa-plus"></span> <?php echo $group['groupname']?></button>
                <?php } ?>
                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="invoices.deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


            </h1>
        </div>

        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <form id="frmsearchinvoices" class="panel-body">
                    <div class="form-group col-md-3">
                        <label>Mã phiếu</label>
                        <input type="text" id="invoicenumber" name="invoicenumber" value="<?php echo @$search['invoicenumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Tên tài sản</label>
                        <input type="text" id="itemname" name="itemname" value="<?php echo @$search['itemname']?>" class="form-control"/>
                    </div><div class="form-group col-md-3">
                        <label>Số imei</label>
                        <input type="text" id="itemnumber" name="itemnumber" value="<?php echo @$search['itemnumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Giá trị cầm</label>
                        <input type="text" id="amount" name="amount" value="<?php echo @$search['amount']?>" class="form-control number"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Từ ngày cầm</label>
                        <input type="text" id="formstartdate" name="formstartdate" value="<?php echo @$search['formstartdate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Đến ngày cầm</label>
                        <input type="text" id="tostartdate" name="tostartdate" value="<?php echo @$search['tostartdate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Từ ngày hết hạn</label>
                        <input type="text" id="formenddate" name="formenddate" value="<?php echo @$search['formenddate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Đến ngày hết hạn</label>
                        <input type="text" id="toenddate" name="toenddate" value="<?php echo @$search['toenddate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Tên khách hàng</label>
                        <input type="text" id="fullname" name="fullname" value="<?php echo @$search['fullname']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Số CMND</label>
                        <input type="text" id="idnumber" name="idnumber" value="<?php echo @$search['idnumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Nơi cấp</label>
                        <input type="text" id="idlocation" name="idlocation" value="<?php echo @$search['idlocation']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Ngày cấp</label>
                        <input type="text" id="iddate" name="iddate" value="<?php echo @$search['iddate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Số điện thoại</label>
                        <input type="text" id="phone" name="phone" value="<?php echo @$search['phone']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Địa chỉ</label>
                        <input type="text" id="address" name="address" value="<?php echo @$search['address']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Nhóm tài sản</label>
                        <select class="form-control" id="group" name="group">
                            <option value=""></option>
                            <?php foreach($groups as $group){ ?>
                            <option value="<?php echo $group['groupid']?>"><?php echo $group['groupname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Lưu trữ</label>
                        <select id="storage" name="storage" class="form-control">
                            <option value="">Chọn tủ</option>
                            <?php foreach($storage as $it){ ?>
                            <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Trạng thái</label>
                        <select id="status" name="status" class="form-control">
                            <option value=""></option>
                            <?php foreach($this->document->invoicesstatus as $status => $statusname){ ?>
                            <option value="<?php echo $status?>"><?php echo $statusname?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Thời hạn</label>
                        <select id="statustime" name="statustime" class="form-control">
                            <option value=""></option>
                            <?php foreach($this->document->invoicestime as $status => $statusname){ ?>
                            <option value="<?php echo $status?>"><?php echo $statusname?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group pull-right">
                        <button onclick="invoices.search()" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-filter"></span> Tìm</button>
                        <button onclick="invoices.showAll()" type="button" class="btn btn-default btn-bg btn-success">Tất cả</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">

        <div class="col-lg-12">
            <div class="panel panel-default">

                <div class="panel-body">
                    <div id="loadinvoicesdata" class="dataTable_wrapper">

                    </div>
                    <!-- /.table-responsive -->

                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>
<script language="JavaScript">
    $('#frmsearchinvoices #group').val("<?php echo @$search['group']?>");
    $('#frmsearchinvoices #storage').val("<?php echo @$search['storage']?>");
    $('#frmsearchinvoices #status').val("<?php echo @$search['status']?>");
    $('#frmsearchinvoices #statustime').val("<?php echo @$search['statustime']?>");
    function Invoices()
    {
        this.deleteitem = function()
        {
            var answer = confirm("Bạn có muốn xóa không?")
            if (answer)
            {
                $.post("?route=addon/invoices/delete",
                        $("#listitem").serialize(),
                        function(data)
                        {
                            if(data!="")
                            {
                                alert(data);
                                window.location.reload();
                            }
                        }
                );
            }
        }
        this.search = function()
        {
            $.get("?route=addon/invoices/getData",
                    $('#frmsearchinvoices').serialize(),
                    function(html){
                        $('#loadinvoicesdata').html(html);
                    });
        }
        this.showAll = function()
        {
            $('input').val('');
            $('select').val('');
            this.search();
        }
        this.view = function(id)
        {
            $("#invoiceviewpopup").modal({show: true});
            $("#invoiceviewpopup #btnPrint").attr('invoiceid',id);
            $("#invoiceviewpopup .modal-dialog").css("width","80%");
            $("#invoiceviewpopup .modal-body").html(loading);
            $("#invoiceviewpopup .modal-body").load("?route=addon/invoices/view&id="+id+"&type=popup", function () {
                $.getJSON("?route=addon/invoices/getInvoices&id="+id, function (data)
                {
                    $("#invoiceviewpopup #btnStatus").html(data.statustext);
                    switch(data.status)
                    {
                        case 'new':
                            break;
                        case 'payrate':
                            break;
                        case 'getback':
                        case 'payoff':
                            $('#invoiceviewpopup #btnPayRate').hide();
                            $('#invoiceviewpopup #btnGetBack').hide();
                            $('#invoiceviewpopup #btnPayOff').hide();
                            break;

                    }
                })
            });
            $("#invoiceviewpopup").on('hidden.bs.modal', function () {
                invoices.search();
            });
        }
        this.print = function(id)
        {
            openDialog("?route=addon/invoices/view&id="+id+"&type=print",800,500);
        }
        this.payRate = function(id)
        {
            $('#invoicepayratepopup').modal({show:true});
            $('#invoicepayratepopup .modal-body').html(loading);
            $("#invoicepayratepopup .modal-body").load("?route=addon/invoices/payRate&id="+id+"&type=popup");
        }
        this.payRateAction = function()
        {
            $.post("?route=addon/invoices/payRateAction",$('#frmPayRate').serialize(), function (data) {
                var obj = $.parseJSON(data);
                $('#invoicepayratepopup').modal('hide');
                invoices.view(obj.id);


            });
        }
        this.getBack = function(id)
        {
            $('#invoicegetbackpopup').modal({show:true});
            $('#invoicegetbackpopup .modal-body').html(loading);
            $("#invoicegetbackpopup .modal-body").load("?route=addon/invoices/getBack&id="+id+"&type=popup");

        }
        this.getBackAction = function()
        {
            $.post("?route=addon/invoices/getBackAction",$('#frmGetBack').serialize(), function (data) {
                var obj = $.parseJSON(data);
                $('#invoicegetbackpopup').modal('hide');
                $('#invoicegetbackpopup').modal('hide');


            });
        }
        this.payOff = function(id)
        {
            $('#invoicepayoffpopup').modal({show:true});
            $('#invoicepayoffpopup .modal-body').html(loading);
            $("#invoicepayoffpopup .modal-body").load("?route=addon/invoices/payOff&id="+id+"&type=popup");
        }
        this.payOffAction = function()
        {
            $.post("?route=addon/invoices/payOffAction",$('#frmPayOff').serialize(), function (data) {
                var obj = $.parseJSON(data);
                $('#invoicepayoffpopup').modal('hide');
                $('#invoiceviewpopup').modal('hide');


            });
        }
        this.history = function(id)
        {
            $('#invoicehistorypopup').modal({show:true});
            $('#invoicehistorypopup .modal-body').html(loading);
            $("#invoicehistorypopup .modal-body").load("?route=addon/invoices/history&id="+id+"&type=popup");
        }
    }
    var invoices = new Invoices();
    $(document).ready(function(){
        invoices.search();
        $('input').change(function(){
            invoices.search()
        });
        $('select').change(function(){
            invoices.search();
        });
    });
</script>
<div class="modal fade" id="invoiceviewpopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-success" id="btnStatus" onclick="invoices.history($('#btnPrint').attr('invoiceid'))"></button>
                <button type="button" class="btn btn-default" id="btnPayRate" onclick="invoices.payRate($('#btnPrint').attr('invoiceid'))">Đóng lãi</button>
                <button type="button" class="btn btn-default" id="btnGetBack" onclick="invoices.getBack($('#btnPrint').attr('invoiceid'))">Chuộc</button>
                <button type="button" class="btn btn-default" id="btnPayOff" onclick="invoices.payOff($('#btnPrint').attr('invoiceid'))">Thanh lý</button>

                <button type="button" class="btn btn-default" id="btnPrint" onclick="invoices.print($(this).attr('invoiceid'));">In phiếu</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="invoicepayratepopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnPayRateAction" onclick="invoices.payRateAction()">Đóng lãi</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="invoicegetbackpopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnGetBackAction" onclick="invoices.getBackAction()">Chuộc</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="invoicepayoffpopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnPayOffAction" onclick="invoices.payOffAction()">Thanh lý</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
<div class="modal fade" id="invoicehistorypopup" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>

    </div>
</div>
