<?php
class ControllerAddonOrtherbrand extends Controller
{
	private $error = array();
	public function index()
	{
		$this->load->model("core/category");
		$this->data['brandother'] = array();
		$this->model_core_category->getTree("brandother",$this->data['brandother']);
		unset($this->data['brandother'][0]);
		
		$this->id="content";
		$this->template="addon/ortherbrand.tpl";
		$this->render();
	}
}
?>