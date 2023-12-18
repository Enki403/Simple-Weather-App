import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:simple_weather_app/models/city_model.dart";
import "package:simple_weather_app/models/weather_model.dart";
import "package:simple_weather_app/presentation/providers/cities_provider.dart";
import "package:simple_weather_app/presentation/providers/weather_provider.dart";
import "package:simple_weather_app/presentation/screens/cities/city_selection.dart";

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, City? selectedCity});
  City selectedCity = City();
  String selectedCityByName = "";

  @override
  Widget build(BuildContext context) {
    final citiesProvider = context.watch<CitiesProvider>();
    final weatherProvider = context.watch<WeatherProvider>();

    final size = MediaQuery.of(context).size;

    final widthSize = size.width * 0.2;
    const double heightSize = 95.0;

    selectedCityByName = citiesProvider.cityName;
    selectedCity = citiesProvider.selectedCity;
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Weather App"))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: ClipRRect(
                        child: Image.network(
                      'https://openweathermap.org/img/wn/${weatherProvider.currentWeather.weatherIcon}@2x.png',
                      width: widthSize,
                      height: heightSize,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                            width: widthSize,
                            height: heightSize,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const CircularProgressIndicator());
                      },
                    )),
                  ),
                  Text(
                    "${weatherProvider.currentWeather.weatherMain}",
                    style: const TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${weatherProvider.currentWeather.weatherDescription}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${weatherProvider.currentWeather.temperature} °F",
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Feels-like: ${weatherProvider.currentWeather.feelsLike} °F",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Feels-like: ${weatherProvider.currentWeather.feelsLike} °F",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hummidity: ${weatherProvider.currentWeather.humidity} °F",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CitySelection(),
              ),
            );
          },
          tooltip: 'Search',
          child: const Icon(Icons.search),
        ));
  }
}
