import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box textBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  textBox = await Hive.openBox("textBox");
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txtController = TextEditingController();
  bool isEditClicked = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Uyga Vazifa"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Text kiriting")),
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                if (isEditClicked) {
                  textBox.putAt(selectedIndex, txtController.text);
                  isEditClicked = false;
                } else {
                  textBox.add(txtController.text);
                }
                txtController.clear();
              });
            },
            color: Colors.blue,
            child: Text(isEditClicked == true ? "Tahrirlash" : "Saqlash"),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: textBox.listenable(),
                  builder: (context, value, child) {
                    return ListView.builder(
                        itemCount: textBox.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(4),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    textBox.getAt(index),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          textBox.deleteAt(index);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditClicked = true;
                                            selectedIndex = index;
                                            txtController =
                                                TextEditingController(
                                                    text: textBox.getAt(index));
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }))
        ],
      ),
    );
  }
}
