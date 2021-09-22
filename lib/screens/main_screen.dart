import 'package:covid_track/constants.dart';
import 'package:covid_track/models/provider.dart';
import 'package:covid_track/screens/home_screen.dart';
import 'package:covid_track/screens/live_reports_screen.dart';
import 'package:covid_track/screens/symptoms_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_track/models/flip_bar_item.dart';
import 'package:covid_track/widgets/flip_box_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: ChangeNotifierProvider<MyData>(
        create: (context) => MyData(),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            MyHomeScreen(),
            SymptomScreen(),
            LiveReportScreen(),
          ],
          onPageChanged: (page) {},
        ),
      ),
      bottomNavigationBar: FlipBoxBar(
        items: [...FlipBarItem.items],
        navBarHeight: size.height * 0.08,
        selectedIndex: _currentIndex,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController!.animateToPage(
            index,
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        },
      ),
    );
  }
}
