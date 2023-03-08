import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// COLORS
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

// PADDING
const double defaultPadding = 16.0;

// NAVIGATION
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

// FIREBASE
var auth = FirebaseAuth.instance;
