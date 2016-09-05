<?php
class ControllerPageDetail extends Controller
{
	private $breadcrumb = array();
	function __construct() 
	{
		//$this->iscache = true;
		$arr=array();
		foreach($_GET as $key => $val)
			$arr[] = $key."=".$val;
	 	$this->name ="Pagedetail_".implode("_",$arr);
		$this->breadcrumb = array(
								'login' => "Đăng nhập",
								'register' => 'Đăng ký',
								'cart' => 'Giỏ hàng',
								'checkout' => 'Thanh toán',
								'checkoutcomplete' => 'Thông tin đơn hàng',
								'active' => 'Kích hoạt tài khoản',
								'member' => 'Thông tin thành viên',
								'memberinfor' => 'Cập nhật thông tin cá nhân',
								'changepass' => 'Thay đổi mật khẩu',
								'historyorder' => 'Lịch sử mua hàng',
								'forgotpassword' => 'Quên mật khẩu',
								'activelink' => 'Kích hoạt tài khoản'
								
								);
		
   	}
	public function index()
	{
		//print_r($this->string->browser_info());
		$this->destop();
		//$this->mobile();
	}
	
	public function destop()
	{
		if(@$this->cachehtml->iscacht($this->name) == false)
		{
			$this->load->model("core/sitemap");
			$this->load->model('core/media');
			@$this->document->sitemapid = $this->request->get['sitemapid'];
			$siteid = $this->member->getSiteId();
			
			
			@$id = $this->request->get['id'];
			
			$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($this->document->sitemapid, $siteid);
			if($this->document->sitemapid == 'brand')
			{
				
				$this->data['breadcrumb'].= "<a>".$this->document->getCategory($id)."</a>";
			}
			else
			{
				if(@$this->breadcrumb[$this->document->sitemapid]!='')
				{
					$this->data['breadcrumb'].= "<a>".$this->breadcrumb[$this->document->sitemapid]."</a>";
				}
			}
			
			$template = array(
						  'template' => "module/category_brand.tpl"
						  );
			
			$arr = array("nhanhieu",$template);
			$this->data['brand'] = $this->loadModule('module/category','getList',$arr);
			if(@$this->document->sitemapid != "")
			{
				$sitemap = $this->model_core_sitemap->getItem($this->document->sitemapid, $siteid);
				$this->document->title = $this->document->setup['Title'];
				switch(@$sitemap['moduleid'])
				{
					case "":
						if(file_exists($this->document->sitemapid.".html"))
						{
							//$this->response->redirect($this->document->sitemapid.".html");
						}
						else
							$this->data['module'] = $this->loadModule('addon/'.$this->document->sitemapid);
					break;
					case "module/information":
						$this->data['module'] = $this->loadModule('module/information');
					break;
					case "module/location":
						$this->data['module'] = $this->loadModule('module/location');
					break;
					case "module/banner":
						if(@$id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/banner_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/news":
						if(@$id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/news_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/video":
						if(@$id == "")
						{
							$template = array(
											  'template' => "module/news_list.tpl",
											  'width' => 180,
											  'height' =>180
											  );
							$arr = array("",10,"",$template);
							
							$this->data['module'] = $this->loadModule('module/pagelist','getList',$arr);
						}
						else
						{
							$template = array(
										  'template' => "module/video_detail.tpl",
										  'width' => 176,
										  'height' =>176
										  );
							$arr = array("",8,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getForm',$arr);
						}
					break;
					case "module/product":
						if(@$id == "")
						{
							$template = array(
											  'template' => "module/product_list.tpl",
											  'width' => IMG_PROLIST,
											  'height' =>IMG_PROLIST,
											  'widthpreview' => 450,
											  'heightpreview' =>450
											  );
							$arr = array($this->document->sitemapid,0,"",$template);
							$this->data['module'] = $this->loadModule('module/productlist','getAll',$arr);
	
						}
						else
						{
							$template = array(
										  'template' => "module/product_detail.tpl",
										  'width' => 530,
										  'height' =>530
										  );
							$arr = array($this->document->sitemapid,12,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getFormProduct',$arr);
						}
					break;
					case "module/album":
						if(@$id == "")
						{
							$template = array(
											  'template' => "module/album_list.tpl",
											  'width' => 150,
											  'height' =>114
											  );
							$arr = array($this->document->sitemapid,12,"",$template);
							$this->data['module'] = $this->loadModule('module/productlist','index',$arr);
	
						}
						else
						{
							$template = array(
										  'template' => "module/album_detail.tpl",
										  'width' => 520,
										  'height' =>450
										  );
							$arr = array($this->document->sitemapid,12,$template);
							$this->data['module'] = $this->loadModule('module/pagedetail','getFormProduct',$arr);
						}
					break;
					case "module/contact":
						$this->data['module'] = $this->loadModule('module/contact');
					break;
				}
			}
			
			//$this->loadSiteBar();
		}
		$this->id="content";
		$this->template="page/detail.tpl";
		$this->layout="layout/home";
		$this->render();
	}
	
	private function loadSiteBar()
	{
		//Left sitebar
		
		$arr = array('sanpham');
		$this->data['leftsitebar']['produtcategory'] = $this->loadModule('sitebar/catalogue','index',$arr);
		$this->data['leftsitebar']['brand'] = $this->loadModule('sitebar/brand');
		$arr = array('doi-tac');
		$this->data['leftsitebar']['weblink'] = '<div class="head_title"><span>ĐỐI TÁC</span></div>'.$this->loadModule('sitebar/weblink','index',$arr);
		/*$this->data['leftsitebar']['exchange'] = '<div class="clear" style="height:10px;"></div>
                                    <div class="head_title"><span>TỶ GIÁ</span></div>'.$this->loadModule("common/tygia");*/
		/*$this->data['leftsitebar']['searchproduct'] = $this->loadModule('sitebar/searchproduct');
		
		$this->data['leftsitebar']['cart'] = $this->loadModule('sitebar/cart');
		$this->data['leftsitebar']['gallery'] = $this->loadModule('sitebar/gallery');*/
		//$this->data['leftsitebar']['faq'] = $this->loadModule('sitebar/faq');
		
		//$this->data['leftsitebar']['supportonline'] = $this->loadModule('sitebar/supportonline');
		//$this->data['leftsitebar']['exchange'] = $this->loadModule('sitebar/exchange');
		//$this->data['leftsitebar']['weblink'] = $this->loadModule('sitebar/weblink');
		//$this->data['leftsitebar']['hitcounter'] = $this->loadModule('sitebar/hitcounter');
		
		//Rigth sitebar
		$this->data['rightsitebar']['supportonline'] = $this->loadModule('sitebar/supportonline');
		$list_mediaid = json_decode($this->document->setup['sanphamhot']);
		$medias = array();
		foreach($list_mediaid as $mediaid)
		{
			$media = $this->model_core_media->getItem($mediaid);
			$medias[] = $media;
		}
		$template = array(
						  'template' => "sitebar/product_list.tpl",
						  'width' => 120,
						  'height' =>0
						  );
		$arr = array("",0,"",$template,$medias);
		$this->data['rightsitebar']['sanphamhot'] = '<div class="head_title_right"><span>SẢN PHẨM HOT</span></div>'.$this->loadModule('module/productlist','getAll',$arr);
		$template = array(
						  'template' => "sitebar/news_list.tpl",
						  'width' => 55,
						  'height' =>0
						  );
		$arr = array("tin-tuc-hot",0,"",$template);
		$this->data['rightsitebar']['tin-tuc-hot'] = '<div class="head_title_right"><span>TIN TỨC HOT</span></div>'.$this->loadModule('module/pagelist','getList',$arr);
		
		
		
		
		/*$this->data['rightsitebar']['login'] = $this->loadModule('sitebar/login');
		$this->data['rightsitebar']['search'] = $this->loadModule('sitebar/search');
		$this->data['rightsitebar']['cart'] = $this->loadModule('sitebar/cart');
		$this->data['rightsitebar']['banner'] = $this->loadModule('sitebar/banner');
		$this->data['rightsitebar']['question'] = $this->loadModule('sitebar/question');*/
	}
}
?>