<?php if(count($medias)){ ?>
<div class="boxstyle_center_home">
  <div class='clus'>
    <table width='100%' border='0' cellpadding='4' cellspacing='0' bordercolor='#dae5f6' style='border-collapse:collapse'>
    <?php foreach($medias as $media) {?>
      <div class='box_lon dotted_down news_home_1' style='; margin-bottom:10px;'>
        <div class='box_lon_vuong_trai news_home_2'><a href="<?php echo @$media['link']?>" class='title_headline'><img alt="<?php echo @$media['title']?>" src="<?php echo @$media['imagethumbnail']?>" width='120' height='86' class='border_images'></a></div>
        <div class='box_lon_vuong_phai news_home_3'  style=''><a href="<?php echo @$media['link']?>" class='title_headline'><strong><?php echo @$media['title']?></strong></a>
          <div class='xamnho' style='padding-bottom:5px;'><?php echo @$media['statusdate']?></div>
          <div align='justify' class='text_color'><?php echo @$media['summary']?></div>
          <div class='xemchitiet' align='right' style='display:none;'><a href="<?php echo @$media['link']?>"><small>&raquo; Xem chi tiết</small></a></div>
        </div>
      </div>
      <?php } ?>
      
      
    </table>
  </div>
  <div class="clear" style="height:0px;"></div>
</div>
<div class="clear" style="height:8px;"></div>
<?php } ?>