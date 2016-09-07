<?php
class ControllerLayoutDetail extends Controller
{
	public function index()
	{
        $this->template="layout/detail.tpl";
        $this->children=array(
            'common/header',

        );
		$this->render();

	}
}
?>