import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/repository/category_repository.dart';
import 'package:wallet_exe/event/category_event.dart';
import 'package:wallet_exe/event/base_event.dart';

class CategoryBloc extends BaseBloc {
  CategoryRepository _categoryRepository = CategoryRepositoryImpl();

  StreamController<List<Category>> _categoryListStreamController =
      StreamController<List<Category>>();

  Stream<List<Category>> get categoryListStream =>
      _categoryListStreamController.stream;

  List<Category> _categoryListData = List<Category>();

  List<Category> get categoryListData => _categoryListData;

  initData() async {
    if (_categoryListData.length != 0) return;
    final stateData = await _categoryRepository.getAllCategory();
    if (stateData.data != null) {
      _categoryListData = stateData.data;
      _categoryListStreamController.sink.add(_categoryListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _addCategory(Category category) async {
    final stateData = await _categoryRepository.addCategory(category);
    if (stateData.data != null) {
      _categoryListData.add(stateData.data);
      _categoryListStreamController.sink.add(_categoryListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _deleteCategory(Category category) async {
    final stateData = await _categoryRepository.deleteCategory(category.id);
    if (stateData.data ?? false) {
      _categoryListData.remove(category);
      _categoryListStreamController.sink.add(_categoryListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _updateCategory(Category category) async {
    int index = _categoryListData.indexWhere((item) {
      return item.id == category.id;
    });
    final stateData = await _categoryRepository.updateCategory(category);
    if (stateData.data != null) {
      _categoryListData[index] = category;
      _categoryListStreamController.sink.add(_categoryListData);
    } else {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  void dispatchEvent(BaseEvent event) {
    if (event is AddCategoryEvent) {
      Category category = Category.copyOf(event.category);
      _addCategory(category);
    } else if (event is DeleteCategoryEvent) {
      Category category = Category.copyOf(event.category);
      _deleteCategory(category);
    } else if (event is UpdateCategoryEvent) {
      Category category = Category.copyOf(event.category);
      _updateCategory(category);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryListStreamController.close();
    super.dispose();
  }
}
