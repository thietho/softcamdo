<?php
/**
 * Class ControllerReporstProducts
 *
 * @property ModelCoreCards model_core_cards
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 * @property ModelAddonInvoices model_addon_invoices
 * @property ModelCoreBills model_core_bills
 *
 */
class ControllerReportsProducts extends Controller
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
        $this->document->title = "Thông kê lợi nhận theo ngày";

        $this->data['brand'] = array();
        $this->model_core_category->getTree("brand", $this->data['brand']);
        unset($this->data['brand'][0]);

        $this->data['storage'] = array();
        $this->model_core_category->getTree("storage", $this->data['storage']);
        unset($this->data['storage'][0]);

        $this->data['status'] = array();
        $this->model_core_category->getTree("status", $this->data['status']);
        unset($this->data['status'][0]);

        $this->data['groups'] = array();
        $this->data['groups'] = $this->model_addon_group->getList();
    }

    public function index()
    {
        $this->id = 'content';
        $this->template = "reports/products.tpl";
        $this->layout = "layout/home";
        $this->render();
    }

    public function showReport()
    {
        $formdate = $this->date->formatViewDate($this->request->post['formdate']);
        $enddate = $this->date->formatViewDate($this->request->post['enddate']);
        $intformdate = $this->date->timeToInt($formdate);
        $intenddate = $this->date->timeToInt($enddate);
        if($intformdate > $intenddate)
            $this->data['error'] = "Bạn phải chọn từ ngày trước hoặc bằng đến ngày";
        else
        {
            $data = array();
            $where = " AND createdate >= '$formdate' AND createdate <= '$enddate 23:59:59'";
            $data_invoices = $this->model_addon_invoices->getList($where);
            $data_items = $this->model_core_items->getList("ORDER BY `itemname` ASC");
            foreach($data_items as $key => $item)
            {
                $list = $this->string->array_Filter($data_invoices,'itemid',$item['id']);
                $data_items[$key]['count'] = count($list);
                $data_items[$key]['percent'] = count($list) / count($data_invoices) * 100;
            }
            $item = array();
            $item['id'] = 0;
            $item['itemname'] = 'Các loại khác';
            $item['group'] = '';
            $list = $this->string->array_Filter($data_invoices,'itemid',0);
            $item['count'] = count($list);
            $item['percent'] = count($list) / count($data_invoices) * 100;
            $data_items[] = $item;
            $this->data['data'] = $data_items;
            //Tinh phan tram theo group
            foreach($this->data['groups'] as $key => $group)
            {
                $list = $this->string->array_Filter($data_items,'group',$group['groupid']);
                $sumprecent = 0;
                foreach($list as $li)
                {
                    $sumprecent += $li['percent'];
                }
                $this->data['groups'][$key]['percent'] = $sumprecent;
            }
            print_r($this->data['groups']);
        }
        $this->id = 'content';
        $this->template = "reports/products_show.tpl";
        $this->render();
    }

}