<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

                <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Thêm</button>
                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


            </h1>
        </div>

        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="frm_itemssearch">
                        <div class="form-group col-md-3">
                            <label>Tên sản phẩm</label>
                            <input type="text" name="itemname" value="<?php echo @$item['itemname']?>" class="form-control"/>
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
                            <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-filter"></span> Tìm</button>
                            <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success">Tất cả</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- /.row -->
    <div class="row">

        <div class="col-lg-12">
            <div class="panel panel-default">

                <div class="panel-body">
                    <div class="dataTable_wrapper">
                        <form action="" method="post" id="listitem" name="listitem">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                <tr>
                                    <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Hảng sản xuất</th>
                                    <th>Nhóm</th>
                                    <th>Tình trạng</th>
                                    <th>Control</th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php
                                    foreach($datas as $item)
                                    {
                                ?>
                                <tr>
                                    <td><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
                                    <td><?php echo @$item['itemname']?></td>
                                    <td class="number"><?php echo $this->string->numberFormate($item['price'])?></td>
                                    <td><?php echo $this->document->getCategory($item['brand'])?></td>
                                    <td><?php echo $this->document->getGroup($item['group'])?></td>
                                    <td><?php echo $this->document->getCategory($item['status'])?></td>
                                    <td class="text-center">
                                        <button type="button" onClick="window.location = '<?php echo @$item['link_edit']?>'" class="btn btn-default btn-bg btn-success"><span class="fa pencil-square-o"></span> <?php echo @$item['text_edit']?></button>
                                    </td>
                                </tr>

                                <?php } ?>

                                </tbody>
                            </table>
                        </form>
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
    function deleteitem()
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
</script>