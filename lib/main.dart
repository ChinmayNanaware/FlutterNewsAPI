import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_news/NewsContent.dart';
import 'package:flutter_news/Attributes.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo[900]),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

enum SelectedList { verge, techcrunch, wallstreet, reuters, mashable }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SelectedList _selectedList = SelectedList.verge;
  News _newsData = News();
  var category =
      "https://newsapi.org/v2/top-headlines?sources=the-verge&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
  bool flag = false;

  getData() async {
    _newsData = await fetchNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_newsData.list != null) {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Text(
                  'News Sources',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                selectedTileColor: Colors.grey[350],
                selected: _selectedList == SelectedList.verge,
                title: Text(
                  'The Verge',
                ),
                onTap: () {
                  _selectedList = SelectedList.verge;
                  flag = true;
                  category =
                      "https://newsapi.org/v2/top-headlines?sources=the-verge&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
                  getData();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selectedTileColor: Colors.grey[350],
                selected: _selectedList == SelectedList.techcrunch,
                title: Text('TechCrunch'),
                onTap: () {
                  _selectedList = SelectedList.techcrunch;
                  category =
                      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
                  getData();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selectedTileColor: Colors.grey[350],
                selected: _selectedList == SelectedList.wallstreet,
                title: Text('The Wall Street Journal'),
                onTap: () {
                  _selectedList = SelectedList.wallstreet;
                  category =
                      "https://newsapi.org/v2/top-headlines?sources=the-wall-street-journal&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
                  getData();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selectedTileColor: Colors.grey[350],
                selected: _selectedList == SelectedList.reuters,
                title: Text('Reuters'),
                onTap: () {
                  _selectedList = SelectedList.reuters;
                  category =
                      "https://newsapi.org/v2/top-headlines?sources=reuters&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
                  getData();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selectedTileColor: Colors.grey[350],
                selected: _selectedList == SelectedList.mashable,
                title: Text('Mashable'),
                onTap: () {
                  _selectedList = SelectedList.mashable;
                  category =
                      "https://newsapi.org/v2/top-headlines?sources=mashable&apiKey=be8c5d2db3fe41e8935d30f6a4a667a0";
                  getData();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(_newsData.list[0].source.name),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsContent(_newsData, index)),
                );
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shadowColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(_newsData.list[index].urlToImage),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _newsData.list[index].title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "By " +
                            _newsData.list[index].author +
                            " | " +
                            _newsData.list[index].source.name,
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(_newsData.list[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          )),
                    ],
                  ),
                ),
                // ignore: missing_return, missing_return
              ),
            );
          },
          itemCount: _newsData.list.length,
        ),
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    getData();
  }

  Future<News> fetchNews() async {
    var url = category;

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);

      _newsData = News.fromJson(dataJson);
      return _newsData;
    } else {
      print("Error");
    }
  }
}
