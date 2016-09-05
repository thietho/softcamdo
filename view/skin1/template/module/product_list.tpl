<?php
if(@count($medias))
{
?>
<div class="boxstyle_center_home">
  <div class='clus'>
    <table width='100%' cellpadding='5'>
    <?php $i=0?>
    <?php foreach($medias as $media) {?>
    	<?php if($i==0) echo "<tr>";?>
    	<td width='33%' class='row_nam'>
        <?php if($media['discountpercent']>0){ ?>
        <div class="flagdiscount"><?php echo $media['discountpercent']?>%</div>
        <?php } ?>
        <div align='center' style='padding:3px;'><a href="<?php echo @$media['link']?>" class='color_2'><img data-src="<?php echo @$media['imagethumbnail']?>" class="lazy loading"/></a>
            <div class='clear' style='height:1px;'></div>
            <div style='height:50px;overflow:hidden;'>
            <?php if($media['discountpercent']==0){ ?>
              <div class='clear maudo' align='center'><strong><?php echo @$this->string->numberFormate($media['price'])?><?php echo @$this->document->setup['Currency']?></strong></div>
              
            <?php }else{ ?>
            	<div class='clear' align='center'><strong><?php echo @$this->string->numberFormate($media['price'])?><?php echo @$this->document->setup['Currency']?></strong></div>
            	<div class='clear maudo' align='center'><strong><?php echo @$this->string->numberFormate($media['pricepromotion'])?><?php echo @$this->document->setup['Currency']?></strong></div>
            <?php } ?>
              <div class='clear'></div>
              <a href="<?php echo @$media['link']?>"><?php echo @$this->document->productName($media)?></a></div>
            <div align='center'><a class="btncart" onclick="cart.add('<?php echo @$media['mediaid']?>')"><img src='<?php echo HTTP_SERVER.DIR_IMAGE?>chonmua.png' border='0' ></a></div>
          </div>
        </td>
        <?php $i++;?>
        <?php if($i == 3) { echo "</tr>"; $i=0;}?>
    <?php } ?>
    <?php
    	if($i<3)
        {
        	for( ;$i<3;$i++ )
            {
            	echo "<td class='row_nam'></td>";
            }
        }
    ?>
      
    </table>
  </div>
  <div class="clear" style="height:0px;"></div>
</div>


    



<?php
}
?>
<script type="text/javascript">
//loadLazy();
</script>

