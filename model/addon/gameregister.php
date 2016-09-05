<?php
class ModelAddonGameregister extends Model
{ 
	private $arr_col = array(
							
							'fullname',
							'phone',
							'address',
							'email',
							'registime',
							'regiscode',
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `game_register`.* 
									from `game_register` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `game_register`.* 
									from `game_register` 
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
		$this->db->updateData('game_register',$field,$value,$where);
	}
	
	public function save($data)
	{
		$game_register = $this->getItem($data['id']);
		
		$value = array();
		if(count($game_register))
		{
			foreach($game_register as $col => $val)
			{
				if(isset($data[$col]))
					$game_register[$col] = $data[$col];
			}
			$data = $game_register;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		
		$field=$this->arr_col;
		
		if(count($game_register) == 0)
		{
			$data['id'] = $this->db->insertData("game_register",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("game_register",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("game_register",$where);
		
	}
	
}
?>