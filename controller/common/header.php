<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		$this->id="header";
		$this->template="common/header.tpl";
		$this->render();
	}
    public function logout()
    {
        $this->user->logout();
        $this->data['output'] = 'true';
        $this->id="content";
        $this->template="common/output.tpl";
        $this->render();
    }
}
?>