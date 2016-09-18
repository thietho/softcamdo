<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreCards model_core_cards
 *
 */
class ControllerCoreCards extends Controller
{
    private $error = array();
    function __construct()
    {
        $this->load->model("core/cards");
        if (isset($moduleid)) {
            $moduleid = $_GET['route'];
        }
        $this->document->title = "Quản lý khách hàng";
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
                $this->model_core_cards->delete($id);
            @$this->data['output'] = "Xóa thành công";
        }
        @$this->id="content";
        @$this->template="common/output.tpl";
        @$this->render();
    }

    private function getList()
    {
        @$this->data['insert'] = @$this->url->http('core/cards/insert');
        @$this->data['delete'] = @$this->url->http('core/cards/delete');

        $this->id='content';
        $this->template="core/cards_list.tpl";
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
        if(@$data['idnumber'] != "")
            $where .= " AND `idnumber` like '%".$data['idnumber']."%'";
        if(@$data['idlocation'] != "")
            $where .= " AND `idlocation` like '%".$data['idlocation']."%'";


        $this->data['datas'] = array();
        $rows = @$this->model_core_cards->getList($where);
        //Page
        $page = @$this->request->get['page'];
        $x=$page;
        $limit = 20;
        $total = count($rows);
        // work out the pager values
        $this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"loadcardsdata");

        $pager  = @$this->pager->getPagerData($total, $limit, $page);
        $offset = $pager->offset;
        $limit  = $pager->limit;
        $page   = $pager->page;

        for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
        {
            @$this->data['datas'][$i] = $rows[$i];
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('core/cards/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        $this->data['refres']=$_SERVER['QUERY_STRING'];
        $this->id='content';
        $this->template="core/cards_table.tpl";
        $this->render();
    }

    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_core_cards->getItem($id);
        @$this->id='content';
        @$this->template='core/cards_form.tpl';
        @$this->layout="layout/home";
        @$this->render();
    }

    public function save()
    {

        $data = @$this->request->post;
        if($this->validateForm($data))
        {
            $arr = explode(" ",$data['fullname']);
            $data['fistname'] = $arr[count($arr) - 1];
            $data['lastname'] = $arr[0];
            $data['iddate'] = $this->date->formatViewDate($data['iddate']);
            $this->model_core_cards->save($data);
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