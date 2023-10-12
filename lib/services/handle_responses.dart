import 'package:flutter/material.dart';
import 'package:http/http.dart';

void handleResponse(Response response, BuildContext context) {
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transacción agregada :v'),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error crítico :p')),
    );
  }
}
