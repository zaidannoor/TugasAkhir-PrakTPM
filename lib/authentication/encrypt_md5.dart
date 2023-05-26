import 'dart:convert';
import 'package:crypto/crypto.dart';

String encryptText(String input) {
  var bytes = utf8.encode(input);
  var md5Hash = md5.convert(bytes);
  return md5Hash.toString();
}