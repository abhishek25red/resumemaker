import 'package:flutter/material.dart';
import 'package:resumemaker/database.dart';
import 'package:resumemaker/details.dart';
import 'package:resumemaker/edit.dart';
import 'package:resumemaker/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<cv> cvs;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    refreshcvs();
  }

  @override
  void dispose() {
    cvsDatabase.instance.close();

    super.dispose();
  }

  Future refreshcvs() async {
    setState(() => isLoading = true);

    this.cvs = await cvsDatabase.instance.readAllcvs();

    setState(() => isLoading = false);
  }

  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    var widthT = screensize.width;
    var heightT = screensize.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          OutlinedButton(
            child: Text(
              "+",
              style: TextStyle(fontSize: 35),
            ),
            style: OutlinedButton.styleFrom(
                primary: Colors.white,
                onSurface: Colors.blueAccent,
                side: BorderSide(color: Colors.blueAccent, width: 1)),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditcvPage()),
              );

              refreshcvs();
            },
          ),
        ],
        title: Text("Resume Builder"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
          height: heightT,
          width: widthT,
          color: Colors.white70,
          child: isLoading
              ? CircularProgressIndicator()
              : cvs.isEmpty
                  ? Container(
                      child: Center(
                        child: OutlinedButton(
                          child: Text("+"),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.blueAccent,
                              onSurface: Colors.blueAccent,
                              side: BorderSide(
                                  color: Colors.blueAccent, width: 1)),
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddEditcvPage()),
                            );

                            refreshcvs();
                          },
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cvs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cv = cvs[index];
                        return ListTile(
                            leading: Icon(
                              Icons.list,
                              size: 35,
                            ),
                            trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white),
                                onPressed: () async {
                                  refreshcvs();
                                  await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        cvDetailPage(cvId: cv.id!),
                                  ));

                                  refreshcvs();
                                },
                                child: Text(
                                  "open",
                                  style: TextStyle(color: Colors.blueAccent),
                                )),
                            title: Text(
                              cv.title,
                              style: TextStyle(fontSize: 20),
                            ));
                      })),
    );
  }
}
