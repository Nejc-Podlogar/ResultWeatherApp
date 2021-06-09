import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:result_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:result_app/input_bloc_observer.dart';
import 'package:result_app/repositories/repositories.dart';
import 'package:result_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = InputBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherClient: WeatherClient(
      httpClient: http.Client(),
    ),
  );
  runApp(MyApp(weatherRepository: weatherRepository));
}

class MyApp extends StatelessWidget {
  WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result Weather App',
      home: BlocProvider<WeatherBloc>(
            create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),

            child: Weather(),
          )
    );
  }
}
