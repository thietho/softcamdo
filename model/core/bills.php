<?php
/**
 * Class ControllerCoreUser
 *
 * @property db db

 *
 */
class ModelCoreBills extends Model
{
    private $arr_col = array(
        'billnumber',
        'billtype',
        'createdate',
        'createby',
        'accountid',
        'amount',
        'notes',
        'invoiceid',
        'invoicestatus',
        'cardid',
        'fullname'


    );
    public function getItem($id)
    {
        $query = $this->db->query("Select `bills`.*
									from `bills`
									where id ='".$id."' ");
        return $query->row;
    }

    public function getList($where="", $from=0, $to=0)
    {

        $sql = "Select `bills`.*
									from `bills`
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
        $this->db->updateData("bills",$field,$value,$where);
    }
    private function createInvoiceNumber($prefix)
    {
        return $this->db->getNextIdVarChar('bills',"billnumber",$prefix);
    }
    public function save($data)
    {
        @$item = $this->getItem($data['id']);

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
        else
        {
            $prefix = Date('Ymd',time());
            $data['billnumber'] = $this->createInvoiceNumber($prefix);
        }

        foreach($this->arr_col as $col)
        {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field=$this->arr_col;

        if(count($item) == 0)
        {
            $data['id'] = $this->db->insertData("bills",$field,$value);
        }
        else
        {
            $where="id = '".$data['id']."'";
            $this->db->updateData("bills",$field,$value,$where);
        }
        return $data;
    }

    public function delete($id)
    {
        $where="id = '".$id."'";
        $this->db->deleteData("bills",$where);

    }

}
?>