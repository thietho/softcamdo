<?php
class ControllerCommonTygia extends Controller
{
	public function index()
	{
		try 
		{
    		$xml = simplexml_load_file('http://www.vietcombank.com.vn/exchangerates/ExrateXML.aspx');
			$arr=$this->attributestoArr($xml);
			
			/*$this->data['Tygia']['USD']=$this->searchTigia($arr,"CurrencyCode","USD");
			$this->data['Tygia']['AUD']=$this->searchTigia($arr,"CurrencyCode","AUD");
			$this->data['Tygia']['EUR']=$this->searchTigia($arr,"CurrencyCode","EUR");
			$this->data['Tygia']['JPY']=$this->searchTigia($arr,"CurrencyCode","JPY");
			$this->data['Tygia']['GBP']=$this->searchTigia($arr,"CurrencyCode","GBP");*/
			$this->data['Tygia'] = $arr;
			
			$this->id="content";
			$this->template="common/tygia.tpl";
			$this->render();
		} 
		catch (Exception $e) 
		{
			
		}
		
	}
	
	function attributestoArr($objxml)
	{
		$data=array();
		$index=0;
		
		for($i = 0; $i<count($objxml->Exrate) ;$i++)
		{
			$data[$i]= $objxml->Exrate[$i];
		}
		
		return $data;
	}
	function searchTigia($ar,$att,$value)
	{
		foreach($ar as $item)
		{
			if(@$item[$att]==$value)
				return $item;
		}
		return false;
	}
	
	
}
?>