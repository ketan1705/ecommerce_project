import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_request.dart';
import 'package:ecommerce/presentation/auth/pages/enter_password.dart';
import 'package:ecommerce/presentation/auth/pages/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signInText(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _continueButton(context),
            const SizedBox(height: 20),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return const Text(
      'Sign in',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailCon,
      decoration: const InputDecoration(
          hintText: 'Enter Email', prefixIcon: Icon(Icons.email)),
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
        onPressed: () {
          AppNavigator.push(
              context,
              EnterPasswordPage(
                userSignInRequest:
                    UserSignInRequest(email: _emailCon.text.trim()),
              ));
        },
        title: 'Continue');
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Don't have an account? "),
      TextSpan(
          text: 'Create Account',
          style: const TextStyle(fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, const SignUpPage());
            })
    ]));
  }
}
