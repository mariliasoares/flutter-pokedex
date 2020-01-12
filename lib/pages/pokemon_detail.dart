import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';

class PokemonDetail extends StatelessWidget {

  final Pokemon pokemon;

  PokemonDetail({
    this.pokemon
  });

  bodyWidget(BuildContext context) => Stack( //do some stacking on the top of it
    children: <Widget>[
      Positioned.fill(
//        height: MediaQuery.of(context).size.height/1.5, //a posição do background
//        width: MediaQuery.of(context).size.width,
        top: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 90.0,),
              Text(pokemon.name, style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold),),
              Text("Height: ${pokemon.height}"),
              Text("Weight: ${pokemon.weight}"),
              Text("Types", style: TextStyle(fontSize:20.0, fontWeight: FontWeight.bold)),
              Row( //list
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //space among types
                children: pokemon.type.map((text) => FilterChip(
                  backgroundColor: Colors.amber,
                  label: Text(text),
                  onSelected: (b){}))
                .toList(),
              ),
              Text("Weakness"),
              Row( //list
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map((text) => FilterChip(
                  backgroundColor: Colors.red,
                  label: Text(text, style: TextStyle(color: Colors.white),),
                  onSelected: (b){}))
                .toList(),
              ),
              Text("Next Evolution"),
              pokemon.nextEvolution == null?
                Text("No next evolution")
              : Row( //list
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //space among types
                  children: pokemon.nextEvolution.map((n) => FilterChip(
                    backgroundColor: Colors.green,
                    label: Text(n.name, style: TextStyle(color: Colors.white),),
                    onSelected: (b){}))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      //on the top of positioned
      Align(
        alignment: Alignment.topCenter,
        child: Hero(tag: pokemon.img, child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(pokemon.img))
          ),
        )), //hero to perform animation
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
//        title:
//          Text(pokemon.name, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(icon: Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
              size: 30.0,
          ), onPressed: () {
            //
          }),
        ],
      ),

      body: bodyWidget(context),

    );
  }
}
