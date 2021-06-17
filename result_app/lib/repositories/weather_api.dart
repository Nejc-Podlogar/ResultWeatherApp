import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:result_app/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class WeatherClient {
  static const rootUrl = "https://api.openweathermap.org/data/2.5";
  final http.Client httpClient;
  final appId = "ba9334b43e484e40c0ef6e2826d8a07e";

  WeatherClient({
    @required this.httpClient
  });

  Future<Weather> getWeather(String cityName) async {
    final weatherUrl =
        '$rootUrl/weather?q=$cityName&appId=$appId&lang=sl&units=metric';
    dynamic weatherJson;
    try{
      final _connectivityResult = await (Connectivity().checkConnectivity());
      //final checkConnection = await InternetAddress.lookup("example.com");
      //if(checkConnection.isNotEmpty && checkConnection[0].rawAddress.isNotEmpty){
      if(_connectivityResult != ConnectivityResult.none){
        final response = await this.httpClient.get(weatherUrl);

        /* Dodaj hendlanje errorjev */
        if(response.statusCode != 200){
          weatherJson = await getWeatherLocal(cityName);

        }else{
          weatherJson = jsonDecode(response.body);
          saveWeatherLocal(cityName, weatherJson);
        }
      }

      return Weather.fromJson(weatherJson);
    } catch (_) {
      weatherJson = await getWeatherLocal(cityName);
      if(weatherJson == null){
        return null;
      }else {
        return Weather.fromJson(weatherJson);
      }
    }

  }

  Future<bool> saveWeatherLocal(String name, dynamic weatherData) async{
    final _prefs = await SharedPreferences.getInstance();
    final result = await _prefs.setString(name, jsonEncode(weatherData));

    return result;
  }

  Future<dynamic> getWeatherLocal(String name) async{
    final _prefs = await SharedPreferences.getInstance();
    final data = await _prefs.getString(name) ?? "";
    if(data != ""){
      final jsonData = jsonDecode(data);
      return jsonData;
    }
    return null;

  }

}
