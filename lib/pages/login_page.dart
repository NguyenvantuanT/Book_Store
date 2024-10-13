import 'package:book_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/components/app_button.dart';
import 'package:book_app/components/text_field/app_text_field.dart';
import 'package:book_app/components/text_field/app_text_field_pass.dart';
import 'package:book_app/pages/root_page.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/validator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body:  _LoginForm(username: username,),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key, this.username}) : super(key: key);
  final String? username;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const RootPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      _usernameController.text = widget.username ?? "";
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
                _buildPasswordField(),
                const SizedBox(height: 40.0),
                _buildLoginButton(),
                const SizedBox(height: 40.0),
                _remoteRegister(context)
              ],
            ),
          ),
        ),
      ),
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
        child: Text(
          "Register",
          style: Theme.of(context).textTheme.headlineMedium,
        ));
  }

  Widget _buildUsernameField() {
    return AppTextField(
      controller: _usernameController,
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
      onFieldSubmitted: (_) => _submitLogin(),
    );
  }

  Widget _buildLoginButton() {
    return FractionallySizedBox(
      widthFactor: 0.3,
      child: AppButton.ouline(
        text: "Login",
        onTap: _submitLogin,
      ),
    );
  }

}
