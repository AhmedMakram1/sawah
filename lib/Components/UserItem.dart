import 'package:flutter/material.dart';
import 'package:sawah_app/Models/UserModel.dart';

// ignore: must_be_immutable
class UserItem extends StatelessWidget {
  ItemTripModel itemTripModel;
  UserItem({required this.itemTripModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Icon(Icons.trip_origin),
              backgroundColor: Colors.greenAccent,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemTripModel.day!,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    itemTripModel.description!,
                    style: TextStyle(fontSize: 16, color: Color(0xffc64170)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
