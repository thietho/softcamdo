<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 */
class ControllerCoreItems extends Controller
{
    private $error = array();
    function __construct()
    {
        $this->load->model("addon/group");
        $this->load->model("core/category");
        $this->load->model("core/items");
        $this->load->model("core/cards");
        $moduleid = $_GET['route'];
        $this->document->title = "Quản lý sản phẩm";

        $this->data['brand'] = array();
        $this->model_core_category->getTree("brand",$this->data['brand']);
        unset($this->data['brand'][0]);

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
                $this->model_core_items->delete($id);
            @$this->data['output'] = "Xóa thành công";
        }
        @$this->id="content";
        @$this->template="common/output.tpl";
        @$this->render();
    }

    private function getList()
    {
        @$this->data['insert'] = @$this->url->http('core/items/insert');
        @$this->data['delete'] = @$this->url->http('core/items/delete');
        $this->id='content';
        $this->template="core/items_list.tpl";
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

        if($data['itemname'] != "")
            $where .= " AND `itemname` like '%".$data['itemname']."%'";
        if($data['brand'] != "")
            $where .= " AND `brand` = '".$data['brand']."'";
        if($data['group'] != "")
            $where .= " AND `group` = '".$data['group']."'";
        if($data['status'] != "")
            $where .= " AND `status` = '".$data['status']."'";

        $this->data['datas'] = array();
        $rows = @$this->model_core_items->getList($where);
        //Page
        $page = @$this->request->get['page'];
        $x=$page;
        $limit = 20;
        $total = count($rows);
        // work out the pager values
        $this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"loaditemsdata");

        $pager  = @$this->pager->getPagerData($total, $limit, $page);
        $offset = $pager->offset;
        $limit  = $pager->limit;
        $page   = $pager->page;

        for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
        {
            @$this->data['datas'][$i] = $rows[$i];
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('core/items/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        $this->data['refres']=$_SERVER['QUERY_STRING'];
        $this->id='content';
        $this->template="core/items_table.tpl";
        $this->render();
    }

    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_core_items->getItem($id);
        $this->data['data_info'] = $this->model_core_items->getItemInfoList($id);
        @$this->id='content';
        @$this->template='core/items_form.tpl';
        @$this->layout="layout/home";
        @$this->render();
    }

    public function save()
    {

        $data = @$this->request->post;

        if($this->validateForm($data))
        {
            //$data['price'] = $this->string->toNumber($data['price']);
            $obj = $this->model_core_items->save($data);

            foreach($data['infoname'] as $key => $infoname)
            {
                $infovalue = $data['infovalue'][$key];
                $this->model_core_items->saveItemInfo($obj['id'],$infoname,$infovalue);
            }
            //Xoa info
            $listiddelinfo = explode(',',$data['delinfoid']);
            foreach($listiddelinfo as $infoid)
            {
                if($infoid)
                    $this->model_core_items->deleteInfo($infoid);
            }

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