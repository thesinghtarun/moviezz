import 'package:flutter/material.dart';
import 'package:moviezz/consts/font_style.dart';

import '../../consts/colors.dart';

import '../../model/upcoming_movies_model.dart';

class MoviePosterAndDetails extends StatelessWidget {
  const MoviePosterAndDetails({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.poster,
    required this.snapshot,
    required this.index,
  });

  final AsyncSnapshot snapshot;
  final double screenHeight;
  final double screenWidth;
  final String poster;
  final int index;

  @override
  Widget build(BuildContext context) {
    var movie = snapshot.data!.results[index];
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
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
                        text: movie.title,
                        style: FontStyle().boldStyle(19, textColor),
                      ),
                      const TextSpan(text: "\nOriginal-Title: "),
                      TextSpan(
                        text: movie.originalTitle,
                        style: FontStyle().boldStyle(19, textColor),
                      ),
                      const TextSpan(text: "\nRelease-Date: "),
                      TextSpan(
                        text: movie.releaseDate,
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
