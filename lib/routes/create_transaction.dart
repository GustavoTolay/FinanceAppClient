import "package:flutter/material.dart";
import 'package:flutter_app/services/categories.dart';
import 'package:flutter_app/services/handle_responses.dart';
import "package:flutter_app/schemas.dart";
import 'package:flutter_app/services/transactions.dart';

class CreateTransaction extends StatefulWidget {
  /// Renders a Form, fills its inputs with transactionData's values and makes a POST request on submit.
  /// If transactionData is null, leaves the form with "default" values and makes a PUT request.
  const CreateTransaction({
    this.transactionData,
    super.key,
  });

  final Transaction? transactionData;

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final _formKey = GlobalKey<FormState>();

  // Variable for form's select
  late int selectedCategory;

  late Future<List<Category>> categoryData;
  late NewTransaction formValues;

  // Controllers for form's text inputs
  final quantity_controller = TextEditingController();
  final concept_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryData = getAllCategories();
    // If there's transactionData fills the form with its values, else leaves the form with "default" values.
    formValues = widget.transactionData ??
        NewTransaction(
          concept: "",
          category_id: 0,
          quantity: 0,
          resolved: false,
          is_income: false,
        );
    quantity_controller.text = formValues.quantity.toString();
    concept_controller.text = formValues.concept;
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
                  if (!pattern.hasMatch(value) || value == 0.toString()) {
                    return "Solo un número entero distinto de cero";
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
                    value: formValues.is_income,
                    onChanged: (value) {
                      setState(() {
                        formValues.is_income = value!;
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
                    value: formValues.resolved,
                    onChanged: (value) {
                      setState(() {
                        formValues.resolved = value!;
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
                        value: formValues.category_id == 0
                            ? null
                            : formValues.category_id.toString(),
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
                    // Makes a POST request if there isn't transactionData, else makes a PUT request
                    if (widget.transactionData == null) {
                      final formPostValues = NewTransaction(
                        concept: concept_controller.text,
                        category_id: selectedCategory,
                        quantity: int.parse(quantity_controller.text),
                        resolved: formValues.resolved,
                        is_income: formValues.is_income,
                      );
                      final response = await postTransaction(formPostValues);
                      if (!context.mounted) return;
                      handleResponse(response, context);
                    } else {
                      final formPutValues = Transaction(
                        id: widget.transactionData!.id,
                        created: widget.transactionData!.created,
                        concept: concept_controller.text,
                        category_id: selectedCategory,
                        quantity: int.parse(quantity_controller.text),
                        resolved: formValues.resolved,
                        is_income: formValues.is_income,
                      );
                      final response = await putTransaction(formPutValues);
                      if (!context.mounted) return;
                      handleResponse(response, context);
                    }
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
