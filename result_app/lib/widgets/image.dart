import 'package:flutter/material.dart';

import 'package:result_app/models/models.dart';

class WeatherImage extends StatelessWidget {
  final WeatherType condition;

  WeatherImage({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherType condition) {
    Image image;
    switch (condition) {
      case WeatherType.Clouds:
        image = Image.asset(
          "assets/weatherTypes/clouds.png",
          width: 80,
          height: 80,
        );
        break;
      case WeatherType.Clear:
        image = Image.asset(
          'assets/weatherTypes/clear.png',
          width: 80,
          height: 80,
        );

        break;
      case WeatherType.Thunderstorm:
        image = Image.asset(
          'assets/weatherTypes/thunderstorm.png',
          width: 80,
          height: 80,
        );
        break;
      case WeatherType.Drizzle:
        image = Image.asset(
          'assets/weatherTypes/drizzle.png',
          width: 80,
          height: 80,
        );
        break;
      case WeatherType.Rain:
        image = Image.asset(
          'assets/weatherTypes/rain.png',
          width: 80,
          height: 80,
        );
        break;
      case WeatherType.Snow:
        image = Image.asset(
          'assets/weatherTypes/snow.png',
          width: 80,
          height: 80,
        );
        break;
      case WeatherType.Atmosphere:
        image = Image.asset(
          'assets/weatherTypes/atmosphere.png',
          width: 80,
          height: 80,
        );
        break;
    }
    return image;
  }
}
