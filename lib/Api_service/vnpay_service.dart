import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class VNPayService {
  static const String vnpayUrl =
      "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
  static const String vnpayVersion = "2.1.0";
  static const String vnpayTmnCode = "OKS48O4A";
  static const String vnpayHashSecret = "SDKOYXAQWZSABDDCHEBSFNZMGEHYNTHH";
  static const String returnUrl = "http://spcapp.net/returnUrl";

  static String generatePaymentUrl(
      {required String orderInfo, required double amount}) {
    final params = <String, dynamic>{
      'vnp_Version': vnpayVersion,
      'vnp_Command': "pay",
      'vnp_TmnCode': vnpayTmnCode,
      'vnp_Locale': "vn",
      'vnp_CurrCode': "VND",
      'vnp_TxnRef': DateTime.now().millisecondsSinceEpoch.toString(),
      'vnp_OrderInfo': orderInfo,
      'vnp_OrderType': 'other',
      'vnp_Amount': (amount * 100).toStringAsFixed(0),
      'vnp_ReturnUrl': returnUrl,
      'vnp_IpAddr': "192.168.0.1",
      'vnp_CreateDate':
          DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString(),
    };
    var sortedParam = _sortParams(params);
    final hashDataBuffer = StringBuffer();
    sortedParam.forEach((key, value) {
      hashDataBuffer.write(key);
      hashDataBuffer.write('=');
      hashDataBuffer.write(value);
      hashDataBuffer.write('&');
    });
    String query = Uri(queryParameters: sortedParam).query;
    String vnpSecureHash = "";
    vnpSecureHash = Hmac(sha512, utf8.encode(vnpayHashSecret))
        .convert(utf8.encode(query))
        .toString();
    String paymentUrl = "$vnpayUrl?$query&vnp_SecureHash=$vnpSecureHash";
    return paymentUrl;
  }

  static Map<String, dynamic> _sortParams(Map<String, dynamic> params) {
    final sortedParams = <String, dynamic>{};
    final keys = params.keys.toList()..sort();
    for (String key in keys) {
      sortedParams[key] = params[key];
    }
    return sortedParams;
  }
}
