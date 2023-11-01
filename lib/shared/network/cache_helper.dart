import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences sharedPreferences ;
  static init() async
  {
    //To make an instance from shared preferences..........
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> putData({
    required String key,
    required bool value,
     }) async
  {
    return await sharedPreferences.setBool(key, value);
  }

  bool? getData({
    required String key,
  })
  {
    return  sharedPreferences.getBool(key);
  }

}