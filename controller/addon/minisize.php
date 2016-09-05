<?php
class ControllerAddonMinisize extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->breadcrumb .= " » Hàng size nhỏ (Mini size)";
		$this->document->title .= " - Hàng size nhỏ (Mini size)";
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->data['producttype'] = array();
		$this->model_core_category->getTree("producttype",$this->data['producttype']);
		unset($this->data['producttype'][0]);
		
		$this->data['nhanhieu'] = $this->model_core_category->getChild('nhanhieu');
		unset($this->data['nhanhieu'][count($this->data['nhanhieu'])-1]);
		/*$brandother = $this->model_core_category->getChild('brandother');
		foreach($brandother as $cat)
		{
			$this->data['nhanhieu'][] = $cat;
		}*/
		
		$this->data['sitemaps'] = array();
		$this->model_core_sitemap->getTreeSitemap("sanpham", $this->data['sitemaps'],SITEID);
		
		/*foreach($this->data['nhanhieu'] as $key => $brand)
		{
			$this->data['nhanhieu'][$key]['data_medias'] = $this->getListByBrand($brand['categoryid']);
		}*/
		
		//print_r($this->data['data_medias']);
		$this->data['data_medias'] = $this->getList();
		
		$this->id="content";
		$this->template="addon/minisize.tpl";
		$this->render();
	}
	
	public function getListByBrand($brand)
	{
		//$arrprotype = $this->string->matrixToArray($this->data['producttype'],'categoryid');
		//$where = " AND brand = '".$brand."' AND noteprice in ('".implode("','",$arrprotype)."') AND inventory > 0";
		$where = " AND brand = '".$brand."' AND noteprice <> '' AND inventory > 0";
		@$data_medias = array();
		foreach($this->data['sitemaps'] as $sitemap)
		{
			$w = $where . " AND  refersitemap like '%[".$sitemap['sitemapid']."]%'";
			$medias = $this->model_core_media->getList($w,0,0," Order by code");
			if(count($medias))
			{
				//$data_medias = array_merge($data_medias,$medias);
				
				$template = array(
									  'template' => "module/product_list.tpl",
									  'width' => IMG_PROLIST,
									  'height' =>IMG_PROLIST,
									  'widthpreview' => 450,
									  'heightpreview' =>450
									  );
				$arr = array("",20,$header,$template,$medias);
				$data['sitemapname'] = $sitemap['sitemapname'];
				$data['listpro'] = $this->loadModule('module/productlist','getAll',$arr);
				$data_medias[$sitemap['sitemapid']] = $data;
			}
		}
		return $data_medias;
	}
	public function getList()
	{
		//$arrprotype = $this->string->matrixToArray($this->data['producttype'],'categoryid');
		//$where = " AND brand = '".$brand."' AND noteprice in ('".implode("','",$arrprotype)."') AND inventory > 0";
		$where = " AND noteprice <> '' AND inventory > 0";
		@$data_medias = array();
		foreach($this->data['sitemaps'] as $sitemap)
		{
			$w = $where . " AND  refersitemap like '%[".$sitemap['sitemapid']."]%'";
			$medias = $this->model_core_media->getList($w,0,0," Order by code");
			if(count($medias))
			{
				//$data_medias = array_merge($data_medias,$medias);
				
				$template = array(
									  'template' => "module/product_list.tpl",
									  'width' => IMG_PROLIST,
									  'height' =>IMG_PROLIST,
									  'widthpreview' => 450,
									  'heightpreview' =>450
									  );
				@$arr = array("",20,$header,$template,$medias);
				@$data['sitemapname'] = $sitemap['sitemapname'];
				@$data['listpro'] = $this->loadModule('module/productlist','getAll',$arr);
				@$data_medias[$sitemap['sitemapid']] = $data;
			}
		}
		return $data_medias;
	}
}
?>