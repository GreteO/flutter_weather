import 'package:flutter/material.dart';

class CitySelection extends StatefulWidget {
  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Search city'),
        backgroundColor: Colors.teal[900],
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),

                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    //hintText: 'Chicago',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _textController.text);
              },
            )
          ],
        ),
      ),
    );
  }
}