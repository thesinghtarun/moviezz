import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/screens/movie/descriptions/popular_movie_description.dart';
import 'package:provider/provider.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/popular_movies_model.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: screenWidth,
        child: Consumer<AppProvider>(
          builder: (context, value, child) {
            return FutureBuilder<PopularMoviesModel>(
              future: value.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: appBarColor,
                    child: SizedBox(
                      height: 250,
                      width: screenWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(8),
                          height: 250,
                          width: 150,
                          decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'Check your Internet',
                    style: FontStyle().style(20, appBarColor),
                  ));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (context, index) {
                      var movie = snapshot.data!.results[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PopularMovieDescription(
                                      index: index,
                                      movieId: movie.id,
                                      poster:
                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                    ))),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 250,
                          width: 150,
                          decoration: BoxDecoration(
                              color: placeHolderColor,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    },
                  );
                }
              },
            );
          },
        ));
  }
}
