<?php
class ControllerAddonMember extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= " » Thông tin thành viên";
		$this->document->title .= " - Thông tin thành viên";
		$this->load->model("core/user");
		$this->data['member'] = $this->member->data;
		$this->id="content";
		$this->template="addon/member.tpl";
		$this->render();
	}
	
}
?>