<?php
	$path = base64_decode(trim($_GET['path']));
	$arr = split('/',$path);
	if(file_exists($path))
	{
		$handle = fopen($path, "r");
		echo $contents = fread($handle, filesize($path));
		fclose($handle);	
	}
?>