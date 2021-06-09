import 'package:flutter/material.dart';

class CitySelect extends StatefulWidget {
  @override
  State<CitySelect> createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> allCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mesta:"),
        ),
        body: Column(
          children: [
            Form(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(labelText: 'Mesto'),
                      autofocus: true,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    splashRadius: 10,
                    iconSize: 30,
                    onPressed: () {
                      if (_textEditingController.text != "") {
                        setState(() {
                          allCities.add(_textEditingController.text);
                          _textEditingController.text = "";
                        });
                      }
                    })
              ],
            )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: allCities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(allCities[index]);
                      })),],)
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.restore),
                      onPressed: () {
                        setState(() {
                          allCities.clear();
                        });
                      }),
                  OutlinedButton(
                      onPressed: () {

                        if(allCities.isNotEmpty){
                          Navigator.pop(context, allCities);
                        }else{
                          ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: const Text("Vnesite vsaj eno mesto.")));
                        }

                      },
                      child: Text("Pridobi vreme"))
                ],
              ),
            )
          ],
        ));
  }
}
