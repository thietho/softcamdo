<?php
class ControllerPageDetail extends Controller
{
	private $breadcrumb = array();
	function __construct() 
	{
		//$this->iscache = true;
		$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="Pagedetail_".implode("_",$arr);
		
   	}
	public function index()
	{
		@$this->document->sitemapid = $this->request->get['sitemapid'];
		$this->data['module'] = $this->loadModule('addon/'.$this->document->sitemapid);
		$this->id="content";
		$this->template="page/detail.tpl";
		$this->layout="layout/detail";
		$this->render();
	}
}
?>