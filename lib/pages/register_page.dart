import 'package:book_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/app_button.dart';
import 'package:book_app/components/text_field/app_text_field.dart';
import 'package:book_app/components/text_field/app_text_field_pass.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/validator.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPasswordCtronller =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            username: usernameController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildUsernameField(),
                const SizedBox(height: 20.0),
                _buildPhoneField(),
                const SizedBox(height: 20.0),
                _buildPasswordField(),
                const SizedBox(height: 20.0),
                _buildConfirmPasswordField(),
                const SizedBox(height: 20.0),
                _buildEmailField(),
                const SizedBox(height: 40.0),
                _buildRegisterButton(),
                const SizedBox(height: 40.0),
                // GestureDetector(
                //   onTap: () {

                //   },
                //   child: Text("Register" , style: Theme.of(context).textTheme.headlineMedium,))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return AppTextField(
      controller: _emailController,
      prefixIcon: const Icon(Icons.email),
      hintText: "Email",
      labelText: "Email",
      validator: Validator.email,
      onFieldSubmitted: (_) => _submitLogin(),
    );
  }

  Widget _buildConfirmPasswordField() {
    return AppTextFieldPass(
      controller: _confirmPasswordCtronller,
      prefixIcon: const Icon(Icons.lock),
      hintText: "Confirm password",
      labelText: "Confirm password",
      validator:
          Validator.confirmPassword(_passwordController.text.trim()),
    );
  }

  Widget _buildPhoneField() {
    return AppTextField(
      controller: _phoneController,
      prefixIcon: const Icon(Icons.phone),
      hintText: "Phone",
      labelText: "Phone",
      validator: Validator.phone,
    );
  }

  Widget _buildUsernameField() {
    return AppTextField(
      controller: usernameController,
      prefixIcon: const Icon(Icons.account_circle_rounded),
      hintText: "Username",
      labelText: "Username",
      validator: Validator.required,
    );
  }

  Widget _buildPasswordField() {
    return AppTextFieldPass(
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock),
      hintText: "Password",
      labelText: "Password",
      validator: Validator.password,
    );
  }

  Widget _buildRegisterButton() {
    return FractionallySizedBox(
      widthFactor: 0.3,
      child: AppButton.ouline(
        text: "Register",
        onTap: _submitLogin,
      ),
    );
  }
}
