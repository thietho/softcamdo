<?php if($_GET['type']!="popup"){ ?>
<div id="page-wrapper">
<?php } ?>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frm" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="alert alert-danger" style="display:none"></div>
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="fullname" value="<?php echo @$item['fullname']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Số CMND</label>
                        <input type="text" name="idnumber" value="<?php echo @$item['idnumber']?>" class="form-control"/>
                    </div>
                    <div class="form-group" >
                        <label>Ngày cấp</label>
                        <input type="text" name="iddate" value="<?php echo $this->date->formatMySQLDate(@$item['iddate'])?>" class="form-control datepicker"/>
                    </div>
                    <div class="form-group">
                        <label>Nơi cấp</label>
                        <input type="text" name="idlocation" value="<?php echo @$item['idlocation']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" value="<?php echo @$item['phone']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ</label>
                        <input type="text" name="address" value="<?php echo @$item['address']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" name="email" value="<?php echo @$item['email']?>" class="form-control"/>
                    </div>

                    <div class="form-group text-center">
                        <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                        <button type="button" onclick="window.location = '?route=addon/group'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>
                    </div>
                </div>




            </form>
        </div>
    </div>
<?php if($_GET['type']!="popup"){ ?>
</div>
<?php } ?>
<script language="javascript">
function save()
{
    $.blockUI({ message: "<h1>Please wait...</h1>" });

    $.post("?route=core/cards/save", $("#frm").serialize(),
            function(data){
                if(data == "true")
                {
                    window.location = "?route=core/cards";
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
