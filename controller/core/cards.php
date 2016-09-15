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
        $moduleid = $_GET['route'];
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
                $this->model_addon_group->delete($id);
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
        $this->render();
    }

    public function getData()
    {
        $data = $this->request->get;
        $where = "";
        foreach($data as $key => $value)
            $data[$key] = trim(urldecode($value));

        if($data['fullname'] != "")
            $where .= " AND `fullname` like '%".$data['fullname']."%'";
        if($data['idnumber'] != "")
            $where .= " AND `idnumber` = '".$data['idnumber']."'";
        if($data['idlocation'] != "")
            $where .= " AND `idlocation` = '".$data['idlocation']."'";


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
        $this->data['item'] = @$this->model_core_items->getItem($id);
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
            $data['price'] = $this->string->toNumber($data['price']);
            $this->model_core_items->save($data);
            @$this->data['output'] = "true";
        }
        else
        {
            foreach(@$this->error as $item)
            {
                $this->data['output'] .= $item."<br>";
            }
        }
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }

    private function validateForm($data)
    {
        if ((strlen($data['itemname']) == 0))
        {
            @$this->error['itemname'] = "Bạn chưa nhập tên sản phẩm";
        }

        if (count(@$this->error)==0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    //Cac ham xu ly tren form
    public function getItems()
    {
        $id = @$this->request->get['id'];
        $item = @$this->model_core_items->getItem($id);
        @$this->data['output'] = json_encode($item);

        @$this->id="item";
        @$this->template="common/output.tpl";
        @$this->render();
    }
}
?>