<?php foreach($nhanhieu as $brand){ ?>
	<h2><?php echo $brand['categoryname']?></h2>
	<?php foreach($brand[data_medias] as $key => $data){ ?>
        <h3><?php echo $data['sitemapname'];?></h3>
        <?php echo $data['listpro'];?>
    <?php }?>
<?php } ?>
