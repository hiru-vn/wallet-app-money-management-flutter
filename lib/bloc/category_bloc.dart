import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/data/repository/category_repository.dart';
import 'package:wallet_exe/event/category_event.dart';
import 'package:wallet_exe/event/base_event.dart';

class CategoryBloc extends BaseBloc {
  CategoryRepository _categoryRepository = CategoryRepositoryImpl();

  Stream<List<Category>> get categoryListStream =>
      _categoryRepository.getAllCategory();

  initData() async {}

  _addCategory(Category category) async {
    final stateData = await _categoryRepository.addCategory(category);
    if (stateData.data == false) {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _deleteCategory(Category category) async {
    final stateData = await _categoryRepository.deleteCategory(category.id);
    if (stateData.data == false) {
      errorStreamControler.sink.add(stateData.e);
    }
  }

  _updateCategory(Category category) async {
    final stateData = await _categoryRepository.updateCategory(category);
    if (stateData.data == false) {
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
    super.dispose();
  }
}
