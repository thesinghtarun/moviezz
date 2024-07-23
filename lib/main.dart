import 'package:flutter/material.dart';
import 'package:moviezz/provider/app_provider.dart';
import 'package:moviezz/screens/homepage.dart';

import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
          create: (context) => AppProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                color: Colors.black,
              ),

              cardColor: Colors.black,
              canvasColor: Colors.black,
              
            ),
            home: HomePage(),
          )),
    );
