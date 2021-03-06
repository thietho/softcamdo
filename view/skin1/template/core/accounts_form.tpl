<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

            </h1>
        </div>

        <!-- /.col-lg-12 -->

        <div class="col-lg-12">
            <form name="frm" id="frmCat" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<?php echo @$item['id']?>">
                <div id="error" class="alert alert-danger" style="display:none">
                    <div class="panel-heading">
                        Errors
                    </div>
                    <div class="panel-body"></div>
                </div>
                <div class="form-group">
                    <label><?php echo @$text_accountid ?></label>
                    <input type="text" name="accountid" value="<?php echo @$item['accountid']?>" class="form-control" <?php echo @$readonly?>/>
                </div>
                <div class="form-group">
                    <label><?php echo @$text_categroyname ?></label>
                    <input type="text" name="accountname" value="<?php echo @$item['accountname']?>" class="form-control" />
                </div>
                <div class="form-group">
                    <label><?php echo @$text_category_parent?></label>
                    <select id="parent" name="parent" class="form-control">
                        <?php foreach($datas as $it){ ?>
                        <option value="<?php echo @$it['accountid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['accountid']?> - <?php echo @$it['accountname']?></option>
                        <?php } ?>
                    </select>
                </div>
                <center>
                    <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                    <button type="button" onclick="window.location = '?route=core/accounts'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>


                </center>
            </form>

        </div>
    </div>
</div>

<?php
	$parent =$item['parent'];
	if($_GET['parent'] !="")
    	$parent = $_GET['parent'];

?>
<script language="javascript">
    function save()
    {
        $.blockUI({ message: "<h1><?php echo $lang['announ_infor']?></h1>" });

        $.post("?route=core/accounts/save", $("#frmCat").serialize(),
                function(data){
                    if(data == "true")
                    {
                        window.location = "?route=core/accounts";
                    }
                    else
                    {

                        $('#error .panel-body').html(data);
                        $('#error').show('slow');
                        $.unblockUI();

                    }

                }
        );
    }
    $(document).ready(function() {

        $("#parent").val("<?php echo @$parent?>");


    });

</script>
