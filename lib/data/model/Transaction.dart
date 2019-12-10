class Transaction {
  int id; // auto generate & unique

  int idAccount;
  int idCategory;
  int idCategoryType;
  int money;
  DateTime date;

  Transaction({
    this.idAccount,
    this.idCategory,
    this.idCategoryType,
    this.money,
    this.date
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'idAccount' : idAccount,
      'idCategory': idCategory,
      'idCategoryType' : idCategoryType,
      'money' : money,
      'date' : date,
    };
  }
  // setter
  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      idAccount: map['idAccount'],
      idCategory: map['idCategory'],
      idCategoryType: map['idCategoryType'],
      money: map['money'],
      date: map['date'],
    );
  }
}