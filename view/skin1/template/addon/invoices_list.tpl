<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

                <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Thêm</button>
                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="items.deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


            </h1>
        </div>

        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div id="frmsearchcards" class="panel-body">

                    <div class="form-group col-md-4">
                        <label>Tên khách hàng</label>
                        <input type="text" id="fullname" name="fullname" value="<?php echo @$item['fullname']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-4">
                        <label>Số CMND</label>
                        <input type="text" id="idnumber" name="idnumber" value="<?php echo @$item['idnumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-4">
                        <label>Nơi cấp</label>
                        <input type="text" id="idlocation" name="idlocation" value="<?php echo @$item['idlocation']?>" class="form-control"/>
                    </div>
                    <div class="form-group pull-right">
                        <button onclick="invoices.search()" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-filter"></span> Tìm</button>
                        <button onclick="" type="button" class="btn btn-default btn-bg btn-success">Tất cả</button>
                    </div>

                </div>
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
                    {
                        itemname:$('#frmsearchcards #fullname').val(),
                        brand:$('#frmsearchitems #idnumber').val(),
                        group:$('#frmsearchitems #idlocation').val(),

                    },
                    function(html){
                        $('#loadinvoicesdata').html(html);
                    });
        }
        this.view = function(id)
        {
            $("#invoiceviewpopup").modal({show: true});
            $("#invoiceviewpopup #btnPrint").attr('invoiceid',id);
            $("#invoiceviewpopup .modal-dialog").css("width","80%");
            $("#invoiceviewpopup .modal-body").html(loading);
            $("#invoiceviewpopup .modal-body").load("?route=addon/invoices/view&id="+id+"&type=popup");
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
            $.get('?route=addon/invoices/getBack&id='+id, function (data) {

            })
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
