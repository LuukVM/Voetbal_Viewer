import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  //rij 2

  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  //rij 3

  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),

   const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  //rij 4
  const StaggeredTile.extent(1, 1),
];

List<StaggeredTile> _staggeredTiles2 = const <StaggeredTile>[
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 1),
  //rij 2
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 1),

  //rij 3
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  //rij 4
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(1, 1),
];

List<Widget> _tiles = <Widget>[

  _Example01Tile(Colors.blue, "bob a"),
  _Example01Tile(Colors.green, "bob"),
  _Example01Tile(Colors.lightBlue, "bob"),
  _Example01Tile(Colors.amber, "bob"),
  _Example01Tile(Colors.brown, "bob"),
  _Example01Tile(Colors.deepOrange, "bob"),
  _Example01Tile(Colors.indigo, "bob"),
  _Example01Tile(Colors.red, "bob"),
  _Example01Tile(Colors.pink, "bob"),
  _Example01Tile(Colors.purple, "bob"),
  _Example01Tile(Colors.blue, "hgenk"),
];

class ExampleVeld extends StatefulWidget {
  @override
  _ExampleVeldState createState() => _ExampleVeldState();
}

class _ExampleVeldState extends State<ExampleVeld> {
  bool veldtype = false;

  toggle() {
    setState(() {
      veldtype = !veldtype;
      print(veldtype);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('example 01'),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: new StaggeredGridView.extent(
         maxCrossAxisExtent: 100,
          staggeredTiles: veldtype ? _staggeredTiles : _staggeredTiles2,
          children: _tiles,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 10.0,
          padding: const EdgeInsets.all(4.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text("Veld"),
          tooltip: "Veld",
          onPressed: () {
            toggle();
          }),
    );
  }
}

class _Example01Tile extends StatefulWidget {
  final Color backgroundColor;
  final String cardText;

  _Example01Tile(this.backgroundColor, this.cardText);

  @override
  _Example01TileState createState() => _Example01TileState();
}

class _Example01TileState extends State<_Example01Tile> {
  @override
  Widget build(BuildContext context) {
    return new Card(
      color: widget.backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Text(widget.cardText,
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
