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
  final _formKey = GlobalKey();
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Concepto:',
                ),
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
                    return DropdownMenu<String>(
                      initialSelection: snapshot.data!.first.name,
                      onSelected: (String? value) {
                        setState(
                          () {
                            selectedCategory = value!;
                          },
                        );
                      },
                      dropdownMenuEntries:
                          snapshot.data!.map<DropdownMenuEntry<String>>(
                        (category) {
                          return DropdownMenuEntry<String>(
                            value: category.name,
                            label: category.name,
                          );
                        },
                      ).toList(),
                    );
                  }
                  return const Text("Loading...");
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {},
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
