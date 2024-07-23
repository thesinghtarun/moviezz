import 'package:flutter/material.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:provider/provider.dart';

import '../../../consts/colors.dart';
import '../../../provider/app_provider.dart';

Future<dynamic> showSearchedMovie(
  BuildContext context,
  TextEditingController controller,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer<AppProvider>(
        builder: (context, value, child) {
          if (value.data == null && value.errorMessage.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (value.errorMessage.isNotEmpty) {
            return AlertDialog(
              content: Text(
                value.errorMessage,
                style: FontStyle().style(25, appBarColor),
              ),
            );
          } else {
            var title = value.data["Title"] ?? "No Title";
            var posterUrl = value.data["Poster"] ??
                'https://static.thenounproject.com/png/340719-200.png';
            var imdbRating = value.data["Ratings"] != null &&
                    value.data["Ratings"].isNotEmpty
                ? value.data["Ratings"][0]["Value"]
                : "N/A";
            var rottenTomatoRating = value.data["Ratings"] != null &&
                    value.data["Ratings"].length > 1
                ? value.data["Ratings"][1]["Value"]
                : "N/A";
            var boxOffice = value.data["BoxOffice"] ?? "N/A";
            var plot = value.data["Plot"] ?? "No Plot Available";
            var released = value.data["Released"] ?? "N/A";
            var actors = value.data["Actors"] ?? "N/A";
            var director = value.data["Director"] ?? "N/A";
            var writer = value.data["Writer"] ?? "N/A";

            return AlertDialog(
              backgroundColor: Colors.transparent.withOpacity(.7),
              content: GestureDetector(
                onTap: () => value.dontShowYearSearchBox(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      child: value.data == null
                          ? const CircularProgressIndicator()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                      child: value.showYearTextBox
                                          ? TextField(
                                              autofocus: true,
                                              onChanged: (year) =>
                                                  value.getPreciseData(
                                                      controller.text
                                                          .toString(),
                                                      year),
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "Enter year for better result",
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () =>
                                                  value.showYearSearchBox(),
                                              style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.transparent)),
                                              child: Text(
                                                "Year",
                                                style: FontStyle()
                                                    .style(16, appBarColor),
                                              ))),
                                ),
                                Text(
                                  title,
                                  style: FontStyle().style(25, appBarColor),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Image.network(
                                  posterUrl,
                                  height: 210,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/imdb.png",
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(imdbRating),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/rotten_tomato.png",
                                              height: 40,
                                              width: 30,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(rottenTomatoRating),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        style:
                                            FontStyle().style(18, appBarColor),
                                        children: [
                                      const TextSpan(text: "Collection: "),
                                      TextSpan(
                                          text: boxOffice,
                                          style:
                                              FontStyle().style(16, textColor)),
                                    ])),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          appBarColor, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      plot,
                                      style: FontStyle().style(18, textColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          appBarColor, // Set the border color
                                      width: 2.0, // Set the border width
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SingleChildScrollView(
                                      child: RichText(
                                          text: TextSpan(
                                              style: FontStyle()
                                                  .style(18, appBarColor),
                                              children: [
                                        const TextSpan(text: "Released: "),
                                        TextSpan(
                                            text: released,
                                            style: FontStyle()
                                                .style(16, textColor)),
                                        const TextSpan(text: "\nActors: "),
                                        TextSpan(
                                            text: actors,
                                            style: FontStyle()
                                                .style(16, textColor)),
                                        const TextSpan(text: "\nDirector: "),
                                        TextSpan(
                                            text: director,
                                            style: FontStyle()
                                                .style(16, textColor)),
                                        const TextSpan(text: "\nWriter: "),
                                        TextSpan(
                                            text: writer,
                                            style: FontStyle()
                                                .style(16, textColor)),
                                      ]))),
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    },
  );
}
