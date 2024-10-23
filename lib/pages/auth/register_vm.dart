import 'package:book_app/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterVm extends BaseViewModel {
  final globalKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordCtronller = TextEditingController();
  final emailController = TextEditingController();
  bool isLoading = false;

  Future<void> submitRegister(BuildContext context) async {
    if (globalKey.currentState!.validate() == false) return;
    isLoading = true;
    rebuildUi();
    await Future.delayed(const Duration(milliseconds: 1200));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage(email: emailController.text,)),
        (Route<dynamic> route) => false);
  }
}
