import 'package:flutter/material.dart';
import './pages/landing_page.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon.dart';

void main() =>
 runApp(MaterialApp(
   title: "Pokedex",
   home: LandingPage(),
   debugShowCheckedModeBanner: false,
));



