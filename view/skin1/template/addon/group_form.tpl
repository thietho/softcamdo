<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frm" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="alert alert-danger" style="display:none"></div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Mã nhóm</label>
                        <input type="text" name="groupid" value="<?php echo @$item['groupid']?>" class="form-control" <?php echo $readonly?>/>
                    </div>
                    <div class="form-group">
                        <label>Tên nhóm</label>
                        <input type="text" name="groupname" value="<?php echo @$item['groupname']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Lãi xuất mặc định</label>
                        <input type="text" name="rate" value="<?php echo @$item['rate']?>" class="form-control number"/>
                    </div>
                    <label>Chu kỳ</label>
                    <div class="form-group input-group">

                        <input type="text" name="period" value="<?php echo @$item['period']?>" class="form-control number"/>
                        <span class="input-group-addon">Ngày</span>
                    </div>
                    <div class="form-group">
                        <label>Thông tin cần lưu</label>
                        <textarea class="form-control" name="infodes"><?php echo @$item['infodes']?></textarea>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            Cài đặt mức lãi xuất
                        </div>
                        <div id="listrate"></div>
                        <div class="panel-body">
                            <table id="grouplistrate">
                                <?php foreach($listrate as $amount => $rate){ ?>
                                <tr>
                                    <td>
                                        <div class="form-group input-group">
                                            <span class="input-group-addon">>=</span>
                                            <input type="text" name="listamount[]" class="form-control number" value="<?php echo $amount?>" placeholder="Số tiền trong khoản áp dụng"/>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group input-group">

                                            <input type="text" name="listrate[]" class="form-control number" value="<?php echo $rate?>" placeholder="Lãi xuất"/><span class="input-group-addon">%</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="form-group">
                                            <button type="button" class="btn btn-danger form-control btnRemove"><span class="fa fa-trash"></span></button>
                                        </div>
                                    </td>
                                </tr>
                                <?php } ?>
                            </table>

                            <button type="button" class="btn btn-primary form-control" id="btnAddListRate"><span class="fa fa-plus"></span> Thêm mưc lãi xuất</button>


                        </div>

                    </div>
                </div>
                <div class="col-md-12 text-center">
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

        $.post("?route=addon/group/save", $("#frm").serialize(),
                function(data){
                    if(data == "true")
                    {
                        window.location = "?route=addon/group";
                    }
                    else
                    {
                        $('#error').html(data).show('slow');
                    }
                    $.unblockUI();
                }
        );
    }

    $('#btnAddListRate').click(function () {
        $('#grouplistrate').append($('#listratetemplate').html());
        numberReady();
        $('#grouplistrate .btnRemove').click(function (eid) {
            $(this).parents('tr').remove();
        })
    });
    $('#grouplistrate .btnRemove').click(function (eid) {
        $(this).parents('tr').remove();
    })
</script>
<table id="listratetemplate" style="display: none">
    <tr>
        <td>
            <div class="form-group input-group">
                <span class="input-group-addon">>=</span>
                <input type="text" name="listamount[]" class="form-control number" placeholder="Số tiền trong khoản áp dụng"/>
            </div>
        </td>
        <td>
            <div class="form-group input-group">

                <input type="text" name="listrate[]" class="form-control number" placeholder="Lãi xuất"/><span class="input-group-addon">%</span>
            </div>
        </td>
        <td>
            <div class="form-group">
                <button type="button" class="btn btn-danger form-control btnRemove"><span class="fa fa-trash"></span></button>
            </div>
        </td>
    </tr>




</table>