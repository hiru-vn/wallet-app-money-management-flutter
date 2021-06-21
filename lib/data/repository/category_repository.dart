import 'package:wallet_exe/data/local/category_local_data_source.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/model/User.dart';
import 'package:wallet_exe/data/remote/category_remote_data_source.dart';
import 'package:wallet_exe/data/repo/state_data.dart';
import 'package:wallet_exe/data/repository/user_repository.dart';

abstract class CategoryRepository {
  Stream<List<Category>> getAllCategory();

  Future<StateData> addCategory(Category category);

  Future<StateData> updateCategory(Category category);

  Future<StateData> deleteCategory(String categoryId);
}

class CategoryRepositoryImpl implements CategoryRepository {
  static final _instance = CategoryRepositoryImpl._internal();

  final _categoryRemoteDataSource = CategoryRemoteDataSource();
  final UserRepository _userRepository = UserRepositoryImpl();
  final _categoryLocalDataSource = CategoryLocalDataSource();

  factory CategoryRepositoryImpl() {
    return _instance;
  }

  CategoryRepositoryImpl._internal();

  @override
  Future<StateData> addCategory(Category category) async {
    return _getUser() != null
        ? await _categoryRemoteDataSource.addCategory(_getUser().id, category)
        : _errorLogin();
  }

  @override
  Stream<List<Category>> getAllCategory() {
    final _streamCategories =
        _categoryRemoteDataSource.getAllCategory(_getUser().id);
    _streamCategories.listen((data) {
      _categoryLocalDataSource.saveCategories(data);
    });
    return _streamCategories;
  }

  @override
  Future<StateData> updateCategory(Category category) async {
    return _getUser() != null
        ? await _categoryRemoteDataSource.updateCategory(
            _getUser().id, category)
        : _errorLogin();
  }

  @override
  Future<StateData> deleteCategory(String categoryId) async {
    return _getUser() != null
        ? await _categoryRemoteDataSource.deleteCategory(
            _getUser().id, categoryId)
        : _errorLogin();
  }

  StateData _errorLogin() {
    return StateData.error(Exception('User must login'));
  }

  UserModel _getUser() {
    return _userRepository.getCurrentUser();
  }
}
