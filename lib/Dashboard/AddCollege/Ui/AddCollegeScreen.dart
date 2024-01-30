import 'package:college_admission/Dashboard/AddCollege/Repo/AddCollegeRepo.dart';
import 'package:college_admission/Dashboard/AddCollege/bloc/add_college_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCollegeScreen extends StatefulWidget {
  AddCollegeScreen({super.key});

  @override
  State<AddCollegeScreen> createState() => _AddCollegeScreenState();
}

class _AddCollegeScreenState extends State<AddCollegeScreen> {
  AddCollegeBloc addCollegeBloc = AddCollegeBloc();
  final _key = GlobalKey<FormState>();

  var imageName;
  var bannerImageName;
  var imageUrl;
  var bannerUrl;

  TextEditingController? collegeName = TextEditingController();
  TextEditingController? description = TextEditingController();
  TextEditingController? departmentsName = TextEditingController();
  TextEditingController? eventsName = TextEditingController();
  TextEditingController? logoName = TextEditingController();
  TextEditingController? collegeImageName = TextEditingController();
  TextEditingController? dateController = TextEditingController();
  TextEditingController? admissionNotice = TextEditingController();
  TextEditingController? locationName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocConsumer<AddCollegeBloc, AddCollegeState>(
          bloc: addCollegeBloc,
          listenWhen: (previous, current) => current is AddCollegeActionState,
          buildWhen: (previous, current) => current is! AddCollegeActionState,
          listener: (context, state) {
            if (state is AddCollegeSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Successfully added college")));
              _key.currentState?.reset();
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: collegeName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "College name is required";
                          } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                            return "college Name Contain only letter";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: "College Name"),
                      ),
                      TextFormField(
                        controller: eventsName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "event name is required";
                          } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                            return "event Name Contain only letter";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Event Name",
                            hintText: "Ex: Nature Club,Rover Scout,Drama Club",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300)),
                      ),
                      TextFormField(
                        controller: description,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Description",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300)),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: collegeImageName =
                            TextEditingController(text: imageName),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "College image is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "select college image",
                            prefixIcon: Icon(Icons.camera)),
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            PlatformFile file = result.files.first;

                            imageName = file.name;

                            imageUrl = await AddCollegeRepo.uploadCollegeImage(
                                kIsWeb ? file.bytes : file.path);
                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: logoName =
                            TextEditingController(text: bannerImageName),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Image banner is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "select image banner",
                            prefixIcon: Icon(Icons.camera)),
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            PlatformFile file = result.files.first;

                            bannerImageName = file.name;
                            bannerUrl = await AddCollegeRepo.uploadCollegeImage(
                                kIsWeb ? file.bytes : file.path);
                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                      ),
                      TextFormField(
                        controller: departmentsName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Departments name is required";
                          } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                            return "Department Name Contain only letter";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Available Department",
                            hintText: "Ex: bangla,english,math",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300)),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "admission date is required";
                          }
                          return null;
                        },
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: "Date of admission",
                        ),
                        onTap: () async {
                          DateTimeRange? datePicker = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2030),
                            currentDate: DateTime.now(),
                          );

                          if (datePicker != null) {
                            var startDate = DateFormat("yyyy-mm-dd")
                                .format(datePicker.start);
                            var endDate =
                                DateFormat("yyyy-mm-dd").format(datePicker.end);
                            dateController!.text = "${startDate},${endDate}";
                          }
                        },
                      ),
                      TextFormField(
                        controller: admissionNotice,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Admission Notice is required";
                          }
                          return null;
                        },
                        decoration:
                            InputDecoration(labelText: "Admission Notice"),
                      ),
                      TextFormField(
                        controller: locationName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Location is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: "Location"),
                      ),
                      SizedBox(
                          width: 100.w,
                          child: ElevatedButton(
                              onPressed: () {
                                addCollegeInfo();
                              },
                              child: Text("Add")))
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  void addCollegeInfo() {
    var isValid = _key.currentState?.validate();
    if (isValid == true) {
      var collegeInfo = {
        "collegeName": collegeName?.text.toString(),
        "event": eventsName?.text.toString().split(","),
        "description": description?.text.toString(),
        "image": imageUrl.toString(),
        "logo": bannerUrl.toString(),
        "admissionDate": {
          "start": dateController?.text.toString().split(",")[0],
          "end": dateController?.text.toString().split(",")[1],
        },
        "departments": departmentsName?.text.toString().split(","),
        "admissonNotice": admissionNotice?.text.toString(),
        "location": locationName?.text.toString(),
        "top": false
      };
      addCollegeBloc.add(AddCollegePostEvent(collegeInfo: collegeInfo));
    }
  }
}
