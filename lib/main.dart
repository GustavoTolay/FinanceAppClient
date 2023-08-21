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
                    const Divider(color: Colors.grey,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.maxFinite,
                        child: const Text(
                          "Accesos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {},
                                      child: const SizedBox(
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.edit_document,
                                                  color: Colors.lightBlue,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "TODAS las transacciones",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: Colors.grey,
                                      child: const SizedBox(
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.monetization_on,
                                                  color: Color.fromARGB(
                                                      255, 255, 193, 22),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "Reservas",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: Colors.grey,
                                      child: const SizedBox(
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.upload_file_rounded,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "Ver Ingresos",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.blue),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: Colors.grey,
                                      child: const SizedBox(
                                          child: Center(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.sim_card_download_rounded,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                "Ver Consumos",
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // color: Colors.red,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        // color: Colors.blue,
                      ),
                    ),
                  ],
                ),
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
