import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/event/category_event.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key key}) : super(key: key);

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  IconData _iconData;
  List<TransactionType> _option = TransactionType.getAllType();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;
  final _formNameKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = "Hạng mục chi";
    _iconData = Icons.category;
    super.initState();
  }

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconSize: 40,
        iconPickerShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Chọn icon', style: TextStyle(fontWeight: FontWeight.bold)),
        closeChild: Text(
          'Đóng',
          textScaleFactor: 1.25,
        ),
        searchHintText: 'Tìm icon...',
        noResultsText: 'Không tìm thấy:');

    if (icon != null) {
      setState(() {
        _iconData = icon;
      });
    }
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
        _iconData,
        Colors.blueAccent,
        TransactionType.valueFromName(this._currentOption),
        _descriptionController.text); //TO DO
    _bloc.event.add(AddCategoryEvent(category));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = CategoryBloc();

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);
    return Scaffold(
        appBar: AppBar(
          title: Text('Tạo hạng mục mới'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () => _submit(_bloc),
            )
          ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: _iconData != null
                                  ? Icon(
                                      _iconData,
                                      size: 30,
                                    )
                                  : Container()),
                          SizedBox(
                            width: 10,
                          ),
                          RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: _pickIcon,
                            child: Text('Chọn icon',
                                style: Theme.of(context).textTheme.subtitle),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Text(
                          //   'Loại:',
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       color: Colors.black.withOpacity(0.5)),
                          // ),
                          // SizedBox(width: 10),
                          DropdownButton(
                            value: _currentOption,
                            items: _dropDownMenuItems,
                            onChanged: changedDropDownItem,
                          ),
                        ],
                      )
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
