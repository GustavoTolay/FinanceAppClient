import "package:flutter/material.dart";
import "package:flutter_app/routes/transactions_route.dart";

class AccessesWidget extends StatelessWidget {
  const AccessesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            child: const Text(
              "Accesos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TransactionRoute()),
                            );
                          },
                          child: const SizedBox(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.edit_document,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "TODAS las transacciones",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.grey,
                          child: const SizedBox(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: Color.fromARGB(255, 255, 193, 22),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Reservas",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.grey,
                          child: const SizedBox(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.upload_file_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Ver Ingresos",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.grey,
                          child: const SizedBox(
                            child: Center(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.sim_card_download_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Ver Consumos",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              // color: Colors.red,
              ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              // color: Colors.blue,
              ),
        ),
      ],
    );
  }
}
