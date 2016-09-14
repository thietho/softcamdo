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
                <div id="frmsearchitems" class="panel-body">

                    <div class="form-group col-md-3">
                        <label>Tên sản phẩm</label>
                        <input type="text" id="itemname" name="itemname" value="<?php echo @$item['itemname']?>" class="form-control"/>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Hảng sản xuất</label>
                        <select id="brand" name="brand" class="form-control">
                            <option value=""></option>
                            <?php foreach($brand as $it){ ?>
                            <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Nhóm sản phẩm</label>
                        <select id="group" name="group" class="form-control">
                            <option value=""></option>
                            <?php foreach($groups as $group){ ?>
                            <option value="<?php echo @$group['id']?>"><?php echo @$group['groupname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <label>Trạng thái</label>
                        <select id="status" name="status" class="form-control">
                            <option value=""></option>
                            <?php foreach($status as $it){ ?>
                            <option value="<?php echo @$it['categoryid']?>"><?php echo @$it['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group pull-right">
                        <button onclick="items.search()" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-filter"></span> Tìm</button>
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
                    <div id="loaditemsdata" class="dataTable_wrapper">

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
function Items()
{
    this.deleteitem = function()
    {
        var answer = confirm("Bạn có muốn xóa không?")
        if (answer)
        {
            $.post("?route=addon/group/delete",
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
        $.get("?route=core/items/getData",
                {
                    itemname:$('#frmsearchitems #itemname').val(),
                    brand:$('#frmsearchitems #brand').val(),
                    group:$('#frmsearchitems #group').val(),
                    status:$('#frmsearchitems #status').val()

                },
                function(html){
                    $('#loaditemsdata').html(html);
        });
    }
}
    var items = new Items();
    $(document).ready(function(){
        items.search();
        $('input').change(function(){
            items.search()
        });
        $('select').change(function(){
            items.search();
        });
    });
</script>