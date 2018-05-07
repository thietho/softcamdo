<h1 class="text-center" style="font-size: 2.2em">
    DV.CẦM ĐỒ*PHƯƠNG NGHI*
</h1>
<p class="text-center" style="font-size: 1.1em">
    <strong>SỐ.16.Đ.PHẠM THỊ TÁNH.P.04.Q.08.TPHCM*ĐT*38.521107*DĐ*0989.517.727.</strong>
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
    SỐ TIỀN CẦM: <?php echo $this->string->numberFormate($item['amount'])?>VNĐ - <span style="text-transform: uppercase"><?php echo $this->string->doc_so($item['amount'])?></span> ĐỒNG CHẲN - [G.C]-…………
</p>
<p>
    <strong>TỪ NGÀY</strong> <?php echo $this->date->getDay($item['startdate'])?>/THÁNG/<?php echo $this->date->getMonth($item['startdate'])?>/NĂM:<?php echo $this->date->getYear($item['startdate'])?><strong>*ĐẾN NGÀY*></strong> <?php echo $this->date->getDay($item['enddate'])?>/THÁNG/<?php echo $this->date->getMonth($item['enddate'])?>/NĂM:<?php echo $this->date->getYear($item['enddate'])?> <strong>*HẾT HẠN.</strong>
</p>
<p>
    THỜI GIAN CẦM HẾT HẠN, KHÁCH HÀNG KHÔNG ĐẾN CHUỘC, CỬA HÀNG CÓ QUYỀN TỰ TIẾN HÀNH<strong>[THANH LÝ MÓN ĐỒ CẦM CỐ]</strong>ĐỂ THU HỒI VỐN VÀ LÃI, MỌI THẮC MẮC VÀ KHIẾU  NẠI VỀ SAU CỦA QUÝ KHÁCH,CỬA HÀNG SẼ KHÔNG GIÃI QUYẾT,MÓN ĐỒ CẦM TẠI CỬA HÀNG LÀ HỢP PHÁP,VÀ CHỊU HOÀN TOÀN TRÁCH NHIỆM NẾU CÓ TRANH CHẤP XÃY RA<strong>[ĐẾN KỲ THANH TOÁN]</strong>MÓN ĐỒ CẦM DƯỚI MƯỜI TRIỆU ĐỒNG,CỬA HÀNG SẼ KHÔNG NHẮC
</p>
<p>
    LÃI SUẤT* SỐ TIỀN CẦM ,VÀ THỜI GIAN ĐÃ ĐƯỢC THÔNG BÁO KHI ĐẾN CẦM,VÀ ĐỒNG Ý !
</p>
<p>
    GIỜ MỠ CỮA*	TỪ.08.GIỜ.SÁNG ĐẾN*>21.GIỜ.00.TỐI*MỖI NGÀY*	[LS/TỐI.THIỄU*.>………….]
</p>
<p>
    <strong>LƯU Ý*</strong>	MẤT BIÊN NHẬN <strong>[CẦM ĐỒ]</strong> CỮA HÀNG SẼ KHÔNG GIÃI QUYẾT,CHO QUÝ KHÁCH.
</p>


<table>
    <tr>
        <td class="text-left" style="width: 50%"><strong>KHÁCH HÀNG ĐỌC HIỂU.(KÝ,GHI HỌ TÊN)</strong></td>
        <td class="text-center" style="width: 50%"><strong>PHỤ TRÁCH CỬA HÀNG</strong></td>
    </tr>
    <tr style="height: 50px"></tr>
</table>
