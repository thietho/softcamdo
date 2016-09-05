<div>
	<h1><center>Tham gia chương trình</center></h1>
	<form id="frmRequest" method="post">
    	<div id="error" class="ben-error" style="display:none"></div>
    	<table>
        	<tr>
            	<td width="40%"><label>Họ và tên</label> <input type="text" id="fullname" name="fullname" class="ben-textbox" style="width:75%"></td>
                <td><label>Số điện thoại</label> <input type="text" id="phone" name="phone" class="ben-textbox" style="width:80%"></td>
            </tr>
            <tr>
            	<td colspan="2">
                	<label>Địa chỉ</label>
                    <input type="text" id="address" name="address" class="ben-textbox" style="width:100%">
                </td>
                
            </tr>
            <tr>
            	<td colspan="2">
                	<label>Email</label>
                    <input type="text" id="email" name="email" class="ben-textbox" style="width:100%">
                </td>
                
            </tr>
           	
            
            
            
            <tr>
            	<td class="ben-right"></td>
                <td>
                	<input type="button" id="btnSend" name="btnSend" class="ben-button" value="Tham gia">
                    
                </td>
            </tr>
        </table>
    </form>
</div>
<div class="clearer">&nbsp;</div>
<script language="javascript">
$("#btnSend").click(function(){
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("<?php echo HTTP_SERVER?>?route=addon/gameregister/send", $("#frmRequest").serialize(),
		function(data){
			if(data == "true")
			{
				
			}
			else
			{
				
				$('#error').html(data).show('slow');
				
				
			}
			$.unblockUI();
		}
	);					   
});
</script>