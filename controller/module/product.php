<?php
class ControllerModuleProduct extends Controller
{
	public function getList()
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		if(@$sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		
		$siteid = $this->user->getSiteId();
		$this->data['sitemaps'] = array();
		$this->model_core_sitemap->getTreeSitemap($sitemapid,$this->data['sitemaps'],$siteid);
		
		$this->id="news";
		$this->template="module/product.tpl";
		$this->render();
	}
	
	public function quickView()
	{
		$template = array(
					  'template' => "module/product_quickview.tpl",
					  'width' => 250,
					  'height' =>250
					  );
		$arr = array($this->document->sitemapid,12,$template);
		@$this->data['output'] = $this->loadModule('module/pagedetail','getFormProduct',$arr);
		
		
		$this->id="quickView";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>