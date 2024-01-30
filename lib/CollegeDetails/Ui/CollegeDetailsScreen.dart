import 'package:college_admission/CollegeDetails/bloc/college_datails_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:marquee/marquee.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CollegeDetailsScreen extends StatefulWidget {
  const CollegeDetailsScreen({super.key, required this.argument});

  final argument;

  @override
  State<CollegeDetailsScreen> createState() => _CollegeDetailsScreenState();
}

class _CollegeDetailsScreenState extends State<CollegeDetailsScreen> {
  CollegeDetailsBloc collegeDetailsBloc = CollegeDetailsBloc();
  final List<String> ratings = ['1', '2', "3", "4"];
  var selectedRating;
  TextEditingController? feedBackController = TextEditingController();
  final _key = GlobalKey<FormState>();

  List gender = ["Male", "Female", "Other"];
  var selectedGender;

  TextEditingController? nameController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? numberController = TextEditingController();
  TextEditingController? rollController = TextEditingController();
  TextEditingController? regController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  var selectedSubject;
  @override
  Widget build(BuildContext context) {
    final Map route = ModalRoute.of(context)?.settings.arguments as Map;
    final query = route["query"];
   
    return Scaffold(
      appBar: AppBar(
        title: Text("College"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: BlocConsumer<CollegeDetailsBloc, CollegeDetailsState>(
            bloc: collegeDetailsBloc,
            listenWhen: (previous, current) =>
                current is CollegeDetailsActionState,
            buildWhen: (previous, current) =>
                current is! CollegeDetailsActionState,
            listener: (context, state) {
              if (state is SendFeedbackSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Feedback successfully added")));
                _key.currentState?.reset();
              } else if (state is SenFormDataSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(" successfully submited")));
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  Card(
                    elevation: 5,
                    child: SizedBox(
                      width: 100.w,
                      height: 100,
                      child: Image.network(
                        widget.argument.logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    // height: 100,
                    child: Image.network(
                      widget.argument.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Card(
                    child: Row(
                      children: [
                        SizedBox(
                            width: 20.w,
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text("Notice"))),
                        SizedBox(
                          width: 74.w,
                          height: 20,
                          child: Marquee(
                            text:
                                "${widget.argument.admissonNotice}.Admission going on ${widget.argument.admissionDate.start} to ${widget.argument.admissionDate.end}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 20.0,
                            velocity: 100.0,
                            pauseAfterRound: Duration(seconds: 1),
                            startPadding: 10.0,
                            accelerationDuration: Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.argument.collegeName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.argument.description,
                    style: TextStyle(fontSize: 12.sp),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Events:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Card(
                    elevation: 3,
                    child: SizedBox(
                      width: 100.w,
                      height: 110,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5, crossAxisCount: 2),
                        itemCount: widget.argument.event.length,
                        itemBuilder: (context, index) {
                          return Text(widget.argument.event[index]);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available Department:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 3,
                    child: SizedBox(
                      width: 100.w,
                      height: 200,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 5, crossAxisCount: 2),
                        itemCount: widget.argument.departments.length,
                        itemBuilder: (context, index) {
                          return Text(widget.argument.departments[index]);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Loaction:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.argument.location,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  query == "mycollege"
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            admissionForm();
                          },
                          child: Text("Admission Form")),
                  SizedBox(
                    height: 20,
                  ),
                  query == "mycollege"
                      ? Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: feedBackController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Feedback is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    label: Text("Feedback"),
                                    border: OutlineInputBorder()),
                              ),
                              RatingBar.builder(
                                initialRating: 1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  selectedRating = rating;
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    submitFeedBack();
                                  },
                                  child: Text("Add"))
                            ],
                          ))
                      : SizedBox()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void submitFeedBack() {
    var isValid = _key.currentState?.validate();
    if (isValid == true) {
      String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
      var feeback = {
        "collegeName": widget.argument.collegeName,
        "id": widget.argument.sId,
        "rating": selectedRating,
        "feedback": feedBackController?.text.toString(),
        "date": date
      };
      collegeDetailsBloc.add(SendFeedbackEvent(feedback: feeback));
    }
  }

  void admissionForm() async {
    List<dynamic> dynamicList = widget.argument.departments;
    List<DropdownMenuItem<Object>> dropdownItems = [];
    dropdownItems = dynamicList.map((item) {
      return DropdownMenuItem<Object>(
        value:
            item, // You can set this to whatever value you need for the DropdownMenuItem
        child: Text(
            item.toString()), // You can customize the child widget as needed
      );
    }).toList();

    final email = FirebaseAuth.instance.currentUser?.email;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: SizedBox(
                width: 100.w,
                height: 500,
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/education_logo.png"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: Text(widget.argument.collegeName)),
                        ]),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Candidate name is Required";
                            }
                            
                          },
                          decoration: InputDecoration(
                              labelText: "Candidate Name",
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: emailController =
                              TextEditingController(text: email),
                          readOnly: true,
                          decoration: InputDecoration(
                              labelText: "Candidate email",
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone number is Required";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address is Required";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Address",
                              border: OutlineInputBorder()),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Subject',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: dropdownItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.value.toString(),
                                        child: Text(
                                          item.value.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedSubject,
                              onChanged: (value) {
                                setState(() {
                                  selectedSubject = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Gender',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: gender
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: rollController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Hsc Roll number is required";
                            } else if (!RegExp('^[0-9]{4}').hasMatch(value)) {
                              return "Roll must be 4 digit";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Hsc Roll number",
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          controller: regController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Hsc Reg number is required";
                            } else if (!RegExp('^[0-9]{8}').hasMatch(value)) {
                              return "Reg no must be 8 digit";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Hsc Reg number",
                              border: OutlineInputBorder()),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            child: Text("Submit"))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void submitForm() {
    var isValid = _key.currentState?.validate();
    if (isValid == true) {
      var formData = {
        "name": nameController?.text.toString(),
        "address": addressController?.text.toString(),
        "gender": selectedGender,
        "subject": selectedSubject,
        "number": numberController?.text.toString(),
        "roll": rollController?.text.toString(),
        "reg": regController?.text.toString(),
        "email": emailController?.text.toString(),
      };
      collegeDetailsBloc.add(SendFormDataEvent(
          formDetails: formData, collegeId: widget.argument.sId));
      Navigator.of(context).pop();
    }
  }
}
