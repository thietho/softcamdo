<?php
class ModelAddonInvoices extends Model
{
    private $arr_col = array(
        'invoiceid',
        'createdate',
        'createby',
        'itemid',
        'fistname',
        'lastname',
        'fullname',
        'idnumber',
        'iddate',
        'idlocation',
        'phone',
        'group',
        'amount',
        'rate',
        'itemnumber',
        'deallinedate',
        'numberexpirydate',
        'notes',
        'storage',
        'status'
    );
    public function getItem($id)
    {
        $query = $this->db->query("Select `invoices`.*
									from `invoices`
									where id ='".$id."' ");
        return $query->row;
    }

    /**
     * @param string $where
     * @param int $from
     * @param int $to
     * @return mixed
     */
    public function getList($where="", $from=0, $to=0)
    {

        $sql = "Select `invoices`.*
									from `invoices`
									where 1=1";
        $sql.=$where;
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
        $this->db->updateData("invoices",$field,$value,$where);
    }

    public function save($data)
    {
        $invoices = $this->getItem($data['id']);

        $value = array();
        if(count($invoices))
        {
            foreach($invoices as $col => $val)
            {
                if(isset($data[$col]))
                    $invoices[$col] = $data[$col];
            }
            $data = $invoices;
        }

        foreach($this->arr_col as $col)
        {
            $value[] = $this->db->escape(@$data[$col]);
        }

        $field=$this->arr_col;

        if(count($invoices) == 0)
        {
            $data['id'] = $this->db->insertData("invoices",$field,$value);
        }
        else
        {
            $where="id = '".$data['id']."'";
            $this->db->updateData("invoices",$field,$value,$where);
        }
        return $data;
    }

    public function delete($id)
    {
        $where="id = '".$id."'";
        $this->db->deleteData("invoices",$where);

    }

    public function getInvoicesValue($invoiceid,$infoname)
    {
        $sql = "SELECT *
                FROM  `invoices_info`
                WHERE `invoiceid` = '$invoiceid' AND `infoname` = '$infoname'";
        $query = $this->db->query($sql);
        return $query->row['infovalue'];
    }

    public function getInvoices($invoiceid)
    {
        $sql = "SELECT *
                FROM  `invoices_info`
                WHERE `invoiceid` = '$invoiceid'";
        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function saveInvoicesInfo($invoiceid,$infoname,$infovalue)
    {
        $sql = "SELECT *
                FROM  `invoices_info`
                WHERE `invoiceid` = '$invoiceid' AND `infoname` = '$infoname'";
        $query = $this->db->query($sql);
        $info = $query->row;
        $field=array(
            "invoiceid",
            "infoname",
            "infovalue"
        );

        $value=array(
            $invoiceid,
            $infoname,
            $infovalue,
        );
        if(count($info) > 0)
        {
            $where="invoiceid = '".$invoiceid."' AND infoname = '".$infoname."'";
            @$this->db->updateData('invoices_info',$field,$value,$where);
        }
        else
        {
            @$this->db->insertData("invoices_info",$field,$value);
        }
    }

    public function getInvoicesLog($id)
    {
        $sql = "SELECT *
                FROM  `invoices_log`
                WHERE `id` = '$id'";
        $query = $this->db->query($sql);
        return $query->row;
    }

    public function getInvoicesLogList($where)
    {
        $sql = "Select `invoices_log`.*
									from `invoices_log`
									where 1=1";
        $sql.=$where;
        $query = $this->db->query($sql);
        return $query->rows;
    }
}
?>