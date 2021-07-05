<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreCards model_core_cards
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 * @property ModelAddonInvoices model_addon_invoices
 * @property ModelCoreBills model_core_bills
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
        $this->load->model("core/bills");
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

        $this->id='content';
        $this->template="addon/invoices_home.tpl";
        $this->layout="layout/home";
        $this->render();
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
    public function view()
    {
        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_invoices->getItem($id);
        $info = $this->model_addon_invoices->getInvoicesValue($id,'info');
        $data_info = json_decode(base64_decode($info),true);
        $arr = array();
        foreach($data_info as $key => $val)
        {
            $arr[] = $key.': '.$val;
        }
        $this->data['item']['info'] = implode(' - ',$arr);
        $group = $this->model_addon_group->getItemById($this->data['item']['group']);
        $this->data['item']['period'] = $group['period'];

        @$this->id='content';
        switch($this->data['item']['group'])
        {
            case 'gtx':
                $this->template='addon/invoices_view_gtx.tpl';
                break;
            default:
                $this->template='addon/invoices_view.tpl';
        }

        $this->layout="layout/home";
        @$type = $this->request->get['type'];
        if($type=='popup')
            $this->layout="";
        if($type=='print')
            $this->layout="layout/print";
        @$this->render();
    }

    public function history()
    {
        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_invoices->getItem($id);
        $where = " AND invoiceid = ".$id;
        $this->data['data_log'] = $this->model_addon_invoices->getInvoicesLogList($where);
        $this->data['data_bills'] = $this->model_core_bills->getList($where);
        @$this->id='content';
        @$this->template='addon/invoices_history.tpl';
        $this->layout="layout/home";
        @$type = $this->request->get['type'];
        if($type=='popup')
            $this->layout="";
        if($type=='print')
            $this->layout="layout/print";
        @$this->render();
    }

    public function delete()
    {
        $listid=@$this->request->post['delete'];
        if(count($listid))
        {
            foreach($listid as $id)
                $this->model_addon_invoices->delete($id);
            @$this->data['output'] = "Xóa thành công";
        }
        @$this->id="content";
        @$this->template="common/output.tpl";
        @$this->render();
    }

    public function getList()
    {
        @$this->data['insert'] = @$this->url->http('addon/invoices/insert');
        @$this->data['delete'] = @$this->url->http('addon/invoices/delete');
        $this->data['search'] = $this->request->get;
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
        if(@$data['invoicenumber'] != "")
            $where .= " AND `invoicenumber` like '%".$data['invoicenumber']."%'";
        if(@$data['itemname'] != "")
            $where .= " AND `itemname` like '%".$data['itemname']."%'";
        if(@$data['itemnumber'] != "")
            $where .= " AND `itemnumber` like '%".$data['itemnumber']."%'";
        if(@$data['amount'] != 0)
            $where .= " AND `amount` like '%".$this->string->toNumber($data['amount'])."%'";
        if(@$data['formstartdate'] != "")
            $where .= " AND `startdate` >= '".$this->date->formatViewDate($data['formstartdate'])."'";
        if(@$data['tostartdate'] != "")
            $where .= " AND `startdate` <= '".$this->date->formatViewDate($data['tostartdate'])."'";
        if(@$data['formenddate'] != "")
            $where .= " AND `enddate` >= '".$this->date->formatViewDate($data['formenddate'])."'";
        if(@$data['toenddate'] != "")
            $where .= " AND `enddate` <= '".$this->date->formatViewDate($data['toenddate'])."'";

        if(@$data['fullname'] != "")
            $where .= " AND `fullname` like '%".$data['fullname']."%'";
        if(@$data['idnumber'] != "")
            $where .= " AND `idnumber` = '%".$data['idnumber']."%'";
        if(@$data['idlocation'] != "")
            $where .= " AND `idlocation` = '%".$data['idlocation']."%'";
        if(@$data['iddate'] != "")
            $where .= " AND `iddate` = '".$this->date->formatViewDate($data['iddate'])."'";
        if(@$data['phone'] != "")
            $where .= " AND `phone` = '%".$data['phone']."%'";
        if(@$data['address'] != "")
            $where .= " AND `address` like '%".$data['address']."%'";
        if(@$data['group'] != "")
            $where .= " AND `group` like '".$data['group']."'";
        if(@$data['storage'] != "")
            $where .= " AND `storage` like '%".$data['storage']."%'";
        if(@$data['status'] != "")
            $where .= " AND `status` like '%".$data['status']."%'";
        switch($data['statustime'])
        {
            case "upcoming":
                $where.= $this->model_addon_invoices->whereUpComing();
                break;
            case "deadline":
                $where.= $this->model_addon_invoices->whereDeadLine();
                break;
            case "expired":
                $where.= $this->model_addon_invoices->whereExpired();
                break;
            case "liquidation":
                $where.= $this->model_addon_invoices->whereLiquidation();
                break;
        }
        $where .= " ORDER BY `id` DESC ";
        $this->data['datas'] = array();
        $rows = @$this->model_addon_invoices->getList($where);
        //Page
        $page = $this->request->get['page'];
        $this->session->set('invoicepage',$page);
        //echo $this->session->data['invoicepage'];
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
            $this->data['datas'][$i] = $rows[$i];
            $this->data['datas'][$i]['link_edit'] = $this->url->http('addon/invoices/update&id='.@$this->data['datas'][$i]['id']);
            $this->data['datas'][$i]['text_edit'] = "Sửa";


        }
        $this->data['refres']=$_SERVER['QUERY_STRING'];
        $this->id='content';
        $this->template="addon/invoices_table.tpl";
        $this->render();
    }
    public function getItemGroupInfo()
    {
        $group = $this->request->get['group'];
        $invoiceid = $this->request->get['invoiceid'];

        $objgroup = $this->model_addon_group->getItemById($group);
        $strinfo = $this->model_addon_invoices->getInvoicesValue($invoiceid,'info');
        $data = json_decode(base64_decode($strinfo),true);
        $this->data['group'] = $objgroup;
        if(count($data)== 0)
        {
            $arr = explode('-',$objgroup['infodes']);
            foreach($arr as $val)
                $this->data['infos'][trim($val)] = '';
        }
        else
        {
            //$data = json_decode(base64_decode($strinfo),true);
            $this->data['infos'] = $data;
        }

        $this->id='content';
        $this->template="addon/invoices_group_info.tpl";
        $this->render();
    }
    private function getForm()
    {
        @$this->data['error'] = @$this->error;

        $id = $this->request->get['id'];
        $group = $this->request->get['group'];
        $copyid = $this->request->get['copyid'];
        if($copyid == '')
        {
            if($group == '' && $id == '')
            {
                $this->response->redirect("?route=addon/invoices/getList");
            }
        }


        $this->document->title .= " ".$this->document->getGroup($group);
        if($id!='')
        {
            $this->data['item'] = @$this->model_addon_invoices->getItem($id);

        }
        else
        {

            if($copyid)
            {
                $this->data['item'] = @$this->model_addon_invoices->getItem($copyid);
                $this->data['item']['id'] = '';
                $this->data['item']['copyid'] = $copyid;
                $objgroup = $this->model_addon_group->getItemById($this->data['item']['group']);
                $this->data['item']['enddate'] = date('Y-m-d',time()+24*60*60*$objgroup['period']);
            }else{
                $this->data['item']['startdate'] = date('Y-m-d',time());
                $objgroup = $this->model_addon_group->getItemById($group);
                $this->data['item']['enddate'] = date('Y-m-d',time()+24*60*60*$objgroup['period']);
                $this->data['item']['group'] = $group;
            }

        }
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
            //Luu thong tin khach hang
            $cards = $data['cards'];
            $arr = explode(" ",$cards['fullname']);
            $cards['fistname'] = $arr[count($arr) - 1];
            $cards['lastname'] = $arr[0];
            $cards['iddate'] = $this->date->formatViewDate($cards['iddate']);
            $cards=$this->model_core_cards->save($cards);

            //Luu thong tin invoices
            $invoices = array();
            $invoices['id'] = $data['id'];
            @$invoices['invoicenumber'] = $data['invoicenumber'];
            @$invoices['itemid'] = $data['invoices']['itemid'];
            $invoices['cardid'] = $cards['id'];
            $invoices['fistname'] = $cards['fistname'];
            $invoices['lastname'] = $cards['lastname'];
            $invoices['fullname'] = $cards['fullname'];
            $invoices['idnumber'] = $cards['idnumber'];
            $invoices['iddate'] = $cards['iddate'];
            $invoices['idlocation'] = $cards['idlocation'];
            $invoices['phone'] = $cards['phone'];
            $invoices['address'] = $cards['address'];
            $invoices['email'] = $cards['email'];
            $invoices['group'] = $data['invoices']['group'];
            $invoices['pricenow'] = $this->string->toNumber($data['invoices']['pricenow']);
            $invoices['amount'] = $this->string->toNumber($data['invoices']['amount']);
            $invoices['rate'] = $this->string->toNumber($data['invoices']['rate']);
            $invoices['itemname'] = $data['invoices']['itemname'];
            $invoices['itemnumber'] = $data['invoices']['itemnumber'];
            $invoices['startdate'] = $this->date->formatViewDate($data['invoices']['startdate']);
            $invoices['enddate'] = $this->date->formatViewDate($data['invoices']['enddate']);
            $invoices['numberexpirydate'] = $this->string->toNumber($data['invoices']['numberexpirydate']);
            $invoices['notes'] = $data['invoices']['notes'];
            $invoices['storage'] = $data['invoices']['storage'];

            $invoices = $this->model_addon_invoices->save($invoices);

            //Luu thong tin info
            $info = base64_encode(json_encode($data['info']));

            $this->model_addon_invoices->saveInvoicesInfo($invoices['id'],'info',$info);
            if($data['id']=='')
            {
                //Them phiêu moi tạo phieu chi cho phiêu cầm đồ
                $bill = array();
                $bill['billtype'] = 'pay';
                $bill['createdate'] = $this->date->getToday();
                $bill['createby'] = $this->user->getUserName();
                $bill['accountid'] = '111';
                $bill['amount'] = $this->string->toNumber($invoices['amount']);
                $bill['notes'] = 'Cầm '.$invoices['invoicenumber']." - ".$invoices['itemname']." - ".$invoices['itemnumber'];
                $bill['invoiceid'] = $invoices['id'];
                $bill['invoicestatus'] = 'new';
                $bill['cardid'] = $invoices['cardid'];
                $bill['fullname'] = $invoices['fullname'];
                $this->model_core_bills->save($bill);
            }
            else
            {
                $where = " AND invoiceid = ".$data['id']." AND billtype = 'pay'";
                $data_bill = $this->model_core_bills->getList($where);
                if(count($data_bill))
                {
                    $bill = $data_bill[0];
                    $bill['amount'] = $this->string->toNumber($invoices['amount']);
                    $bill['notes'] = 'Cầm '.$invoices['invoicenumber']." - ".$invoices['itemname']." - ".$invoices['itemnumber'];
                    $bill['invoiceid'] = $invoices['id'];
                    $bill['cardid'] = $invoices['cardid'];
                    $bill['fullname'] = $invoices['fullname'];
                    $this->model_core_bills->save($bill);
                }
                else
                {
                    //Them phiêu moi tạo phieu chi cho phiêu cầm đồ
                    $bill = array();
                    $bill['billtype'] = 'pay';
                    $bill['createdate'] = $this->date->getToday();
                    $bill['createby'] = $this->user->getUserName();
                    $bill['accountid'] = '111';
                    $bill['amount'] = $this->string->toNumber($invoices['amount']);
                    $bill['notes'] = 'Cầm '.$invoices['invoicenumber']." - ".$invoices['itemname']." - ".$invoices['itemnumber'];
                    $bill['invoiceid'] = $invoices['id'];
                    $bill['cardid'] = $invoices['cardid'];
                    $bill['fullname'] = $invoices['fullname'];
                    $this->model_core_bills->save($bill);
                }

            }
            $invoices['error'] = '';
            @$this->data['output'] = json_encode($invoices);
        }
        else
        {
            foreach(@$this->error as $item)
            {
                $data['error'] .= $item."<br>";
            }
            @$this->data['output'] = json_encode($data);
        }
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }

    private function validateForm($data)
    {
        if ((strlen(@$data['cards']['fullname']) == 0))
        {
            @$this->error['fullname'] = "Bạn chưa nhập họ và tên";
        }

        if (count(@$this->error)==0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    public function payRate()
    {
        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_invoices->getItem($id);
        //$this->date->
        $intstartdate = strtotime($this->data['item']['startdate']);
        $datenow = date('Y-m-d',time());
        $intnow = strtotime($datenow);
        $this->data['numdate'] = ($intnow - $intstartdate)/(24*60*60) ;

        @$this->id="item";
        @$this->template="addon/invoices_payrate.tpl";
        @$this->render();
    }
    public function payRateAction()
    {
        $data = $this->request->post;
        $invoice = $this->model_addon_invoices->getItem($data['id']);
        //Tao phieu thu tien lai
        $bill = array();
        $bill['billtype'] = 'collect';
        $bill['createdate'] = $this->date->getToday();
        $bill['createby'] = $this->user->getUserName();
        $bill['accountid'] = '111';
        $bill['amount'] = $this->string->toNumber($data['amount']);
        $bill['notes'] = 'Đóng tiền lãi phiếu '.$invoice['invoicenumber']." - ".$invoice['itemname']." - ".$invoice['itemnumber'];
        $bill['invoiceid'] = $invoice['id'];
        $bill['invoicestatus'] = 'payrate';
        $bill['cardid'] = $invoice['cardid'];
        $bill['fullname'] = $invoice['fullname'];
        $this->model_core_bills->save($bill);
        //Cap nhat startdate va enddate
        $group = $this->model_addon_group->getItemById($invoice['group']);
        $startdate = $this->date->addday($invoice['startdate'],$data['numday']);
        $enddate = $this->date->addday($startdate,$group['period']);
        $this->model_addon_invoices->updateCol($invoice['id'],'startdate',$startdate);
        $this->model_addon_invoices->updateCol($invoice['id'],'enddate',$enddate);
        //Cập nhật trạng thái
        $this->model_addon_invoices->updateCol($invoice['id'],'status','payrate');
        //Ghi log
        $log = array();
        $log['invoiceid'] = $invoice['id'];
        $log['status'] = 'payrate';
        $log['notes'] = $data['notes'];
        $log['datelog'] = $this->date->getToday();
        $this->model_addon_invoices->writelog($log);
        $this->data['output'] = json_encode($invoice);
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }
    public function getBack()
    {
        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_invoices->getItem($id);
        $intstartdate = strtotime($this->data['item']['startdate']);
        $datenow = date('Y-m-d',time());
        $intnow = strtotime($datenow);
        $this->data['numdate'] = ($intnow - $intstartdate)/(24*60*60) ;

        @$this->id="item";
        @$this->template="addon/invoices_getback.tpl";
        @$this->render();
    }
    public function getBackAction()
    {
        $data = $this->request->post;
        $invoice = $this->model_addon_invoices->getItem($data['id']);
        //Tao phieu thu tien lai
        $bill = array();
        $bill['billtype'] = 'collect';
        $bill['createdate'] = $this->date->getToday();
        $bill['createby'] = $this->user->getUserName();
        $bill['accountid'] = '111';
        $bill['amount'] = $this->string->toNumber($data['amount']);
        $bill['notes'] = 'Đóng tiền chuột phiếu '.$invoice['invoicenumber']." - ".$invoice['itemname']." - ".$invoice['itemnumber'];
        $bill['invoiceid'] = $invoice['id'];
        $bill['invoicestatus'] = 'getback';
        $bill['cardid'] = $invoice['cardid'];
        $bill['fullname'] = $invoice['fullname'];
        $this->model_core_bills->save($bill);

        //Cập nhật trạng thái
        $this->model_addon_invoices->updateCol($invoice['id'],'status','getback');
        //Ghi log
        $log = array();
        $log['invoiceid'] = $invoice['id'];
        $log['status'] = 'getback';
        $log['notes'] = $data['notes'];
        $log['datelog'] = $this->date->getToday();
        $this->model_addon_invoices->writelog($log);
        $this->data['output'] = json_encode($invoice);
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();

        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }
    public function payOff()
    {
        $id = $this->request->get['id'];
        $this->data['item'] = @$this->model_addon_invoices->getItem($id);
        $intstartdate = strtotime($this->data['item']['startdate']);
        $datenow = date('Y-m-d',time());
        $intnow = strtotime($datenow);
        $this->data['numdate'] = ($intnow - $intstartdate)/(24*60*60) ;

        @$this->id="item";
        @$this->template="addon/invoices_payoff.tpl";
        @$this->render();
    }
    public function payOffAction()
    {
        $data = $this->request->post;
        $invoice = $this->model_addon_invoices->getItem($data['id']);
        //Tao phieu thu tien lai
        $bill = array();
        $bill['billtype'] = 'collect';
        $bill['createdate'] = $this->date->getToday();
        $bill['createby'] = $this->user->getUserName();
        $bill['accountid'] = '111';
        $bill['amount'] = $this->string->toNumber($data['amount']);
        $bill['notes'] = 'Thanh lý phiếu '.$invoice['invoicenumber']." - ".$invoice['itemname']." - ".$invoice['itemnumber'];
        $bill['invoiceid'] = $invoice['id'];
        $bill['invoicestatus'] = 'payoff';
        $bill['cardid'] = $invoice['cardid'];
        $bill['fullname'] = $invoice['fullname'];
        $this->model_core_bills->save($bill);

        //Cập nhật trạng thái
        $this->model_addon_invoices->updateCol($invoice['id'],'status','payoff');
        //Ghi log
        $log = array();
        $log['invoiceid'] = $invoice['id'];
        $log['status'] = 'payoff';
        $log['notes'] = $data['notes'];
        $log['datelog'] = $this->date->getToday();
        $this->model_addon_invoices->writelog($log);
        $this->data['output'] = json_encode($invoice);
        $this->id='content';
        $this->template='common/output.tpl';
        $this->render();
    }

    //Cac ham xu ly tren form
    public function getInvoices()
    {
        $id = @$this->request->get['id'];
        $item = @$this->model_addon_invoices->getItem($id);
        $item['statustext'] = $this->document->invoicesstatus[$item['status']];
        @$this->data['output'] = json_encode($item);

        @$this->id="item";
        @$this->template="common/output.tpl";
        @$this->render();
    }
}
?>