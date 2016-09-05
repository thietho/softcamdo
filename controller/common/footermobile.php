<?php
class ControllerCommonFootermobile extends Controller
{
	public function index()
	{
		
		
		$this->id="footer";
		$this->template="common/footermobile.tpl";
		$this->render();
	}
}
?>