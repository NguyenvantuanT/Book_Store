import 'package:book_app/pages/auth/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/app_button.dart';
import 'package:book_app/components/text_field/app_text_field.dart';
import 'package:book_app/components/text_field/app_text_field_pass.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/validator.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StackedView<RegisterVm> {
  const RegisterPage({super.key});

  @override
  RegisterVm viewModelBuilder(BuildContext context) => RegisterVm();

  @override
  Widget builder(BuildContext context, RegisterVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Register"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          children: [
            Form(
              key: viewModel.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUsernameField(viewModel),
                  const SizedBox(height: 20.0),
                  _buildPhoneField(viewModel),
                  const SizedBox(height: 20.0),
                  _buildPasswordField(viewModel),
                  const SizedBox(height: 20.0),
                  _buildConfirmPasswordField(viewModel),
                  const SizedBox(height: 20.0),
                  _buildEmailField(viewModel, context),
                  const SizedBox(height: 40.0),
                  _buildRegisterButton(viewModel, context),
                  const SizedBox(height: 40.0),
                  // GestureDetector(
                  //   onTap: () {

                  //   },
                  //   child: Text("Register" , style: Theme.of(context).textTheme.headlineMedium,))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField(RegisterVm viewModel, BuildContext context) {
    return AppTextField(
      controller: viewModel.emailController,
      prefixIcon: const Icon(Icons.email),
      hintText: "Email",
      labelText: "Email",
      validator: Validator.email,
      onFieldSubmitted: (_) => viewModel.submitRegister(context),
    );
  }

  Widget _buildConfirmPasswordField(RegisterVm viewModel) {
    return AppTextFieldPass(
      controller: viewModel.confirmPasswordCtronller,
      prefixIcon: const Icon(Icons.lock),
      hintText: "Confirm password",
      labelText: "Confirm password",
      validator:
          Validator.confirmPassword(viewModel.passwordController.text.trim()),
    );
  }

  Widget _buildPhoneField(RegisterVm viewModel) {
    return AppTextField(
      controller: viewModel.phoneController,
      prefixIcon: const Icon(Icons.phone),
      hintText: "Phone",
      labelText: "Phone",
      validator: Validator.phone,
    );
  }

  Widget _buildUsernameField(RegisterVm viewModel) {
    return AppTextField(
      controller: viewModel.usernameController,
      prefixIcon: const Icon(Icons.account_circle_rounded),
      hintText: "Username",
      labelText: "Username",
      validator: Validator.required,
    );
  }

  Widget _buildPasswordField(RegisterVm viewModel) {
    return AppTextFieldPass(
      controller: viewModel.passwordController,
      prefixIcon: const Icon(Icons.lock),
      hintText: "Password",
      labelText: "Password",
      validator: Validator.password,
    );
  }

  Widget _buildRegisterButton(RegisterVm viewModel, BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: AppButton.ouline(
        text: "Register",
        onTap: () => viewModel.submitRegister(context),
      ),
    );
  }
}
