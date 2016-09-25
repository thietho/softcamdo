<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frmItem" id="frmItem" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="error" style="display:none"></div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Nhóm sản phẩm</label>
                        <select id="group" name="group" class="form-control">
                            <option value=""></option>
                            <?php foreach($groups as $group){ ?>
                            <option value="<?php echo @$group['groupid']?>"><?php echo @$group['groupname']?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tên sản phẩm</label>
                        <input type="text" name="itemname" value="<?php echo @$item['itemname']?>" class="form-control"/>
                    </div>

                    <div class="form-group">
                        <label>Hảng sản xuất</label>
                        <select id="brand" name="brand" class="form-control">
                            <option value=""></option>
                            <?php foreach($brand as $it){ ?>
                            <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Link thao khảo</label>
                        <input type="text" name="link" value="<?php echo @$item['link']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Trạng thái</label>
                        <select id="status" name="status" class="form-control">
                            <option value=""></option>
                            <?php foreach($status as $it){ ?>
                            <option value="<?php echo @$it['categoryid']?>"><?php echo @$it['categoryname']?></option>
                            <?php } ?>
                        </select>
                    </div>

                </div>
                <div class="col-md-6">
                    <div id="iteminfo">
                        <?php foreach($data_info as $info){ ?>
                        <div class="info" infoid="<?php echo $info['id']?>">
                            <div class="form-group col-md-5">
                                <input type="text" name="infoname[]" class="form-control" value="<?php echo $info['infoname']?>" placeholder="Tiêu đề"/>
                            </div>
                            <div class="form-group col-md-5">
                                <input type="text" name="infovalue[]" class="form-control" value="<?php echo $info['infovalue']?>" placeholder="Nội dung"/>
                            </div>
                            <div class="form-group col-md-2">
                                <button type="button" class="btn btn-danger form-control btnRemove"><span class="fa fa-trash"></span></button>
                            </div>
                        </div>



                        <?php } ?>
                    </div>
                    <button type="button" class="btn btn-primary" id="btnAddInfo"><span class="fa fa-plus"></span> Thêm thông tin</button>
                    <input type="hidden" id="delinfoid" name="delinfoid">
                </div>
                <div class="form-group text-center col-md-12">
                    <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                    <button type="button" onclick="window.location = '?route=addon/group'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>
                </div>


            </form>
        </div>
    </div>
</div>
<script language="javascript">
function save()
{
    $.blockUI({ message: "<h1>Please wait...</h1>" });

    $.post("?route=core/items/save", $("#frmItem").serialize(),
            function(data){
                if(data == "true")
                {
                    window.location = "?route=core/items";
                }
                else
                {

                    $('#error').html(data).show('slow');


                }
                $.unblockUI();
            }
    );
}
$('#btnAddInfo').click(function () {
    $('#iteminfo').append($('#infotemplate').html());
})
$('#frmItem .btnRemove').click(function () {
    var infoid = $(this).parents('.info').attr('infoid');
    $('#delinfoid').val($('#delinfoid').val() + "," +infoid );
    alert($('#delinfoid').val());
    $(this).parents('.info').remove();
});
$('#brand').val("<?php echo $item['brand']?>");
$('#group').val("<?php echo $item['group']?>");
$('#status').val("<?php echo $item['status']?>");

</script>
<div id="infotemplate" style="display: none">
    <div class="info">
        <div class="form-group col-md-5">
            <input type="text" name="infoname[]" class="form-control" placeholder="Tiêu đề"/>
        </div>
        <div class="form-group col-md-5">
            <input type="text" name="infovalue[]" class="form-control" placeholder="Nội dung"/>
        </div>
        <div class="form-group col-md-2">
            <button type="button" class="btn btn-danger form-control btnRemove"><span class="fa fa-trash"></span></button>
        </div>
    </div>

</div>
