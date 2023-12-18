import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/city_model.dart';
import "package:flutter/services.dart" as root_bundle;

class CitiesProvider extends ChangeNotifier {
  List<City> unfilterdCitiesList = [];
  List<City> citiesList = [];
  City selectedCity = City();
  String cityName = "";

  Future<Iterable<City>> readCityJson() async {
    if (citiesList.isEmpty) {
      return citiesList;
    }
    final citiesData =
        await root_bundle.rootBundle.loadString('assets/smallCities.json');
    List<dynamic> temporalCitiesList = json.decode(citiesData) as List<dynamic>;

    citiesList = temporalCitiesList
        .map((city) => City.fromJson(city as Map<String, dynamic>))
        .toList();
    return citiesList;
  }

  Future<void> loadCities(String text) async {
    await readCityJson();
    notifyListeners();
  }
}
