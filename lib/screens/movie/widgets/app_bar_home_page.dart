import 'package:flutter/material.dart';

import '../../../consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';

import '../../../provider/app_provider.dart';
import 'show_searched_movie.dart';

AppBar appBarHomePage(AppProvider value, BuildContext context,TextEditingController controller) {
    return AppBar(
          title: value.isSeraching
              ? TextField(
                  controller: controller,
                  autofocus: true,
                  style: FontStyle().style(20, appBarColor),
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            value.getSearchedMovieData(
                                controller.text.toString());
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              : Text(
                  "Moviezz",
                  style: FontStyle().style(25, appBarColor),
                ),
          actions: value.isSeraching
              ? []
              : [
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
                bottom: const TabBar(tabs: [
                  Tab(text:"Movie"),
                  Tab(text: "Serial",)
                ]),
        );
  }
