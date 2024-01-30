import 'package:college_admission/LogIn/Repo/LogInRepo.dart';
import 'package:college_admission/LogIn/SignUp/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:sizer/sizer.dart';

class SignUpScreenWeb extends StatefulWidget {
  const SignUpScreenWeb({super.key});

  @override
  State<SignUpScreenWeb> createState() => _SignUpScreenWebState();
}

class _SignUpScreenWebState extends State<SignUpScreenWeb> {
  SignUpBloc signUpBloc = SignUpBloc();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  TextEditingController? universityNameController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? numberController = TextEditingController();
  bool seePass = false;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Center(
            child: SizedBox(
              width: sw > 576 && sw <= 768
                  ? 70.w
                  : sw > 768 && sw <= 992
                      ? 60.w
                      : sw > 992
                          ? 30.w
                          : 100.w,
              // height: 100.h,
              child: BlocConsumer<SignUpBloc, SignUpState>(
                bloc: signUpBloc,
                listenWhen: (previous, current) => current is SignUpActionState,
                buildWhen: (previous, current) => current is! SignUpActionState,
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("successfully Sign up!")));
                    _key.currentState?.reset();
                    context.go("/home");
                  } else if (state is SignUpErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.Error)));
                  } else if (state is SignUpToSignInState) {
                    context.go("/signIn");
                  }
                },
                builder: (context, state) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Glad to see you"),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                            key: _key,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name is required";
                                    } else if (!RegExp(r'[A-Za-z]')
                                        .hasMatch(value)) {
                                      return "Name contains only letter";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.input),
                                      labelText: "Enter your full name",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.input),
                                      labelText: "Enter your Email",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password is required";
                                    } else if (!RegExp(r'.{8,}')
                                        .hasMatch(value)) {
                                      return "Password length minimum 8";
                                    }
                                  },
                                  obscureText: seePass ? true : false,
                                  obscuringCharacter: "*",
                                  decoration: InputDecoration(
                                      suffixIcon: seePass
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  seePass = false;
                                                });
                                              },
                                              icon: Icon(Icons.visibility))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  seePass = true;
                                                });
                                              },
                                              icon: Icon(Icons.visibility_off)),
                                      prefixIcon: Icon(Icons.password),
                                      labelText: "Password",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: confirmPasswordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Confirem password is required";
                                    } else if (passwordController?.text
                                            .toString() !=
                                        value.toString()) {
                                      return "Confirm password doesn't match in your password";
                                    }
                                    return null;
                                  },
                                  obscureText: seePass ? true : false,
                                  obscuringCharacter: "*",
                                  decoration: InputDecoration(
                                      suffixIcon: seePass
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  seePass = false;
                                                });
                                              },
                                              icon: Icon(Icons.visibility))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  seePass = true;
                                                });
                                              },
                                              icon: Icon(Icons.visibility_off)),
                                      prefixIcon: Icon(Icons.password),
                                      labelText: "Confirm Password",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: universityNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "University name is required";
                                    } else if (!RegExp(r'[A-Za-z]')
                                        .hasMatch(value)) {
                                      return "University name only letter";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.input),
                                      labelText: "Enter your University name",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: addressController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Address is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.input),
                                      labelText: "Enter your address",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: numberController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Phone number is required";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.input),
                                      labelText: "Enter your phone number",
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 100.w,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        signUpFormSubmit();
                                      },
                                      child: Text("Sign Up")),
                                )
                              ],
                            )),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    signUpBloc.add(SignUpToSignInEvent());
                                  },
                                  child: Text("Sign In",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                          decoration:
                                              TextDecoration.underline)))
                            ])
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUpFormSubmit() {
    bool isValid = _key.currentState!.validate();
    if (isValid) {
      var userInfo = {
        "name": nameController?.text.toString(),
        "email": emailController?.text.toString(),
        "password": confirmPasswordController?.text.toString(),
        "university": universityNameController?.text.toString(),
        "address": addressController?.text.toString(),
        "number": numberController?.text.toString(),
        "role": "user"
      };
      setState(() {
        signUpBloc.add(SignUpSuccessEvent(userInfo: userInfo));
      });
    }
  }
}
