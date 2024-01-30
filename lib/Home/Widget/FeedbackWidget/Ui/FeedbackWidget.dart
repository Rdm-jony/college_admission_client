import 'package:college_admission/Home/Widget/FeedbackWidget/bloc/feedback_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  FeedbackBloc feedbackBloc = FeedbackBloc();
  @override
  void initState() {
    feedbackBloc.add(FatchInitialFeedbackEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      bloc: feedbackBloc,
      listenWhen: (previous, current) => current is FeedbackActionState,
      buildWhen: (previous, current) => current is! FeedbackActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case FeedbackLoadingState:
            return Center(
              child: CircularProgressIndicator(),
            );
          case FeedbackSuccessState:
            final success = state as FeedbackSuccessState;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: success.feedbacks.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 90.w,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  "assets/images/education_logo.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                success.feedbacks[index].collegeName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: success.feedbacks[index].image == ""
                                    ? CircleAvatar(
                                        backgroundColor: Colors.blue.shade100,
                                        child: Text(
                                          success.feedbacks[index].name
                                              .toString()
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            success.feedbacks[index].image),
                                      ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                success.feedbacks[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBarIndicator(
                                rating:
                                    success.feedbacks[index].rating.toDouble(),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              Text(success.feedbacks[index].date)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(success.feedbacks[index].feedback)
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
    );
  }
}
