import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

class CardWidget extends StatelessWidget {
  final routeName;
  final cardData;
  final bloc;
  const CardWidget(
      {required this.cardData, required this.bloc, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 100,
                  child: Image.network(
                    cardData.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    cardData.collegeName.toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                cardData.description.length > 200
                    ? Text(
                        "${cardData.description.toString().substring(0, 200)}....")
                    : Text(cardData.descriptions),
                Text(
                  "Events",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 100.w,
                  height: 100,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 5, crossAxisCount: 2),
                    itemCount:
                        cardData.event.length > 6 ? 6 : cardData.event.length,
                    itemBuilder: (context, index) {
                      return Center(child: Text(cardData.event[index]));
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.push(
                        "/college?query=${routeName}",
                        extra: cardData,
                      );
                    },
                    child: Text("See Details"))
              ],
            )),
      ),
    );
    ;
  }
}
