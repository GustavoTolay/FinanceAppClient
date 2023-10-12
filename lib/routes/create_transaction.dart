import "package:flutter/material.dart";
import 'package:flutter_app/services/handle_responses.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter_app/schemas.dart";

// Fetch all categories & convert response JSON to Object
Future<List<Category>> fetchData() async {
  final url = Uri.parse("http://localhost:8000/categories");
  final response = await http.get(url);
  final List<dynamic> decodedList = jsonDecode(response.body);
  final List<Category> categoryList = [];
  for (var category in decodedList) {
    categoryList.add(
      Category.fromJson(category),
    );
  }
  return categoryList;
}

// Create a new Transaction
Future<http.Response> postTransaction(NewTransaction newTransaction) async {
  final url = Uri.parse("http://localhost:8000/transactions/");
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newTransaction),
  );
  return response;
}

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({
    super.key,
  });

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();

  // Variables to form's checkboxes and select
  bool is_income = false;
  bool resolved = false;
  late int selectedCategory;

  // Controllers for form's inputs
  final quantity_controller = TextEditingController();
  final concept_controller = TextEditingController();

  late Future<List<Category>> categoryData;

  @override
  void initState() {
    super.initState();
    categoryData = fetchData();
  }

  @override
  void dispose() {
    quantity_controller.dispose();
    concept_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Transacciones"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Cantidad:',
                ),
                validator: (value) {
                  // Only an integer number
                  final pattern = RegExp(r"^[0-9]+$");
                  if (value == null || value.isEmpty) {
                    return "Completa este campo";
                  }
                  if (!pattern.hasMatch(value)) {
                    return "Solo un número entero";
                  }
                  return null;
                },
                controller: quantity_controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Concepto:',
                ),
                validator: (value) {
                  // Only words/numbers separated by one space and , or .
                  final pattern = RegExp(r"^([A-Za-z0-9],?\.?[ ]?)+$");
                  if (value == null || value.isEmpty) {
                    return "Completa este campo";
                  }
                  if (!pattern.hasMatch(value)) {
                    return "Solo letras, números y espacios";
                  }
                  return null;
                },
                controller: concept_controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: FormField(
                builder: (FormFieldState<dynamic> field) {
                  return CheckboxListTile(
                    value: is_income,
                    onChanged: (value) {
                      setState(() {
                        is_income = value!;
                      });
                    },
                    title: const Text("Es ingreso?"),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: FormField(
                builder: (FormFieldState<dynamic> field) {
                  return CheckboxListTile(
                    value: resolved,
                    onChanged: (value) {
                      setState(() {
                        resolved = value!;
                      });
                    },
                    title: const Text("Está concretado?"),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                  );
                },
              ),
            ),
            FutureBuilder(
                future: categoryData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Failed to fetch data");
                  }
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 16),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seleccione una categoria";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            selectedCategory = int.parse(value);
                          }
                        },
                        items: snapshot.data!.map<DropdownMenuItem<String>>(
                          (category) {
                            return DropdownMenuItem<String>(
                              value: category.id.toString(),
                              child: Text(category.name),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  }
                  return const Text("Loading...");
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final formValues = NewTransaction(
                      concept: concept_controller.text,
                      category_id: selectedCategory,
                      quantity: int.parse(quantity_controller.text),
                      resolved: resolved,
                      is_income: is_income,
                    );
                    final response = await postTransaction(formValues);
                    if (!context.mounted) return;
                    handleResponse(response, context);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Crear transacción',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
