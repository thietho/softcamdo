<?php
class ControllerAddonRequest extends Controller
{
	private $error = array();
	public function index()
	{
		//print_r($_SESSION);
		$this->document->breadcrumb .= " » Yêu cầu tư vấn";
		$this->document->title .= " » Yêu cầu tư vấn";
		$this->data['skinstatus'] = array("Khô","Dầu","Nhại cảm","Hổn hợp dầu","Hổn hợp khô","Da yếu","Da mụn","Da mỏng");
		$this->id="content";
		$this->template="addon/request.tpl";
		$this->render();
	}
	
	public function send()
	{
		$data = $this->request->post;
		
		if(@$this->validateForm($data))
		{
			$this->load->model("addon/request");
			$data['birthday'] = $this->date->formatViewDate($data['birthday']);
			$data['skinstatus'] = $this->string->arrayToString($data['skinstatus']);
			$data['datesend'] = $this->date->getToday();
			$data['id'] = $this->model_addon_request->save($data);
			print_r($data);
		}
		else
		{
			foreach($this->error as $item)
			{
				@$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		
		
    	if(trim($data['fullname']) == "")
		{
      		$this->error['fullname'] = "Bạn chưa nhập họ tên!";
    	}
		
		if(trim($data['phone']) =="")
		{
      		$this->error['phone'] = "Bạn chưa nhập số điện thoại";
    	}
		if(trim($data['address']) =="")
		{
      		$this->error['address'] = "Bạn chưa nhập địa chỉ";
    	}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>