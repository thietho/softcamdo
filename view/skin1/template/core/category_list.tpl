<link href="<?php echo DIR_CSS?>jquery.nestable.css" rel="stylesheet">
<script src="<?php echo DIR_JS?>jquery.nestable.js"></script>

<div id="page-wrapper">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                <button onclick="window.location.href='<?php echo @$insert?>'" type="button" class="btn btn-default btn-bg btn-success"><span class="fa fa-plus"></span> Thêm</button>

                <button id="btnEditPosition" name="btnEditPosition" class="btn btn-default btn-bg btn-success"><span class="fa fa-sort"></span> Sắp sếp thứ tự</button>
                <button id="btnUpdateTree" name="btnUpdateTree" class="btn btn-default btn-bg btn-success" style="display:none" onclick="updateTree()"><span class="fa fa-check-square-o"> Lưu</button>
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
                            <div class="dd" id="nestable">
                                <ol class="dd-list">
                            	<?php echo @$tree?>
                                </ol>
                            </div>
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
<textarea id="nestable-output"></textarea>
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Lựa chọn phương thức</h4>
      </div>
      <div class="modal-body">
        <p>Some text in the modal.</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-default" id="btnCatEdit">Chỉnh sửa</button>
        <button type="button" class="btn btn-default" id="btnCatAddChild">Thêm con</button>

        <button type="button" class="btn btn-default" id="btnCatDel">Xóa</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
      </div>
    </div>

  </div>
</div>
<script language="javascript">
var updateOutput = function(e)
{
	var list   = e.length ? e : $(e.target),output = list.data('output');
	if (window.JSON) {
		$('#nestable-output').val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
	} else {
		$('#nestable-output').val('JSON browser support required for this demo.');
	}
};
$(document).ready(function(e) {
   /* $('#nestable').nestable({
       
    })
    .on('change', updateOutput);*/
	$('[data-toggle="popover"]').popover(); 
});
$('.hl-cat').click(function(e) {
    $('.modal-body').html($(this).attr('catname'));
	$('#btnCatEdit').attr('catid',$(this).attr('catid'));
	$('#btnCatAddChild').attr('catid',$(this).attr('catid'));
	$('#btnCatEditConten').attr('catid',$(this).attr('catid'));
	$('#btnCatDel').attr('catid',$(this).attr('catid'));
});
$('#btnCatEdit').click(function(e) {
    window.location = '?route=core/category/update&categoryid='+ $(this).attr('catid');
});
$('#btnCatAddChild').click(function(e) {
    window.location = '?route=core/category/insert&parent='+ $(this).attr('catid');
});
$('#btnCatEditConten').click(function(e) {
    window.location = '?route=module/information&sitemapid=cat'+ $(this).attr('catid');
});
$('#btnCatDel').click(function(e) {

    deleteitem($(this).attr('catid'));
});
$('#btnEditPosition').click(function(e) {
    $('#nestable').nestable({
       
    })
    .on('change', updateOutput);
	$('#btnUpdateTree').show();
	$('#btnEditPosition').hide();
});
function deleteitem(catid)
{
	var answer = confirm("Bạn có muốn xoa không?")
	if (answer)
	{
		$.get("?route=core/category/delete&catid="+catid,

				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}

function updateTree()
{
	$.blockUI({ message: "<div class='hl-message'><h1><?php echo $lang['announ_infor']?></h1></div>" });
	
	$.post("?route=core/category/updateTree", 
			{data:encodeURI($('#nestable-output').val())}, 
			function(data)
			{
				if(data!="")
				{
					$('.hl-message').html('<h1>Lưu thành công!!!<h1>');
					
				}
				window.location.reload();
				//$.unblockUI();
			}
			
	);
	
}

</script>