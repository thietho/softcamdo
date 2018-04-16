<form action="" method="post" id="listitem" name="listitem">
    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
        <thead>
        <tr>
            <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
            <th>Tên sản phẩm</th>
            <!--<th>Giá</th>-->
            <th>Hảng sản xuất</th>
            <th>Nhóm</th>
            <th>Tình trạng</th>
            <th>Control</th>
        </tr>
        </thead>
        <tbody>
        <?php
                                    foreach($datas as $item)
                                    {
                                ?>
        <tr>
            <td><input class="inputchk" type="checkbox" name="delete[<?php echo @$item['id']?>]" value="<?php echo @$item['id']?>" ></td>
            <td><?php echo @$item['itemname']?></td>
            <!--<td class="number"><?php echo $this->string->numberFormate($item['price'])?></td>-->
            <td><?php echo $this->document->getCategory($item['brand'])?></td>
            <td><?php echo $this->document->getGroup($item['group'])?></td>
            <td><?php echo $this->document->getCategory($item['status'])?></td>
            <td class="text-center">
                <?php if(@$_GET['type']=="popup"){ ?>
                <button type="button"
                        id="<?php echo @$item['id']?>"
                        itemname="<?php echo $item['itemname']?>"
                        price="<?php echo $item['price']?>"
                        brand="<?php echo $item['brand']?>"
                        group="<?php echo $item['group']?>"
                        link="<?php echo $item['link']?>"
                        status="<?php echo $item['status']?>"
                        data-dismiss="modal"
                        class="btn btn-default btn-bg btn-success selectItems" ><span class="fa fa-check"></span> Chọn</button>
                <?php } ?>
                <button type="button" onClick="window.location = '<?php echo @$item['link_edit']?>'" class="btn btn-default btn-bg btn-success"><span class="fa pencil-square-o"></span> <?php echo @$item['text_edit']?></button>
            </td>
        </tr>

        <?php } ?>

        </tbody>
    </table>
    <div class="text-right">
        <?php echo $pager?>
    </div>


</form>