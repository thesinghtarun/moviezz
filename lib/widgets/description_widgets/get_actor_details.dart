import 'package:flutter/material.dart';
import 'package:moviezz/consts/colors.dart';
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
                children: [
                  Container(
                    height: screenHeight * .4,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${actors[index].profilePath}"),
                            fit: BoxFit.cover)),
                  ),
                  const Text("Details")
                ],
              );
            }
          },
        );
      },
    ));
  }
}
