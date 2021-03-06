import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_app/widgets/weather_post.dart';

import 'package:result_app/widgets/widgets.dart';
export 'package:result_app/blocs/weather_bloc/weather_bloc.dart';

class Weather extends StatelessWidget {

  List<Widget> _generateChildren(int count, double sizeOfWindow, dynamic weatherResult){
    List<Widget> listOfElements = [];

    for( int i = 0; i < count; i++){
      listOfElements.add(WeatherPost(weatherResult[i], sizeOfWindow));
    }

    return listOfElements;
  }


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
              return LayoutBuilder(builder: (context, constraints){

                if(constraints.maxWidth > 700){
                  return  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(child:
                      Wrap( spacing: 8.0, runSpacing: 2.0, children: _generateChildren(weatherResult.length, constraints.maxWidth, weatherResult)))

                  );
                }else{
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: weatherResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WeatherPost(weatherResult[index], constraints.maxWidth);
                      });
                }
              },);

            }else{
              return
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Center(
                  child: Text("Podatki o vne??enem mestu niso na voljo. Preverite internetno povezavo.", textAlign: TextAlign.center,),
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
                        "Pri??lo je do napake pri nalaganju vremena. Poskusite ponovno"),
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
