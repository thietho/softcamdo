<?php
	$class =""; 
	if(@count($childs))
    {
    	$class = "hvp-left hvp-info-content";
	}
?>



<div class="hvp-editor <?php echo $class?>">
    <p>
        <?php echo @$post['description']?>
    </p>
</div>

<?php if(@count($childs)){ ?>

<div class="hvp-info-childs hvp-right">
	<?php foreach($childs as $item){ ?>
    	<a href="<?php echo $this->document->createLink($item['sitemapid'])?>">
    		<img src="<?php echo $item['media']['imagethumbnail']?>">
    	</a>
    <?php } ?>
</div>
<?php } ?>
<div class="clearer">&nbsp;</div>
<?php if(count($attachment)){ ?>
<link rel="stylesheet" href="<?php echo HTTP_SERVER.DIR_VIEW?>css/colorbox.css" />
<script src="<?php echo HTTP_SERVER.DIR_VIEW?>js/jquery.colorbox.js"></script>
<div id="hvp-info-attachment">
	<?php foreach($attachment as $item){ ?>
    <a class="zoom" href="<?php echo $item['preview']?>">
    	<img src="<?php echo $item['imagethumbnail']?>">
    </a>
    <?php } ?>
</div>
<script language="javascript">
$(document).ready(function(e) {
    $(".zoom").colorbox({rel:'zoom'});
});
</script>
<?php } ?>