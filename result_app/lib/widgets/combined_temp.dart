import 'package:flutter/material.dart';

class CombinedTemp extends StatelessWidget {
  CombinedTemp(this.temp, this.maxTemp, this.minTemp);

  final double temp;
  final double maxTemp;
  final double minTemp;

  @override
  Widget build(BuildContext context) {
    print(this.temp);
    print(this.maxTemp);
    print(this.minTemp);
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8.0,
      alignment: WrapAlignment.center,
      children: [
        Chip(
          label: RichText(
              text: TextSpan(
                  text: "Trenutna: ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: this.temp.toString(),
                    children: <TextSpan>[TextSpan(text: "°C")])
              ])),
        ),
        Chip(
          label: RichText(
              text: TextSpan(
                  text: "Maximalna: ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: this.maxTemp.toString(),
                    children: <TextSpan>[TextSpan(text: "°C")])
              ])),
        ),
        Chip(
          label: RichText(
              text: TextSpan(
                  text: "Minimalna: ",
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                TextSpan(
                    text: this.minTemp.toString(),
                    children: <TextSpan>[TextSpan(text: "°C")])
              ])),
        )
      ],
    );
  }
}
