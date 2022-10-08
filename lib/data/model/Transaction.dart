import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/utils/date_format_util.dart';

import '../dao/transaction_table.dart';

class Transaction {
  int id; // auto generate & unique

  Account account;
  Category category;
  int amount;
  DateTime date;
  String description;

  Transaction(account, category, amount, date, description);

  Transaction.copyOf(Transaction copy) {
    id = copy.id;
    account = copy.account;
    category = copy.category;
    amount = copy.amount;
    date = copy.date;
    description = copy.description;
  }

  // getter
  Map<String, dynamic> toMap() {
    return {
      TransactionTable().id: id,
      TransactionTable().date: convertToISO8601DateFormat(date),
      TransactionTable().amount: amount,
      TransactionTable().description: description,
      TransactionTable().idCategory: category.id,
      TransactionTable().idAccount: account.id
    };
  }

  // setter
  Transaction.fromMap(Map<String, dynamic> map) {
    id = map[TransactionTable().id];
    account = Account.fromMap(map);
    date = DateTime.parse(map[TransactionTable().date]);
    amount = map[TransactionTable().amount];
    description = map[TransactionTable().description];
    //merge table query
    category = Category.fromMap(map);
  }

  void checkValidationAndThrow() {
    if (date == null) {
      throw Exception("No date!");
    }

    if (amount <= 0) {
      throw Exception("No amount!");
    }

    if (category == null) {
      throw Exception("No category!");
    }
  }
}
