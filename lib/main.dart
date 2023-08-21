import "package:flutter/material.dart";
import "acesses.dart";

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
                        padding: const EdgeInsets.all(5),
                        // color: Colors.yellow,
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                // color: Colors.amber,
                                child: const Text(
                                  "Balance Total:",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Crear Nuevo:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Ingreso",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Consumo",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: AccessesWidget(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    // color: Colors.lightGreen,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
