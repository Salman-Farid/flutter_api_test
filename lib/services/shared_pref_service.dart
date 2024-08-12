import 'dart:convert';
import 'package:karmalab_assignment/views/home/home_view.dart';
import 'package:karmalab_assignment/views/onboarding/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';



class SharedPrefService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();






  Future<void> saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
  }

  Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  Future<void> clearSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
  }





  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    print('Saving User: $userJson');  // Debugging statement
    await prefs.setString('user', userJson);
  }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      print('Retrieved User JSON: $userJson');  // Debugging statement
      return User.fromJson(jsonDecode(userJson));
    }
    print('No user data found in SharedPreferences');  // Debugging statement
    return null;
  }




  void userLog({String? email, String? id, int? otp}) async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", true);
    pref.setString("email", email ?? "email");
    pref.setString("id", id?? "0");
    pref.setInt("otp", otp ?? 0);
  }

  Future<String> start() async {
    SharedPreferences pref = await _prefs;

    var status = pref.getString("email");
    if (status == null) {
      pref.setBool("login", false);
    }

    return status != null ? HomeView.routeName : OnboardingView.routeName;
  }


  Future<void> forgotPassCred({String? token, int? otp}) async {
    SharedPreferences pref = await _prefs;
    // ? simulate delay
    await Future.delayed(const Duration(seconds: 0));

    pref.setInt("otp", otp ?? 0);
    pref.setString("token", token ?? "");
  }

  Future<String?> getToken() async {
    SharedPreferences pref = await _prefs;
    return pref.getString("token");
  }

  Future<void> updateToken(String? token) async {
    SharedPreferences pref = await _prefs;
    pref.setString("token", token ?? "");
  }

  void clear() async {
    SharedPreferences pref = await _prefs;
    pref.setBool("login", false);
    pref.remove("email");
    pref.remove("id");
    pref.remove("otp");
  }
}
