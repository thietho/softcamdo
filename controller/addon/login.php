<?php
class ControllerAddonLogin extends Controller
{
	private $error = array();
	public function index()
	{
		$this->document->sitebar['login'] = "hide";
		$this->document->breadcrumb .= " » Đăng nhập";
		$this->document->title .= " - Đăng nhập";
		$this->data['error'] = array();
		
		if(@$this->request->post['username'])
		{
			$this->login();
			if(count($this->error) == 0)
			{
				$this->response->redirect(HTTP_SERVER);
			}
			$this->data['error'] = $this->error;
			
		}
		
		$this->id="content";
		$this->template="addon/login.tpl";
		$this->render();
	}
	
	public function login()
	{
		$data = $this->request->post;
		if(@$this->validateForm($data))
		{
			$username = $data['username'];
			$password = $data['password'];
			if(@$this->chkLogin($username, $password))
			{
				if(@$data['remember'] == 1)
				{
					setcookie('username', $data['username'],time()+3600);
					setcookie('password', $data['password'],time()+3600);
				}
				@$this->data['output'] = "true";
			}
			else
				$this->error['passfalse'] = "Mật khẩu không đúng";
		}
		else
		{
			foreach($this->error as $item)
			{
				@$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function chkLogin($username,$pwd)
	{
		$this->load->model("core/user");
		//echo $username;
		$user = $this->model_core_user->getItemByUserName($username);
		
		if(md5($pwd) == $user['password'])
		{
			//Login thanh cong
			$this->session->set('member',$user);
			
			return true;
			
		}
		else
			return false;
	}
	private function validateForm($data)
	{
		
		
    	if(trim($data['username']) == "")
		{
      		$this->error['username'] = "Bạn chưa nhập tên đăng nhập";
    	}
		else
		{
			$this->load->model('core/user');
			$activecode = $this->model_core_user->getInformation(trim($data['username']),"activecode");
			if(@$activecode != "")
				$this->error['username'] = "tài khoản của bạn chưa được kích hoạt! <a href='".$this->document->createLink('active')."'>Kích hoạt tài khoản click vào đây</a>";
		}
		if(trim($data['password']) =="")
		{
      		$this->error['password'] = "Bạn chưa nhập mật khẩu";
    	}
		
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>