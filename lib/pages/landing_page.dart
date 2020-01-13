import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pages/pokemon_detail.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/about.dart';

//stless + ENTER
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Icon searchIcon = Icon(Icons.search, color: Colors.white, size: 30.0,);
  Widget searchBar = Text("Pokedex");
  var hideSearch = true;

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Pokedex pokedex;

  List<Pokemon> _search = [];

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

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if(text.isEmpty) {
      setState(() {});
      return;
    }

    pokedex.pokemon.forEach((p) {
//      text = text.toLowerCase();
      if(p.name.contains(text) || p.num.contains(text)) {
        this._search.add(p);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //scaffold: to create pages
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: searchBar,
      ),

      body: Container(
        child: Column(
         children: <Widget>[
           Container(
             color: Colors.cyan,
             child: Card(
               child: ListTile(
                 leading: Icon(Icons.search),
                 title: TextField(
                   controller: controller,
                   onChanged: onSearch,
                   decoration: InputDecoration(
                     hintText: "Search",
                     border: InputBorder.none,
                   )
                 ),
                 trailing: IconButton(
                   onPressed: (){
                     controller.clear();
                     onSearch('');
                     FocusScope.of(context).requestFocus(FocusNode());
                   },
                   icon: Icon(Icons.cancel),
                 ),
               ),
             ),
           ),
           pokedex == null?
             Center(
               child: CircularProgressIndicator(),
             )
             : Expanded(
               child: _search.length != 0 || controller.text.isNotEmpty
               ? ListView.builder(
                 itemCount: _search.length,
                 itemBuilder: (context, i){
                   final pok = _search[i];
                   return ListTile(
                     leading: CircleAvatar(
                       backgroundColor: Colors.white,
                       backgroundImage: NetworkImage(pok.img),
                       radius: 35.0,
                     ),
                     title: Text(pok.name),
                     subtitle: Text(pok.num),
                     onTap: () {
                        //navigator takes context(basically the location of the widget) and router(way)
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(
                          pokemon: pok,
                        )));
                     },
                   );
                 },
               )
               : ListView.builder(
                 itemCount: pokedex.pokemon.length,
                 itemBuilder: (context, i) {
                   final pok2 = pokedex.pokemon[i];

                   return ListTile(
                     trailing: Icon(Icons.keyboard_arrow_right),
                     contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0,),
                     leading: CircleAvatar(
                       backgroundColor: Colors.white,
                       backgroundImage: NetworkImage(pok2.img),
                       radius: 35.0,
                     ),
                     title: Text(pok2.name, style: TextStyle(fontSize: 18.0),),
                     subtitle: Text(pok2.num),
                     onTap: () {
                       //navigator takes context(basically the location of the widget) and router(way)
                       Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(
                         pokemon: pok2,
                       )));
                     },
                   );
                 }
               ),
             ),
         ],
        ),

      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.cyan,
                  Colors.cyan,
                ])
            ),
            accountName: Text("Marilia Soares", style: TextStyle(fontSize:18.0, fontWeight: FontWeight.bold, color: Colors.black45)),
            accountEmail: Text("marisoares1202@gmail.com", style: TextStyle(fontSize:14.0, fontWeight: FontWeight.bold, color: Colors.black45)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.greenAccent,
//              backgroundImage: NetworkImage(pok2.img),
              radius: 35.0,
              child: new Text("M", style: TextStyle(fontSize:18.0, fontWeight: FontWeight.bold, color: Colors.black45)),
            ),
          ),
            ListTile(
              title: Text("Favorites"),
              onTap: (){},
            ),
            new Divider(),
            ListTile(
              title: Text("Sobre mim"),
              onTap: (){
                  //navigator takes context(basically the location of the widget) and router(way)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

