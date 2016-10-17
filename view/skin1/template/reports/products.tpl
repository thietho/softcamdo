<script src="<?php echo HTTP_SERVER.DIR_JS?>canvasjs.min.js"></script>
<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

            </h1>
        </div>

        <!-- /.col-lg-12 -->

        <div class="col-lg-12">
            <form name="frm" id="frmProduct" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">

                <div class="form-group col-lg-4">

                    <input type="text" name="formdate" class="form-control datepicker" placeholder="Từ ngày"/>
                </div>
                <div class="form-group col-lg-4">

                    <input type="text" name="enddate" class="form-control datepicker" placeholder="Đến ngày"/>
                </div>
                <div class="form-group col-lg-4">
                    <button type="button" id="btnShowReport" class="btn btn-default btn-bg btn-success"><span class="fa fa-eye"></span> Xem</button>
                </div>
            </form>

        </div>

        <div id="showreport"></div>
    </div>
</div>



<script language="JavaScript">
    $('#btnShowReport').click(function () {
        $.post("?route=reports/products/showReport",$('#frmProduct').serialize(), function (html) {
            $('#showreport').html(html);
        })
    });
</script>