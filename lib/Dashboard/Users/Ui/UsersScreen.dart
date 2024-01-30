import 'package:college_admission/Dashboard/Users/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UsersBloc usersBloc = UsersBloc();
  @override
  void initState() {
    usersBloc.add(FatchAllUsersEvent());
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UsersBloc, UsersState>(
      bloc: usersBloc,
      listenWhen: (previous, current) => current is UsersActionState,
      buildWhen: (previous, current) => current is! UsersActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case FatchAllUsersLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case FatchAllUsersSuccessState:
            final success = state as FatchAllUsersSuccessState;
            return ListView.builder(
              itemCount: success.users.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(success.users[index].image.toString()),
                      ),
                      Text(success.users[index].email),
                      Text(success.users[index].name),
                      success.users[index].role == "user"
                          ? ElevatedButton(
                              onPressed: () {
                                usersBloc.add(UserAddToAdminEvent(
                                    role: "admin",
                                    userId: success.users[index].sId));
                              },
                              child: Text("Add To Admin"))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () {
                                usersBloc.add(UserAddToAdminEvent(
                                    role: "user",
                                    userId: success.users[index].sId));
                              },
                              child: Text("Undo")),
                    ],
                  ),
                );
              },
            );
        }
        return Container();
      },
    ));
  }
}
