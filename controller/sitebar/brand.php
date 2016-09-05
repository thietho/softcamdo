<?php
class ControllerSitebarBrand extends Controller
{
	public function index()
	{
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->data['data_brand'] = $this->model_core_category->getChild('nhanhieu');
		$this->id="content";
		$this->template="sitebar/brand.tpl";
		$this->render();
	}
}
?>