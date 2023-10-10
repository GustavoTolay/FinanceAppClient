import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:flutter_app/schemas.dart";

// Fetch all categories & convert response JSON to Object
var url = Uri.parse("http://localhost:8000/categories");

Future<List<Category>> fetchData() async {
  final response = await http.get(url);
  final List<dynamic> decodedList = jsonDecode(response.body);
  final List<Category> categoryList = [];
  decodedList.forEach((category) {
    categoryList.add(
      Category.fromJson(category),
    );
  });
  return categoryList;
}

class CreateTransaction extends StatefulWidget {
  CreateTransaction({
    super.key,
  });

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();
  // Variables to form checkboxes
  bool is_income = false;
  bool resolved = false;

  late String selectedCategory;

  late Future<List<Category>> CategoryData;

  @override
  void initState() {
    super.initState();
    CategoryData = fetchData();
  }

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
                  if(value == null || value.isEmpty) {
                    return "Completa este campo";
                  }
                  if(!pattern.hasMatch(value)) {
                    return "Solo un número entero";
                  }
                  return null;
                },
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
                  final pattern = RegExp(r"^([A-Za-z0-9],?\.?[ ]?)+$", dotAll: true);
                  if(value == null || value.isEmpty) {
                    return "Completa este campo";
                  }
                  if(!pattern.hasMatch(value)) {
                    return "Solo letras, números y espacios";
                  }
                  return null;
                },
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
                future: CategoryData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Failed to fetch data");
                  }
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Seleccione una categoria";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        items:
                            snapshot.data!.map<DropdownMenuItem<String>>(
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
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Validated Form')),
                  );
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
