import "package:flutter/material.dart";

class TransactionRoute extends StatelessWidget {
  const TransactionRoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Transacciones"),
      ),
      body: Text("hola"),
    );
  }
}
