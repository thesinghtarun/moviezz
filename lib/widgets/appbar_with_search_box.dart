import 'package:flutter/material.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/widgets/show_searched_movie.dart';

import '../consts/colors.dart';
import '../provider/app_provider.dart';

AppBar appBarWithSearchBox(AppProvider value, BuildContext context,
    TextEditingController controller, TextEditingController yearController) {
  return AppBar(
    title: TextField(
      controller: controller,
      autofocus: true,
      style: FontStyle().style(20, appBarColor),
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                value.getSearchedMovieData(controller.text.toString());
                await showSearchedMovie(
                  context,
                  controller,
                );
              },
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                    color: appBarColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  "assets/images/send.png",
                  height: 3,
                  width: 3,
                ),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
  );
}
