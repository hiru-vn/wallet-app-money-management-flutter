import 'dart:async';

import 'package:wallet_exe/bloc/base_bloc.dart';
import 'package:wallet_exe/data/dao/category_table.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/event/category_event.dart';
import 'package:wallet_exe/event/base_event.dart';


class CategoryBloc extends BaseBloc {
  CategoryTable _categorytable = CategoryTable();

  StreamController<List<Category>> _categoryListStreamController = 
    StreamController<List<Category>>();

  Stream<List<Category>> get categoryListStream => _categoryListStreamController.stream;

  List<Category> _categoryListData = List<Category>();

  List<Category> get categoryListData => _categoryListData;

  initData() async {
    if (_categoryListData.length != 0) return;
    _categoryListData = await _categorytable.getAll();
    if (_categoryListData == null) return;

    print('category bloc init');

    _categoryListStreamController.sink.add(_categoryListData);
  }

  _addCategory(Category category) async {
    _categorytable.insert(category);

    _categoryListData.add(category);
    _categoryListStreamController.sink.add(_categoryListData);
  }

  _deleteCategory(Category category) async {
    _categorytable.delete(category.id);

    _categoryListData.remove(category);
    _categoryListStreamController.sink.add(_categoryListData);
  }

  _updateCategory(Category category) async {
    _categorytable.update(category);

    int index =_categoryListData.indexWhere((item) {return item.id == category.id;});
    _categoryListData[index] = category;
    _categoryListStreamController.sink.add(_categoryListData);
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
    super.dispose();
  }
}