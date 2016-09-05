<div class="head_title"><span>Danh mục</span></div>
<div class="boxstyle">
            <div id="right-menu-right">
                <ul id="right-menu-panel">
                	<?php echo @$menu?>
                	  
            	</ul>
            <div id="div-line-xanh"></div>
            </div>            
		</div>
        <div class="clear" style="height:10px;"></div>
<script language="javascript">

function menupanel(){
$(" #right-menu-panel ul").css({display: "none"}); // Opera Fix
$(" #right-menu-panel li").hover(function(){
			$(this).find('ul:first').css({visibility: "visible",display: "none"}).show();
		},function(){
			$(this).find('ul:first').css({display: "none"});
		});
}

$(document).ready(function(){					
	menupanel();
	
});
</script>