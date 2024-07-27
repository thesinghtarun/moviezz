import 'package:flutter/material.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/widgets/series/widgets_series/series_helper_widgets/popular_series.dart';
import 'package:moviezz/widgets/series/widgets_series/series_helper_widgets/airing_today_series.dart';
import 'package:moviezz/widgets/series/widgets_series/series_helper_widgets/top_rated_series.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';

class SerialTab extends StatelessWidget {
  const SerialTab({super.key});

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
                      "Airing Today",
                      style: FontStyle().style(22, textColor),
                    ),
                    AiringTodaySeries(
                        screenHeight: screenHeight, screenWidth: screenWidth),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Top Rated Series",
                      style: FontStyle().style(22, textColor),
                    ),
                    TopRatedSeries(screenWidth: screenWidth),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Popular Series",
                      style: FontStyle().style(22, textColor),
                    ),
                    PopularSeries(screenWidth: screenWidth)
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
