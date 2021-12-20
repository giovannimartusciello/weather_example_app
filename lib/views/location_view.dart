import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final String city;

  const LocationView({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(city.toUpperCase(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ))
      ]),
    );
  }
}
