import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_app/schemas.dart";

var url = Uri.parse("http://localhost:8000/transactions");

Future<List<Transaction>> fetchData() async {
  final response = await http.get(url);
  final List<dynamic> decodedList = jsonDecode(response.body);
  final List<Transaction> transactionList = [];
  decodedList.forEach((transaction) {
    transactionList.add(
      Transaction.fromJson(transaction),
    );
  });
  return transactionList;
}

class TransactionRoute extends StatefulWidget {
  TransactionRoute({
    super.key,
  });

  @override
  State<TransactionRoute> createState() => _TransactionRouteState();
}

class _TransactionRouteState extends State<TransactionRoute> {
  late Future<List<Transaction>> TransactionData;

  @override
  void initState() {
    super.initState();
    TransactionData = fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Transacciones"),
      ),
      body: FutureBuilder(
        future: TransactionData,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("error in the fetch");
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 5,
              children: List.generate(snapshot.data!.length + 1, (index) {
                if (index == 0) {
                  return Center(
                    child: ElevatedButton.icon(
                      onPressed: () => {},
                      icon: const Icon(Icons.dashboard_customize_rounded),
                      label: const Text("Agregar Transacción"),
                    ),
                  );
                }
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(4.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              snapshot.data![index - 1].created.toString(),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.normal,
                              ),
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.end,
                            ),
                            const Spacer(),
                            Text(
                              "\$${snapshot.data![index - 1].quantity.toString()}",
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              textScaleFactor: 1.2,
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          "Concepto:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(snapshot.data![index - 1].concept.toString()),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              "Categoria:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(snapshot.data![index - 1].category.name
                                .toString())
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Estado:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: snapshot.data![index - 1].resolved
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text(
                              snapshot.data![index - 1].resolved
                                  ? " Completado"
                                  : " Pendiente",
                              style: TextStyle(
                                color: snapshot.data![index - 1].resolved
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => {},
                              child: Icon(Icons.edit_square),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () => {},
                              child: Icon(Icons.delete_forever),
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }
          return const Text("loading...");
        },
      ),
    );
  }
}
