<?php
if(@count($medias))
{
?>
<div class="boxstyle">
	<?php foreach($medias as $media){ ?> 
    <div style='border-bottom:1px dotted #CCCCCC; margin:10px;' align='center'>
    	<?php if($media['discountpercent']>0){ ?>
        	<div class="flagdiscountsitebar"><?php echo $media['discountpercent']?>%</div>
        <?php } ?>
        <a href="<?php echo @$media['link']?>">
        	<img alt='<?php echo @$this->document->productName($media)?>' data-src="<?php echo $media['imagethumbnail']?>" width='120' height='auto' class='img_3 lazy'></a>
        	<strong>
            	<a href="<?php echo @$media['link']?>">
                	<?php if($media['discountpercent']==0){ ?>
            		<div class='clear do_nho'><?php echo @$this->string->numberFormate($media['price'])?><?php echo @$this->document->setup['Currency']?></div>
                    <?php }else{ ?>
                    <div class='clear den_nho'><?php echo @$this->string->numberFormate($media['price'])?><?php echo @$this->document->setup['Currency']?></div>
                    <div class='clear do_nho'><?php echo @$this->string->numberFormate($media['pricepromotion'])?><?php echo @$this->document->setup['Currency']?></div>
                    <?php } ?>
            		<div class='clear'></div>
                    <?php echo @$this->document->productName($media)?></a>
            </strong>
            <div align='center'><a class="btncart" onclick="cart.add('<?php echo @$media['mediaid']?>')"><img src='<?php echo HTTP_SERVER.DIR_IMAGE?>chonmua.png' border='0'></a></div>
    </div>
	<?php } ?>
	<div class="clear" style="height:1px;"></div>
</div>
<?php } ?>
<div class="clear" style="height:10px;"></div>