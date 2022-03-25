import 'package:shared_preferences/shared_preferences.dart';
class UserPreferences {
  static late SharedPreferences _preferences;

  static const farmerId = 'farmerId';
  static const buyerId = 'buyerId';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();


  static Future setBuyerID(String id) async {
    await _preferences.setString(buyerId, id);
  }
  static String? getBuyerID() {
    return _preferences.getString(buyerId);
  }
  static Future setFarmerID(String id) async {
    await _preferences.setString(farmerId, id);
  }

  static String? getFarmerID() {
    return _preferences.getString(farmerId);
  }

  static Future<bool> clearData() async {
    return await _preferences.clear();
  }
}