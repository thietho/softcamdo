<?php
class ControllerModuleCategory extends Controller
{
	public function getList($categoryid,$template)
	{
		$this->load->model('core/category');
		$this->data['datas'] = array();
		$this->model_core_category->getTree($categoryid,$this->data['datas']);
		unset($this->data['datas'][0]);
		$this->id="category";
		$this->template=$template['template'];
		$this->render();
	
	}
	public function getListChild()
	{
		$this->load->model('core/category');
		$categoryid = @$this->request->get['categoryid'];
		$child = array();
		if($categoryid)
			$child = @$this->model_core_category->getChild($categoryid);
		@$this->data['output'] = json_encode($child);
		
		@$this->id="donvi";
		@$this->template="common/output.tpl";
		@$this->render();
	}
}
?>