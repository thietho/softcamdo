<?php
class ModelAddonRequest extends Model
{ 
	private $arr_col = array(
							
							'fullname',
							'phone',
							'address',
							'skinstatus',
							'birthday',
							'cosused',
							'coscur',
							'unknownorigin',
							'note',
							'attachments',
							'datesend',
							'status',
							'reply'
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `request`.* 
									from `request` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `request`.* 
									from `request` 
									where 1=1 " . $where ;
		if(@$to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function updateCol($id,$col,$val)
	{
		$id = $id;
		$col = $col;
		$val = $val;
		
		
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('request',$field,$value,$where);
	}
	
	public function save($data)
	{
		$request = $this->getItem($data['id']);
		
		$value = array();
		if(count($request))
		{
			foreach($request as $col => $val)
			{
				if(isset($data[$col]))
					$request[$col] = $data[$col];
			}
			$data = $request;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($request) == 0)
		{
			$data['id'] = $this->db->insertData("request",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("request",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("request",$where);
		
	}
	
}
?>