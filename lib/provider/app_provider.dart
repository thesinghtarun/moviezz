// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:moviezz/model/now_playing_movies_model.dart';
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

  Future<void> getData(String movieName) async {
    try {
      var response =
          await https.get(Uri.parse(serachBaseUrl + movieName + searchApiKey));

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print("printtt $data");
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
        print("printtt $data");
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
}
