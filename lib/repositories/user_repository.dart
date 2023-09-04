
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<void> init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   }
  static Future<String> getNome() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var nome = await sharedPreferences.getString('nome');
  return nome!;
}
}