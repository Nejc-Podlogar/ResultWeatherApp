import 'dart:async';
import 'package:meta/meta.dart';
import 'package:result_app/models/models.dart';
import 'package:result_app/repositories/weather_api.dart';

class WeatherRepository {
  final WeatherClient weatherClient;

  WeatherRepository({@required this.weatherClient}) : assert(weatherClient != null);

  Future<Weather> getCurrWeather(String cityName) async {
    print("Repositorij");
    return weatherClient.getWeather(cityName);
  }
}
