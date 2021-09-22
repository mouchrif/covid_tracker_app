import 'package:flutter/material.dart';
import 'package:covid_track/animations/stagered_column_animation.dart';
import 'package:covid_track/models/provider.dart';
import 'package:covid_track/widgets/lastUpdate-statistics.dart';
import 'package:covid_track/widgets/simple_series_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covid_track/constants.dart';
import 'package:covid_track/widgets/statistic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final myData = Provider.of<MyData>(context, listen: false);
    if (_isInit) {
      await myData.fetchContriesData();
      myData.fetchGlobalData();
      myData.fetchHistoricalDataAll();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final data = Provider.of<MyData>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding / 1.5),
      child: data.globalData.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ColumnAnimationStaggered(
              children: [
                SizedBox(height: 20),
                Text(
                  "COVID-Statistics",
                  style: GoogleFonts.lato(
                    color: kTextColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                LastUpdateStatistics(
                  date: DateTime.fromMillisecondsSinceEpoch(
                      data.globalData['updated']),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Statistic(
                        title: "Total Deaths",
                        text: data.globalData['deaths'],
                        color: kPrimaryColor),
                    SizedBox(width: 16),
                    Statistic(
                        title: "Total Recovered",
                        text: data.globalData['recovered'],
                        color: Colors.green),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.32, // il faut adapter chart widget size height
                  child: SimpleSeriesLegend(historicalData: data.historicalDataLastDays,),
                ),
                SizedBox(height: 20),
                Text(
                  "Top Contries",
                  style: GoogleFonts.lato(
                    color: kTextColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      ...List.generate(
                        10,
                        (index) {
                          var _formatedNumber = NumberFormat.compact();
                          return Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: kDefaultPadding,
                                  horizontal: kDefaultPadding,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: kTextColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        data.getCountryOfDeathNumber(data
                                                .getTopCountriesDeaths()[
                                            index])[0]['countryInfo']['flag'],
                                        height: 20,
                                        width: 30,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      data.getCountryOfDeathNumber(
                                          data.getTopCountriesDeaths()[
                                              index])[0]['country'],
                                      style: GoogleFonts.lato(
                                        color: kTextColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _formatedNumber.format(
                                              data.getCountryOfDeathNumber(
                                                  data.getTopCountriesDeaths()[
                                                      index])[0]['deaths']),
                                          style: GoogleFonts.lato(
                                              color: kWhiteColor,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 6),
                                        Icon(
                                          FontAwesomeIcons.caretUp,
                                          color: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
