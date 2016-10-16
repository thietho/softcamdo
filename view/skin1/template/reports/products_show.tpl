<?php
if(@$error != '')
    echo $error;
else
{
?>
<table class="table table-striped table-bordered table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Sản phẩm</th>
        <th>Phần trăm</th>
    </tr>
    </thead>
    <tbody>
    <?php $sum = 0; ?>
    <?php foreach($data as $key => $item){ ?>
    <tr>
        <td class="text-center"><?php echo $key + 1?></td>
        <td><?php echo $item['itemname']?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['percent'])?>%</td>
    </tr>

    <?php } ?>
    </tbody>
</table>
<?php } ?>