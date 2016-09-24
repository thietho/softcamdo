<?php
class ModelCoreItems extends Model
{ 
	private $arr_col = array(
							'itemname',
							'price',
							'brand',
                            'group',
                            'files',
                            'link',
                            'status'
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `items`.*
									from `items`
									where id ='".$id."' ");
		return $query->row;
	}
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `items`.*
									from `items`
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
		$this->db->updateData("items",$field,$value,$where);
	}
	
	public function save($data)
	{
		$item = $this->getItem($data['id']);

		$value = array();
		if(count($item))
		{
			foreach($item as $col => $val)
			{
				if(isset($data[$col]))
                    $item[$col] = $data[$col];
			}
			$data = $item;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		
		$field=$this->arr_col;
		
		if($data['id'] == '')
		{
			$data['id'] = $this->db->insertData("items",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("items",$field,$value,$where);
		}
		return $data;
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("items",$where);
		
	}
    public function getItemValue($itemid,$infoname)
    {
        $sql = "SELECT *
                FROM  `items_info`
                WHERE `itemid` = '$itemid' AND `infoname` = '$infoname'";
        $query = $this->db->query($sql);
        return @$query->row['infovalue'];
    }

    public function getItemInfoList($itemid)
    {
        $sql = "SELECT *
                FROM  `items_info`
                WHERE `itemid` = '$itemid'";
        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function saveItemInfo($itemid,$infoname,$infovalue)
    {
        $sql = "SELECT *
                FROM  `items_info`
                WHERE `itemid` = '$itemid' AND `infoname` = '$infoname'";
        $query = $this->db->query($sql);
        $info = $query->row;
        $field=array(
            "itemid",
            "infoname",
            "infovalue"
        );

        $value=array(
            $itemid,
            $infoname,
            $infovalue,
        );
        if(count($info) > 0)
        {
            $where="itemid = '".$itemid."' AND infoname = '".$infoname."'";
            @$this->db->updateData('items_info',$field,$value,$where);
        }
        else
        {
            @$this->db->insertData("items_info",$field,$value);
        }
    }
}
?>