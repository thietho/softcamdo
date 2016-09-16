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