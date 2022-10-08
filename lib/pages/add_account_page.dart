import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/account_bloc.dart';
import 'package:wallet_exe/data/model/Account.dart';
import 'package:wallet_exe/enums/account_type.dart';
import 'package:wallet_exe/event/account_event.dart';
import 'package:wallet_exe/utils/text_input_formater.dart';
import 'package:wallet_exe/widgets/circle_image_picker.dart';

class AddAccountPage extends StatefulWidget {
  AddAccountPage({Key key}) : super(key: key);

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  String _imgUrl = 'assets/bank.png';
  List<AccountType> _option = AccountType.getAllType();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentOption;
  final _formNameKey = GlobalKey<FormState>();
  final _formBalanceKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _balanceController = TextEditingController();
  var _descriptionController = TextEditingController();

  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentOption = "Tài khoản tiêu dùng";
    super.initState();
  }

  _pickIcon() async {
    String url = await FlutterCircleImagePicker.showCircleImagePicker(context,
        imageSize: 60,
        imagePickerShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Chọn ảnh tài khoản',
            style: TextStyle(fontWeight: FontWeight.bold)),
        closeChild: Text(
          'Đóng',
          textScaleFactor: 1.25,
        ),
        searchHintText: 'Tìm ảnh...',
        noResultsText: 'Không tìm thấy:');

    if (url != null) {
      setState(() {
        _imgUrl = url;
      });
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (AccountType option in _option) {
      items.add(DropdownMenuItem(value: option.name, child: Text(option.name)));
    }
    return items;
  }

  void changedDropDownItem(String selectedOption) {
    setState(() {
      _currentOption = selectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = AccountBloc();

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    void _submit() {
      if (!this._formNameKey.currentState.validate()) {
        return;
      }
      if (!this._formBalanceKey.currentState.validate()) {
        return;
      }
      Account account = Account(
          _nameController.text,
          currencyToInt(_balanceController.text),
          AccountType.valueFromName(this._currentOption),
          Icons.account_balance_wallet,
          this._imgUrl
          );
      _bloc.event.add(AddAccountEvent(account));
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Tạo tài khoản mới'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _submit,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Form(
                      key: _formNameKey,
                      child: TextFormField(
                        validator: (String value) {
                          return value.trim() == ''
                              ? 'Tên tài khoản không được để trống'
                              : null;
                        },
                        controller: _nameController,
                        autofocus: true,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            hintText: 'Tên tài khoản',
                            hintStyle: TextStyle(fontSize: 20),
                            icon: Icon(
                              Icons.account_balance_wallet,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Form(
                      key: _formBalanceKey,
                      child: TextFormField(
                        validator: (String value) {
                          if (value.trim() == "")
                            return 'Số dư không được để trống';
                          return currencyToInt(value) <= 0
                              ? 'Số tiền phải lớn hơn 0'
                              : null;
                        },
                        controller: _balanceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CurrencyTextFormatter()],
                        autofocus: true,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            suffixText: 'đ',
                            hintText: 'Số dư ban đầu',
                            hintStyle: TextStyle(fontSize: 20),
                            icon: Icon(
                              Icons.attach_money,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                              height: 38,
                              width: 38,
                              child: Image.asset(this._imgUrl),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.mode_edit),
                            onPressed: _pickIcon,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Loại:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    onPressed: _submit,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
