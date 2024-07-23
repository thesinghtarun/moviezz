import 'package:flutter/material.dart';
import 'package:moviezz/consts/font_style.dart';

import '../consts/colors.dart';
import '../provider/app_provider.dart';

AppBar appBarWithOutSearchBox(AppProvider value) {
  return AppBar(
    //  backgroundColor: Colors.black,
    elevation: 0,
    actions: [
      InkWell(
        onTap: () {
          value.activateSearchBox();
        },
        child: const Icon(
          Icons.search,
          color: appBarColor,
          size: 30,
        ),
      )
    ],
    title: Text(
      "Moviezz",
      style: FontStyle().style(25, appBarColor),
    ),
  );
}
