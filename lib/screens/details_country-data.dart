import 'package:flutter/material.dart';
import 'package:covid_track/constants.dart';
import 'package:covid_track/screens/row_details_country.dart';
import 'package:covid_track/widgets/cases_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CountryData extends StatelessWidget {
  const CountryData({Key? key}) : super(key: key);
  static String routeName = "/country-data";

  @override
  Widget build(BuildContext context) {
    final double coefficent = 0.4;
    final Size size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * coefficent,
            child: PreferredSize(
              preferredSize: Size(size.width, size.height * coefficent),
              child: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(39),
                    bottomRight: Radius.circular(39),
                  ),
                ),
                backgroundColor: Colors.transparent,
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(39),
                    bottomRight: Radius.circular(39),
                  ),
                  child: Hero(
                    tag: args['data']['countryInfo']['flag'],
                    child: Material(
                      type: MaterialType.transparency,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/corona_virus.jpg",
                            height: size.height * coefficent + MediaQuery.of(context).padding.top,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kBlackColor.withOpacity(0.75),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Last Update :  " +
                                    DateFormat('EEE  MMM d, ' 'yyyy' '    ' 'h:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(args['data']['updated'])),
                                    style: GoogleFonts.oswald(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Corona Virus Today Cases",                                                                                       
                                    style: GoogleFonts.oswald(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    args['data']['todayCases'].toString(),
                                    style: GoogleFonts.oswald(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.02,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: kTextColor,
                    size: 16.0,
                  ),
                ),
                title: Text(
                  args['data']['country'],
                  style: GoogleFonts.lato(
                    color: kWhiteColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * coefficent - kDefaultPadding * 5,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding / 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowDetailsCountryCases(
                      boxColor: kCardColor, 
                      titles: ["Deaths", "Recovered"], 
                      texts: ["${args['data']['deaths']}", "${args['data']['recovered']}"], 
                      textColors: [kPrimaryColor, Colors.green],
                    ),
                    SizedBox(height: 10),
                    RowDetailsCountryCases(
                      boxColor: kCardColor, 
                      titles: ["Today deaths", "Today recovered"], 
                      texts: ["${args['data']['todayDeaths']}", "${args['data']['todayRecovered']}"], 
                      textColors: [kPrimaryColor, Colors.green],
                    ),
                    SizedBox(height: 10),
                    CasesBox(
                      boxColor: kCardColor,
                      title: "Active cases",
                      casesNumber: "${args['data']['active']}",
                      subTitleTop: "Mild Condition",
                      subTitleBottom: "Critical",
                      topPercent: ((args['data']['active'] - args['data']['critical'])/args['data']['active']*100).toStringAsFixed(1) + "%",
                      bottomPercent: ((args['data']['critical']/args['data']['active'])*100).toStringAsFixed(1) + "%",
                    ),
                    SizedBox(height: 10),
                    CasesBox(
                      boxColor: kCardColor,
                      title: "Closed cases",
                      casesNumber: "${args['data']['cases'] - args['data']['active']}",
                      subTitleTop: "Recovered",
                      subTitleBottom: "Deaths",
                      topPercent: (args['data']['recovered']/(args['data']['cases'] - args['data']['active'])*100).toStringAsFixed(1) + "%",
                      bottomPercent: (args['data']['deaths']/(args['data']['cases'] - args['data']['active'])*100).toStringAsFixed(1) + "%",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
