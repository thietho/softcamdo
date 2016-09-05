<?php
class ControllerSitebarSearchproduct extends Controller
{
	public function index()
	{
		$this->load->model("core/category");
		$this->load->model("core/sitemap");
		$this->data['loaisp'] = array();
		$siteid = $this->member->getSiteId();
		$this->model_core_sitemap->getTreeSitemap("sanpham",$this->data['loaisp'],$siteid);
		unset($this->data['loaisp'][0]);
		
		$this->data['nhomhuong'] = array();
		$this->model_core_category->getTree("nhomhuong",$this->data['nhomhuong']);
		unset($this->data['nhomhuong'][0]);
		
		$this->data['nhanhieu'] = $this->model_core_category->getChild('nhanhieu');
		unset($this->data['nhanhieu'][count($this->data['nhanhieu'])-1]);
		$brandother = $this->model_core_category->getChild('brandother');
		foreach($brandother as $cat)
		{
			$this->data['nhanhieu'][] = $cat;
		}
		
		$this->data['gia'] = array();
		$this->model_core_category->getTree("gia",$this->data['gia']);
		unset($this->data['gia'][0]);
		
		$this->data['status'] = array();
		$this->model_core_category->getTree("status",$this->data['status']);
		unset($this->data['status'][0]);
		
		$this->id="content";		
		$this->template="sitebar/searchproduct.tpl";
		
		$this->render();
	}
	
	
}
?>