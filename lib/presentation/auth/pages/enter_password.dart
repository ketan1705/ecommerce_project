import 'package:ecommerce/common/bloc/button/button_state.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_request.dart';
import 'package:ecommerce/domain/auth/auth_di.dart';
import 'package:ecommerce/presentation/auth/pages/forgot_password.dart';
import 'package:ecommerce/presentation/home/pages/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/helper/navigator/app_navigator.dart';

class EnterPasswordPage extends StatefulWidget {
  final UserSignInRequest userSignInRequest;

  const EnterPasswordPage({super.key, required this.userSignInRequest});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _passwordCon = TextEditingController();

  var _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState) {
                var snackbar = SnackBar(
                  content: Text(state.errorMessage),
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              if (state is ButtonSuccessState) {
                AppNavigator.pushAndRemoveUntil(context, const HomePage());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signInText(context),
                const SizedBox(
                  height: 20,
                ),
                _passwordField(context),
                const SizedBox(height: 20),
                _continueButton(context),
                const SizedBox(height: 20),
                _forgotPassword(context)
              ],
            ),
          ),
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

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicReactiveButton(
          onPressed: () {
            widget.userSignInRequest.password = _passwordCon.text.trim();
            context.read<ButtonStateCubit>().execute(
                useCase: SignInUseCase(), params: widget.userSignInRequest);
          },
          title: 'Continue');
    });
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(text: "Forgot password? "),
      TextSpan(
          text: 'Reset Password',
          style: const TextStyle(fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, ForgotPassword());
            })
    ]));
  }
}
