<?php
class ControllerAddonHistoryorder extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= ' » <a href="'.$this->document->createLink('member').'">Thông tin thành viên </a> » '."Lịch sử mua hàng";
		$this->document->title .= " - Lịch sử mua hàng";
		$this->getList();
		$this->id="content";
		$this->template="addon/historyorder.tpl";
		$this->render();
	}
	
	private function getList()
	{
		$this->load->model("core/user");
		$this->data['member'] = $this->member->data;
		$this->load->model("addon/order");
		$where = "AND userid = '".$this->data['member']['username']."'";
		$this->data['orders'] = $this->model_addon_order->getList($where);
	}
}
?>