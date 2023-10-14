import "package:flutter/material.dart";
import "package:flutter_app/schemas.dart";
import 'package:flutter_app/routes/create_transaction.dart';
import 'package:flutter_app/services/transactions.dart';
import 'package:flutter_app/services/handle_responses.dart';
import 'package:http/http.dart';

class TransactionRoute extends StatefulWidget {
  const TransactionRoute({
    super.key,
  });

  @override
  State<TransactionRoute> createState() => _TransactionRouteState();
}

class _TransactionRouteState extends State<TransactionRoute> {
  late Future<List<Transaction>> transactionData;
  late Response response;

  @override
  void initState() {
    super.initState();
    transactionData = getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Transacciones"),
      ),
      body: FutureBuilder(
        future: transactionData,
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("error in the fetch");
          if (snapshot.hasData) {
            return GridView.count(
              crossAxisCount: 5,
              children: List.generate(snapshot.data!.length + 1, (index) {
                if (index == 0) {
                  return Center(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateTransaction(),
                        ),
                      ),
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
                            Text(snapshot.data![index - 1].category!.name
                                .toString()),
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
                        const Spacer(),
                        Row(
                          children: [
                            // Edit button
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateTransaction(transactionData: snapshot.data![index - 1]),
                                ),
                              ),
                              child: const Icon(Icons.edit_square),
                            ),
                            const Spacer(),
                            // Delete button
                            ElevatedButton(
                              onPressed: () async {
                                response = await deleteTransaction(
                                  snapshot.data![index - 1].id,
                                );
                                if (!context.mounted) return;
                                handleResponse(response, context);
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Colors.red,
                                ),
                              ),
                              child: const Icon(Icons.delete_forever),
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
