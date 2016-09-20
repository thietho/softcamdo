<?php
class ModelCoreAccounts extends Model
{

    public function getItem($accountid, $where="")
    {
        $query = @$this->db->query("Select `accounts`.*
									from `accounts` 
									where accountid ='".$accountid."' ".$where);
        return $query->row;
    }

    public function getList($where="", $from=0, $to=0,$order = " Order by amount")
    {

        $sql = "Select `accounts`.*
									from `accounts` 
									where 1=1 " . $where . $order;
        if(@$to > 0)
        {
            $sql .= " Limit ".$from.",".$to;
        }
        //echo $sql;
        $query = @$this->db->query($sql);
        return $query->rows;
    }

    public function getChild($accountid ,$order = " Order by accountid")
    {
        $where = " AND parent = '".$accountid."'";
        return @$this->getList($where);
    }

    protected function getnextid($prefix)
    {
        $id=@$this->db->getNextIdVarChar("accounts","accountid",$prefix);
        return $id;
    }

    public function nextamount($parent)
    {
        $sql = "Select max(amount) as max From accounts where parent='".$parent."'";
        $query = @$this->db->query($sql);
        return $query->rows[0]['max'] +1 ;
    }

    public function insert($data)
    {
        $accountid= @$this->db->escape(@$data['accountid']);
        $accountname=@$this->db->escape(@$data['accountname']);
        $parent=@$this->db->escape(@$data['parent']);
        $amount= (int)@$this->nextamount($parent);



        $field=array(
            'accountid',
            'accountname',
            'parent'

        );
        $value=array(
            $accountid,
            $accountname,
            $parent,

        );
        @$this->db->insertData("accounts",$field,$value);

        return $accountid;
    }

    public function update($data)
    {
        $accountid= @$this->db->escape(@$data['accountid']);
        $accountname=@$this->db->escape(@$data['accountname']);
        $parent=@$this->db->escape(@$data['parent']);

        $field=array(
            'accountid',
            'accountname',
            'parent'
        );
        $value=array(
            $accountid,
            $accountname,
            $parent
        );

        $where="accountid = '".$accountid."'";
        @$this->db->updateData("accounts",$field,$value,$where);



        return true;
    }

    public function updateCol($accountid,$col,$val)
    {

        $col = $this->db->escape($col);
        $val = $this->db->escape($val);


        $field=array(
            $col
        );
        $value=array(
            $val
        );

        $where="accountid = '".$accountid."'";
        @$this->db->updateData("accounts",$field,$value,$where);
    }
    public function save($data)
    {
        $item = @$this->getItem($data['accountid']);
        if(count($item) == 0)
        {
            @$this->insert($data);
        }
        else
        {
            @$this->update($data);
        }
    }

    public function delete($accountid)
    {
        $data = @$this->getChild($accountid);
        if(count($data)==0)
        {
            $where="accountid = '".$accountid."'";
            @$this->db->deleteData("accounts",$where);

        }
    }

    public function deletedatas($data)
    {
        if(count($data)>0)
        {
            foreach($data as $item)
                @$this->delete($item);
        }
    }

    //Tree
    function getTree($id, &$data, $level=-1, $path="", $parentpath="")
    {
        $arr=@$this->getItem($id);

        $rows = @$this->getChild($id);

        @$arr['countchild'] = count($rows);

        if(@$arr['parent'] != "")
            $parentpath .= "-".$arr['parent'];

        if(@$id!="" )
        {
            $level += 1;
            $path .= "-".$id;

            @$arr['level'] = $level;
            @$arr['path'] = $path;
            @$arr['parentpath'] = $parentpath;

            array_push($data,$arr);
        }


        if(count($rows))
            foreach($rows as $row)
            {
                @$this->getTree($row['accountid'], $data, $level, $path, $parentpath);
            }
    }

    public function getDanhMucPhanLoai()
    {
        $data = array();
        @$this->getTree(@$this->root,$data);
        foreach($data as $key =>$item)
        {
            $data[$key]['parentpath'] = str_replace("-".@$this->root,"",$data[$key]['parentpath']);
            $data[$key]['path'] = str_replace("-".@$this->root,"",$data[$key]['path']);
        }
        return $data;
    }
}
?>