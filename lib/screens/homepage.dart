import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';

import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/tabs/movies_tab.dart';
import 'package:moviezz/tabs/serial_tab.dart';
import 'package:moviezz/screens/movie/widgets/movie_widgets/top_rated_movies.dart';
import 'package:provider/provider.dart';
import 'movie/widgets/app_bar_home_page.dart';
import 'movie/widgets/movie_widgets/upcoming_movies.dart';
import 'movie/widgets/movie_widgets/popular_movies.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Consumer<AppProvider>(
        builder: (context, value, child) => GestureDetector(
          onTap: () {
            value.deactivateSearchBox();
            _searchController.text = "";
            _yearController.text = "";
            value.dontShowYearSearchBox();
          },
          child: Scaffold(
            appBar: appBarHomePage(value, context, _searchController),
            body: const TabBarView(children: [
              MoviesTab(),
              SerialTab()
            ])
           ),
        ),
      ),
    );
  }
}
