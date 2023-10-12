import 'package:flutter/material.dart';
import 'package:http/http.dart';

/// Displays a SnackBar with a message based on the response code
void handleResponse(Response response, BuildContext context) {
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operación exitosa :v'),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error crítico :p')),
    );
  }
}
