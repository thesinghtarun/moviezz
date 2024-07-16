import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/model/popular_movies_model.dart';
import 'package:moviezz/provider/app_provider.dart';

import 'package:provider/provider.dart';

class PopularMovieDescription extends StatelessWidget {
  const PopularMovieDescription({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return FutureBuilder<PopularMoviesModel>(
            future: value.getPopularMovies(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var movie = snapshot.data!.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                          height: screenHeight * .4,
                          width: screenWidth,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(
                                style: FontStyle().style(19, appBarColor),
                                children: [
                              const TextSpan(text: "Title: "),
                              TextSpan(
                                text: movie.title,
                                style: FontStyle().style(18, textColor),
                              ),
                              const TextSpan(text: "\nOriginal-Title: "),
                              TextSpan(
                                text: movie.originalTitle,
                                style: FontStyle().style(18, textColor),
                              ),
                              TextSpan(
                                text: "\n\n${movie.overview}",
                                style: FontStyle().style(18, textColor),
                              ),
                            ])),
                        Container(
                          color: appBarColor,
                          height: 150,
                          width: screenWidth,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(appBarColor)),
                              child: Text(
                                "Close",
                                style: FontStyle().style(19, textColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Abhi thoda baaki h🫣")));
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(textColor)),
                              child: Text(
                                "Watch Trailer",
                                style: FontStyle().style(19, appBarColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
