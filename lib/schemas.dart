class Transaction {
  final int id;
  final String concept;
  final int category_id;
  final int quantity;
  final bool resolved;
  final String created;

  const Transaction({
    required this.id,
    required this.concept,
    required this.category_id,
    required this.quantity,
    required this.resolved,
    required this.created,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      concept: json["concept"],
      category_id: json["category_id"],
      quantity: json["quantity"],
      resolved: json["resolved"],
      created: json["created"],
    );
  }
}