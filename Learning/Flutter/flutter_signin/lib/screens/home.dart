import 'package:flutter/material.dart';
import 'package:flutter_signin/doamain/code.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Code Storage'),
          leading: Icon(Icons.qr_code),
          backgroundColor: Theme.of(context).splashColor,
        ),
        body: CodesList(),
      ),
    );
  }
}

class CodesList extends StatelessWidget {
  final codes = <Code>[
    Code(id: 1, title: 'MK', comment: 'Nice milk'),
    Code(id: 2, title: 'VP', comment: 'Not so good milk'),
    Code(id: 3, title: 'Mlekovita', comment: 'Nice poland milk'),
    Code(id: 4, title: 'Zlagoda', comment: 'Delicious Cheese'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: codes.length,
          itemBuilder: (context, int i) {
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    codes[i].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
