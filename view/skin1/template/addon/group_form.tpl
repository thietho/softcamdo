<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frm" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="error" style="display:none"></div>
                <div>
                    <div class="form-group">
                        <label>Mã nhóm</label>
                        <input type="text" name="groupid" value="<?php echo @$item['groupid']?>" class="form-control" <?php echo $readonly?>/>
                    </div>
                    <div class="form-group">
                        <label>Tên nhóm</label>
                        <input type="text" name="groupname" value="<?php echo @$item['groupname']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Lãi xuất</label>
                        <input type="text" name="rate" value="<?php echo @$item['rate']?>" class="form-control"/>
                    </div>

                </div>
                <center>
                    <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                    <button type="button" onclick="window.location = '?route=addon/group'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>


                </center>

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
                        $.unblockUI();

                    }

                }
        );
    }


</script>
