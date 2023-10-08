class Transaction {
  final int id;
  final String concept;
  final int category_id;
  final Category category;
  final int quantity;
  final bool resolved;
  final bool is_income;
  final String created;

  const Transaction({
    required this.id,
    required this.concept,
    required this.category,
    required this.category_id,
    required this.quantity,
    required this.resolved,
    required this.is_income,
    required this.created,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      concept: json["concept"],
      category_id: json["category_id"],
      category: json["category"],
      quantity: json["quantity"],
      resolved: json["resolved"],
      is_income: json["is_income"],
      created: json["created"],
    );
  }
}

class Category {
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });
}
