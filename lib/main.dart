import 'package:covid_track/constants.dart';
import 'package:covid_track/screens/details_country-data.dart';
import 'package:covid_track/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 tracking app',
      theme: ThemeData(
        scaffoldBackgroundColor: kBlackColor,
        primaryColor: kPrimaryColor,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: kTextColor,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        CountryData.routeName: (ctx) => CountryData(),
      },
      home: HomeScreen(),
    );
  }
}
