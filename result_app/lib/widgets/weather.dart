import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_app/widgets/weather_post.dart';

import 'package:result_app/widgets/widgets.dart';
export 'package:result_app/blocs/weather_bloc/weather_bloc.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result weather app."),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final List<String> cityName = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitySelect()),
                );
                if (cityName != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherGet(cityName: cityName));
                }
              },
            ),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Center(
              child: Text("Dodajte opazovalno mesto."),
            );
          } else if (state is WeatherLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
            final weatherResult = state.weatherData;
            if(weatherResult.isNotEmpty){
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: weatherResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return WeatherPost(weatherResult[index]);
                  });
            }else{
              return
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Center(
                  child: Text("Podatki o vnešenem mestu niso na voljo. Preverite internetno povezavo.", textAlign: TextAlign.center,),
                ));
            }

          } else if (state is WeatherError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Icon(
                    Icons.error,
                    size: 30.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                        "Prišlo je do napake pri nalaganju vremena. Poskusite ponovno"),
                  )
                ],
              ),
            ));
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
