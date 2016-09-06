<?php
final class User {
	private $userid;
	private $username;
	private $siteid;
	private $usertypeid;
	public $nhanvien = array();
  	private $permission = array();
	private $Control = array();
	

  	public function __construct() {
		$this->db = Registry::get('db');
		$this->request = Registry::get('request');
		$this->session  = Registry::get('session');
		$this->json  = Registry::get('json');
		$this->string  = Registry::get('string');
		$this->date  = Registry::get('date');
		if(@$this->request->get['lang'])
		{
			$this->session->set('siteid',$this->request->get['lang']);
		}
		else
		{
			if (!isset($this->session->data['siteid'])) {
				$this->session->set('siteid',SITEID);
			}
		}
		
		$this->siteid = $this->session->data['siteid'];
  	}
		
  	
	
	public function setPermission($strPermission)
	{
		$this->permission = array();
		
		$this->permission = $this->string->referSiteMapToArray($strPermission);
		
	}

	

	public function hasPermission($moduleid, $action) 
	{
		
		if($this->usertypeid == 'admin')
			return true;
		$allow = false;
		if (count($this->permission)) 
		{
			$moduleid = trim($moduleid);
			$action = trim($action);
			foreach($this->permission as $item)
			{
				@$arr = split("-",$item);
				if($arr[0] ==$moduleid && $arr[1] == $action )
					$allow = true;
			}
		}
		
		return $allow;
	}
  
  	public function isLogged() {
    	if($this->session->data['userid']){
			$this->usertypeid = $this->session->data['usertypeid'];
			$this->userid = $this->session->data['userid'];
			$this->username = $this->session->data['username'];	
			$this->siteid = $this->session->data['siteid'];		
			return true;
		}
		
		return false;
  	}
	
	public function isCMSLogged() {
    	if($this->session->data['cmsuserid']){
			$this->usertypeid = $this->session->data['usertypeid'];
			$this->userid = $this->session->data['userid'];
			$this->username = $this->session->data['username'];
			
			return true;
		} 
		return false;
  	}
  	public function logout() {
		unset($_SESSION['safemode']);
		unset($_SESSION['userid']);
		unset($_SESSION['username']);
		unset($_SESSION['sessionid']);
		unset($this->session->data['sessionid']);
		unset($this->session->data['userid']);	
		$this->userid = '';
		$this->username = '';
		$this->safemode = false;
  	}
	public function setSessionId($sessionid)
	{
		$this->session->set('sessionid',$sessionid);
	}
	public function getSessionId()
	{
		return $this->session->data['sessionid'];
	}
  	public function getId() {
    	return $this->userid;
  	}
	
	public function getUserTypeId() {
    	return $this->usertypeid;
  	}
	
	public function getSiteId() {
    	return $this->siteid;
  	}
	
  	public function getUserName() {
    	return $this->username;
  	}
	
	public function getPermission() {
		return $this->permission;
	}
	
	public function getLayout()
	{
		
		switch($this->getUserTypeId())
		{
			case 'user':
				$layout="layout/user";
				break;
			case 'admin':
				$layout="layout/center";
		}
		return $layout;
	}
	public function writeLog($detail)
	{
		$logdate = $this->date->getToday();
		$field=array(

						'logdate',
						'detail',
						'userid'
						
						);
						$value=array(

						$logdate,
						$detail,
						$this->userid
						);
						$this->db->insertData("log",$field,$value);

	}

	
	
	
	
	public function getLogs($where)
	{
		$sql = "Select `log`.*
									from `log` 
									where 1=1 " . $where;

		$query = $this->db->query($sql);
		return $query->rows;
	}
	
//BENGIN PERMISSION JSON
	
	
	//return array
	public function _getJSONArray($strJSON)
	{
		//$this->json  = Registry::get('json');
		$arr = array();
		if($strJSON != "") return $this->json->decode($strJSON);
		return $arr;
	}
	
	//return array
	public function _getModules($arrJSON)
	{
		$arr = array();
		if(count($arrJSON) > 0)
		{
			return $arrJSON[0];
		}
		return $arr;
	}


	public function _getModules_Filter($arrJSON)
	{
		$arr = array();
			
		if(count($arrJSON) > 0)
		{
			
			if(count($arrJSON[0]) > 0)
			{
				foreach($arrJSON[0] as $moduleid)
				{
					$arrP = $this->_getPermissions($moduleid, $arrJSON);
					$arrS = $this->_getSitemaps($moduleid, $arrJSON);
					if(count($arrP) > 0 || count($arrS) > 0)
					{
						array_push($arr, $moduleid);
					}
				}
			}
		}
		return $arr;
	}

	
	//return array
	public function _getPermissions($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][0]) > 0)
		{
			return $arrJSON[$index][0];
		}

		return $arr;
	}
	
	//return array
	public function _getSitemaps($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][1]) > 0)
		{
			return $arrJSON[$index][1];
		}

		return $arr;
	}
//END PERMISSION JSON
	
}
?>