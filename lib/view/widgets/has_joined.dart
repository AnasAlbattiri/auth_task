import 'package:flutter/material.dart';
import 'package:three_stars_task/data/model/joined.dart';
import '../../utils/constants.dart';

Widget hasJoined(Joined model){
  return Container(
    decoration: BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    width: 250,
    child: Center(
      child: Text(
        '${model.name} has joined',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    ),
  );
}