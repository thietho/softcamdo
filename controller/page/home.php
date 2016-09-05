<?php
class ControllerPageHome extends Controller
{
	function __construct() 
	{
		//$this->iscache = true;
		$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="PageHome".implode("_",$arr);
	 	
   	}
	public function index()
	{
		
		$this->load->model('core/media');
		$this->load->model('core/sitemap');
		$this->load->helper('image');
		$this->destop();
		//$this->mobile();
	}
	
	public function destop()
	{
		if(@$this->cachehtml->iscacht($this->name) == false)
		{
			
			//Brand
			/*$template = array(
						  'template' => "module/category_brand.tpl"
						  );
		
			$arr = array("nhanhieu",$template);
			$this->data['brand'] = $this->loadModule('module/category','getList',$arr);*/
			//Banner home
			$template = array(
						  'template' => "home/banner.tpl",
						  'width' => 980,
						  'height' =>0
						  );
		
			$arr = array("bannerhome",0,"",$template);
			$this->data['bannerhome'] = $this->loadModule('module/block','getList',$arr);
			
			$arr = array("thiet-ke");
			$this->data['thietke'] = $this->loadModule('page/home','getSiteMap',$arr);
			
			$arr = array("in-an-san-xuat");
			$this->data['inansanxuat'] = $this->loadModule('page/home','getSiteMap',$arr);
			
			
			//$this->loadSiteBar();
			
		}
		$this->document->title = $this->document->setup['Title'];
		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/home";
		$this->render();
	}
	
	private function loadSiteBar()
	{
		//Left sitebar
		
		$arr = array('sanpham');
		$this->data['leftsitebar']['produtcategory'] = $this->loadModule('sitebar/catalogue','index',$arr);
		$this->data['leftsitebar']['brand'] = $this->loadModule('sitebar/brand');
		$arr = array('doi-tac');
		$this->data['leftsitebar']['weblink'] = '<div class="head_title"><span>ĐỐI TÁC</span></div>'.$this->loadModule('sitebar/weblink','index',$arr);
		/*$this->data['leftsitebar']['exchange'] = '<div class="clear" style="height:10px;"></div>
                                    <div class="head_title"><span>TỶ GIÁ</span></div>'.$this->loadModule("common/tygia");*/
		/*$this->data['leftsitebar']['searchproduct'] = $this->loadModule('sitebar/searchproduct');
		
		$this->data['leftsitebar']['cart'] = $this->loadModule('sitebar/cart');
		$this->data['leftsitebar']['gallery'] = $this->loadModule('sitebar/gallery');*/
		//$this->data['leftsitebar']['faq'] = $this->loadModule('sitebar/faq');
		
		//$this->data['leftsitebar']['supportonline'] = $this->loadModule('sitebar/supportonline');
		//$this->data['leftsitebar']['exchange'] = $this->loadModule('sitebar/exchange');
		//$this->data['leftsitebar']['weblink'] = $this->loadModule('sitebar/weblink');
		//$this->data['leftsitebar']['hitcounter'] = $this->loadModule('sitebar/hitcounter');
		
		//Rigth sitebar
		$this->data['rightsitebar']['supportonline'] = $this->loadModule('sitebar/supportonline');
		$list_mediaid = json_decode($this->document->setup['sanphamhot']);
		$medias = array();
		foreach($list_mediaid as $mediaid)
		{
			$media = $this->model_core_media->getItem($mediaid);
			$medias[] = $media;
		}
		$template = array(
						  'template' => "sitebar/product_list.tpl",
						  'width' => 120,
						  'height' =>0
						  );
		$arr = array("",0,"",$template,$medias);
		$this->data['rightsitebar']['sanphamhot'] = '<div class="head_title_right"><span>SẢN PHẨM HOT</span></div>'.$this->loadModule('module/productlist','getAll',$arr);
		$template = array(
						  'template' => "sitebar/news_list.tpl",
						  'width' => 55,
						  'height' =>0
						  );
		$arr = array("tin-tuc-hot",0,"",$template);
		$this->data['rightsitebar']['tin-tuc-hot'] = '<div class="head_title_right"><span>TIN TỨC HOT</span></div>'.$this->loadModule('module/pagelist','getList',$arr);
		
		
		
		
		/*$this->data['rightsitebar']['login'] = $this->loadModule('sitebar/login');
		$this->data['rightsitebar']['search'] = $this->loadModule('sitebar/search');
		$this->data['rightsitebar']['cart'] = $this->loadModule('sitebar/cart');
		$this->data['rightsitebar']['banner'] = $this->loadModule('sitebar/banner');
		$this->data['rightsitebar']['question'] = $this->loadModule('sitebar/question');*/
	}
	
	function getSiteMap($sitemapid)
	{
		$siteid = $this->member->getSiteId();
		$sitemap = $this->model_core_sitemap->getItem($sitemapid,$siteid);
		$sitemap['childs'] = $this->model_core_sitemap->getListByParent($sitemapid,$siteid);
		$sitemap['post'] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
		$sitemap['post']['imagethumbnail'] = HelperImage::resizePNG($sitemap['post']['imagepath'],200, 200);
		$this->data['sitemap'] = $sitemap; 
		$this->id="content";
		$this->template="home/sitemap.tpl";
		$this->render();
		
	}
}
?>