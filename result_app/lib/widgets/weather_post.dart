import 'package:flutter/material.dart';
import 'package:result_app/models/models.dart';
import 'package:result_app/widgets/combined_temp.dart';
import 'package:result_app/widgets/image.dart';

class WeatherPost extends StatelessWidget {
  WeatherPost(this.weatherData);

  final Weather weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 350,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: WeatherImage(condition: weatherData.weatherMain),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      weatherData.weatherDescription,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(weatherData.city),
                    Text(", "),
                    Text(weatherData.country)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Center(
                    child: Text(
                      "Temperatura: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: CombinedTemp(weatherData.currentTemp,
                        weatherData.maxTemp, weatherData.minTemp)),
              ])),
        ));
  }
}
