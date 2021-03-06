<?php
ini_set("memory_limit","1500M");
date_default_timezone_set('Asia/Ho_Chi_Minh');
include('system/config/directory.php');
include(DIR_SYSTEM.'config/config.php');
include(DIR_SYSTEM.'config/startup.php');
// Front Controller
$controller = new Front();
// Login
$controller->addPreAction(new Action('common/login', 'checkLogin'));

// Permission
//$controller->addPreAction(new Action('common/permission', 'checkPermission'));

// Router
if (isset($request->get['route'])) {
    $action = new Router($request->get['route']);
} else {
    $action = new Action('page/home', 'index');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found', 'index'));

// Output
$response->output();
?>