import 'package:college_admission/AllColleges/bloc/all_colleges_bloc.dart';
import 'package:college_admission/Dashboard/Colleges/bloc/colleges_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CollegesScreen extends StatefulWidget {
  CollegesScreen({super.key});

  @override
  State<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends State<CollegesScreen> {
  CollegesBloc collegesBloc = CollegesBloc();

  @override
  void initState() {
    collegesBloc.add(FatchCollegesEvent());
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CollegesBloc, CollegesState>(
        bloc: collegesBloc,
        listenWhen: (previous, current) => current is CollegesActionState,
        buildWhen: (previous, current) => current is! CollegesActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FacthCollegesDataLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case FacthCollegesDataSuccessState:
              final success = state as FacthCollegesDataSuccessState;
              return ListView.builder(
                itemCount: success.colleges.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.square(
                              dimension: 50,
                              child: Image.network(
                                  success.colleges[index].image,
                                  fit: BoxFit.fill),
                            ),
                            SizedBox(
                              width: 50.w,
                              child: Text(
                                success.colleges[index].collegeName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            success.colleges[index].top == true
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    onPressed: () {
                                      collegesBloc.add(CollegesAddToTopEvent(
                                          collegeId:
                                              success.colleges[index].sId,
                                          isTop: false));
                                    },
                                    child: Text("Undo"))
                                : ElevatedButton(
                                    onPressed: () {
                                      collegesBloc.add(CollegesAddToTopEvent(
                                          collegeId:
                                              success.colleges[index].sId,
                                          isTop: true));
                                    },
                                    child: Text("Add To Top")),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
