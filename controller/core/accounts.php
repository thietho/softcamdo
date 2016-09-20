<?php
/**
 * Class ControllerCoreUser
 *
 * @property ModelCoreAccounts model_core_accounts

 *
 */
class ControllerCoreAccounts extends Controller
{
	private $error = array();
   	function __construct() 
	{

        $this->document->title = "Danh mục tài khoản";
		@$this->load->model("core/accounts");

		$data_childs = @$this->model_core_accounts->getChild('');
		@$this->data['tree'] ="";
		foreach($data_childs as $child)
		{
			@$this->data['tree'] .= @$this->getTree($child['accountid']);
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
			
			//@$this->load->language('core/accounts');
			//@$this->data = array_merge(@$this->data, @$this->language->getData());
			/*$accountid = @$this->request->get['accountid'];
			$category = @$this->model_core_accounts->getItem(@$this->request->get['accountid']);
			
			@$this->data['DIR_UPLOADPHOTO'] = HTTP_SERVER."index.php?route=common/uploadpreview";
			@$this->data['DIR_UPLOADATTACHMENT'] = HTTP_SERVER."index.php?route=common/uploadattachment";
			@$this->data['post']['mediaid'] = @$this->user->getSiteId()."cat".$accountid;
			@$this->data['post']['mediatype'] = "information";
			
			@$this->data['post']=@$this->model_core_media->initialization(@$this->data['post']['mediaid'],@$this->data['post']['mediatype']);
			@$this->data['post'] = @$this->model_core_media->getItem(@$this->data['post']['mediaid']);
			
			if(@$this->data['post']['title'] == '' && $route='module/information')
			{
				@$this->data['post']['mediaid'] = @$this->user->getSiteId()."cat".$accountid;
				@$this->data['post']['title'] = $category['accountname'];
			}
			if(@$this->data['post']['imagepath'] != "")
			{
				@$this->data['post']['imagethumbnail'] = HelperImage::resizePNG(@$this->data['post']['imagepath'], 200, 200);
			}*/
			@$this->id='content';
			@$this->template='common/output.tpl';
			@$this->layout="layout/center";
			@$this->render();
		}
		
  	}
	
	public function delete() 
	{
		$catid=@$this->request->get['catid'];
		//$listaccountid=$_POST['delete'];

		if($catid)
		{
			@$this->model_core_accounts->delete($catid);
			@$this->data['output'] = "Xóa thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
  	}
	
	public function updateposition()
	{
		$listposition=@$this->request->post['position'];
		//$listaccountid=$_POST['delete'];
		@$this->load->model("core/accounts");
		if(count($listposition))
		{
			foreach($listposition as $key => $item)
			{
				$data['accountid'] = $key;
				$data['position'] = $item;
				@$this->model_core_accounts->updateposition($data);		
			}
			
			@$this->data['output'] = "Cập nhật thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
		
	}
	private function getTree($id)
	{
		
		$data_childs = @$this->model_core_accounts->getChild($id);
		$cat = @$this->model_core_accounts->getItem($id);
		$str ='<li class="dd-item" data-id="'.$cat['accountid'].'">';
		//$btnEdit = '<a href="?route=core/accounts/update&accountid='.$cat['accountid'].'">Edit</a>';
		//$btnAddChild = '<a href="?route=core/accounts/insert&parent='.$cat['accountid'].'">Add child</a>';
		//$btnEditContent = '<a href="?route=module/information&sitemapid=cat'.$cat['accountid'].'">Edit content</a>';
		//$btnRemove = '<a>Remove</a>';
		//$str .= '<div class="dd-handle">'.$cat['accountname']." ".$btnEdit." ".$btnAddChild." ".$btnEditContent." ".$btnRemove.'</div>';
		$str .= '<div class="dd-handle hl-cat" data-toggle="modal" data-target="#myModal" catid="'.$cat['accountid'].'" catname="'.$cat['accountname'].'">'.$cat['accountid']." - ".$cat['accountname'].'</div>';
		//$str .= '<div class="dd-handle dd3-handle"></div><div class="dd3-content">'.$cat['accountname']." ".$btnEdit." ".$btnAddChild." ".$btnEditContent." ".$btnRemove.'</div>';
		
		if(count($data_childs))
		{
			
			$str .= '<ol>';
			foreach($data_childs as $child)
			{
				
				$str .= @$this->getTree($child['accountid']);
				
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
		//print_r($obj[0]->id);
		foreach($dataobj as $key => $obj)
		{
			$this->model_core_accounts->updateCol($obj->id,'parent','accounts');

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
				@$this->model_core_accounts->updateCol($child->id,'parent',$note->id);

				@$this->travelTree($child);
			}
		}
		
	}
	private function getList() 
	{
        $this->data['insert'] = @$this->url->http('core/accounts/insert');

        $this->id='content';
		$this->template="core/accounts_list.tpl";
		$this->layout="layout/home";
		
		$this->render();
	}
	
	
	private function getForm()
	{
		@$this->data['error'] = @$this->error;
		@$this->load->model("core/accounts");
		
		@$this->data['datas'] = array();
		@$this->data['datas'] = @$this->model_core_accounts->getDanhMucPhanLoai();
		
		if ((isset($this->request->get['accountid'])) ) 
		{
      		@$this->data['item'] = @$this->model_core_accounts->getItem(@$this->request->get['accountid']);
    	}
		
		@$this->id='content';
		@$this->template='core/accounts_form.tpl';
		@$this->layout="layout/home";
		
		@$this->render();
	}
	
	public function save()
	{
		$data = @$this->request->post;
		if(@$this->validateForm($data))
		{
			@$this->load->model("core/accounts");
			@$this->model_core_accounts->save($data);
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
			if(@$this->validation->_isId(trim($data['accountid'])) == false)
			{
				@$this->error['accountid'] = "Mã danh mục không hợp lệ";
			}
			else
			{
				@$this->load->model("core/accounts");
				$item = @$this->model_core_accounts->getItem($data['accountid']);
				if(count($item)>0)
					@$this->error['accountid'] = "Mã danh mục đã được sử dụng";
			}
		}
		if ((strlen($data['accountid']) == 0)) 
		{
      		@$this->error['accountid'] = "Mã danh mục không được rỗng";
    	}
		if ((strlen($data['accountname']) == 0)) 
		{
      		@$this->error['accountname'] = "Tên danh mục không được rỗng";
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
		$accountid = @$this->request->get['accountid'];
		if($accountid)
		{
			$child = @$this->model_core_accounts->getChild($accountid);
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