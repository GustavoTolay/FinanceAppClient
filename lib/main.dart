import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String balance = "0";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text("Finanzas Personales"),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(5),
                        color: Colors.yellow,
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                // color: Colors.amber,
                                child: const Text(
                                  "Balance Total:",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                // color: Colors.grey,
                                child: const Text(
                                  "\$15.000,00",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Ingreso"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Consumo"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.lime,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.lightGreen,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
