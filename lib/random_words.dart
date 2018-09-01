import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _favourites = new Set<WordPair>();
  final TextStyle _bigFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Random Word Generator'),
          actions: <Widget>[
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved,)
          ],
        ),
        body: _buildSuggestions());
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _favourites.map((WordPair pair) {
            return new ListTile(
              title: new Text(
                '${pair.first} ${pair.second}',
                style: _bigFont,
              )
            );
          });

          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          )
          .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Words')
            ),
            body: new ListView(children: divided),
          );
        }
      )
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          final int index = i ~/ 2;

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool isFavourite = _favourites.contains(pair);

    return new ListTile(
      title: new Text('${pair.first} ${pair.second}', style: _bigFont),
      trailing: new Icon(isFavourite ? Icons.favorite : Icons.favorite_border,
          color: isFavourite ? Colors.red : null),
      onTap: () {
        setState(() {
          if (isFavourite) {
            _favourites.remove(pair);
          } else {
            _favourites.add(pair);
          }
        });
      },
    );
  }
}
