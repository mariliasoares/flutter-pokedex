import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pages/pokemon_detail.dart';
import 'package:pokedex/pokemon.dart';

//stless + ENTER
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Pokedex pokedex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url); //await: do the remaining work after get the response
    var decodedJson = jsonDecode(res.body);
    pokedex = Pokedex.fromJson(decodedJson);

    //when using stateful widgets/to perform some data changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Colors.cyan,
      ),

      body: pokedex == null?
      Center(
        child: CircularProgressIndicator(),)
      : GridView.count(
        crossAxisCount: 2,
        children: pokedex.pokemon.map((poke) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell( //ser clicável
            onTap: () {
              //navigator takes context(basically the location of the widget) and router(way)
              Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(
                pokemon: poke,
              )));
            },
            child: Card(
              elevation: 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //figura e texto
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poke.img))),
                  ),
                  Text(poke.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        )).toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
