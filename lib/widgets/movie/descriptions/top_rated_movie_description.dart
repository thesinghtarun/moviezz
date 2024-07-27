import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/model/movie_model/movie_model.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/widgets/movie/widgets_movie/description_widgets/movie_poster_and_details.dart';
import 'package:provider/provider.dart';

import '../widgets_movie/description_widgets/get_all_actors.dart';

class TopRatedMovieDescription extends StatelessWidget {
  const TopRatedMovieDescription(
      {super.key, required this.index, required this.movieId, required this.poster});
  final int index;
  final int movieId;
  final String poster;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return FutureBuilder<MoviesModel>(
            future: value.getTopRatedMovies(),
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
                        MoviePosterAndDetails(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            poster: poster,
                            snapshot: snapshot,
                            index: index),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: movie.title,
                            style: FontStyle().boldStyle(18, appBarColor),
                          ),
                          TextSpan(
                            text: "\n\n${movie.overview}",
                            style: FontStyle().style(18, textColor),
                          ),
                        ])),
                        GetAllActors(
                          screenWidth: screenWidth,
                          movieId: movieId,
                          value: value,
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
