<?php
final class Document {
	public $title;
	public $description;
	public $base;	
	public $charset = 'utf-8';		
	public $language = 'vi';	
	public $direction = 'ltr';		
	public $links = array();		
	public $styles = array();
	public $scripts = array();
	public $breadcrumbs;
	public $sitemapid = '';
	public $media = array();
	public $meta_description = '';
	public $meta_keyword = '';
	public $meta_image = '';
	public $sitebar =array();
	public $text = array();
	public $setting = array();
	public $setup = array();
	public $productdisplay = array(
						   '' => "Chi tiết",
						   'compact' => "Rút gọn",
						   
						   );
	public $status = array(
						   'new' => "Đơn hàng mới",
						   'wait' => "Đang xử lý",
						   'pending' => "Xát với khách hàng không được",
						   'confirmed' => "Đã xát nhận",
						   'completed' => "Hoàn thành",
						   'cancel' => "Hủy đơn hàng"
						   );

	public function toVND($value,$donvi)
	{
		if($donvi == "VND")
			return $value;
		else
		{
			
			return $value * $this->toNumber($this->setup['Exchange']); 	
		}
			
	}
	private $filepath;
	public function __construct() 
	{
		$this->db = Registry::get('db');
		$this->language = Registry::get('language');
		$this->text = $this->language->getData();
		$this->meta_image = HTTP_IMAGE."default/default.png";
		$this->filepath = DIR_FILE."db/setting.json";
		$this->createDB();
		$this->getData();
		
		
	}
	
	
	
	private function createDB()
	{
		$arr = array();
		if(!is_dir(DIR_FILE."db"))
			mkdir(DIR_FILE."db");
		
		if(!is_file($this->filepath))
		{
			
			$fp = fopen($this->filepath, 'w');
			fwrite($fp, '');
			fclose($fp);	
		}
	}
	
	private function getData()
	{
		$filename = $this->filepath;
		$handle = fopen($filename, "r");
		@$contents = fread($handle, filesize($filename));
		fclose($handle);
		$this->setting = json_decode($contents);
		
	}
	
	public function setValue($key,$value)
	{
		$this->setting->$key = $value;
		$this->saveData();
	}
	
	private function saveData()
	{
		$str = json_encode($this->setting);
		$fp = fopen($this->filepath, 'w');
		fwrite($fp, $str);
		fclose($fp);
	}
	

	
	public function getCategory($categoryid,$name="categoryname")
	{
		$query = $this->db->query("Select `category`.* 
									from `category` 
									where `categoryid` ='".$categoryid."' ");
		return @$query->row[$name];	
	}
    public function getGroup($groupid,$name="groupname")
    {
        $query = $this->db->query("Select `group`.*
									from `group`
									where `groupid` ='".$groupid."' ");
        return @$query->row[$name];
    }

	
	public function getUser($userid,$name = 'fullname')
	{
		$sql = "Select `user`.* 
									from `user` 
									where userid ='".$userid."' ";
		$query = $this->db->query($sql);
		return @$query->row[$name];
	}

	public function httppost($url,$data)
	{
		$options = array(
			'http' => array(
				'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
				'method'  => 'POST',
				'content' => http_build_query($data),
			),
		);
		//print_r($options);
		$context  = stream_context_create($options);
		$result = file_get_contents($url, false, $context);
		return $result;
	}
	
	public function httpget($url,$data)
	{
		$options = array(
			'http' => array(
				'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
				'method'  => 'GET',
				'content' => http_build_query($data),
			),
		);
		$context  = stream_context_create($options);
		$result = file_get_contents($url, false, $context);
		return $result;
	}
	public function objectToArray(&$obj)
	{
		
		
		foreach($obj as $key => $item)
		{
			
			if(is_object($item))
			{	
				$obj[$key] = (array)$item;
				$this->objectToArray($item);
			}
		}
	}
	public function select($sql)
	{
		$url = HTTP_SERVICE.'?route=core/db/select';
		$data = array('sql' => base64_encode($sql));
		$str = $this->httppost($url,$data);
		$tb = json_decode($str);
		$this->objectToArray($tb);
		
		return $tb;
	}
	public function insertData($table,$field,$value)
	{
		$url = HTTP_SERVICE.'?route=core/db/insertData';
		$da = array(
						'table'=>$table,
						'field'=>$field,
						'value'=>$value
					);
		
		$id = $this->httppost($url,$da);
		return $id;
	}
	public function updateData($table,$field,$value,$where)
	{
		$url = HTTP_SERVICE.'?route=core/db/updateData';
		$da = array(
						'table'=>$table,
						'field'=>$field,
						'value'=>$value,
						'where'=> base64_encode($where)
					);
		
		$id = $this->httppost($url,$da);
	}
	public function deleteData($table,$where)
	{
		$url = HTTP_SERVICE.'?route=core/db/deleteData';
		$da = array(
						'table'=>$table,
						'where'=> base64_encode($where)
					);
		
		$id = $this->httppost($url,$da);
	}
	
	public function getNextIdVarChar($tablename,$tableid,$temp)
	{
	 	//echo $temp;
		$sql="SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '$temp%'";
		$mid=$this->select($sql);
		
		//echo count($mid);
		if(count($mid)==0)
			return $temp."1";
		
		$mnum=array();
		for($i=0; $i<count($mid); $i++)
		{
			//echo $mid[$i][$tableid];
			//echo substr($mid[$i][$tableid],strlen($temp));
			array_push($mnum,substr($mid[$i][$tableid],strlen($temp)));
		}
		$max=0;
		//print_r($mnum);
		for($i=0; $i<count($mnum); $i++)
			if($max<intval($mnum[$i]))
				$max=intval($mnum[$i]);
		$nextid=$max+1;
		return $temp.$nextid;
	}
}
?>