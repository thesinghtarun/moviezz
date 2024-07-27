import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/model/serial_model/serial_model.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/widgets/series/widgets_series/description_widgets/series_poster_and_details.dart';

import 'package:provider/provider.dart';

class TopRatedSeriesDescription extends StatelessWidget {
  const TopRatedSeriesDescription(
      {super.key,
      required this.index,
      required this.seriesId,
      required this.poster});
  final int index;

  final int seriesId;
  final String poster;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return FutureBuilder<SeriesModel>(
            future: value.getAiringTodaySerial(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var series = snapshot.data!.results[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SeriesPosterAndDetails(
                            series: series,
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            poster: poster),

                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: series.name,
                            style: FontStyle().boldStyle(18, appBarColor),
                          ),
                          TextSpan(
                            text: "\n\n${series.overview}",
                            style: FontStyle().style(18, textColor),
                          ),
                        ])),
                        // GetAllActors(
                        //   screenWidth: screenWidth,
                        //   movieId: movieId,
                        //   value: value,
                        // ),
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
