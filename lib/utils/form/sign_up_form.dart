import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:type1dm_rl_flutter/utils/button/main_button.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/services/auth_service.dart';
import 'package:type1dm_rl_flutter/utils/function/save_firebase_function.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? signUpErrorMessage;
  bool _obscurePassword = true;
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void signUp(BuildContext context) async {
    setState(() {
      signUpErrorMessage = null;
      isShowLoading = true;
      isShowConfetti = true;
    });
    try {
      final email = emailController.text;
      final password = passwordController.text;
      final user =
          await _authService.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        // Check if user exists in the demographics table
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('primary_care')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // User exists in demographics, show error
          error.fire();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isShowLoading = false;
              signUpErrorMessage = 'User already exist!';
            });
          });
          return; // この行を追加
        } else {
          // User doesn't exist in demographics, navigate to demographics page
          check.fire();
          Future.delayed(Duration(seconds: 2), () {
            confetti.fire();
            Future.delayed(Duration(seconds: 2), () {
              saveActivateUserFirestore();
              Navigator.pushReplacementNamed(
                  context, '/demographicsSettingPage');
            });
          });
        }
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
            signUpErrorMessage = 'Cannot Sign up!';
          });
        });
      }
    } catch (e) {
      error.fire();
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
          signUpErrorMessage = 'Cannot Sign up!';
        });
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isShowLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authFunction = AuthFunction(context);
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                    color: ColorConstants.pandaBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      if (signUpErrorMessage != null) {
                        return signUpErrorMessage;
                      }
                      return null;
                    },
                    onSaved: (email) {},
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: ColorConstants.pandaBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.password),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _obscurePassword = !_obscurePassword;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: ColorConstants.pandaBlack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please confirm your password";
                      } else if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.password),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 20),
                  child: buildButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password cannot be empty')),
                          );
                          return;
                        }
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Passwords do not match')),
                          );
                          return;
                        }
                        signUp(context);
                      }
                    },
                    text: 'Sign Up',
                    icon: Icons.person_add,
                    color: ColorConstants.pandaBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                child: Transform.scale(
                  scale: 6,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: (artboard) {
                      StateMachineController controller =
                          getRiveController(artboard);
                      confetti =
                          controller.findSMI("Trigger explosion") as SMITrigger;
                    },
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
