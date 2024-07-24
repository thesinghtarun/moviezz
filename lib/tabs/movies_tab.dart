import 'package:flutter/material.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../screens/movie/widgets/movie_widgets/popular_movies.dart';
import '../screens/movie/widgets/movie_widgets/top_rated_movies.dart';
import '../screens/movie/widgets/movie_widgets/upcoming_movies.dart';
import 'package:moviezz/consts/font_style.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming",
                      style: FontStyle().style(22, textColor),
                    ),
                    UpcomingMovies(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Top Rated Movies",
                      style: FontStyle().style(22, textColor),
                    ),
                    TopRatedMovies(screenWidth: screenWidth),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Popular Movies",
                      style: FontStyle().style(22, textColor),
                    ),
                    PopularMovies(screenWidth: screenWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
