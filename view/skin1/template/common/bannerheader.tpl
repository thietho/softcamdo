<div class="head_banner" style="margin-top:0px; margin-bottom:0px;"><div class="fix980" align="center">   
     <link rel='stylesheet' id='camera-css'  href='<?php echo HTTP_SERVER.DIR_CSS?>camera.css' type='text/css' media='all'> 
        <style>
            #back_to_camera {
                clear: both;
                display: block;
                height: 80px;
                line-height: 40px;
                padding: 20px;
            }
            .fluid_container {
                margin: 0 auto;
                max-width: 980px;
                width: 90%;
            }
        </style>
        
        <script type='text/javascript' src='<?php echo HTTP_SERVER.DIR_JS?>camera.min.js'></script> 
        <script>

            jQuery(function(){
                jQuery('#camera_wrap').camera({
                    thumbnails  : false,
                    height      : '200px',
                    pagination  : false,
                    time        : 2500,
                    overlayer   : false
                });
            });
        </script>
        <div style="height:200px; width:970px;" class="banner_top_ten">
            <div class="camera_wrap camera_azure_skin" id="camera_wrap" style="width:970px;height:300px;">
                <?php foreach($medias as $media) {?>
                <div data-thumb="<?php echo @$media['imagethumbnail']?>" data-src="<?php echo @$media['imagethumbnail']?>">
                	<div class='camera_caption fadeFromBottom'></div>
                </div>
                <?php } ?>
            </div>  
        </div>
    </div>
</div>