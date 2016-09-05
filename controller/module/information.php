<?php
class ControllerModuleInformation extends Controller
{
	/*function __construct() 
	{
		$this->iscache = true;
	 	$this->name ="Information".$this->document->sitemapid;
   	}*/
	public function index($sitemapid="")
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		if(@$sitemapid=="")
			$sitemapid = $this->document->sitemapid;
		//$sitemapid = $this->document->sitemapid;
		$siteid = $this->user->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		//$this->data['sitemap']['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
		//$this->document->breadcrumb = $this->data['sitemap']['breadcrumb'];
		
		$this->data['post'] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
		@$this->document->title .= " - ".$this->data['post']['title'];
		if(count($this->data['post']) == 0)
		{
			$this->data['post']['description'] = "Updating...";
		}
		$this->document->meta_description = strip_tags($this->data['post']['description']);
		$this->data['post']['description'] = html_entity_decode($this->data['post']['description']);
		
		$this->data['childs'] = $this->model_core_sitemap->getListByParent($sitemapid,$siteid);
		
		foreach($this->data['childs'] as $key =>$item)
		{
			$this->data['childs'][$key]['media'] = $this->model_core_media->getItem($this->member->getSiteId().$item['sitemapid']);
			
			$this->data['childs'][$key]['media']['imagethumbnail'] = HelperImage::resizePNG($this->data['childs'][$key]['media']['imagepath'],100, 100);
		}
		
		$listfile = $this->model_core_media->getInformation($this->member->getSiteId().$sitemapid, "attachment");
		$listfileid=array();
		if(@$listfile)
			@$listfileid=split(",",$listfile);
		$this->data['attachment'] = array();
		foreach($listfileid as $key => $item)
		{
			//@$this->data['attachment'][$key] = @$this->model_core_file->getFile($item);
			$info = pathinfo($item);
			//print_r($info);
			@$this->data['attachment'][$key]=$info;
			@$this->data['attachment'][$key]['imagethumbnail'] = HelperImage::resizePNG($item, 300, 300);
			@$this->data['attachment'][$key]['preview'] = HelperImage::resizePNG($item, 800, 800);
			@$this->data['attachment'][$key]['filepath'] = $item;
			if(!@$this->string->isImage($info['extension']))
			{
				$urlext = HTTP_IMAGE."icon/48px/".$info['extension'].".png";
				if(!@fopen($urlext,"r"))
					$urlext = HTTP_IMAGE."icon/48px/_blank.png";
				
				@$this->data['attachment'][$key]['imagethumbnail'] = $urlext;
			}
				
		}
		$this->id="information";
		$this->template="module/information.tpl";
		$this->render();
	}
}
?>