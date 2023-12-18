import "package:flutter/material.dart";
import "package:simple_weather_app/models/city_model.dart";
import "package:simple_weather_app/presentation/screens/cities/city_selection.dart";

class HomeScreen extends StatelessWidget {
  final City selectedCity = City();

  HomeScreen({super.key, City? selectedCity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Weather App"))),
        body: _HomeView(selectedCity),
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

class _HomeView extends StatelessWidget {
  final City selectedCity = City();

  _HomeView(City? selectedCity);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          Text("${selectedCity}"),
        ]),
      ),
    );
  }
}
