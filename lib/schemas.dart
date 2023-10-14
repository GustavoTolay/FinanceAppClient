class NewTransaction {
  final String concept;
  final int category_id;
  final int quantity;
  bool resolved;
  bool is_income;

  NewTransaction({
    required this.concept,
    required this.category_id,
    required this.quantity,
    required this.resolved,
    required this.is_income,
  });

  Map<String, dynamic> toJson() => {
    "concept": concept,
    "category_id": category_id,
    "quantity": quantity,
    "resolved": resolved,
    "is_income": is_income,
  };
}

class Transaction extends NewTransaction {
  final int id;
  final Category? category;
  final String created;

  Transaction({
    required this.id,
    this.category,
    required this.created,
    required super.concept,
    required super.category_id,
    required super.quantity,
    required super.resolved,
    required super.is_income,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json["id"],
      concept: json["concept"],
      category_id: json["category_id"],
      category: Category.fromJson(json["category"]),
      quantity: json["quantity"],
      resolved: json["resolved"],
      is_income: json["is_income"],
      created: json["created"],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    "concept": concept,
    "category_id": category_id,
    "quantity": quantity,
    "resolved": resolved,
    "is_income": is_income,
    "created": created,
  };
}

class Category {
  final int id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }
}
