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
class ControllerReportsProfitdate extends Controller
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
        $this->template = "reports/profitdate.tpl";
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
            while($intformdate <= $intenddate )
            {
                $date = date('Y-m-d',$intformdate);
                $data[] = $this->getProfitDate($date);
                //$data[] = $date;
                $intformdate += 24*60*60;
            }
            $this->data['data'] = $data;
        }
        $this->id = 'content';
        $this->template = "reports/profitdate_show.tpl";
        $this->render();
    }

    public function getProfitDate($date)
    {
        //Tiền lời từ việc khách đến đóng lãi trong ngày
        $where = " AND createdate = '$date' AND invoicestatus = 'payrate'";
        $bills = $this->model_core_bills->getList($where);
        $sumpayrate = 0;
        foreach($bills as $bill)
        {
            $sumpayrate += $bill['amount'];
        }
        //Tiền lời từ việc thanh lý và chuộc trong ngày
        $where = " AND createdate = '$date' AND invoicestatus in ('payoff','getback')";
        $bills = $this->model_core_bills->getList($where);
        $sumprofit = 0;
        foreach($bills as $bill)
        {
            $amount = $bill['amount'];
            $invoiceid = $bill['invoiceid'];
            $invoice = $this->model_addon_invoices->getItem($invoiceid);
            $profit = $amount - $invoice['amount'];
            $sumprofit +=$profit;
        }
        //Tiền dự thu từ các phiếu đang cầm
        $sumwillprofit = 0;
        $where = " AND status in ('new','payrate') AND DATE( '$date' ) - DATE(`startdate`)  > 0";
        $invoices = $this->model_addon_invoices->getList($where);
        $intnow = strtotime($date);
        foreach($invoices as $invoice)
        {
            $intstartdate = strtotime($invoice['startdate']);
            $numdate = ($intnow - $intstartdate)/(24*60*60);
            $profit = $numdate *$invoice['amount']*$invoice['rate']/100/30;
            $sumwillprofit += $profit;
        }
        return array('date'=>$date,'willprofit' => $sumwillprofit,'profit' => $sumpayrate + $sumprofit);
    }
}