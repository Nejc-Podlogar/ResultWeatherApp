part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherGet extends WeatherEvent {
  final List<String> cityName;

  const WeatherGet({@required this.cityName}) : assert(cityName != null);

  @override
  List<Object> get props => [cityName];
}
