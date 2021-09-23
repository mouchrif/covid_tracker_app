import 'dart:async';

import 'package:covid_track/animations/fade_in_animation.dart';
import 'package:covid_track/models/provider.dart';
import 'package:covid_track/screens/details_country-data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:covid_track/constants.dart';
import 'package:provider/provider.dart';

class LiveReportScreen extends StatefulWidget {
  const LiveReportScreen({Key? key}) : super(key: key);

  @override
  _LiveReportScreenState createState() => _LiveReportScreenState();
}

class _LiveReportScreenState extends State<LiveReportScreen> {
  bool _isInit = true;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final mData = Provider.of<MyData>(context, listen: false);
      mData.fetchContriesData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: kDefaultPadding * 2,
          left: kDefaultPadding,
          right: kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: kWhiteColor,
                    size: 18.0,
                  ),
                  Text(
                    "Live Reports",
                    style: GoogleFonts.lato(
                      color: kWhiteColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.solidBookmark,
                    color: kWhiteColor,
                    size: 18.0,
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              LayoutBuilder(
                builder: (context, constraints) => Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "To Day",
                      style: GoogleFonts.lato(
                        color: kWhiteColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.06),
                    Container(
                      width: 2,
                      height: 20,
                      color: kWhiteColor,
                    ),
                    SizedBox(width: constraints.maxWidth * 0.06),
                    Consumer<MyData>(
                      builder: (context, data, child) => Text(
                        DateFormat('EEE  MMM d, ' 'yyyy' '    ' 'h:mm a')
                            .format(DateTime.now()),
                        style: GoogleFonts.lato(
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Consumer<MyData>(builder: (context, data, child) {
          return Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 6),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () {
                      return Future.delayed(const Duration(seconds: 1), () {
                        print("refresh");
                        data.clearListCountries();
                        data.fetchContriesData();
                      });
                    },
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: data.contriesData.length,
                        itemBuilder: (context, index) => LayoutBuilder(
                              builder: (context, constraints) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding / 2),
                                child: TranslateFadeAnimation(
                                  index: index,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        CountryData.routeName,
                                        arguments: {
                                          "data": data.contriesData[index],
                                        }
                                      );
                                    },
                                    child: Card(
                                      color: kCardColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal:
                                                    kDefaultPadding / 1.5,
                                                vertical: kDefaultPadding / 4),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Hero(
                                            tag: data.contriesData[index]['countryInfo']['flag'],
                                            child: Image.network(
                                              data.contriesData[index]['countryInfo']['flag'],
                                              height: constraints.maxHeight,
                                              width: constraints.maxWidth * 0.18,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          data.contriesData[index]['country'],
                                          style: GoogleFonts.lato(
                                              color: kWhiteColor,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Deaths",
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "  ${data.contriesData[index]['todayDeaths']}",
                                                    style: GoogleFonts.lato(
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Recovered",
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "  ${((data.contriesData[index]['todayRecovered'] / data.contriesData[index]['recovered']) * 100).toStringAsFixed(2)}%",
                                                    style: GoogleFonts.lato(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
          );
        }),
      ],
    );
  }
}
