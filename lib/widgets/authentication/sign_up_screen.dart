import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mission_diary/global/gaps.dart';
import 'package:mission_diary/global/sizes.dart';
import 'package:mission_diary/util/valid_util.dart';
import 'package:mission_diary/widgets/authentication/login_screen.dart';
import 'package:mission_diary/widgets/authentication/view_model/sign_up_view_model.dart';
import 'package:mission_diary/widgets/common/constrainted_body.dart';
import 'package:mission_diary/widgets/common/linked_text.dart';
import 'package:mission_diary/widgets/common/rounded_button.dart';
import 'package:mission_diary/widgets/common/user_info_text_field.dart';
import 'package:mission_diary/widgets/home/home_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  static const String routePath = "/signup";
  static const String routeName = "signup";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isCorrectInfo = false;

  void _isSignUpValidator() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isCorrectInfo = true;
      });
    } else {
      setState(() {
        _isCorrectInfo = false;
      });
    }
  }

  void _onTapLogin() {
    context.goNamed(LoginScreen.routeName);
  }

  Future<void> _onTapSignUp() async {
    final result = await ref.read(signUpProvider.notifier).signUp(
          _emailController.text,
          _passwordController.text,
        );
    if (mounted) {
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            content: Text(result),
          ),
        );
      } else {
        //TODO: it will can be go to onboarding screens
        context.goNamed(HomeScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstraintedBody(
        child: Form(
          key: _formKey,
          onChanged: _isSignUpValidator,
          child: Column(
            children: [
              Flexible(
                flex: 20,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              Flexible(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserInfoTextField(
                      controller: _emailController,
                      labelText: "Email",
                      guideText: "Enter your Email",
                      floatingLabelText: "Email",
                      prefixIcon: FontAwesomeIcons.envelope,
                      textInputType: TextInputType.emailAddress,
                      validator: FormValidator.emailValidator,
                    ),
                    Gaps.v20,
                    UserInfoTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      guideText: "Enter your password",
                      floatingLabelText: "Password",
                      prefixIcon: FontAwesomeIcons.lock,
                      validator: FormValidator.passwordValidator,
                      isObscure: true,
                    ),
                    Gaps.v20,
                    UserInfoTextField(
                      controller: _confirmPasswordController,
                      labelText: "Confirm Password",
                      guideText: "Enter your password again",
                      floatingLabelText: "Confirm Password",
                      prefixIcon: FontAwesomeIcons.lock,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Confirm your password";
                        } else {
                          return null;
                        }
                      },
                      isObscure: true,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      onTap: _onTapSignUp,
                      text: "Create",
                      borderRadius: Sizes.size12,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fontColor: Colors.white,
                      isActive: !ref.watch(signUpProvider).isLoading &&
                          _isCorrectInfo,
                      centerWidget: ref.watch(signUpProvider).isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : null,
                    ),
                    Gaps.v40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size20,
                          ),
                          child: Text(
                            "or with",
                            style: TextStyle(
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v32,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.size10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/google_logo.svg",
                              width: Sizes.size20,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.size10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.apple,
                              size: Sizes.size20,
                            ),
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            padding: const EdgeInsets.all(Sizes.size10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.github,
                              size: Sizes.size20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Have any account? ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w300,
                            fontSize: Sizes.size14,
                          ),
                        ),
                        WidgetSpan(
                          child: LinkedText(
                            onTap: _onTapLogin,
                            text: "Log In",
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: Sizes.size14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
