<div class="ben-post">
	<div class="ben-left product-left">
    	<?php if(in_array("sanphamhot",$properties)){ ?>
        <div id="ben-icon-hot-detail" class="ben-icon">
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-hot.png" />
        </div>
        <?php } ?>
        <?php if(in_array("sanphamkhuyenmai",$properties)){ ?>
        <div id="ben-icon-sale-detail" class="ben-icon">
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-sale.png" />
        </div>
        <?php } ?>
        <?php if(in_array("sanphammoi",$properties)){ ?>
        <div id="ben-icon-new-detail" class="ben-icon">
            <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-new.png" />
        </div>
        <?php } ?>
        
    	<?php if(@$post['imagethumbnail'] !=""){ ?>
        <div class="product-mainimage">
        	<table>
            	<tr valign="middle">
                	<td id="product-preview" height="250px" align="center"><img id="mainimage" src="<?php echo @$post['imagethumbnail']?>" /></td>
                </tr>
            </table>
	        
        </div>
        
        <?php }?>
        

        
     
    </div>
    <div class="ben-right product-right">
        <h2>
        	<?php echo @$this->document->productName($post['mediaid'])?>
        </h2>
        <?php if(@$post['noted']!="") echo "<h4>".$post['noted']."</h4>";?>
        
        <!--<a href="http://www.facebook.com/sharer/sharer.php?u=<?php echo @$post['link']?>" target="_blank">
    		<img src="<?php echo HTTP_SERVER.DIR_IMAGE?>facebook.gif" />
    	</a>-->
        <div class="fb-like" data-href="<?php echo @$post['link']?>" data-layout="button" data-action="like" data-show-faces="true" data-share="true"></div>
        
        <div class="ben-post-body">
        	<p>
            	<table>
                	
                	<tr>
                    	<td width="25%"><strong>Loại sản phẩm:</strong></td>
                        <td>
                        	<?php foreach($loaisp as $it){ ?>
                            <strong><?php echo @$it['sitemapname'].'<br />'; ?></strong>
                            <?php } ?>
                        </td>
                    </tr>
                    <tr>
                    	<td><strong>Nhãn hiệu:</strong></td>
                        <td>
                        	
                            <strong><a class="brand" href="<?php echo @$this->document->createLink('brandinfor',$post['brand'])?>" title="<?php echo @$this->document->getCategory($post['brand'])?>"><?php echo @$this->document->getCategory($post['brand'])?></a></strong>
                            
                        </td>
                    </tr>
                    <?php if(@$post['color'] != ""){ ?>
                    <tr>
                    	<td><strong>Màu:</strong></td>
                        <td>
                        	
                            <?php echo @$post['color']?>
                            
                        </td>
                    </tr>
                    <?php } ?>
                    <?php if(@count($priceproduct) == 0){ ?>
                    <tr>
                    	<td><strong>Giá:</strong></td>
                        <td>
                        	<?php $cls = '';?>
                            <?php if(@$post['pricepromotion']!=0){ ?>
                            <?php $cls = 'product-price-no';?>
                            <span class="product-pricepromotion">
                            <?php echo @$this->string->numberFormate($post['pricepromotion'])?> <?php echo @$this->document->setup['Currency']?>
                            </span>
                            <?php } ?>
                            <?php if(@$post['price']){ ?>
                            <span  class="product-price <?php echo @$cls?>"><?php echo @$this->string->numberFormate($post['price'])?> <?php echo @$this->document->setup['Currency']?></span>
                            <?php }else{ ?>
                            Giá đang cập nhật
                            <?php }?>
                            <input type="button" class="ben-button" onclick="cart.add('<?php echo @$post['mediaid']?>')" value="Đặt hàng">
                        </td>
                    </tr>
                    <?php } ?>
                </table>
            	
                
            </p>
            <p class="short_intro">
            	<?php echo @$post['summary']?>
                
            </p>
            <?php if(@count($data_samplecode)>1){ ?>
            <p>
            	<?php foreach($data_samplecode as $key => $item){?>
                <a href="<?php echo @$this->document->createLink($this->document->sitemapid,$item['alias'])?>" title="<?php echo @$item['color']?>"><img src="<?php echo @$item['icon']?>" /></a>
                <?php } ?>
            </p>
            <?php } ?>
        </div>
        
    </div>
    <div class="clearer">&nbsp;</div>

    <div class="ben-hline"></div>
    <p>
        <?php echo @$post['description']?>
    </p>
    
    <p class="ben-text-right">
        <b><?php echo @$post['source']?></b>
    </p>
    <?php if(@count($priceproduct)){ ?>
    <div id="listprice">
        <table>
            <thead>
                <tr>
                    <th>Sẩn phẩm</th>
                    <th>Hình</th>
                    <th>Giá bán</th>
                    <th>Giảm</th>
                    <th>Khuyến mãi</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                
                
                <?php foreach($priceproduct as $val){ ?>
                <tr>
                    <td>
                    	<?php echo @$this->document->productName($val)?>
                        <?php if(@$val['noteprice']!=""){ ?>
                            (<?php echo @$this->document->getCategory($val['noteprice'])?>)
                        <?php }?>
                    	<?php if(@$val['tenkhuyenmai']){ ?>
                        <p class="ben-khuyenmai"><a  onclick="xemkhuyenmai('<?php echo @$val['makhuyenmai']?>')"><?php echo @$val['tenkhuyenmai']?></a></p>
                        <?php } ?>
                    </td>
                    <td>
                    	<img src="<?php echo @$val['icon']?>" onClick="$('#mainimage').attr('src','<?php echo @$val['imagethumbnail']?>')">
                    </td>
                    <td class="number">
                    	<?php $cls = '';?>
                            <?php if(@$val['pricepromotion']!=0){ ?>
                            <?php $cls = 'product-price-no';?>
                        <?php } ?>
                        <?php if(@$val['price']!=0){ ?>
                        <span class="<?php echo @$cls?>"><?php echo @$this->string->numberFormate($val['price'])?><?php echo @$this->document->setup['Currency']?></span>
                        <?php } ?>
                    </td>
                    <td class="number">
                        <?php if(@$val['discountpercent']!=0){ ?>
                        <span class="product-pricepromotion">
                        -<?php echo @$this->string->numberFormate($val['discountpercent'])?>%
                        </span>
                        <?php } ?>
                    </td>
                    <td class="number">
                        <?php if(@$val['pricepromotion']!=0){ ?>
                        <span class="product-pricepromotion">
                        <?php echo @$this->string->numberFormate($val['pricepromotion'])?><?php echo @$this->document->setup['Currency']?>
                        </span>
                        <?php } ?>
                    </td>
                    <td><input type="button" class="ben-button ben-center" onclick="cart.add('<?php echo @$val['mediaid']?>')" value="Đặt hàng"></td>
                </tr>
                <?php } ?>
                
            </tbody>
        </table>
    </div>
    <?php } ?>
    
    
    
    
    
    <div class="clearer">&nbsp;</div>
</div>

