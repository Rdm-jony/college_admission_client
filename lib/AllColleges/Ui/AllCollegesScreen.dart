import 'package:college_admission/AllColleges/Repo/AllCollegesRepo.dart';
import 'package:college_admission/AllColleges/bloc/all_colleges_bloc.dart';
import 'package:college_admission/Home/Widget/Banner/Ui/CardWidget.dart';
import 'package:college_admission/Navbar/BottomNavbar/Ui/AdaptiveNavbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class AllCollegesScreen extends StatefulWidget {
  const AllCollegesScreen({super.key});

  @override
  State<AllCollegesScreen> createState() => _AllCollegesScreenState();
}

class _AllCollegesScreenState extends State<AllCollegesScreen> {
  AllCollegesBloc allCollegesBloc = AllCollegesBloc();
  var searchColleges = [];
  @override
  void initState() {
    allCollegesBloc.add(FatchAllCollegesEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: kIsWeb
          ? AppBar(
              leadingWidth: 100.w,
              leading: WebNavbarWidget(),
            )
          : AppBar(
              title: Text("All Collges"),
            ),
      body: BlocConsumer<AllCollegesBloc, AllCollegesState>(
        bloc: allCollegesBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchAllCollegesLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case FatchAllCollegesSuccessState:
              final success = state as FatchAllCollegesSuccessState;
              return SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 100.w,
                            height: 50,
                            child: TextFormField(
                              onChanged: (value) {
                                seachFunction(value);
                              },
                              decoration: InputDecoration(
                                  labelText: "search your college",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 5))),
                            ))
                      ],
                    ),
                    searchColleges.length > 0
                        ? SizedBox(
                            width: 100.w,
                            height: 200,
                            child: ListView.builder(
                              itemCount: searchColleges.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.push(
                                      "/college",
                                      extra: searchColleges[index],
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: SizedBox.square(
                                        dimension: 50,
                                        child: Image.network(
                                          searchColleges[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(searchColleges[index]
                                          .collegeName
                                          .toString()
                                          .toUpperCase()),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: success.allColleges.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                CardWidget(
                                  bloc: allCollegesBloc,
                                  cardData: success.allColleges[index],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
          }
          return Container();
        },
      ),
    );
  }

  void seachFunction(text) async {
    searchColleges = await AllCollegesRepo.fatchSearchItem(text);
    setState(() {});
  }
}
