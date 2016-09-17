<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frm" method="post" enctype="multipart/form-data">


                <input type="hidden" name="id" value="<?php echo @$item['id']?>"/>
                <div id="error" class="error" style="display:none"></div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin khách hàng
                        </div>
                        <div class="panel-body">
                            <div class="form-group">

                                <input type="text" name="fullname" value="<?php echo @$item['fullname']?>" class="form-control" placeholder="Họ và tên"/>
                            </div>
                            <div class="form-group input-group">

                                <input type="text" name="idnumber" value="<?php echo @$item['idnumber']?>" class="form-control" placeholder="Số CMND"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group" >

                                <input type="text" name="iddate" value="<?php echo $this->date->formatMySQLDate(@$item['iddate'])?>" class="form-control datepicker" placeholder="Ngày cấp"/>
                            </div>
                            <div class="form-group">

                                <input type="text" name="idlocation" value="<?php echo @$item['idlocation']?>" class="form-control" placeholder="Nơi cấp"/>
                            </div>
                            <div class="form-group">

                                <input type="text" name="phone" value="<?php echo @$item['phone']?>" class="form-control" placeholder="Số điện thoại"/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="address" value="<?php echo @$item['address']?>" class="form-control" placeholder="Địa chỉ"/>
                            </div>
                            <div class="form-group">

                                <input type="text" name="email" value="<?php echo @$item['email']?>" class="form-control" placeholder="Email"/>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin tài sản
                        </div>
                        <div class="panel-body">
                            <div class="form-group input-group">

                                <input type="text" name="itemname" value="<?php echo @$item['itemname']?>" class="form-control" placeholder="Tên sản phẩm"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                            <div class="form-group">

                                <input type="text" name="valuenow" value="<?php echo @$item['itemnumber']?>" class="form-control" placeholder="Số IMEI"/>
                            </div>
                            <div class="form-group">
                                <label>Giá hiện tại</label>
                                <input type="text" name="valuenow" value="<?php echo @$item['valuenow']?>" class="form-control number"/>
                            </div>
                            <div class="form-group">

                                <select id="brand" name="brand" class="form-control">
                                    <option value="">Hảng sản xuất</option>
                                    <?php foreach($brand as $it){ ?>
                                    <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group">

                                <select id="group" name="group" class="form-control">
                                    <option value="">Nhóm sản phẩm</option>
                                    <?php foreach($groups as $group){ ?>
                                    <option value="<?php echo @$group['groupid']?>"><?php echo @$group['groupname']?></option>
                                    <?php } ?>
                                </select>
                            </div>
                            <div class="form-group">

                                <input type="text" name="link" value="<?php echo @$item['link']?>" class="form-control" placeholder="Link thao khảo"/>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Thông tin phiếu
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label>Từ ngày</label>
                                <input type="text" name="createdate" value="<?php echo @$item['createdate']?>" class="form-control datepicker"/>
                            </div>
                            <div class="form-group">
                                <label>Đến ngày</label>
                                <input type="text" name="deallinedate" value="<?php echo $this->date->formatMySQLDate(@$item['deallinedate'])?>" class="form-control datepicker"/>
                            </div>
                            <div class="form-group" >
                                <label>Lãi xuất</label>
                                <input type="text" name="rate" value="<?php echo @$item['rate']?>" class="form-control number"/>
                            </div>
                            <div class="form-group">
                                <label>Số tiền cầm</label>
                                <input type="text" name="amount" value="<?php echo @$item['amount']?>" class="form-control number"/>
                            </div>

                        </div>

                    </div>
                </div>
                <div class="col-md-12">

                    <div class="form-group text-center">
                        <button type="button" onClick="save()" class="btn btn-default btn-bg btn-success"><span class="fa fa-floppy-o"></span> Save</button>
                        <button type="button" onclick="window.location = '?route=addon/group'" class="btn btn-default btn-bg btn-success"><span class="fa fa-undo  "></span> Quay lại</button>
                    </div>
                </div>




            </form>
        </div>
    </div>
</div>
<script language="javascript">
    function save()
    {
        $.blockUI({ message: "<h1>Please wait...</h1>" });

        $.post("?route=core/items/save", $("#frm").serialize(),
                function(data){
                    if(data == "true")
                    {
                        window.location = "?route=core/items";
                    }
                    else
                    {

                        $('#error').html(data).show('slow');
                        $.unblockUI();

                    }

                }
        );
    }
    $('#brand').val("<?php echo $item['brand']?>");
    $('#group').val("<?php echo $item['group']?>");
    $('#status').val("<?php echo $item['status']?>");
</script>
