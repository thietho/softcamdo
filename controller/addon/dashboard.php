<?php
class ControllerAddonDashboard extends Controller
{
	private $error = array();
	public function index()
	{
		
		
		$this->id="content";
		$this->template="addon/dashboard.tpl";
		$this->render();
	}
	
	
}
?>