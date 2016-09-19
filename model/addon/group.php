<?php
class ModelAddonGroup extends Model
{ 
	private $arr_col = array(
							'groupid',
							'groupname',
							'rate',
                            'infodes'
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `group`.*
									from `group`
									where id ='".$id."' ");
		return $query->row;
	}

    public function getItemById($groupid)
    {
        $query = $this->db->query("Select `group`.*
									from `group`
									where groupid ='".$groupid."' ");
        return $query->row;
    }
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `group`.*
									from `group`
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
		$id = $this->db->escape($id);
		$col = $this->db->escape($col);
		$val = $this->db->escape($val);
		
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData("group",$field,$value,$where);
	}
	
	public function save($data)
	{
		$group = $this->getItem($data['id']);

		$value = array();
		if(count($group))
		{
			foreach($group as $col => $val)
			{
				if(isset($data[$col]))
					$group[$col] = $data[$col];
			}
			$data = $group;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		
		$field=$this->arr_col;
		
		if(count($group) == 0)
		{
			$data['id'] = $this->db->insertData("group",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("group",$field,$value,$where);
		}
		return $data;
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("group",$where);
		
	}
	
}
?>