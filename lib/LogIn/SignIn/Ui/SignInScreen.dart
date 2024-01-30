import 'package:college_admission/LogIn/SignIn/bloc/sign_in_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInBloc signInBloc = SignInBloc();
  final _key = GlobalKey<FormState>();

  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool seePass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: BlocConsumer<SignInBloc, SignInState>(
        bloc: signInBloc,
        listenWhen: (previous, current) => current is SignInActionState,
        buildWhen: (previous, current) => current is! SignInActionState,
        listener: (context, state) {
          if (state is SignInSuceessState) {
            context.go("/home");
            _key.currentState?.reset();
          } else if (state is SignInErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.Error)));
          } else if (state is SignInToSignUpState) {
            context.go("/signUp");
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: SizedBox(
                    width:100.w,
                    height: 80.h,
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "email is required";
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: "Enter your email",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is required";
                              }
                              return null;
                            },
                            controller: passwordController,
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
                                labelText: "Enter your password",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: ElevatedButton(
                                onPressed: () {
                                  submit();
                                },
                                child: Text("Sign In")),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Not a member?"),
                                TextButton(
                                    onPressed: () {
                                      signInBloc.add(SignInToSignUpEvent());
                                    },
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline)))
                              ])
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  void submit() {
    var isValid = _key.currentState?.validate();

    if (isValid == true) {
      signInBloc.add(SignInSuccessEvent(
          email: emailController!.text.toString(),
          passsword: passwordController!.text.toString()));
    }
  }
}
