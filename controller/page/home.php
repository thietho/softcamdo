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
class ControllerPageHome extends Controller
{
	function __construct() 
	{
        $this->load->model("addon/group");
        $this->load->model("core/category");
        $this->load->model("core/items");
        $this->load->model("core/cards");
        $this->load->model("addon/invoices");
        $this->load->model("core/bills");
        $this->document->title = "Dashboard";
	 	
   	}
	public function index()
	{	
        //Sắp đến hạn
        $where = $this->model_addon_invoices->whereUpComing();
        $this->data['upcoming'] = $this->model_addon_invoices->getList($where);
        //Den hang
        $where = $this->model_addon_invoices->whereDeadLine();
        $this->data['deadline'] = $this->model_addon_invoices->getList($where);
        //Quá hạn
        $where = $this->model_addon_invoices->whereExpired();
        $this->data['expired'] = $this->model_addon_invoices->getList($where);
        //Cần thanh lý
        $where = $this->model_addon_invoices->whereLiquidation();
        $this->data['liquidation'] = $this->model_addon_invoices->getList($where);

		$this->id="content";
		$this->template="page/home.tpl";
		$this->layout="layout/home";
		$this->render();
	}
}
?>