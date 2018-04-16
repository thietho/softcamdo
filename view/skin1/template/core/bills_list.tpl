<?php if(@$_GET['type']!="popup"){ ?>
<div id="page-wrapper">
<?php } ?>

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

                <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Thêm</button>
                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="bills.deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


            </h1>
        </div>

        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <form id="frmsearchbills" class="panel-body">
                    <div class="form-group col-md-4">
                        <label>Mã phiếu</label>
                        <input type="text" id="billnumber" name="billnumber" value="<?php echo @$item['billnumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-4">
                        <label>Tên khách hàng</label>
                        <input type="text" id="fullname" name="fullname" value="<?php echo @$item['fullname']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-4">
                        <label>Loại</label>
                        <select class="form-control" name="billtype" id="billtype">
                            <option value=""></option>
                            <?php foreach($this->document->billtype as $key => $val){ ?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                    </div>

                    <div class="form-group col-md-4">
                        <label>Từ ngày cầm</label>
                        <input type="text" id="formcreatedate" name="formcreatedate" value="<?php echo @$search['formcreatedate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group col-md-4">
                        <label>Đến ngày cầm</label>
                        <input type="text" id="tocreatedate" name="tocreatedate" value="<?php echo @$search['tocreatedate']?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group pull-right">
                        <button onclick="bills.search()" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-filter"></span> Tìm</button>
                        <button onclick="" type="button" class="btn btn-default btn-bg btn-success">Tất cả</button>
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
                    <div id="loadbillsdata" class="dataTable_wrapper">

                    </div>
                    <!-- /.table-responsive -->

                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
<?php if(@$_GET['type']!="popup"){ ?>
</div>
<?php } ?>
<script language="JavaScript">
    function Bills()
    {
        this.deleteitem = function()
        {
            var answer = confirm("Bạn có muốn xóa không?")
            if (answer)
            {
                $.post("?route=core/bills/delete",
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
            $.get("?route=core/bills/getData",
                    $('#frmsearchbills').serialize(),
                    function(html){
                        $('#loadbillsdata').html(html);
                    });
        }
    }
    var bills = new Bills();
    $(document).ready(function(){
        bills.search();
        $('input').change(function(){
            bills.search()
        });
        $('select').change(function(){
            bills.search();
        });
    });
</script>