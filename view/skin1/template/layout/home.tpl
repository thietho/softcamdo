<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>style.css" rel="stylesheet">

    <!-- Bootstrap Core CSS -->
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>bootstrap.css" rel="stylesheet">
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>bootstrap-datepicker.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>metisMenu.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>sb-admin-2.css" rel="stylesheet">



    <!-- Custom Fonts -->
    <link href="<?php echo HTTP_SERVER.DIR_CSS?>font-awesome.css" rel="stylesheet" type="text/css">
    <!-- jQuery -->
    <script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?php echo HTTP_SERVER.DIR_JS?>bootstrap.js"></script>
    <script src="<?php echo HTTP_SERVER.DIR_JS?>bootstrap-datepicker.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<?php echo HTTP_SERVER.DIR_JS?>metisMenu.js"></script>



    <!-- Custom Theme JavaScript -->
    <script src="<?php echo HTTP_SERVER.DIR_JS?>sb-admin-2.js"></script>
    <script src="<?php echo HTTP_SERVER.DIR_JS?>jquery.blockUI.js"></script>
    <script src="<?php echo HTTP_SERVER.DIR_JS?>common.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script language="javascript">
        var HTTP_SERVER = '<?php echo HTTP_SERVER?>';
        var DIR_COMPONENT = '<?php echo HTTP_SERVER.DIR_COMPONENT?>';
        var loading = '<div class="text-center"><img src="<?php echo HTTP_SERVER.DIR_IMAGE?>loading.gif"></div>';
        $(document).ready(function(){

        });

    </script>
</head>

<body>

<div id="wrapper">
    <?php if($this->user->isLogged()){ ?>
    <!-- Navigation -->
    <?php echo @$header?>
    <?php } ?>
    <?php echo @$content?>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->



</body>

</html>
