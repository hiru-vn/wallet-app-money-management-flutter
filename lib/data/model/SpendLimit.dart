class SpendLimit {
  int id; // auto generate & unique

  int idUserAccount;
  int money;
  int type;

  SpendLimit({
    this.idUserAccount,
    this.money,
    this.type
  });

  // getter
  Map<String, dynamic> toMap() {
    return {
      'idUserAccount': idUserAccount,
      'money': money,
      'type' : type,
    };
  }
  // setter
  static SpendLimit fromMap(Map<String, dynamic> map) {
    return SpendLimit(
      idUserAccount: map['idUserAccount'],
      money: map['money'],
      type: map['type']
    );
  }
}