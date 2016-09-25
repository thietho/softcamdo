<div id="page-wrapper">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <?php echo @$this->document->title?>

                <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Thêm</button>
                <button type="button" class="btn btn-default btn-bg btn-danger" onclick="deleteitem()"><span class="fa fa-trash"></span> Xóa</button>


            </h1>
        </div>

        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">

        <div class="col-lg-12">
            <div class="panel panel-default">

                <div class="panel-body">
                    <div class="dataTable_wrapper">
                        <form action="" method="post" id="listitem" name="listitem">
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                <tr>
                                    <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                                    <th>Mã nhóm</th>
                                    <th>Tên nhóm</th>
                                    <th>Lãi xuất</th>
                                    <th>Chu kỳ</th>
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
                                    <td><?php echo @$item['groupid']?></td>
                                    <td><?php echo @$item['groupname']?></td>
                                    <td class="number">
                                        <?php if(count($item['arrlistrate'])){ ?>
                                        <?php
                                        $arr = array();
                                        foreach($item['arrlistrate'] as $amount => $rate)
                                        {
                                            $arr[] = ">=".$this->string->numberFormate($amount)."=".$rate."%";
                                        }
                                        echo implode("<br>",$arr);
                                        ?>
                                        <?php }else{ ?>
                                        <?php echo @$item['rate']?>%
                                        <?php } ?>
                                    </td>
                                    <td class="number"><?php echo @$item['period']?> ngày</td>
                                    <td>
                                        <button type="button" onClick="window.location = '<?php echo @$item['link_edit']?>'" class="btn btn-default btn-bg btn-success"><span class="fa pencil-square-o"></span> <?php echo @$item['text_edit']?></button>
                                    </td>
                                </tr>

                                <?php } ?>

                                </tbody>
                            </table>
                        </form>
                    </div>
                    <!-- /.table-responsive -->

                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>
<script language="JavaScript">
    function deleteitem()
    {
        var answer = confirm("Bạn có muốn xóa không?")
        if (answer)
        {
            $.post("?route=addon/group/delete",
                    $("#listitem").serialize(),
                    function(data)
                    {
                        if(data!="")
                        {
                            alert(data);
                            window.location.reload();
                        }
                    }
            );
        }
    }
</script>