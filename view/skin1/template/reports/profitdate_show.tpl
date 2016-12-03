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
        <th>Ngày</th>
        <th>Tiền lãi sẻ thu</th>
        <th>Vốn cầm đồ</th>
        <th>Tiền lãi</th>
    </tr>
    </thead>
    <tbody>
    <?php $sum = 0; ?>
    <?php foreach($data as $key => $item){ ?>
    <tr>
        <td class="text-center"><?php echo $key + 1?></td>
        <td class="text-center"><?php echo $this->date->formatMySQLDate($item['date'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['willprofit'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['capital'])?></td>
        <td class="number"><?php echo $this->string->numberFormate($item['profit'])?></td>
    </tr>
    <?php $sum += $item['profit']?>
    <?php } ?>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="4" class="text-right">Tổng tiền lãi thu về</td>
        <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
    </tr>
    </tfoot>
</table>
<?php } ?>