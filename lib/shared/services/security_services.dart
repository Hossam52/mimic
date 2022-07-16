import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:dart_des/dart_des.dart';

class SecurityServices {
  //cipher type=> AES-256-CBC

  static String key = '%)#@M@#&';
  static String iv = '%&*^=#@<';

  static String encrypt(String plainText) {
    //convert plain to cipher
    DES des = DES(
      mode: DESMode.CBC,
      iv: iv.codeUnits,
      key: key.codeUnits,
      paddingType: DESPaddingType.PKCS7,
    );
    final list = des.encrypt(plainText.codeUnits);
    // print('Decrypt');
    //print(hex.encode(list));
    return hex.encode(list).toUpperCase();
    //return await FlutterDes.encryptToHex(plainText, key, iv: iv);
  }

  static String decrypt(String cipherText) {
    //cipher tp plain
    DES des = DES(
      mode: DESMode.CBC,
      iv: iv.codeUnits,
      key: key.codeUnits,
      paddingType: DESPaddingType.PKCS7,
    );
    final list = des.decrypt(hex.decode(cipherText));
    // print('$list');
    return utf8.decode(list);
    // return await FlutterDes.decryptFromHex(cipherText, key, iv: iv);
  }

  static void init() async {
    // const string = "ahmed";
    // var value = await encrypt(string);
    // print(value);
    // print(await decrypt('9EC8B905675E1748C6D758886D5B1F36'));
    // var encrypt = await FlutterDes.encrypt(string, key, iv: iv);
    // var decrypt = await FlutterDes.decrypt(
    //   encrypt!,
    //   key,
    //   iv: iv,
    // );
    // var encryptHex = await FlutterDes.encryptToHex(
    //   string,
    //   key,
    //   iv: iv,
    // );
    // var decryptHex = await FlutterDes.decryptFromHex(encryptHex, key, iv: iv);
    // // var encryptBase64 = await FlutterDes.encryptToBase64(string, key, iv: iv);
    // // var decryptBase64 =
    // //     await FlutterDes.decryptFromBase64(encryptBase64, key, iv: iv);
    // print(encryptHex);
    // print(decryptHex);

    //secret key
    // final convertedKey = utf8.encode(secretKey);
    // final convertedData = utf8.encode('ahmed');
    // print(convertedData.toString());
    // final encryptedAlgo = Hmac(
    //   md5,
    //   convertedKey,
    // );
    // print(encryptedAlgo.convert(convertedData).toString());
    //

    /// List<int> secretKeysha256 = sha256.convert(bytes1).bytes;
    // Key key = Key.fromUtf8(secret);
    // encrypter = Encrypter(Salsa20(key));
    // //convert Iv to base64
    // final bytes = utf8.encode(secretIV);

    // iv = IV.fromUtf8(secretIV);
  }

  // static Encrypted encrypt(String plainText) {
  //   return encrypter.encrypt(plainText, iv: iv);
  // }

  // static String decrypt(Encrypted encrypted) {
  //   print('Print ');
  //   print('decrypted ${encrypt('ahmed').base64}');
  //   print(encrypted.base64);
  //   String plainText = encrypter.decrypt(encrypted, iv: iv);
  //   print('Plain $plainText');
  //   return plainText;
  // }
}
