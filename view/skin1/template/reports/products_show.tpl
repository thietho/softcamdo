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

<script type="text/javascript">
    $(document).ready(function(){
        var chart = new CanvasJS.Chart("chartContainer",
                {
                    theme: "theme2",
                    title:{
                        text: ""
                    },
                    data: [
                        {
                            type: "pie",
                            showInLegend: true,
                            toolTipContent: "{y} - #percent %",
                            //yValueFormatString: "#0.#,,. Million",
                            legendText: "{indexLabel}",
                            dataPoints: [
                                    <?php foreach($groups as $group){ ?>
                                {  y: <?php echo $group['count']?>, indexLabel: "<?php echo $group['groupname']?>" },


                                    <?php } ?>
                            ]
                        }
                    ]
                });
        chart.render();
    });

</script>

<div id="chartContainer" style="height: 400px; width: 100%;"></div>
<?php } ?>