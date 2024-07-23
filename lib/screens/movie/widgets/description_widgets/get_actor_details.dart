import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
import 'package:moviezz/consts/font_style.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:provider/provider.dart';

class GetActorDetails extends StatelessWidget {
  const GetActorDetails(
      {super.key, required this.movieId, required this.index});
  final int movieId;
  final int index;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(body: Consumer<AppProvider>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.getMovieActors(movieId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var actors = snapshot.data!.cast;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * .7,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${actors[index].profilePath}"),
                            fit: BoxFit.cover)),
                  ),
                  RichText(
                      text: TextSpan(
                          style: FontStyle().style(25, appBarColor),
                          children: [
                        const TextSpan(text: "Name: "),
                        TextSpan(
                            text: actors[index].name,
                            style: FontStyle().style(23, textColor)),
                        const TextSpan(text: "\nCharacter in movie: "),
                        TextSpan(
                            text: actors[index].character,
                            style: FontStyle().style(23, textColor)),
                        const TextSpan(text: "\nKnown for: "),
                        TextSpan(
                            text: actors[index].knownForDepartment,
                            style: FontStyle().style(23, textColor)),
                      ]))
                ],
              );
            }
          },
        );
      },
    ));
  }
}
