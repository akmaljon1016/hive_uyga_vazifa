import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dilog tutorial"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Ogohlantirish"),
                        content: Text("Dasturdan chiqishni rostan ham xohlaysizmi?"),
                        actions: [
                          TextButton(onPressed: (){Navigator.pop(context);},child: Text("Close")),
                          TextButton(onPressed: (){},child: Text("Ok")),
                        ],
                      );
                    });
              },
              child: Text("Dialog"),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
