<?php
class ControllerCommonFooter extends Controller
{
	public function index()
	{
		$arr = array('khach-hang');
		$this->data['khachhang'] = $this->loadModule('sitebar/weblink','index',$arr);
		
		$this->id="footer";
		$this->template="common/footer.tpl";
		$this->render();
	}
}
?>