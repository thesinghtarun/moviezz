import 'package:flutter/material.dart';
import 'package:moviezz/consts/font_style.dart';

import '../../../../consts/colors.dart';
import '../../../../model/serial_model/serial_model.dart';

class SeriesPosterAndDetails extends StatelessWidget {
  const SeriesPosterAndDetails({
    super.key,
    required this.series,
    required this.screenHeight,
    required this.screenWidth,
    required this.poster,
  });

  final Series series;
  final double screenHeight;
  final double screenWidth;
  final String poster;

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${series.backdropPath}',
              height: screenHeight * .4,
              width: screenWidth,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
    image: DecorationImage(
        image: NetworkImage(poster), fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    RichText(
                        text: TextSpan(
      style: FontStyle().boldStyle(20, appBarColor),
      children: [
    const TextSpan(text: "Title: "),
    TextSpan(
      text: series.name,
      style: FontStyle().boldStyle(19, textColor),
    ),
    const TextSpan(text: "\nOriginal-Title: "),
    TextSpan(
      text: series.originalName,
      style: FontStyle().boldStyle(19, textColor),
    ),
    const TextSpan(text: "\nRelease-Date: "),
    TextSpan(
      text: series.firstAirDate,
      style: FontStyle().boldStyle(19, textColor),
    ),
                        ])),
                  ],
                ),
              ),
            ),
          ],
        );
  }
}
