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

/// Converts a Transaction to JSON, then posts it & returns the Response
Future<http.Response> postTransaction(NewTransaction newTransaction) async {
  final url = Uri.parse("http://localhost:8000/transactions/");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newTransaction),
  );
  return response;
}

/// Sends a delete request with the id of the Transaction & returns its Response
Future<http.Response> deleteTransaction(int id) async {
  final url = Uri.parse("http://localhost:8000/transactions/$id");
  final response = await http.delete(url);
  return response;
}

/// Converts the Transaction to JSON & sends a PUT request with it, then return its Response
Future<http.Response> editTransaction(Transaction newTransaction) async {
  final url = Uri.parse("http://localhost:8000/transactions/");
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newTransaction),
  );
  return response;
}
