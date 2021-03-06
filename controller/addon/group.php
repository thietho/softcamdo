<?php
/**
 * Class ControllerCoreUser
 *
 * @property ModelAddonGroup model_addon_group

 *
 */
class ControllerAddonGroup extends Controller
{
    private $error = array();
    function __construct()
    {
        @$this->load->model("addon/group");
        $moduleid = $_GET['route'];
        $this->document->title = "Quản lý nhóm";
    }
    public function index()
    {

        @$this->getList();
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
        //$listmadonvi=$_POST['delete'];

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
        @$this->data['insert'] = @$this->url->http('addon/group/insert');
        @$this->data['delete'] = @$this->url->http('addon/group/delete');

        @$this->data['datas'] = array();
        @$this->data['datas'] = @$this->model_addon_group->getList();

        for($i=0; $i <= count(@$this->data['datas'])-1 ; $i++)
        {
            //@$this->data['datas'][$i] = $rows[$i];
            @$this->data['datas'][$i]['arrlistrate'] = json_decode(base64_decode(@$this->data['datas'][$i]['listrate']),true);
            //if(count($this->data['datas'][$i]['arrlistrate'])) echo count($this->data['datas'][$i]['arrlistrate']);
            @$this->data['datas'][$i]['link_edit'] = $this->url->http('addon/group/update&id='.@$this->data['datas'][$i]['id']);
            @$this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        @$this->data['refres']=$_SERVER['QUERY_STRING'];
        @$this->id='content';
        @$this->template="addon/group_list.tpl";
        @$this->layout="layout/home";

        @$this->render();
    }


    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_group->getItem($id);
        $this->data['listrate'] = json_decode(base64_decode($this->data['item']['listrate']),true);

        @$this->id='content';
        @$this->template='addon/group_form.tpl';
        @$this->layout="layout/home";

        @$this->render();
    }

    public function save()
    {

        $data = @$this->request->post;
        if($this->validateForm($data))
        {
            if(isset($data['listamount']))
            {
                $listamount = $data['listamount'];
                $listrate = $data['listrate'];


                $arrlistrate = array();
                foreach($listamount as $key =>$amount)
                {
                    $arrlistrate[$this->string->toNumber($amount)] = $listrate[$key];
                }
                $data['listrate'] = base64_encode(json_encode($arrlistrate));
            }
            else
                $data['listrate'] = '';

            $this->model_addon_group->save($data);
            @$this->data['output'] = "true";
        }
        else
        {
            foreach(@$this->error as $item)
            {
                @$this->data['output'] .= $item."<br>";
            }
        }
        @$this->id='content';
        @$this->template='common/output.tpl';
        @$this->render();
    }

    private function validateForm($data)
    {
        if(@$data['id'] == "" && strlen($data['groupid']) > 0)
        {
            if($this->validation->_isId(trim($data['groupid'])) == false)
            {
                $this->error['groupid'] = "Mã nhóm không hợp lệ";
            }
            else
            {
                $where = " AND `groupid` = '".$data['groupid']."'";
                $items = $this->model_addon_group->getList($where);
                if(count($items)>0)
                    $this->error['groupid'] = "Mã nhóm đã được sử dụng";
            }
        }
        if ((strlen($data['groupid']) == 0))
        {
            @$this->error['groupid'] = "Bạn chưa nhập mã nhóm";
        }


        if ((strlen($data['groupname']) == 0))
        {
            @$this->error['groupname'] = "Bạn chưa nhập tên nhóm";
        }

        if (count(@$this->error)==0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    //Cac ham xu ly tren form
    public function getGroup()
    {
        $groupid = @$this->request->get['groupid'];
        $item = @$this->model_addon_group->getItemById($groupid);
        $item['arrlistrate'] = json_decode(base64_decode($item['listrate']),true);
        $item['coutlistrate'] = count($item['arrlistrate']);
        @$this->data['output'] = json_encode($item);

        @$this->id="item";
        @$this->template="common/output.tpl";
        @$this->render();
    }
}
?>