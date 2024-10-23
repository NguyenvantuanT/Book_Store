import 'package:book_app/pages/auth/login_vm.dart';
import 'package:book_app/pages/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/app_button.dart';
import 'package:book_app/components/text_field/app_text_field.dart';
import 'package:book_app/components/text_field/app_text_field_pass.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/validator.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StackedView<LoginVm> {
  const LoginPage({super.key, this.email});
  final String? email;

  @override
  LoginVm viewModelBuilder(BuildContext context) => LoginVm(email: email);

  @override
  void onViewModelReady(LoginVm viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, LoginVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Form(
                key: viewModel.globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100.0),
                    _buildUsernameField(viewModel),
                    const SizedBox(height: 20.0),
                    _buildPasswordField(context, viewModel),
                    const SizedBox(height: 40.0),
                    _buildLoginButton(context, viewModel),
                    const SizedBox(height: 40.0),
                    _remoteRegister(context)
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _remoteRegister(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't hava account? ",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Register",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ));
  }

  Widget _buildUsernameField(LoginVm viewModel) {
    return AppTextField(
      controller: viewModel.usernameController,
      prefixIcon: const Icon(Icons.account_circle_rounded),
      hintText: "Username",
      labelText: "Username",
      validator: Validator.required,
    );
  }

  Widget _buildPasswordField(BuildContext context, LoginVm viewModel) {
    return AppTextFieldPass(
      controller: viewModel.passwordController,
      prefixIcon: const Icon(Icons.lock),
      hintText: "Password",
      labelText: "Password",
      validator: Validator.password,
      onFieldSubmitted: (_) => viewModel.submitLogin(context),
    );
  }

  Widget _buildLoginButton(BuildContext context, LoginVm viewModel) {
    return FractionallySizedBox(
      widthFactor: 0.3,
      child: AppButton.ouline(
        text: "Login",
        onTap: () => viewModel.submitLogin(context),
      ),
    );
  }
}
