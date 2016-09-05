<div class="ben-section-title">
    <table class="ben-brand">
        <tr>
    <?php foreach($datas as $key => $item){?>
        <?php if(@$item['parent'] == "nhanhieu"){ ?>
            <td>
            <?php if(@$item['categoryid'] != 'brandother'){ ?>
            <a href="<?php echo @$this->document->createLink('brand',$item['categoryid'])?>" class="<?php echo @$item['categoryid']?>" title="<?php echo @$item['categoryname']?>"><?php echo @$item['categoryname']?></a>
            <?php }else{ ?>
            <a class="<?php echo @$item['categoryid']?>" title="<?php echo @$item['categoryname']?>">...</a>
            <?php } ?>
            
            </td>
    <?php } ?>
        <?php } ?>
        </tr>
    </table>
</div>
			<?php 
                $arr = $this->string->array_Filter($datas,'parent','brandother');
                if(@count($arr))
                {
            ?>
            <ul class="ben-subbrand ben-section-title">
            <?php
                    foreach($arr as $val)
                    {
            ?>
                <li>
                    <a href="<?php echo @$this->document->createLink('brand',$val['categoryid'])?>" title="<?php echo @$val['categoryname']?>"><?php echo @$val['categoryname']?></a>
                </li>
            <?php
                    }
            ?>
            </ul>	
            
            
            <?php
                }
            ?>
<script language="javascript">
$(document).ready(function(e) {
  	$(".brandother").hover(
		function(){
			$(".ben-subbrand").show();
		},
		function(){
			$(".ben-subbrand").hover(function(){},function(){ $(this).hide()});
		}
	); 
});

</script>