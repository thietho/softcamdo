<?php
/**
 * Class ControllerCoreBills
 *
 * @property ModelCoreBills model_core_bills
 * @property ModelCoreaccounts model_core_accounts
 */
class ControllerCoreBills extends Controller
{
    private $error = array();
    function __construct()
    {
        $this->load->model("core/bills");
        $this->load->model("core/accounts");
        if (isset($moduleid)) {
            $moduleid = $_GET['route'];
        }
        $this->document->title = "Quản lý phiếu thu chi";
    }
    public function index()
    {
        $this->getList();
    }

    public function insert()
    {
        @$this->getForm();
    }

    public function update()
    {

        @$this->data['readonly'] = 'readonly="readonly"';
        @$this->getForm();
    }


    public function delete()
    {
        $listid=@$this->request->post['delete'];
        if(count($listid))
        {
            foreach($listid as $id)
                $this->model_core_bills->delete($id);
            @$this->data['output'] = "Xóa thành công";
        }
        @$this->id="content";
        @$this->template="common/output.tpl";
        @$this->render();
    }

    private function getList()
    {
        @$this->data['insert'] = @$this->url->http('core/bills/insert');
        @$this->data['delete'] = @$this->url->http('core/bills/delete');

        $this->id='content';
        $this->template="core/bills_list.tpl";
        $this->layout="layout/home";
        @$type = $this->request->get['type'];
        if($type=='popup')
            $this->layout="";
        $this->render();
    }

    public function getData()
    {
        $data = $this->request->get;
        $where = "";
        foreach($data as $key => $value)
            $data[$key] = trim(urldecode($value));
        if(@$data['fullname'] != "")
            $where .= " AND `fullname` like '%".$data['fullname']."%'";
        if(@$data['billnumber'] != "")
            $where .= " AND `billnumber` like '%".$data['billnumber']."%'";
        if(@$data['billtype'] != "")
            $where .= " AND `billtype` like '".$data['billtype']."'";
        if(@$data['formcreatedate'] != "")
            $where .= " AND `createdate` >= '".$this->date->formatViewDate($data['formcreatedate'])."'";
        if(@$data['tocreatedate'] != "")
            $where .= " AND `createdate` <= '".$this->date->formatViewDate($data['tocreatedate'])."'";

        $this->data['datas'] = array();
        $rows = @$this->model_core_bills->getList($where);
        //Page
        $page = @$this->request->get['page'];
        $x=$page;
        $limit = 20;
        $total = count($rows);
        // work out the pager values
        $this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"loadbillsdata");

        $pager  = @$this->pager->getPagerData($total, $limit, $page);
        $offset = $pager->offset;
        $limit  = $pager->limit;
        $page   = $pager->page;

        for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
        {
            @$this->data['datas'][$i] = $rows[$i];
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('core/bills/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        $this->data['refres']=$_SERVER['QUERY_STRING'];
        $this->id='content';
        $this->template="core/bills_table.tpl";
        $this->render();
    }

    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        if($id)
        {
            $this->data['item'] = @$this->model_core_bills->getItem($id);
        }
        else
        {
            $this->data['item']['createdate'] = $this->date->getToday();
        }

        @$this->data['datas'] = array();
        @$this->data['datas'] = @$this->model_core_accounts->getDanhMucPhanLoai();

        @$this->id='content';
        @$this->template='core/bills_form.tpl';
        @$this->layout="layout/home";
        @$this->render();
    }

    public function save()
    {

        $data = @$this->request->post;
        if($this->validateForm($data))
        {
            $data['createdate'] = $this->date->formatViewDate($data['createdate']);
            $data['amount'] = $this->string->toNumber($data['amount']);
            $this->model_core_bills->save($data);
            @$this->data['output'] = "true";
        }
        else
        {
            foreach(@$this->error as $item)
            {
                @$this->data['output'] .= $item."<br>";
            }
        }
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }

    private function validateForm($data)
    {
        if ((strlen(@$data['fullname']) == 0))
        {
            @$this->error['fullname'] = "Bạn chưa nhập họ và tên";
        }

        if (count(@$this->error)==0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    //Cac ham xu ly tren form
    public function getCards()
    {
        $col = @$this->request->get['col'];
        $val = @$this->request->get['val'];
        $where = " AND `$col` = '$val'";
        $data = @$this->model_core_cards->getList($where);
        foreach($data as $key => $item)
        {
            $data[$key]['iddate'] = $this->date->formatMySQLDate($item['iddate']);
        }
        @$this->data['output'] = json_encode($data);

        @$this->id="item";
        @$this->template="common/output.tpl";
        @$this->render();
    }
}
?>