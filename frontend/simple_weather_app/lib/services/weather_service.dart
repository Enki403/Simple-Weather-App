import 'package:dio/dio.dart';
import 'package:simple_weather_app/config/constraints/enviroments.dart';
import 'package:simple_weather_app/models/weather_model.dart';

class WeatherService {
  final String apiEndpointUrl = Enviroment.apiUrl;

  final _dio = Dio();

  Future<Weather> getWeatherByCoordenates(
      {required String latitude, required String longitude}) async {
    try {
      final response = await _dio
          .get("${apiEndpointUrl}getWeatherByCoordinates", queryParameters: {
        "units": "imperial",
        "lat": latitude,
        "lng": longitude
      });

      if (response.statusCode == 200) {
        Weather queriedWeather = Weather(
          weatherMain: response.data["weather_main"],
          weatherDescription: response.data["weather_description"],
          weatherIcon: response.data["weather_icon"],
          temperature: response.data["temperature"]?.toDouble(),
          feelsLike: response.data["feels_like"]?.toDouble(),
          humidity: response.data["humidity"],
        );

        return queriedWeather;
      } else {
        return Weather();
      }
    } on DioError catch (e) {
      return Weather();
    } catch (e) {
      return Weather();
    }
  }

  Future<Weather> getWeatherByCityName({required String cityName}) async {
    try {
      final response = await _dio.get("${apiEndpointUrl}getWeatherByCityName",
          queryParameters: {"units": "imperial", "cityName": cityName});
      if (response.statusCode == 200) {
        Weather queriedWeather = Weather(
          weatherMain: response.data["weather_main"],
          weatherDescription: response.data["weather_description"],
          weatherIcon: response.data["weather_icon"],
          temperature: response.data["temperature"]?.toDouble(),
          feelsLike: response.data["feels_like"]?.toDouble(),
          humidity: response.data["humidity"],
        );

        return queriedWeather;
      } else {
        return Weather();
      }
    } on DioError catch (e) {
      return Weather();
    } catch (e) {
      return Weather();
    }
  }
}
