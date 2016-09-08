<?php
class ControllerPageHome extends Controller
{
	function __construct() 
	{
		//$this->iscache = true;
		$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="PageHome".implode("_",$arr);
	 	
   	}
	public function index()
	{	

		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/home";
		$this->render();
	}
}
?>