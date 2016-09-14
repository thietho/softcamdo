<?php
class ModelCoreCards extends Model
{
    private $arr_col = array(
        'fistname',
        'lastname',
        'fullname',
        'idnumber',
        'iddate',
        'idlocation',
        'phone',
        'phone',
        'address',
        'email'
    );
    public function getItem($id)
    {
        $query = $this->db->query("Select `cards`.*
									from `cards`
									where id ='".$id."' ");
        return $query->row;
    }

    public function getList($where="", $from=0, $to=0)
    {

        $sql = "Select `cards`.*
									from `cards`
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
        $this->db->updateData("cards",$field,$value,$where);
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

        if(count($item) == 0)
        {
            $data['id'] = $this->db->insertData("cards",$field,$value);
        }
        else
        {
            $where="id = '".$data['id']."'";
            $this->db->updateData("cards",$field,$value,$where);
        }
        return $data;
    }

    public function delete($id)
    {
        $where="id = '".$id."'";
        $this->db->deleteData("cards",$where);

    }

}
?>