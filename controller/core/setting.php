<?php
/**
 * Class ControllerCoreItems
 *
 */
class ControllerCoreItems extends Controller
{
    private $error = array();
    function __construct()
    {

        $moduleid = $_GET['route'];
        $this->document->title = "Cài đặt hệ thống";


    }
    public function index()
    {

    }
}
