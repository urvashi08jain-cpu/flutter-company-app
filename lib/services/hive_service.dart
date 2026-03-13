import 'package:hive/hive.dart';

class HiveService {

  static const boxName = "session";

  Future<void> saveLogin(bool value) async {

    var box = await Hive.openBox(boxName);

    box.put("isLogin", value);
  }

  Future<bool> isLoggedIn() async {

    var box = await Hive.openBox(boxName);

    return box.get("isLogin", defaultValue: false);
  }

  Future<void> logout() async {

    var box = await Hive.openBox(boxName);

    await box.clear();
  }
}