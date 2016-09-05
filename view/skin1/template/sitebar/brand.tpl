		<div class="head_title"><span>Thương hiệu</span></div>
        <div class="boxstyle">
            <div id="right-menu-right">
                <ul id="right-menu-panel">
                	<?php foreach($data_brand as $item){ ?>
                  	<li><a href="<?php echo @$this->document->createLink('brand', $item['categoryid'])?>" class='menuicon'><?php echo $item['categoryname']?></a></li>
                    <?php } ?>
                	  
            	</ul>
            <div id="div-line-xanh"></div>
            </div>            
		</div>
        <div class="clear" style="height:10px;"></div>