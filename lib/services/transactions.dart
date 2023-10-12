import 'package:http/http.dart' as http;
import "package:flutter_app/schemas.dart";
import 'dart:convert';

/// GETs all transactions and converts them to objects
Future<List<Transaction>> getAllTransactions() async {
  final url = Uri.parse("http://localhost:8000/transactions/");
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

/// Converts a Transaction to JSON, then posts it
Future<http.Response> postTransaction(NewTransaction newTransaction) async {
  final url = Uri.parse("http://localhost:8000/transactions/");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newTransaction),
  );
  return response;
}
