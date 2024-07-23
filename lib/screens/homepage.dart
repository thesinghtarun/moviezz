import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/widgets/movie_widgets/top_rated_movies.dart';
import 'package:provider/provider.dart';
import '../widgets/app_bar_home_page.dart';
import '../widgets/movie_widgets/upcoming_movies.dart';
import '../widgets/movie_widgets/popular_movies.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          value.deactivateSearchBox();
          _searchController.text = "";
          _yearController.text = "";
          value.dontShowYearSearchBox();
        },
        child: Scaffold(
          appBar: appBarHomePage(value, context, _searchController),
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
                    height: 30,
                  ),
                  Text(
                    "Top Rated Movies",
                    style: FontStyle().style(22, textColor),
                  ),
                  TopRatedMovies(screenWidth: screenWidth),
                  const SizedBox(
                    height: 30,
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
        ),
      ),
    );
  }
}
