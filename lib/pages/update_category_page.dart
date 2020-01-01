import 'package:flutter/material.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/event/category_event.dart';

class UpdateCategoryPage extends StatefulWidget {
  final Category _category;
  UpdateCategoryPage(this._category);

  @override
  _UpdateCategoryPageState createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  Category _category;
  final _formNameKey = GlobalKey<FormState>();
  List<TransactionType> _option = TransactionType.getAllType();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    this._category = widget._category;
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = this._category.transactionType.name;
    _nameController.text= this._category.name;
    //_descriptionController = this._category.description;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (TransactionType option in _option) {
      items.add(DropdownMenuItem(value: option.name, child: Text(option.name)));
    }
    return items;
  }

  void changedDropDownItem(String selectedOption) {
    setState(() {
      _currentOption = selectedOption;
    });
  }

  _submit(_bloc) {
    if (!this._formNameKey.currentState.validate()) {
      return;
    }
    //add data
    Category category = Category(
        _nameController.text,
        Icons.ac_unit,
        Colors.blueAccent,
        TransactionType.valueFromName(this._currentOption), ''); //TO DO
    category.id = this._category.id;
    _bloc.event.add(UpdateCategoryEvent(category));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = CategoryBloc();

    return Scaffold(
        appBar: AppBar(
          title: Text('Sửa hạng mục'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    width: double.infinity,
                    child: Form(
                      key: _formNameKey,
                      child: TextFormField(
                        validator: (String value) {
                          return value.trim() == ''
                              ? 'Tên hạng mục không được để trống'
                              : null;
                        },
                        controller: _nameController,
                        autofocus: true,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            hintText: 'Tên hạng mục',
                            hintStyle: TextStyle(fontSize: 20),
                            icon: Icon(
                              Icons.category,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  child: TextFormField(
                    controller: _descriptionController,
                    autofocus: true,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        hintText: 'Diễn giải',
                        hintStyle: TextStyle(fontSize: 20),
                        icon: Icon(
                          Icons.subject,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Loại hạng mục',
                        style: TextStyle(
                            fontSize: 18, color: Colors.black.withOpacity(0.5)),
                      ),
                      SizedBox(width: 15),
                      DropdownButton(
                        value: _currentOption,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.save_alt,
                            size: 28,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Tạo',
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () => _submit(_bloc),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
