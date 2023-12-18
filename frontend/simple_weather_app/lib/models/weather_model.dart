// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJsonMap());

class Weather {
  String? weatherMain;
  String? weatherDescription;
  String? weatherIcon;
  double? temperature;
  double? feelsLike;
  int? humidity;

  Weather({
    this.weatherMain,
    this.weatherDescription,
    this.weatherIcon,
    this.temperature,
    this.feelsLike,
    this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        weatherMain: json["weather_main"],
        weatherDescription: json["weather_description"],
        weatherIcon: json["weather_icon"],
        temperature: json["temperature"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJsonMap() => {
        "weather_main": weatherMain,
        "weather_description": weatherDescription,
        "weather_icon": weatherIcon,
        "temperature": temperature,
        "feels_like": feelsLike,
        "humidity": humidity,
      };
}
