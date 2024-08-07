import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/model/serial_model/serial_model.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/widgets/series/description/top_rated_series_description.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TopRatedSeries extends StatelessWidget {
  const TopRatedSeries({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) {
        return FutureBuilder<SeriesModel>(
          future: value.getTopRatedSerial(),
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
                    itemCount: kIsWeb ? 9 : 3,
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
              return SizedBox(
                height: 250,
                width: screenWidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.results.length,
                  itemBuilder: (context, index) {
                    var series = snapshot.data!.results[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TopRatedSeriesDescription(
                                  index: index,
                                  seriesId: series.id,
                                  poster:
                                      "https://image.tmdb.org/t/p/w500${series.posterPath}"))),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 250,
                        width: 150,
                        decoration: BoxDecoration(
                          color: placeHolderColor,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${series.posterPath}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
