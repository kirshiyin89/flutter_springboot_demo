import 'package:flutter/material.dart';

int determineCrossAxisCount(BuildContext context) {
  int _crossAxisCount = 1;
  final double screenWidthSize = MediaQuery.of(context).size.width;
  if (screenWidthSize > 820) {
    _crossAxisCount = 4;
  } else if (screenWidthSize > 720) {
    _crossAxisCount = 3;
  } else if (screenWidthSize > 520) {
    _crossAxisCount = 2;
  } else {
    _crossAxisCount = 1;
  }

  return _crossAxisCount;
}
