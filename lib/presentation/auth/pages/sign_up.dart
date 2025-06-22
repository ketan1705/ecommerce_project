import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce/presentation/auth/pages/gender_age_selection.dart';
import 'package:ecommerce/presentation/auth/pages/sign_in.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../data/auth/models/user_creation_request.dart';

/// A page that allows new users to sign up for an account.
///
/// This page collects the user's first name, last name, email, and password.
/// Upon successful input, it navigates to the [GenderAndAgeSelectionPage].
/// It also provides an option to navigate to the [SigninPage] if the user
/// already has an account.
class SignUpPage extends StatefulWidget {
  /// Creates a [SignUpPage].
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailCon = TextEditingController();

  final TextEditingController _passwordCon = TextEditingController();

  final TextEditingController _firstNameCon = TextEditingController();

  final TextEditingController _lastNameCon = TextEditingController();

  var _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signUpText(),
            const SizedBox(height: 20),
            _firstNameField(context),
            const SizedBox(height: 20),
            _lastNameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            _continueButton(context),
            const SizedBox(height: 20),
            _createAccount(context)
          ],
        ),
      ),
    );
  }

  /// Builds the "Create Account" title text.
  Widget _signUpText() {
    return const Text(
      'Create Account',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  /// Builds the text field for the user's first name.
  Widget _firstNameField(BuildContext context) {
    return TextField(
      controller: _firstNameCon,
      decoration: const InputDecoration(
        hintText: 'Enter FirstName',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  /// Builds the text field for the user's last name.
  Widget _lastNameField(BuildContext context) {
    return TextField(
      controller: _lastNameCon,
      decoration: const InputDecoration(
        hintText: 'Enter Lastname',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  /// Builds the text field for the user's email address.
  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailCon,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  /// Builds the text field for the user's password.
  Widget _passwordField(BuildContext context) {
    return TextField(
      obscureText: !_isPasswordVisible,
      controller: _passwordCon,
      decoration: InputDecoration(
          hintText: 'Enter Password',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(_isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off))),
    );
  }

  /// Builds the "Continue" button.
  ///
  /// When pressed, this button navigates to the [GenderAndAgeSelectionPage],
  /// passing along the user's input data in a [UserCreationRequest].
  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
        onPressed: () {
          AppNavigator.push(
              context,
              GenderAndAgeSelectionPage(
                  userCreationReq: UserCreationRequest(
                firstName: _firstNameCon.text,
                lastName: _lastNameCon.text,
                email: _emailCon.text,
                password: _passwordCon.text,
              )));
        },
        title: 'Continue');
  }

  /// Builds the text that allows users to navigate to the sign-in page.
  ///
  /// This widget displays "Already have an account? Login", where "Login"
  /// is a tappable link that navigates to the [SigninPage].
  Widget _createAccount(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Already have an account? "),
      TextSpan(
          text: 'Login',
          style: const TextStyle(fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.pushReplacement(context, SigninPage());
            })
    ]));
  }
}
