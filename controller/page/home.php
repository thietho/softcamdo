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
		if (@$this->user->isLogged()) {
			@$this->redirect('?route=addon/dashboard');
		}

		if ((@$this->request->post) && (@$this->validate())) {
            @$this->redirect('?route=addon/dashboard');
			return;
		}
		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/home";
		$this->render();
	}
	private function validate() {
		//Kiem tra secure image
		/*if(@$this->validSecure == false)
		{
			@$this->error['error_warning'] = @$this->language->get('error_warning');
		}*/
		
		//Kiem tra dang nhap
		
		if(@$this->request->post['username']=="")
			@$this->error['error_warning'] = @$this->language->get('error_warning');
		else
		{
				
			if (!@$this->login(@$this->request->post['username'], @$this->request->post['password'])) 
			{
				
				@$this->error['error_warning'] = @$this->language->get('error_warning');
			}
			
		}
		if (!@$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}	
	
	public function login($username,$pwd)
	{
		@$this->load->model("core/user");
		
		$user = @$this->model_core_user->getItemByUserName($username);
		
		if(md5($pwd) == $user['password'] && $user['status'] == 'active')
		{
			
			//Login thanh cong
			@$this->session->set('usertypeid',$user['usertypeid']);
			@$this->session->set('userid',$user['userid']);
			@$this->session->set('username',$user['username']);	
			@$this->session->set('siteid',SITEID);
			return true;
			
		}
		else
			return false;
	}
	public function checkLogin() {
		if (!@$this->user->isLogged()) {
			$route = @$this->getRoute();
			$part = explode('/', $route);
			$ignore = array(
				'common/forgotpassword'
			);
			
			if (!in_array(@$part[0] . '/' . @$part[1], $ignore)) {
				return @$this->forward('common/login', 'index');
			}
			
		}
	}
}
?>