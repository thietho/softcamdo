<?php
/**
 * Class ControllerCoreUser
 *
 * @property ModelCoreCategory model_core_category

 *
 */
class ControllerCoreCategory extends Controller
{
	private $error = array();
   	function __construct() 
	{

        $this->document->title = "Quản lý phân loại";
		@$this->load->model("core/category");

		$data_childs = @$this->model_core_category->getChild('');
		@$this->data['tree'] ="";
		foreach($data_childs as $child)
		{
			@$this->data['tree'] .= @$this->getTree($child['categoryid']);
		}
        $this->data['lang'] = $this->language->getData();
   	}
	
	public function index()
	{
		

		@$this->getList();
	}
	
	public function insert()
	{

    	@$this->getForm();
	}
	
	public function update()
	{

			
			
			
        @$this->data['haspass'] = false;
        @$this->data['readonly'] = 'readonly="readonly"';


        @$this->getForm();

		
  	}
	
	public function edit()
	{
		if(!@$this->user->hasPermission(@$this->getRoute(), "edit"))
		{
			@$this->response->redirect("?route=common/permission");
		}
		else
		{
			
			//@$this->load->language('core/category');
			//@$this->data = array_merge(@$this->data, @$this->language->getData());
			/*$categoryid = @$this->request->get['categoryid'];
			$category = @$this->model_core_category->getItem(@$this->request->get['categoryid']);
			
			@$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
			@$this->data['DIR_UPLOADATTACHMENT'] = HTTP_SERVER."index.php?route=common/uploadattachment";
			@$this->data['post']['mediaid'] = @$this->user->getSiteId()."cat".$categoryid;
			@$this->data['post']['mediatype'] = "information";
			
			@$this->data['post']=@$this->model_core_media->initialization(@$this->data['post']['mediaid'],@$this->data['post']['mediatype']);
			@$this->data['post'] = @$this->model_core_media->getItem(@$this->data['post']['mediaid']);
			
			if(@$this->data['post']['title'] == '' && $route='module/information')
			{
				@$this->data['post']['mediaid'] = @$this->user->getSiteId()."cat".$categoryid;
				@$this->data['post']['title'] = $category['categoryname'];
			}
			if(@$this->data['post']['imagepath'] != "")
			{
				@$this->data['post']['imagethumbnail'] = HelperImage::resizePNG(@$this->data['post']['imagepath'], 200, 200);
			}*/
			@$this->id='content';
			@$this->data['output'] = @$this->loadModule('core/postcontent');
			@$this->template='common/output.tpl';
			@$this->layout="layout/center";
			@$this->render();
		}
		
  	}
	
	public function delete() 
	{
		$catid=@$this->request->get['catid'];
		//$listcategoryid=$_POST['delete'];

		if($catid)
		{
			@$this->model_core_category->delete($catid);
			@$this->data['output'] = "Xóa thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
  	}
	
	public function updateposition()
	{
		$listposition=@$this->request->post['position'];
		//$listcategoryid=$_POST['delete'];
		@$this->load->model("core/category");
		if(count($listposition))
		{
			foreach($listposition as $key => $item)
			{
				$data['categoryid'] = $key;
				$data['position'] = $item;
				@$this->model_core_category->updateposition($data);		
			}
			
			@$this->data['output'] = "Cập nhật thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
		
	}
	private function getTree($id)
	{
		
		$data_childs = @$this->model_core_category->getChild($id);
		$cat = @$this->model_core_category->getItem($id);
		$str ='<li class="dd-item" data-id="'.$cat['categoryid'].'">';
		//$btnEdit = '<a href="?route=core/category/update&categoryid='.$cat['categoryid'].'">Edit</a>';
		//$btnAddChild = '<a href="?route=core/category/insert&parent='.$cat['categoryid'].'">Add child</a>';
		//$btnEditContent = '<a href="?route=module/information&sitemapid=cat'.$cat['categoryid'].'">Edit content</a>';
		//$btnRemove = '<a>Remove</a>';
		//$str .= '<div class="dd-handle">'.$cat['categoryname']." ".$btnEdit." ".$btnAddChild." ".$btnEditContent." ".$btnRemove.'</div>';
		$str .= '<div class="dd-handle hl-cat" data-toggle="modal" data-target="#myModal" catid="'.$cat['categoryid'].'" catname="'.$cat['categoryname'].'">'.$cat['categoryname'].'</div>';
		//$str .= '<div class="dd-handle dd3-handle"></div><div class="dd3-content">'.$cat['categoryname']." ".$btnEdit." ".$btnAddChild." ".$btnEditContent." ".$btnRemove.'</div>';
		
		if(count($data_childs))
		{
			
			$str .= '<ol>';
			foreach($data_childs as $child)
			{
				
				$str .= @$this->getTree($child['categoryid']);
				
			}
			$str.='</ol>';
			
		}
		$str .= '</li>';
		return $str;
	}
	public function updateTree()
	{
		$data = urldecode($this->request->post['data']);
		$dataobj = json_decode($data);
		print_r($dataobj);
		foreach($dataobj as $key => $obj)
		{
			$this->model_core_category->updateCol($obj->id,'parent','category');
			$this->model_core_category->updateCol($obj->id,'position',$key);
			@$this->travelTree($obj);
		}
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	private function travelTree($note)
	{
		echo "id:".$note->id;
		if(count($note->children))
		{
			echo "<br>childs:";
			foreach($note->children as $key => $child)
			{
				echo $child->id;
				@$this->model_core_category->updateCol($child->id,'parent',$note->id);
				@$this->model_core_category->updateCol($child->id,'position',$key);
				@$this->travelTree($child);
			}
		}
		
	}
	private function getList() 
	{
        $this->data['insert'] = @$this->url->http('core/category/insert');

        $this->id='content';
		$this->template="core/category_list.tpl";
		$this->layout="layout/home";
		
		$this->render();
	}
	
	
	private function getForm()
	{
		@$this->data['error'] = @$this->error;
		@$this->load->model("core/category");
		
		@$this->data['datas'] = array();
		@$this->data['datas'] = @$this->model_core_category->getDanhMucPhanLoai();
		
		if ((isset($this->request->get['categoryid'])) ) 
		{
      		@$this->data['item'] = @$this->model_core_category->getItem(@$this->request->get['categoryid']);
    	}
		
		@$this->id='content';
		@$this->template='core/category_form.tpl';
		@$this->layout="layout/home";
		
		@$this->render();
	}
	
	public function save()
	{
		$data = @$this->request->post;
		if(@$this->validateForm($data))
		{
			@$this->load->model("core/category");
			@$this->model_core_category->save($data);
			@$this->data['output'] = "true";
		}
		else
		{
			foreach(@$this->error as $item)
			{
				@$this->data['output'] .= $item."<br>";
			}
		}
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	
	private function validateForm($data)
	{
		if(@$data['id'] == "")
		{
			if(@$this->validation->_isId(trim($data['categoryid'])) == false)
			{
				@$this->error['categoryid'] = "Mã danh mục không hợp lệ";
			}
			else
			{
				@$this->load->model("core/category");
				$item = @$this->model_core_category->getItem($data['categoryid']);
				if(count($item)>0)
					@$this->error['categoryid'] = "Mã danh mục đã được sử dụng";
			}
		}
		if ((strlen($data['categoryid']) == 0)) 
		{
      		@$this->error['categoryid'] = "Mã danh mục không được rỗng";
    	}
		if ((strlen($data['categoryname']) == 0)) 
		{
      		@$this->error['categoryname'] = "Tên danh mục không được rỗng";
    	}

		if (count(@$this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	//Cac ham xu ly tren form
	public function getListChild()
	{
		$categoryid = @$this->request->get['categoryid'];
		if($categoryid)
		{
			$child = @$this->model_core_category->getChild($categoryid);
			@$this->data['output'] = json_encode($child);
		}
		else
			@$this->data['output'] = json_encode(array());
		@$this->id="donvi";
		@$this->template="common/output.tpl";
		@$this->render();
	}
}
?>