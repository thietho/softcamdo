<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<?php echo HTTP_SERVER?>">Cầm đồ Phương Nghi</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <?php
                    end($this->document->invoicestime);
                    $lastKey = key($this->document->invoicestime);
                    ?>
                    <ul class="dropdown-menu dropdown-alerts">
                        <?php foreach($this->document->invoicestime as $key => $statustime){ ?>
                        <li>
                            <a href="?route=addon/invoices/getList&statustime=<?php echo $key?>">
                                <div>
                                    <img src="<?php echo HTTP_SERVER.DIR_IMAGE?><?php echo $key?>.png" width="14px"> <?php echo $statustime?>
                                    <span class="pull-right text-muted small"><?php echo $this->string->numberFormate(count($status[$key]))?></span>
                                </div>
                            </a>
                        </li>
                        <?php if($key != $lastKey){ ?>
                        <li class="divider"></li>
                        <?php }?>
                        <?php } ?>



                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="#" onclick="logout()"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">

                        <li>
                            <a href="<?php echo HTTP_SERVER?>"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="#">Quản lý danh mục<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="?route=core/category">Phân loại</a>
                                </li>
                                <li>
                                    <a href="?route=addon/group">Nhóm tài sản</a>
                                </li>
                                <li>
                                    <a href="?route=core/items">Sản phẩm</a>
                                </li>
                                <li>
                                    <a href="?route=core/cards">Khách hàng</a>
                                </li>
                                <li>
                                    <a href="?route=core/accounts">Danh mục tài khoản</a>
                                </li>
                                <li>
                                    <a href="?route=core/bills">Phiếu thu chi</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li><a href="?route=addon/invoices">Cầm đồ</a></li>
                        <li>
                            <a href="#">Báo cáo thống kê<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="?route=reports/profitdate">Thông kê lợi nhận theo ngày</a>
                                </li>
                                <li>
                                    <a href="?route=reports/products">Thống kê theo loại hàng</a>
                                </li>

                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>