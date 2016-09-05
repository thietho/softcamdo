<?php
class ControllerAddonSearchproduct extends Controller
{
	public function index()
	{
		$this->document->breadcrumb .= "  » Tìm kiếm sản phẩm";
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
		
		
		$this->getList();	
		
		$this->id="content";		
		$this->template="addon/searchproduct.tpl";
		
		$this->render();
	}
	
	private function getList()
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		$donvi = 1000;
		//$para = $this->string->referSiteMapToArray($_GET['search']);
		$status = urldecode($_GET['status']);
		$keyword = urldecode($_GET['keyword']);
		$loaisp = urldecode($_GET['loaisp']);
		$nhanhieu = urldecode($_GET['nhanhieu']);
		$grouppro = urldecode($_GET['grouppro']);
		$gia = urldecode($_GET['gia']);
		
		if(@$keyword == "" && $loaisp == "" && $nhanhieu == "" && $gia == "" && $status == "")
		{
			@$this->data['searchresult'] = "Bạn chưa chọn tiêu chí tìm kiếm";
			return;
		}
		
		$where = " AND mediatype = 'module/product' AND mediaparent = ''";
		@$keyword = preg_replace("/[^a-zA-Z0-9]/", " ", $keyword);
		if(@$keyword !="")
		{
			@$arrkey = split(' ', $keyword);
			$arr = array();
			foreach($arrkey as $key)
			{
				@$arr[] = "keyword like '%".$key."%'";
			}
			$where .= " AND (". implode(" AND ",$arr). ")";
		}
		if(@$loaisp)
		{
			$where .= " AND refersitemap like '%[".$loaisp."]%'";
		}
		if(@$nhanhieu)
		{
			$where .= " AND brand like '".$nhanhieu."'";
		}
		if(@$grouppro)
		{
			$where .= " AND grouppro like '".$grouppro."'";
		}
		if(@$status !="")
		{
			$where .= " AND groupkeys like '%[".$status."]%'";
		}
		/*if(@$gia)
		{
			@$arrgia = split("-",$datasearch['gia']);
			$giatu = (int)$arrgia[0];
			$giaden = (int)$arrgia[1];
			$whereprice=" AND mediatype = 'module/product'";
			if(@$giatu)
				$whereprice = " AND price >= '".$giatu*$donvi ."'";
			if(@$giaden)
				$whereprice.= " AND price <= '".$giaden*$donvi ."'";
			
			$mediaprice = $this->model_core_media->getList($whereprice);
			
			$listparent = $this->string->matrixToArray($mediaprice,"mediaparent");
			
		}*/
		
		$medias = $this->model_core_media->getList($where);
		
		if(count($listparent))
		{
			$data = array();
			foreach($medias as $key =>$item)
			{
				if(!in_array($item['mediaid'],$listparent))
				{
					unset($medias[$key]);	
				}
				else
				{
					$data[] = $item;	
				}
			}
			$medias = $data;
		}
		else
		{
			if(@$hasprice)
				$medias = array();	
		}
		
		$template = array(
							  'template' => "module/product_list.tpl",
							  'width' => 320,
							  'height' =>320,
							  'widthpreview' => 450,
						  	  'heightpreview' =>450
							  );
		$arr = array("",'',"Kết quả tìm kiếm",$template,$medias);
		$this->data['searchresult'] = $this->loadModule('module/productlist','getAll',$arr);
	}
	
}
?>