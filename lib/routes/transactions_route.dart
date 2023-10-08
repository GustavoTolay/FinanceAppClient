import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Transaction {
  final int id;
  final String concept;
  final int category_id;
  final int quantity;
  final bool resolved;
  final String created;

  const Transaction({
    required this.id,
    required this.concept,
    required this.category_id,
    required this.quantity,
    required this.resolved,
    required this.created,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      concept: json["concept"],
      category_id: json["category_id"],
      quantity: json["quantity"],
      resolved: json["resolved"],
      created: json["created"],
    );
  }
}

var url = Uri.parse("http://localhost:8000/transactions");

Future<List<Transaction>> fetchData() async {
  final response = await http.get(url);
  final List<dynamic> decodedList = jsonDecode(response.body);
  final List<Transaction> transactionList = [];
  decodedList.forEach((transaction) {
    transactionList.add(Transaction.fromJson(transaction));
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
              crossAxisCount: 4,
              children: List.generate(snapshot.data!.length + 1, (index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        const EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 120.0),
                    child: ElevatedButton.icon(
                        onPressed: () => null,
                        icon: const Icon(Icons.dashboard_customize_rounded),
                        label: const Text("Agregar Categoria")),
                  );
                  // return Card(
                  //   elevation: 8.0,
                  //   margin: EdgeInsets.all(4.0),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15)),
                  //   child: Center(
                  //     child: Icon(Icons.add),
                  //   ),
                  // );
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
                                  fontWeight: FontWeight.normal),
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
                        Text(snapshot.data![index - 1].concept.toString()),
                        Text(snapshot.data![index - 1].category_id.toString()),
                        Text(snapshot.data![index - 1].created.toString()),
                        Text(snapshot.data![index - 1].resolved.toString()),
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
