import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resumemaker/database.dart';
import 'package:resumemaker/edit.dart';
import 'package:resumemaker/model.dart';

class cvDetailPage extends StatefulWidget {
  final int cvId;

  const cvDetailPage({
    Key? key,
    required this.cvId,
  }) : super(key: key);

  @override
  _cvDetailPageState createState() => _cvDetailPageState();
}

class _cvDetailPageState extends State<cvDetailPage> {
  late cv cvs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshcv();
  }

  Future refreshcv() async {
    setState(() => isLoading = true);

    this.cvs = await cvsDatabase.instance.readNote(widget.cvId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('resumes'),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      cvs.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(cvs.createdTime),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      cvs.address,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditcvPage(cvs: cvs),
        ));

        refreshcv();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await cvsDatabase.instance.delete(widget.cvId);

          Navigator.of(context).pop();
        },
      );
}
