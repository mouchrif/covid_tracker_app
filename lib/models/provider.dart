import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyData with ChangeNotifier {
  List<Map> _contriesData = [];
  List<Map> _filtredCountriesData = [];
  bool _isRefresh = false;

  Map _glabalData = {};

  Map<String, dynamic> _historicalDatalastdays = {};
  Map<String, dynamic> get historicalDataLastDays {
    return {..._historicalDatalastdays};
  }

  List get contriesData {
    return [..._contriesData];
  }

  List get filtredCountriesData {
    return [..._filtredCountriesData];
  }

  Map get globalData {
    return {..._glabalData};
  }

  bool get isRefresh {
    return _isRefresh;
  }

  Future fetchContriesData() async {
    var url = Uri.parse("https://corona.lmao.ninja/v2/countries?today&sort");
    try {
      var response = await http.get(url);
      List loadedData = json.decode(response.body);
      final List<Map> contries = [];
      loadedData.forEach((data) {
        contries.add(data);
      });
      _contriesData = contries;
      _filtredCountriesData = _contriesData;
      _isRefresh = false;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void fetchFiltredCountriesData(String text) {
    if (text.isEmpty) {
      _filtredCountriesData = _contriesData;
      notifyListeners();
    } else {
      _filtredCountriesData = _contriesData
          .where((countryData) => countryData['country'].toLowerCase().contains(text))
          .toList();
      notifyListeners();
    }
  }

  Future fetchGlobalData() async {
    var url = Uri.parse("https://corona.lmao.ninja/v2/all?yesterday");
    try {
      var response = await http.get(url);
      Map loadedGlobalData = json.decode(response.body);
      final Map all = {};
      loadedGlobalData.forEach((key, value) {
        all.addAll({key: value});
      });
      _glabalData = all;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future fetchHistoricalDataAll() async {
    var url =
        Uri.parse("https://disease.sh/v3/covid-19/historical/all?lastdays=6");
    try {
      var response = await http.get(url);
      Map<String, dynamic> loadedLastDaysOfWeekHistoricalData =
          json.decode(response.body);
      final Map<String, dynamic> lastDaysOfWeekHistoricalData = {};
      loadedLastDaysOfWeekHistoricalData.forEach((key, value) {
        lastDaysOfWeekHistoricalData.addAll({key: value});
      });
      _historicalDatalastdays = lastDaysOfWeekHistoricalData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future clearListCountries() async {
    _contriesData.clear();
    _isRefresh = true;
    notifyListeners();
  }

  List<int> getTopCountriesDeaths() {
    List<int> deathsNumbers = [];
    _contriesData.forEach((countryData) {
      deathsNumbers.add(countryData['deaths']);
      deathsNumbers.sort();
    });
    return deathsNumbers.reversed.toList();
  }

  List<Map> getCountryOfDeathNumber(int deathNumber) {
    List<Map> countryOfDeathNumber = [];
    _contriesData.forEach((countryData) {
      if (countryData['deaths'] == deathNumber) {
        countryOfDeathNumber.add(countryData);
      }
    });
    return countryOfDeathNumber;
  }
}
