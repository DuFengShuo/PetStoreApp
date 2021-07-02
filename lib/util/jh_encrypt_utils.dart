import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flustars/flustars.dart';
import 'package:local_life_app/common/common.dart';


// ignore: non_constant_identifier_names
var _KEY = Constant.dataKey;

//128的keysize=16，192keysize=24，256keysize=32

// var enStr = JhEncryptUtils.aesMd5Base64(jsonString);
//   print('AES 加密：$enStr');
// var deStr = JhEncryptUtils.aesDecrypt(enStr);
// print('AES 解密：$deStr');

class JhEncryptUtils {
  static String aesMd5Base64(Map<String, dynamic> params) {
    final paramsString = jsonEncode(params).toString();
    jsonEncode(params).toString();
    final _random = new Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    var code = next(10000000, 99999999);
    String hashKey = encodeMd5('$code$_KEY');
    final aesString = aesEncrypt(paramsString, hashKey);
    return '$code$aesString';
  }

  static String decMd5Base64(String param) {
    if (param.isEmpty) return '';
    String hashKey = encodeMd5('${param.substring(0, 8)}$_KEY');
    final aesString = aesDecrypt(param.substring(8), hashKey);
    return jsonDecode(aesString);
  }

  //Base64编码
  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  //Base64解码
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }

  // md5 加密 32位小写
  static String encodeMd5(String plainText) {
    return EncryptUtil.encodeMd5(plainText);
  }

  //AES加密
  static aesEncrypt(plainText, String hashKey) {
    try {
      final key = Key.fromBase16('$hashKey');
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(encrypted, String hashKey) {
    try {
      final key = Key.fromBase16('$hashKey');
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      return encrypted;
    }
  }
}
