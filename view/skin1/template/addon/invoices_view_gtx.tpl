<h1 class="text-center" style="font-size: 2.2em">
    DV.CẦM ĐỒ*PHƯƠNG NGHI*
</h1>
<p class="text-center" style="font-size: 1.1em">
    <strong>ĐỊA CHỈ: SỐ.16.Đ.152.CAO LỖ.P.04.Q.08.TPHCM*ĐT*38.521107*DĐ*0989.517.727.</strong>
</p>
<p class="text-center" style="font-size: 1.2em">
    <strong>*BIÊN NHẬN*[có giá trị.<?php echo $item['period']?>.ngày]</strong>
</p>
<p class="text-center">
    HÔM NAY*NGÀY:<?php echo $this->date->getDay($item['createdate'])?>:THÁNG:<?php echo $this->date->getMonth($item['createdate'])?>:NĂM:<?php echo $this->date->getYear($item['createdate'])?>
    BL/SỐ <?php echo $item['invoicenumber']?> [2.LIÊN] ĐTKH: <?php echo $item['phone']?>
</p>
<p>
    <strong>NHẬN CỦA: <?php echo $item['fullname']?></strong>
    <?php echo $item['itemname']?>
    <?php echo $item['info']?>
</p>
<p>
    SỐ TIỀN CẦM: <?php echo $this->string->numberFormate($item['amount'])?>/VNĐ - <span style="text-transform: uppercase"><?php echo $this->string->doc_so($item['amount'])?></span> ĐỒNG-[G.C]-…………
</p>
<p>
    <strong>TỪ NGÀY</strong> <?php echo $this->date->formatMySQLDate($item['startdate'])?> <strong>ĐẾN NGÀY:</strong> <?php echo $this->date->formatMySQLDate($item['enddate'])?> <strong>*HẾT HẠN.</strong>
</p>
<p>
    LÃI SUẤT* . SỐ TIỀN CẦM ,VÀ THỜI GIAN ĐÃ ĐƯỢC THÔNG BÁO KHI ĐẾN CẦM,VÀ ĐỒNG Ý !
</p>
<p>
    GIỜ MỠ CỮA*	TỪ.08.GIỜ.SÁNG ĐẾN*>20.GIỜ.30.TỐI*MỖI NGÀY*	[LS/TỐI.THIỄU*.>………….]
</p>



<table>
    <tr>
        <td class="text-center" style="width: 50%"><strong>KHÁCH HÀNG ĐỌC HIỂU.(KÝ,GHI HỌ TÊN)</strong></td>
        <td class="text-center" style="width: 50%"><strong>PHỤ TRÁCH CỬA HÀNG</strong></td>
    </tr>
    <tr style="height: 50px"></tr>
</table>
<p>
    <strong>LƯU Ý*</strong>	MẤT BIÊN NHẬN <strong>[CẦM ĐỒ]</strong> CỮA HÀNG SẼ KHÔNG GIÃI QUYẾT,CHO QUÝ KHÁCH.
</p>