import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:provider/provider.dart";
import "package:simple_weather_app/config/theme/app_theme.dart";
import "package:simple_weather_app/presentation/providers/cities_provider.dart";
import "package:simple_weather_app/presentation/providers/weather_provider.dart";
import "package:simple_weather_app/presentation/screens/home/home_screen.dart";

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_) => CitiesProvider())
      ],
      child: MaterialApp(
        title: "Simple Weather App",
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 0).theme(),
        home: HomeScreen(),
      ),
    );
  }
}
