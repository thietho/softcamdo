<?php
class ControllerLayoutMobile extends Controller
{
	public function index()
	{
		
		if(file_exists($_GET['sitemapid'].".html"))
		{
			
			@$this->data['output'] = file_get_contents($_GET['sitemapid'].".html");
			$this->template="common/output.tpl";
			$this->render();
			
		}
		else
		{				
		$this->data['title'] = $this->document->title;
		$this->data['url'] = HTTP_SERVER.substr($_SERVER[REQUEST_URI],1);
		if(@$this->document->meta_description == "")
			$this->data['meta_description'] = $this->document->setup['Description'];
		else
			$this->data['meta_description'] = $this->document->meta_description ;
		if(@$this->document->meta_keyword == "")
			$this->data['meta_keyword'] = $this->document->setup['Keyword'];
		else
			$this->data['meta_keyword'] = $this->document->meta_keyword;
		//
		@$arr = split(',',$this->document->meta_image);
		//print_r($arr);
		//$this->document->meta_image;
		$this->data['meta_image'] = "";
		
		if(count($arr))
		{
			foreach($arr as $item)
			{
				if(@$item)
					$this->data['meta_image'] .= '<meta content="'.$item.'" property="og:image">';
			}
		}
		else
		{
			$this->data['meta_image'] .= '<meta content="'.$this->document->meta_image.'" property="og:image">';
		}
		
		
		
		$this->template="layout/mobile.tpl";
		$this->children=array(
			'common/headermobile',
			'common/footermobile'
		);
		$this->render();
		}
	}
}
?>