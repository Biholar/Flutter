// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin/doamain/code.dart';
import 'package:flutter_signin/utilities/auth.dart';
import 'package:flutter_signin/utilities/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final String userEmail;
  HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Code> codes = [];

  Widget buildList() {
    codes.sort((prev, next) => prev.id.compareTo(next.id));
    return ListView.builder(
      shrinkWrap: true,
      itemCount: codes.length,
      itemBuilder: (context, int i) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            codes.removeAt(i);
          },
          direction: DismissDirection.endToStart,
          child: GestureDetector(
            onTap: () {
              displayTextInputDialog(context, isUpdate: true, code: codes[i]);
            },
            child: Card(
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
            ),
          ),
        );
      },
    );
  }

  Widget addButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 170, vertical: 10),
      child: TextButton(
        onPressed: () {
          displayTextInputDialog(context, isUpdate: false);
        },
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Icon(
              FontAwesomeIcons.plus,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text('Code Storage'),
        leading: Icon(Icons.qr_code),
        actions: [
          TextButton(
            onPressed: () async {
              await Auth.logOut(context);
            },
            child: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Theme.of(context).splashColor,
      ),
      body: FutureBuilder(
        future: FirestoreSync.getCodes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            codes = snapshot.data as List<Code>;
            if (codes.isNotEmpty) {
              return buildList();
            } else {
              return Center(
                child: addButton(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> displayTextInputDialog(BuildContext context,
      {bool? isUpdate, Code? code}) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    if (isUpdate!) {
      nameController.text = code!.title;
      codeController.text = code.code;
      commentController.text = code.comment!;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Code'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Enter name here"),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  TextField(
                    controller: codeController,
                    decoration: InputDecoration(hintText: "Enter code here"),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  TextField(
                    maxLines: null,
                    controller: commentController,
                    decoration: InputDecoration(hintText: "Enter comment here"),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () async {
                  var tmpCode = Code(
                    id: isUpdate ? code!.id : codes.length + 1,
                    title: nameController.text,
                    comment: commentController.text,
                    code: codeController.text,
                    firebaseId: isUpdate ? code!.firebaseId : null,
                  );

                  if (isUpdate) {
                    await FirestoreSync.updateCode(context, tmpCode);
                    codes.removeWhere((element) => element.id == code!.id);
                    codes.add(tmpCode);
                  } else {
                    var res = await FirestoreSync.addCode(tmpCode);
                    codes.add(res);
                  }

                  setState(() {});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
