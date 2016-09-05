
	<h2><?php echo $sitemap['sitemapname']?></h2>
    <table>
    	<tr>
        	<td><img src="<?php echo $sitemap['post']['imagethumbnail']?>"></td>
            <td>
            	<ul>
            	<?php foreach($sitemap['childs'] as $child){ ?>
                	<li><a href="<?php echo $this->document->createLink($child['sitemapid'])?>"><?php echo $child['sitemapname']?></a></li>
                <?php } ?>
                </ul>
            </td>
        </tr>
    </table>
    
