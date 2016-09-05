<div class="boxstyle">
  <marquee id="marqueelup2" onmouseover="marqueelup2.stop()" onmouseout="marqueelup2.start()" scrollamount="2" scrolldelay="100" direction="up" style="width: 100%; height: 300px;">
  <?php foreach($medias as $media) {?>
  <table width='100%' border=0 style='border-collapse:collapse'>
    <tr>
      <td><div class='left_news_hay' style='height:17px; overflow:hidden;'><strong><a href="<?php echo @$media['link']?>"><?php echo @$media['title']?></a></strong></div></td>
    </tr>
    <tr class='row_title_line'>
      <td height='50' valign='top'><table width='100%'>
          <tr>
            <td width='30'><a href="<?php echo @$media['link']?>"><img alt="<?php echo @$media['title']?>" width='55px' class='border_images' src="<?php echo @$media['imagethumbnail']?>"></a></td>
            <td valign='top'><?php echo @$media['summary']?></td>
          <tr>
        </table></td>
    </tr>
  </table>
  <?php } ?>
  </marquee>
  <div class="clear" style="height:0px;"></div>
</div>
<div class="clear" style="height:10px;"></div>
