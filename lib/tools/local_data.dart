import 'package:shared_preferences/shared_preferences.dart';

class LocalData{
  set_data(key, value) async{
    final prefs = await SharedPreferences.getInstance();
    if (value.runtimeType == int){
      prefs.setInt(key, value);
    }else if (value.runtimeType == String){
      prefs.setString(key, value);
    }else if (value.runtimeType == bool){
      prefs.setBool(key, value);
    }else if (value.runtimeType == double){
      prefs.setDouble(key, value);
    }
  }

  get_data(key, type) async{
    final prefs = await SharedPreferences.getInstance();
    // return prefs.get(key);
    if (type == int){
      return prefs.getInt(key) ?? 0;
    }else if (type == String){
      return prefs.getString(key) ?? "";
    }else if (type == bool){
      return prefs.getBool(key) ?? false;
    }else if (type == double){
      return prefs.getDouble(key) ?? 0.0;
    }
  }

  static clear_data() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}