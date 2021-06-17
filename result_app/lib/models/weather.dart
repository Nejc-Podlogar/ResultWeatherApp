import 'package:equatable/equatable.dart';

enum WeatherType {
  Clouds,
  Clear,
  Thunderstorm,
  Drizzle,
  Rain,
  Snow,
  Atmosphere
}

class Weather extends Equatable {
  final WeatherType weatherMain;
  final String weatherDescription;
  final double currentTemp;
  final double maxTemp;
  final double minTemp;
  final String city;
  final String country;

  const Weather(
      {this.currentTemp,
      this.maxTemp,
      this.minTemp,
      this.weatherMain,
      this.weatherDescription,
      this.city,
      this.country});

  @override
  List<Object> get props => [
        weatherMain,
        weatherDescription,
        currentTemp,
        maxTemp,
        minTemp,
        city,
        country
      ];

  static Weather fromJson(dynamic jsonData) {
    final basicInfo = jsonData['weather'][0];
    final mainInfo = jsonData['main'];
    final sysInfo = jsonData['sys'];
    return Weather(
        weatherMain: _mapStringToWeatherType(basicInfo['main'] as String),
        weatherDescription: basicInfo['description'],
        currentTemp: mainInfo['temp'] as double,
        minTemp: mainInfo['temp_min'] as double,
        maxTemp: mainInfo['temp_max'] as double,
        country: sysInfo['country'],
        city: jsonData['name']);
  }

  static WeatherType _mapStringToWeatherType(String type) {
    WeatherType state;
    switch (type) {
      case "Clouds":
        state = WeatherType.Clouds;
        break;
      case "Clear":
        state = WeatherType.Clear;
        break;
      case "Thunderstorm":
        state = WeatherType.Thunderstorm;
        break;
      case "Drizzle":
        state = WeatherType.Drizzle;
        break;
      case "Rain":
        state = WeatherType.Rain;
        break;
      case "Snow":
        state = WeatherType.Snow;
        break;
      case "Mist":
      case "Smoke":
      case "Haze":
      case "Dust":
      case "Fog":
      case "Sand":
      case "Ash":
      case "Squall":
      case "Tornado":
        state = WeatherType.Atmosphere;
        break;
    }

    return state;
  }
}
