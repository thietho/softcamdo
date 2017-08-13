<h1 class="text-center" style="font-size: 2.2em">
    DV.CẦM ĐỒ*PHƯƠNG NGHI*
</h1>
<p class="text-center" style="font-size: 1.1em">
    <strong>ĐỊA CHỈ: SỐ.16.Đ.152.CAO LỖ.P.04.Q.08.TPHCM*ĐT*38.521107*DĐ*0989.517.727.</strong>
</p>
<h2 class="text-center">BIÊN NHẬN(cầm <?php echo mb_strtolower($this->document->getGroup($item['group']),'UTF-8')?>)</h2>
<p style="float: right">
    <?php echo $item['invoicenumber']?>
</p>
<p class="text-center">
    (CÓ GIÁ TRỊ <?php echo $item['period']?> NGÀY)
</p>
<div style="clear: both"></div>
<p>
    <strong>NHẬN CỦA: <?php echo $item['fullname']?></strong>
    <?php echo $item['itemname']?>
    <?php echo $item['info']?>
</p>
<p>
    SỐ TIỀN CẦM: <?php echo $this->string->numberFormate($item['amount'])?>VNĐ - <span style="text-transform: uppercase"><?php echo $this->string->doc_so($item['amount'])?></span> ĐỒNG CHẲN
</p>
<p>
    <strong>TỪ NGÀY</strong> <?php echo $this->date->getDay($item['startdate'])?>/<?php echo $this->date->getMonth($item['startdate'])?>/<?php echo $this->date->getYear($item['startdate'])?><strong>*ĐẾN NGÀY*</strong> <?php echo $this->date->getDay($item['enddate'])?>/<?php echo $this->date->getMonth($item['enddate'])?>/<?php echo $this->date->getYear($item['enddate'])?> <strong>*HẾT HẠN*ĐT: <?php echo $item['phone']?></strong>
</p>
<p style="margin-bottom: 10px">
    Lãi xuất: số tiền cầm và thời gian đã được thông báo khi đến cầm và đồng ý!
</p>
<p style="margin-bottom: 10px">
    Lưu ý: Mất biên nhận (cầm đồ) phải báo ngay. Nếu báo trể mọi thiệt hại khách hàng chịu(nếu có)
</p>
<p style="margin-bottom: 10px">
    Giờ mở cửa: từ 08 giờ đến *21 giờ tối mỗi ngày.LS/Tối Thiểu.........>.........>........../
</p>
<table style="width: 100%">
    <tr>
        <td class="text-left" style="width: 50%"><strong>KHÁCH HÀNG ĐỌC HIỂU VÀ ĐỒNG Ý</strong></td>
        <td class="text-right" style="width: 50%"><strong>PHỤ TRÁCH CỬA HÀNG</strong></td>
    </tr>
    <tr style="height: 50px"></tr>
</table>
