<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		$sitemapid = "hotroonline";
		$siteid = $this->member->getSiteId();
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['media'] = $this->model_core_media->getItem($siteid.$sitemapid);
		@$this->data['supportonline'] = html_entity_decode($this->data['media']['description']);
		$this->data['mainmenu'] = $this->getMenu("");
		
		//Banner header
		$template = array(
					  'template' => "common/bannerheader.tpl",
					  'width' => 980,
					  'height' =>0
					  );
	
		$arr = array("banner",0,"",$template);
		$this->data['banner'] = $this->loadModule('module/block','getList',$arr);
		$this->id="header";
		$this->template="common/header.tpl";
		$this->render();
	}
	
	public function getMenu($parentid)
	{
		$this->load->model("core/sitemap");
		
		$siteid = $this->member->getSiteId();
		
		$rootid = $this->model_core_sitemap->getRoot($this->document->sitemapid, $siteid);

		if(@$this->document->sitemapid == "")
			$rootid = 'trangchu';
		$str = "";
		
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		
		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
			
			$currenttab = "";
			if(@$item['sitemapid'] == $rootid) 
				$currenttab = "class='active'";
			
			$link = "<a ".$currenttab.">".$item['sitemapname']."</a>";
			
			if(@$item['moduleid'] != "group")
			{
				
				$link = "<a ".$currenttab." href='".$this->document->createLink($item['sitemapid'])."' title='".$item['sitemapname']."' >".html_entity_decode($item['sitemapname'])."</a>";
			}
			if(@$item['moduleid'] == "homepage"){
				$link = "<a ".$currenttab." href='".HTTP_SERVER."'>".html_entity_decode($item['sitemapname'])."</a>";
			}
			
			$str .= "<li>";
			$str .= $link;
			
			if(count($childs) > 0)
			{
				$str .= "<ul>";
				$str .= $this->getMenu($item['sitemapid']);
				$str .= "</ul>";
			}

			$str .= "</li>";
		}
		
		return $str;
		
	}
	
	
}
?>