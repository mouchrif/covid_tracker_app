import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_track/models/simple_ordinal_data.dart';
import 'package:intl/intl.dart';

class SimpleSeriesLegend extends StatelessWidget {
  final Map<String, dynamic> historicalData;
  const SimpleSeriesLegend({required this.historicalData});

  String _formateInvalidDate(String invalidDate) {
    List invalidDateList = invalidDate.split("/");
    if (invalidDateList[0].length < 2) {
      invalidDateList[0] = "0" + invalidDateList[0];
    } else {
      invalidDateList[0] = invalidDateList[0];
    }
    List validDateList = [
      "20" + invalidDateList[2],
      invalidDateList[0],
      invalidDateList[1],
    ];
    String validDate = "";
    validDateList.forEach((el) {
      if (validDateList.indexOf(el) < validDateList.length - 1) {
        validDate += "$el-";
      } else {
        validDate += "$el";
      }
    });
    return validDate;
  }

  List<charts.Series<OrdinalCovidData, String>> _createSampleData() {
    if (historicalData.isNotEmpty) {
      // print(historicalData['deaths']);
      List<OrdinalCovidData> cases = [];
      List<OrdinalCovidData> deaths = [];
      // List<OrdinalCovidData> recovered = [];
      num valuesCases = 225915368;
      num valuesDeaths = 4649740;
      // num valuesRecovered = 0;

      historicalData['cases'].forEach((key, value) {
        valuesCases = valuesCases + value;
        cases.add(OrdinalCovidData(
            day: DateFormat('EE')
                .format(DateTime.parse(_formateInvalidDate(key))),
            data: (value / valuesCases) * 100));
      });

      historicalData['deaths'].forEach((key, value) {
        valuesDeaths = valuesDeaths + value;
        deaths.add(OrdinalCovidData(
            day: DateFormat('EE')
                .format(DateTime.parse(_formateInvalidDate(key))),
            data: (value / valuesDeaths) * 100));
      });

      // historicalData['recovered'].forEach((key, value) {
      //   valuesRecovered = valuesRecovered + value;
      //   recovered.add(OrdinalCovidData(
      //       day: DateFormat('EE').format(DateTime.parse(_formateInvalidDate(key))),
      //       data: (value / valuesRecovered) * 100));
      // });

      final casesData = [...cases];
      final deathsData = [...deaths];
      // final recoveredData = [...recovered];

      return [
        charts.Series<OrdinalCovidData, String>(
          id: "Cases",
          colorFn: (e, f) => charts.MaterialPalette.gray.shadeDefault,
          domainFn: (OrdinalCovidData covidData, _) => covidData.day,
          measureFn: (OrdinalCovidData covidData, _) => covidData.data,
          data: casesData,
          fillPatternFn: (c, d) => charts.FillPatternType.solid,
          displayName: "Cases",
        ),
        charts.Series<OrdinalCovidData, String>(
          id: "Deaths",
          colorFn: (e, f) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalCovidData covidData, _) => covidData.day,
          measureFn: (OrdinalCovidData covidData, _) => covidData.data,
          data: deathsData,
          fillPatternFn: (c, d) => charts.FillPatternType.solid,
          displayName: "Deaths",
        ),
        // charts.Series<OrdinalCovidData, String>(
        //   id: "Recovered",
        //   colorFn: (e, f) => charts.MaterialPalette.green.shadeDefault,
        //   domainFn: (OrdinalCovidData covidData, _) => covidData.day,
        //   measureFn: (OrdinalCovidData covidData, _) => covidData.data,
        //   data: recoveredData,
        //   fillPatternFn: (c, d) => charts.FillPatternType.solid,
        //   displayName: "Recovered",
        // ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createSampleData(),
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [charts.SeriesLegend()],
    );
  }
}
