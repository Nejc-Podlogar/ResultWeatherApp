import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:result_app/models/models.dart';
import 'package:result_app/repositories/repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherGet) {
      yield WeatherLoading();
      try {
        List<Weather> weatherList = [];
        Weather weather;
        for (var i = 0; i < event.cityName.length; i++) {
          weather = await weatherRepository.getCurrWeather(event.cityName[i]);
          if(weather != null){
            weatherList.add(weather);
          }

        }
        yield WeatherSuccess(weatherData: weatherList);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
