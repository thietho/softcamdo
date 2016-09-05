<?php
class ControllerAddonBrand extends Controller
{
	private $error = array();
	public function index()
	{
		
		$this->getList();
		
	}
	
	public function getList($where="",$categoryid="",$sitemapid ="")
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		@$this->data['media'] = $this->model_core_media->getItem($mediaid);
		
		if(@$categoryid=="")
		{
			@$arr = split("-",$this->request->get['id']);
			@$categoryid = $arr[0];
			@$sitemapid = $arr[1];
		}
		
		$this->document->title .= " - ".$this->document->getCategory($categoryid);
		$header = $this->document->getCategory($categoryid);
		$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->member->getSiteId());
		if(@$sitemapid == "")	
		{
			$this->document->breadcrumb .= ' » <a href="' .$this->document->createLink("brand",$categoryid).'">'.$header."</a>";
		}
		else
		{
			@$this->document->breadcrumb .= '<a href="' .$this->document->createLink($sitemap['sitemapid']).'">'.$sitemap['sitemapname']."</a> » ". '<a href="' .$this->document->createLink("brand",$categoryid."-".$sitemapid).'">'.$header.'</a>';
		}
		$where .= " AND brand like '".$categoryid."' AND mediaparent =''";
		if(@$sitemapid)
			$where .= " AND refersitemap like '%[".$sitemapid."]%'";
		
		@$order = $_GET['order'];
		$orderby = "";
		switch($order)
		{
			case "az":
				$orderby = " ORDER BY `title` ASC";
				break;
			case "gt":
				$orderby = " ORDER BY `price` ASC";
				break;
			case "gg":
				$orderby = " ORDER BY `price` DESC";
				break;
		}
		$data_media = array();
			
		$listmediaid = $this->model_core_media->getInformation("sort".$categoryid,"sort");
		if(@$listmediaid!="")
		{
			$arrmediaid = $this->string->referSiteMapToArray($listmediaid);
			foreach($arrmediaid as $mediaid)
			{
				$media = $this->model_core_media->getItem($mediaid);
				if(@$media['status'] == 'active' && $media['imagepath'] != "")
					$data_media[] = $media;
			}
			
			$arrmediaid = $this->string->referSiteMapToArray($listmediaid);
			$where .= " AND mediaid NOT IN ('".implode("','",$arrmediaid)."')";
			
		}
		$medias = $this->model_core_media->getList($where.$orderby);
		$medias = array_merge($data_media,$medias);
		/*if(@count($listparent))
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
		}*/
		
		$template = array(
							  'template' => "module/product_list.tpl",
							  'width' => IMG_PROLIST,
							  'height' =>IMG_PROLIST,
							  'widthpreview' => 450,
						 	  'heightpreview' =>450
							  );
		$arr = array("",20,$header,$template,$medias);
		@$this->data['output'] = $this->loadModule('module/productlist','getAll',$arr);
			
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();	
	}
}
?>