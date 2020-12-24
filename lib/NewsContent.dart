import 'package:flutter/material.dart';
import 'package:flutter_news/Attributes.dart';

// ignore: must_be_immutable
class NewsContent extends StatelessWidget {
  News _newsData = News();
  int index;
  NewsContent(this._newsData, this.index);

  @override
  Widget build(BuildContext context) {
    if (_newsData.list != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_newsData.list[0].source.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(_newsData.list[index].urlToImage),
              SizedBox(
                height: 10,
              ),
              Text(
                _newsData.list[index].title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "By " +
                    _newsData.list[index].author +
                    " | " +
                    _newsData.list[index].source.name,
                style: TextStyle(fontSize: 15),
              ),
              Divider(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(_newsData.list[index].description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  )),
              Text(_newsData.list[index].content),
              Container(
                child: RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: _newsData.list[index].content,
                        style: TextStyle(color: Colors.black)),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }
}
