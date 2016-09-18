<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreCards model_core_cards
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 * @property ModelAddonInvoices model_addon_invoices
 *
 */
class ControllerAddonInvoices extends Controller
{
    private $error = array();
    function __construct()
    {
        $this->load->model("addon/group");
        $this->load->model("core/category");
        $this->load->model("core/items");
        $this->load->model("core/cards");
        $this->load->model("addon/invoices");
        if (isset($moduleid)) {
            $moduleid = $_GET['route'];
        }
        $this->document->title = "Quản lý phiếu cầm đồ";
        
        $this->data['brand'] = array();
        $this->model_core_category->getTree("brand",$this->data['brand']);
        unset($this->data['brand'][0]);

        $this->data['storage'] = array();
        $this->model_core_category->getTree("storage",$this->data['storage']);
        unset($this->data['storage'][0]);

        $this->data['status'] = array();
        $this->model_core_category->getTree("status",$this->data['status']);
        unset($this->data['status'][0]);

        $this->data['groups'] = array();
        $this->data['groups'] = $this->model_addon_group->getList();
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
        @$this->data['insert'] = @$this->url->http('addon/invoices/insert');
        @$this->data['delete'] = @$this->url->http('addon/invoices/delete');

        $this->id='content';
        $this->template="addon/invoices_list.tpl";
        $this->layout="layout/home";
        $this->render();
    }

    public function getData()
    {
        $data = $this->request->get;
        $where = "";
        foreach($data as $key => $value)
            $data[$key] = trim(urldecode($value));
        if(@$data['invoiceid'] != "")
            $where .= " AND `invoiceid` like '%".$data['invoiceid']."%'";
        if(@$data['fullname'] != "")
            $where .= " AND `fullname` like '%".$data['fullname']."%'";
        if(@$data['idnumber'] != "")
            $where .= " AND `idnumber` = '%".$data['idnumber']."%'";
        if(@$data['idlocation'] != "")
            $where .= " AND `idlocation` = '%".$data['idlocation']."%'";
        if(@$data['phone'] != "")
            $where .= " AND `phone` = '%".$data['phone']."%'";
        if(@$data['idlocation'] != "")
            $where .= " AND `idlocation` = '%".$data['idlocation']."%'";


        $this->data['datas'] = array();
        $rows = @$this->model_addon_invoices->getList($where);
        //Page
        $page = @$this->request->get['page'];
        $x=$page;
        $limit = 20;
        $total = count($rows);
        // work out the pager values
        $this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"loadinvoicesdata");

        $pager  = @$this->pager->getPagerData($total, $limit, $page);
        $offset = $pager->offset;
        $limit  = $pager->limit;
        $page   = $pager->page;

        for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
        {
            @$this->data['datas'][$i] = $rows[$i];
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('addon/invoices/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        $this->data['refres']=$_SERVER['QUERY_STRING'];
        $this->id='content';
        $this->template="addon/invoices_table.tpl";
        $this->render();
    }
    public function getItemGroupInfo()
    {
        $group = $this->request->get['group'];

        $this->id='content';
        $this->template="addon/invoices_group_".$group.".tpl";
        $this->render();
    }
    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_core_cards->getItem($id);
        @$this->id='content';
        @$this->template='addon/invoices_form.tpl';
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
            $data['createdate'] = $this->date->formatViewDate($data['createdate']);
            $data['deallinedate'] = $this->date->formatViewDate($data['deallinedate']);
            $this->model_addon_invoices->save($data);
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
    public function getItems()
    {
        $id = @$this->request->get['id'];
        $item = @$this->model_core_cards->getItem($id);
        @$this->data['output'] = json_encode($item);

        @$this->id="item";
        @$this->template="common/output.tpl";
        @$this->render();
    }
}
?>