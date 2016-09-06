<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		
		$this->id="header";
		$this->template="common/header.tpl";
		$this->render();
	}
}
?>