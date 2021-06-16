import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/repo/state_data.dart';

class CategoryRemoteDataSource {
  static final _instance = CategoryRemoteDataSource._internal();

  factory CategoryRemoteDataSource() => _instance;

  CategoryRemoteDataSource._internal()

  Future<StateData> addCategory(Category category) async {

  }
}