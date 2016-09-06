<?php
class ControllerLayoutHome extends Controller
{
	public function index()
	{
		
		if(file_exists(@$_GET['sitemapid'].".html"))
		{
			
			@$this->data['output'] = file_get_contents($_GET['sitemapid'].".html");
			$this->template="common/output.tpl";
			$this->render();
			
		}
		else
		{				
		
		
		
			$this->template="layout/home.tpl";
			$this->children=array(
				'common/header',
				
			);
			$this->render();
		}
	}
}
?>