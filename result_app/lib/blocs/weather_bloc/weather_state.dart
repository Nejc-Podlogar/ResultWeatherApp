part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final List<Weather> weatherData;

  const WeatherSuccess({@required this.weatherData})
      : assert(weatherData != null);

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {}
