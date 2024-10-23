import 'package:book_app/pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginVm extends BaseViewModel {
  final String? email;
  LoginVm({this.email});

  final globalKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void init(){
    usernameController.text = email ?? "";
  }

  Future<void> submitLogin(BuildContext context) async {
    if (globalKey.currentState!.validate() == false) return;
    isLoading = true;
    rebuildUi();
    await Future.delayed(const Duration(milliseconds: 1200));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RootPage()),
        (Route<dynamic> route) => false);
  }
}
