import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService weatherService = WeatherService();

  Weather currentWeather = Weather();

  Future<void> queryCity(String text) async {
    currentWeather = await sendQueryByName(text);
    notifyListeners();
  }

  Future<void> queryCoordinates(String lat, String lon) async {
    currentWeather = await sendQueryByCoords(latitude: lat, longitude: lon);
    notifyListeners();
  }

  Future<Weather> sendQueryByName(value) async {
    final sendQuery =
        await weatherService.getWeatherByCityName(cityName: value);
    return sendQuery;
  }

  Future<Weather> sendQueryByCoords(
      {String latitude = "14.0818", String longitude = "-87.2068"}) async {
    final sendQuery = await weatherService.getWeatherByCoordenates(
        latitude: latitude, longitude: longitude);
    return sendQuery;
  }
}
