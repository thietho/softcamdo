<?php
if(@count($medias))
{
?>
<div id="listpoduct">
	<?php foreach($medias as $media) {?>
    <div class="product link_hover" data-tooltip="sticky1" ref="<?php echo @$media['imagetpreview']?>" title="<?php echo @$this->document->productName($media)?>">
        <table>
            <tr class="product-list-image">
                <td width="180px">
                	
                	<?php if(@$media['discountpercent']){ ?>
                	<div class="flagdiscount ben-icon">-<?php echo @$this->string->numberFormate($media['discountpercent'])?>%</div>
                    <?php } ?>
                	
                    <?php if(@$media['imagethumbnail'] !=""){ ?>
                    <a class="islink" href="<?php echo @$media['link']?>" title="<?php echo @$this->document->productName($media)?>"><img src='<?php echo @$media['imagethumbnail']?>' class='ben-center' alt="<?php echo @$this->document->productName($media)?>" title="<?php echo @$this->document->productName($media)?>"/></a>
                    
                    <?php }?>
                    	
                </td>
            
                <td>
                    <div>
                    	<a href="<?php echo @$media['link']?>" title="<?php echo @$this->document->productName($media)?>">
                        	<?php if(@count($media['childs'])){ ?>
                        	<h6>
                            	<?php echo @$media['title']?> - <?php echo @$media['code']?>
                                <?php echo @$media['brand']?>
                                <?php echo @$media['color']?>
                            </h6>
                            <?php }else{ ?>
                            <h6><?php echo @$this->document->productName($media)?></h6>
                            <?php } ?>
                        </a>
                        <?php if(@count($media['childs'])){ ?>
                        <?php foreach($media['childs'] as $me){?>
                        <div>
                        	<?php echo @$me['sizes']?>:<?php echo @$this->string->numberFormate($me['price'])?> <?php echo @$this->document->setup['Currency']?>
                            <?php if(@$me['discountpercent']) echo "Giảm ".$this->string->numberFormate($me['discountpercent'])."%";?>
                        </div>
                        <?php } ?>
                        <?php } ?>
                    </div>
                    <?php if(@count($media['childs'])==0){ ?>
                    <?php $cls = '';?>
                    <?php if(@$media['pricepromotion']!=0){ ?>
                    <div class="product-pricepromotion">
                        	
                        	<?php if(@$media['pricepromotion']){ ?>
                            <?php $cls = 'product-price-no';?>
                        	<?php echo @$this->string->numberFormate($media['pricepromotion'])?> <?php echo @$this->document->setup['Currency']?>
                            <?php } ?>
                    </div>
                    <?php } ?>
                    <div class="product-price <?php echo @$cls?>"><?php echo @$this->string->numberFormate($media['price'])?> <?php echo @$this->document->setup['Currency']?></div>
                    
                    	<?php if(@$media['noteprice']!=""){ ?>
                        (<?php echo @$media['noteprice']?>)<br />
                        <?php }?>
                        <?php if(@$media['noted']!=""){ ?>
                        <em><?php echo @$media['noted']?></em>
                        <?php }?>
                    
                    <?php } ?>
                    <div>
                        <a href="<?php echo @$media['link']?>" title="<?php echo @$media['title']?><?php if(@$media['code']!="") echo ' - '.$media['code']?>">Chi tiết</a><!-- || <a onclick="cart.add('<?php echo @$media['mediaid']?>')">Đặt hàng</a>-->
                    </div>
                </td>
            </tr>
        </table>
        
        
        
        
    </div>
    <?php } ?>
</div>
    


<div class="clearer">&nbsp;</div>
<?php echo @$pager?>
<?php
}
?>
