<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>


                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="items.deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


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
                        <input type="text" id="invoicenumber" name="invoicenumber" class="form-control"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Tên tài sản</label>
                        <input type="text" id="itemname" name="itemname" class="form-control"/>
                    </div><div class="form-group col-md-3">
                        <label>Số imei</label>
                        <input type="text" id="itemnumber" name="itemnumber" class="form-control"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Giá trị cầm</label>
                        <input type="text" id="amount" name="amount" class="form-control number"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Từ ngày cầm</label>
                        <input type="text" id="formstartdate" name="formstartdate" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Đến ngày cầm</label>
                        <input type="text" id="tostartdate" name="tostartdate" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Từ ngày hết hạn</label>
                        <input type="text" id="formenddate" name="formenddate" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Đến ngày hết hạn</label>
                        <input type="text" id="toenddate" name="toenddate" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Tên khách hàng</label>
                        <input type="text" id="fullname" name="fullname" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Số CMND</label>
                        <input type="text" id="idnumber" name="idnumber" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Nơi cấp</label>
                        <input type="text" id="idlocation" name="idlocation" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Ngày cấp</label>
                        <input type="text" id="iddate" name="iddate" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Số điện thoại</label>
                        <input type="text" id="phone" name="phone" class="form-control"/>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Địa chỉ</label>
                        <input type="text" id="address" name="address" class="form-control"/>
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
