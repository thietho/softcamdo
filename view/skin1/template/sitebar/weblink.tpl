
	<div class="hvp-footer-clients-title"><?php echo $sitemap['sitemapname']?></div>
  	<?php foreach($arrpos as $pos) {?>
    <a href='right1' target='_blank' title="<?php echo @$medias[$pos]['title']?>" href="<?php echo @$medias[$pos]['weblink']?>"><img src="<?php echo @$medias[$pos]['imagethumbnail']?>" title="<?php echo @$medias[$pos]['title']?>"></a>
    <?php } ?>
