

<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER.DIR_CSS?>sagscroller.css" />

<script src="<?php echo HTTP_SERVER.DIR_JS?>sagscroller.js">

/***********************************************
* SAG Content Scroller- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
* This notice must stay intact for legal use
***********************************************/

</script>



<script>

var sagscroller_constants={
	navpanel: {height:'16px', downarrow:'<?php echo HTTP_SERVER.DIR_IMAGE?>down.gif', opacity:0.6, title:'Go to Next Content', background:'black'},
	loadingimg: {src:'<?php echo HTTP_SERVER.DIR_IMAGE?>ajaxloading.gif', dimensions:[100,15]}
}
</script>
<?php foreach($views as $brand => $item){?>
<script>
var sagscroller2=new sagscroller({
	id:'<?php echo @$brand?>',
	mode: 'auto',
	pause: 2500,
	animatespeed: 400 //<--no comma following last option
})

</script>
<div class="ben-section">
    <div class="ben-section-content">
    	<div class="ben-section-title"><a href="<?php echo @$item['link']?>"><?php echo @$item['title']?></a></div>
        <div id="<?php echo @$brand?>" class="sagscroller">
            <ul>
                <?php echo @$item['data']?>
            </ul>
        </div>
    </div>
    
</div>
<?php } ?>