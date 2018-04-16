<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><?php echo @$this->document->title?></h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <span class="fa fa-plus"></span> Thêm phiếu
                </div>
                <div class="panel-body">
                    <?php foreach($groups as $group){ ?>
                    <button class="btn btn-primary" onclick="window.location='?route=addon/invoices/insert&group=<?php echo $group['groupid']?>'"><span class="fa fa-plus"></span> <?php echo $group['groupname']?></button>
                    <?php } ?>
                </div>

            </div>
        </div>
        <div class="col-lg-6">
            <div class="panel panel-green">
                <div class="panel-heading">
                    <span class="fa fa-folder-open"></span> Theo đõi
                </div>
                <div class="panel-body">

                    <button class="btn btn-success" onclick="window.location='?route=addon/invoices/getList'"><span class="fa fa-sign-in"></span> Xem</button>

                </div>

            </div>
        </div>
    </div>
</div>