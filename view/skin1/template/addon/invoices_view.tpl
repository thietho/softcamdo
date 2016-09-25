<h1 class="text-center">
    Cầm đồ *Phương Nghi*
</h1>
<p class="text-center">
    SỐ 16.Đ.152 Cao Lỗ P.4 Q.8 TPHCM ĐT: 0838521107 DĐ 0989.517.727
</p>
<p class="text-center">
    Hôm nay: <?php echo $this->date->getDay($item['createdate'])?>/Tháng/<?php echo $this->date->getMonth($item['createdate'])?>/Năm:<?php echo $this->date->getYear($item['createdate'])?>
    BL.SỐ <?php echo $item['invoicenumber']?>
</p>
<p class="text-center">
    Biên Nhận (Có giá trị 30 ngày)
</p>
<p>
    Nhận của: <?php echo $item['fullname']?>
    <?php echo $item['itemname']?>
    <?php echo $item['info']?>
</p>
<p>
    Số tiền cầm: <?php echo $this->string->numberFormate($item['amount'])?>/VNĐ - <?php echo $this->string->doc_so($item['amount'])?> đồng
</p>
<p>
    Từ ngày: <?php echo $this->date->formatMySQLDate($item['startdate'])?> Đến ngày: <?php echo $this->date->formatMySQLDate($item['enddate'])?> Hết hạn
</p>
<p>
    Lãi suất: <?php echo $item['rate']?>. Số tiền cầm, và thời gian đã được thông báo khi đến cầm và đồng ý.
</p>
<p>
    Giờ mở cửa: Từ 08 giờ sáng đến 20 giờ 30 tối. LS/ tối thiểu/T.1/>[20K].T.2/>[30K.>40K]
</p>
<p>
    Thời gian cầm hết hạn sau <strong>"5 ngày"</strong> mà khách không đến chuộc, đóng lãi thay giấy, của hàng có quyền tự tiến hành <strong>"Thanh lý món đồ cầm cố"</strong> để thu hồi vốn và lãi, mọi thắc mắt và khiếu nại về sau của quý khách, cửa hàng sẽ không giải quyết, món đồ cầm tại cửa hàng là hợp pháp và chịu hoàn toàn trách nhiệm nếu có tranh chấp xãy ra <strong>"đến kỳ thanh toán"</strong> món đồ dưới mười triệu đồng cửa hàng sẽ không nhắc
</p>
<p>
    <strong>Lưu ý:</strong> mất biên nhận(CĐ) phải báo ngay nếu báo trể mọi thiệt hại khách hàng chịu.
</p>

<table>
    <tr>
        <td class="text-center" style="width: 50%">Khách hàng đọc hiểu(ký, ghi họ tên)</td>
        <td class="text-center" style="width: 50%">Phụ trác cửa hàng</td>
    </tr>
    <tr style="height: 80px"></tr>
</table>
<p class="text-center">
    *Hân hạnh được phục vụ quý khách*
</p>