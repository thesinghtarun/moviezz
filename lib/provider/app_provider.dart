// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:moviezz/model/actors_of_movie_model.dart';
import 'package:moviezz/model/popular_movies_model.dart';
import 'package:moviezz/model/top_rated_movies_model.dart';
import 'package:moviezz/model/upcoming_movies_model.dart';

import '../api/apis.dart';

class AppProvider extends ChangeNotifier {
  bool isSeraching = false;
  bool showYearTextBox = false;

  void showYearSearchBox() {
    showYearTextBox = true;
    notifyListeners();
  }

  void dontShowYearSearchBox() {
    showYearTextBox = false;
    notifyListeners();
  }

  void activateSearchBox() {
    isSeraching = true;
    notifyListeners();
  }

  void deactivateSearchBox() {
    isSeraching = false;
    notifyListeners();
  }

  var data;
  String errorMessage = "";

  Future<void> getSearchedMovieData(String movieName) async {
    try {
      var response =
          await https.get(Uri.parse(serachBaseUrl + movieName + searchApiKey));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        errorMessage = "";
        notifyListeners();
      } else {
        data = null;
        errorMessage = 'Wrong movie name, please check name.';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'An error occurred, please try again.';
    }
    notifyListeners();
  }

  Future<void> getPreciseData(String movieName, String movieYear) async {
    try {
      var response = await https
          .get(Uri.parse("$serachBaseUrl$movieName&y=$movieYear$searchApiKey"));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        errorMessage = "";
        notifyListeners();
      } else {
        data = null;
        errorMessage = 'Wrong movie name, please check name.';
        notifyListeners();
      }
    } catch (e) {
      errorMessage = 'An error occurred, please try again.';
    }
    notifyListeners();
  }

//to get movieId
  String movieId = "";
  void getMovieId(String id) {
    movieId = id;
    print("movieId: $movieId");
    notifyListeners();
  }

//to get popular movies
  Future<PopularMoviesModel> getPopularMovies() async {
    final response = await https.get(Uri.parse(popularMovies));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PopularMoviesModel.fromJson(data);
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

//to get now_playing movies
  Future<UpcomingMoviesModel> getUpcomingMovies() async {
    final response = await https.get(Uri.parse(upcomingMovies));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return UpcomingMoviesModel.fromJson(data);
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  //to get now_playing movies
  Future<TopRatedMoviesModel> getTopRatedMovies() async {
    final response = await https.get(Uri.parse(topRatedMovies));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return TopRatedMoviesModel.fromJson(data);
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  //to get all actors of upcoming_movie
  Future<ActorsOfMovie> getMovieActors(int id) async {
    final response =
        await https.get(Uri.parse("$baseUrlForMovies$id/credits$apiKey"));
    if (response.statusCode == 200) {
      var actorData = jsonDecode(response.body);
      print("movieId $actorData");
      return ActorsOfMovie.fromJson(actorData);
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}
