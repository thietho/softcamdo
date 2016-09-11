<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 *
 */
class ControllerCoreItems extends Controller
{
    private $error = array();
    function __construct()
    {
        $this->load->model("addon/group");
        $this->load->model("core/category");
        $this->load->model("core/items");
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
                $this->model_addon_group->delete($id);
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

        @$this->data['datas'] = array();
        @$this->data['datas'] = @$this->model_core_items->getList();

        for($i=0; $i <= count(@$this->data['datas'])-1 ; $i++)
        {
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('core/items/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        @$this->data['refres']=$_SERVER['QUERY_STRING'];
        @$this->id='content';
        @$this->template="core/items_list.tpl";
        @$this->layout="layout/home";

        @$this->render();
    }


    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_core_items->getItem($id);
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