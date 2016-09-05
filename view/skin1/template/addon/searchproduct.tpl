<script language="javascript">
	//alert(window.location);
	var str = new String();
	str = window.location.toString();
	var arr = str.split('?');
	//alert(arr[1]);
	window.location = "<?php echo @$this->document->createLink('product')?>?"+arr[1];
</script>