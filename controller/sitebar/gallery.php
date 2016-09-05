<?php
class ControllerSitebarGallery extends Controller
{
	function __construct() 
	{
		//$this->iscache = true;
		/*$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;*/
	 	$this->name ="SitebarGallery";
   	}
	public function index()
	{
		if(@$this->cachehtml->iscacht($this->name) == false)
		{
			//San pham moi
			//$this->load->model('core/sitemap');
			$this->load->model('core/media');
			$this->load->helper('image');
			$template = array(
								  'template' => "sitebar/product_list.tpl",
								  'width' => 60,
								  'height' =>60,
								  'widthpreview' => 450,
								  'heightpreview' =>450
								  );
						  
			$arrbrandid = array(
								"Guerlain",
								"Sisley",
								/*"Chanel",
								"Dior",*/
								
								"EsteeLauder",
								"Lancome",
								"Clarins",
								"Clinique",
								"Shiseido",
								"VictoriaSecrect",
								"LOccitane"
								);			  
			$this->data['views'] = array();
			foreach($arrbrandid as $brandid)
			{
				$medias = $this->getSanPhanMoi("sortsanphammoi".$brandid);
				$arr = array('',0,'',$template,$medias);
				$media = $this->model_core_media->getItem(SITEID."cat".$brandid);
				@$this->data['views'][$brandid]['logo'] = HelperImage::resizePNG($media['imagepath'],190,190);
				$this->data['views'][$brandid]['title'] = $this->document->getCategory($brandid);
				$this->data['views'][$brandid]['link'] = $this->document->createLink('brand',$brandid);
				//$this->data['views'][$brandid]['data'] = $this->loadModule('module/productlist','getAll',$arr);
			}
		}
		
		$this->id="content";
		$this->template="sitebar/gallery1.tpl";
		$this->render();
	}
	function getSanPhanMoi($code)
	{
		$this->load->model('core/sitemap');
		$this->load->model('core/media');
		$data_media = array();
		$listmediaid = $this->model_core_media->getInformation($code,"sort");
		$arrmediaid = array();
		
		$arrmediaid = $this->string->referSiteMapToArray($listmediaid);
		foreach($arrmediaid as $mediaid)
		{
			$media = $this->model_core_media->getItem($mediaid);
			if(@$media['status']== 'active')
				$data_media[] = $media;
		}
			
		return $data_media;
		
	}

}
?>