import 'package:flutter/material.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/widgets/movie/widgets_movie/description_widgets/get_actor_details.dart';

class GetAllActors extends StatelessWidget {
  const GetAllActors({
    super.key,
    required this.screenWidth,
    required this.movieId,
    required this.value,
  });

  final double screenWidth;
  final int movieId;
  final AppProvider value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 150,
      width: screenWidth,
      child: FutureBuilder(
        future: value.getMovieActors(movieId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text(
                "Something went wrong"); // Replace with your error widget
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.cast.length,
              itemBuilder: (context, index) {
                var actors = snapshot.data!.cast;
                return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GetActorDetails(
                                        movieId: movieId,
                                        index: index,
                                      ))),
                          child: CircleAvatar(
                            radius: 50,
                            onBackgroundImageError: (exception, stackTrace) {
                              const Text("Error while loading..");
                            },
                            backgroundImage: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${actors[index].profilePath}",
                            ),
                          ),
                        ),
                      ],
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
