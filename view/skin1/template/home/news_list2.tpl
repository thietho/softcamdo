<?php if(count($medias)){ ?>
<div class="boxstyle_center_home">
  <div class='clus'>
  	<?php $i=0?>
    <table width='100%' border='0' cellpadding='4' cellspacing='0' bordercolor='#dae5f6' style='border-collapse:collapse'>
    <?php foreach($medias as $media) {?>
    	<?php if($i==0) echo "<tr>"; ?>
      
        <td width='50%' valign="top"><table width='100%' border=0 style='border-collapse:collapse'>
            <tr>
              <td><div style='height:14px; overflow:hidden;'><strong><a href="<?php echo @$media['link']?>"><?php echo @$media['title']?></a></strong></div></td>
            </tr>
            <tr class='row_title_line'>
              <td height='60' valign='top'><table width='100%'>
                  <tr>
                    <td width='30'><a href='http://demo154com935.web30s.vn/view-116347/can-canh-microsoft-surface-book-laptop-13-inch-khung-nhat-qua-dat/'><img alt="<?php echo @$media['title']?>" src="<?php echo @$media['imagethumbnail']?>" width='55' class='border_images'></a></td>
                    <td valign='top'><?php echo @$media['summary']?></td>
                  <tr>
                </table></td>
            </tr>
          </table></td>
        
      <?php $i++;?>
        <?php if($i == 2) { echo "</tr>"; $i=0;}?>
    <?php } ?>
    <?php
    	if($i<3)
        {
        	for( ;$i<2;$i++ )
            {
            	echo "<td td width='50%'></td>";
            }
        }
    ?>
    </table>
  </div>
  <div class="clear" style="height:0px;"></div>
</div>
<?php } ?>
