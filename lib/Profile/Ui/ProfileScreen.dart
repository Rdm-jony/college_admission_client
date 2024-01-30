import 'package:college_admission/LogIn/SignIn/Ui/SignInLayoutSreen.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/AdaptiveNavbar.dart';
import 'package:college_admission/Profile/bloc/profile_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();
  TextEditingController? nameController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? universityController = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    profileBloc.add(FatchProfileDataEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: kIsWeb
          ? AppBar(
              leadingWidth: 100.w,
              leading: WebNavbarWidget(),
            )
          : AppBar(
              title: Text("Profile"),
            ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listenWhen: (previous, current) => current is ProfileActionState,
        buildWhen: (previous, current) => current is! ProfileActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchProfileDataLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case FatchProfileDataSuccessState:
              final success = state as FatchProfileDataSuccessState;

              return Center(
                child: SizedBox(
                  width: kIsWeb ? 50.w : 100.w,
                  height: 100.h,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          success.profileData["image"] == null
                              ? CircleAvatar(
                                  radius: 50,
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      success.profileData["image"])),
                          Positioned(
                              bottom: -15,
                              right: -10,
                              child: IconButton(
                                icon: Icon(Icons.camera_alt_outlined),
                                onPressed: () {
                                  profileBloc.add(UpLaodImageEvent());
                                },
                              ))
                        ],
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () {
                                upDateProfile(success.profileData);
                              },
                              icon: Icon(Icons.edit))),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Name:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(success.profileData["name"]
                                  .toString()
                                  .toUpperCase()),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(success.profileData["email"])
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Phone Number:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(success.profileData["number"])
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "University:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(success.profileData["university"]
                                  .toString()
                                  .toUpperCase())
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Address:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(success.profileData["address"]
                                  .toString()
                                  .toUpperCase())
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            logOut();
                          },
                          child: Text("Log Out"))
                    ],
                  ),
                ),
              );
          }
          return Container();
        },
      ),
    );
  }

  void upDateProfile(Map profile) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          builder: (context, snapshot) {
            return AlertDialog(
              content: Column(
                children: [
                  Text(
                    "Update Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Form(
                      key: _key,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController =
                                TextEditingController(text: profile["name"]),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name is required";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Name",
                            ),
                          ),
                          TextFormField(
                            controller: phoneController =
                                TextEditingController(text: profile["number"]),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Number is required";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                            ),
                          ),
                          TextFormField(
                            controller: universityController =
                                TextEditingController(
                                    text: profile["university"]),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "University is required";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "University name",
                            ),
                          ),
                          TextFormField(
                            controller: addressController =
                                TextEditingController(text: profile["address"]),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address is required";
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Address",
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                updateFunction();
                                Navigator.pop(context);
                              },
                              child: Text("Update"))
                        ],
                      ))
                ],
              ),
            );
          },
        );
      },
    );
  }

  void updateFunction() {
    var isValid = _key.currentState?.validate();
    if (isValid == true) {
      var updateInfo = {
        "name": nameController?.text.toString(),
        "university": universityController?.text.toString(),
        "address": addressController?.text.toString(),
        "number": phoneController?.text.toString(),
      };
      profileBloc.add(UpdateUserInfoEvent(updateUserInfo: updateInfo));
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('KEYLOGIN');
    context.go("/signIn");
  }
}
