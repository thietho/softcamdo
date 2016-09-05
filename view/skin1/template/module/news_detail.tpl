<div class="ben-post">
	<?php if(@$post['imagethumbnail'] !=""){ ?>
	<img src='<?php echo @$post['imagethumbnail']?>' class='ben-alignleft' />
	<?php }?>
    <h2><?php echo @$post['title']?></h2>
    <div class="fb-like" data-href="<?php echo @$post['link']?>" data-layout="button" data-action="like" data-show-faces="true" data-share="true"></div>
    <div class="ben-post-date"><?php echo @$post['statusdate']?></div>
    
    <div class="clearer">&nbsp;</div>
    <p>
    <?php echo @$post['description']?>
    </p>
    <p class="ben-text-right">
        <b><?php echo @$post['source']?></b>
    </p>
</div>




<?php if(@$othernews) {?>
<h3>Các tin khác</h3>             
<div>
    <ul>
    	<?php foreach($othernews as $media) {?>
        <li><a href="<?php echo @$media['link']?>"><?php echo @$media['title']?>&nbsp;<span class="ben-other">(<?php echo @$media['statusdate']?>)</span></a></li>
        <?php } ?>    
    </ul>
</div>
<?php } ?>

<div class="clearer">&nbsp;</div>