import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart" as root_bundle;
import "package:provider/provider.dart";
import "package:simple_weather_app/models/city_model.dart";
import "package:simple_weather_app/presentation/providers/cities_provider.dart";
import "package:simple_weather_app/presentation/providers/weather_provider.dart";
import "package:simple_weather_app/presentation/screens/home/home_screen.dart";

const cards = <Map<String, dynamic>>[
  {'elevation': 0.0, 'label': 'Elevation 0'},
  {'elevation': 1.0, 'label': 'Elevation 1'},
  {'elevation': 2.0, 'label': 'Elevation 2'},
  {'elevation': 3.0, 'label': 'Elevation 3'},
  {'elevation': 4.0, 'label': 'Elevation 4'},
  {'elevation': 5.0, 'label': 'Elevation 5'},
];

class CitySelection extends StatelessWidget {
  CitySelection({super.key});

  static final List<City> _cities = List.empty();
  static City selectedCity = City();

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final citiesProvider = context.watch<CitiesProvider>();
    final weatherProvider = context.watch<WeatherProvider>();

    citiesProvider.citiesList = _cities;

    String textBoxValue = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a city:"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Scaffold(
          body: FutureBuilder(
            future: readCityJson(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                // list of cities inside json
                //_cities = data.data as List<City>;
                citiesProvider.citiesList = data.data as List<City>;
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                        onTapOutside: (event) => focusNode.unfocus(),
                        onChanged: (value) {
                          textBoxValue = value;
                        },
                        onSubmitted: (value) {
                          citiesProvider.cityName = value;
                          weatherProvider.queryCity(value);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        decoration: InputDecoration(
                            labelText: 'Search by name',
                            suffixIcon: IconButton(
                              onPressed: () {
                                citiesProvider.cityName = textBoxValue;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.search),
                            ))),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: _CitiesList(cities: citiesProvider.citiesList),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Iterable<City>> readCityJson() async {
    final cities =
        await root_bundle.rootBundle.loadString('assets/smallCities.json');
    final list = json.decode(cities) as List<dynamic>;

    return list.map((city) => City.fromJson(city)).toList();
  }
}

class _CitiesList extends StatelessWidget {
  const _CitiesList({
    required this.cities,
  });

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cities.isEmpty ? 0 : cities.length,
        itemBuilder: (context, index) {
          // Card with city data
          return _CityCard(
              city: cities[index],
              label: cards[3]['label'],
              elevation: cards[3]['elevation']);
        });
  }
}

class _CityCard extends StatelessWidget {
  const _CityCard({
    required this.city,
    required this.label,
    required this.elevation,
  });

  final City city;
  final String label;
  final double elevation;

  void redirect(context, selectedCity) {}

  @override
  Widget build(BuildContext context) {
    final citiesProvider = context.watch<CitiesProvider>();
    final weatherProvider = context.watch<WeatherProvider>();
    return Card(
      elevation: elevation,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: InkWell(
            onTap: () {
              citiesProvider.selectedCity = city;
              weatherProvider.queryCoordinates("${city.lat}", "${city.lng}");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: SizedBox(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 5,
                        child: Text(
                            "${city.name}${(city.country == "US" ? ", ${city.admin1}" : "")}, ${city.country}")),
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.chevron_right_outlined),
                    )
                  ]),
            ),
          )),
    );
  }
}
