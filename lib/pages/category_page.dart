import 'package:flutter/material.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/widgets/card_category_list.dart';
import '../data/model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/bloc/category_bloc.dart';
import 'package:wallet_exe/pages/add_category_page.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var _filter = "";

  @override
  void initState() {
    super.initState();
  }

  void _submit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCategoryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _bloc = CategoryBloc();
    _bloc.initData();
    
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 1920, allowFontScaling: true);

    return Scaffold(
        appBar: AppBar(
          title: Text('Chọn hạng mục'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _submit,
            )
          ],
        ),
        body: StreamBuilder<List<Category>>(
          stream: _bloc.categoryListStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    width: 100,
                    height: 50,
                    child: Text('Bạn chưa tạo hạng mục nào'),
                  ),
                );
              case ConnectionState.none:

              case ConnectionState.active:
                return SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark? Colors.black45: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 15.0),
                                blurRadius: 15.0,
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (text) {
                              this.setState((){
                                _filter = text.trim();
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Tìm tên hạng mục',
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black.withOpacity(0.5),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CardCategoryList('TẤT CẢ', snapshot.data.where((item)=>(item.name.contains(this._filter))).toList()),
                        SizedBox(
                          height: 15,
                        ),
                        CardCategoryList(
                            'Hạng mục chi',
                            snapshot.data.where((item)=>(item.transactionType == TransactionType.EXPENSE)).where((item)=>(item.name.contains(this._filter))).toList()),
                        SizedBox(
                          height: 15,
                        ),
                        CardCategoryList(
                            'Hạng mục thu',
                            snapshot.data.where((item)=>(item.transactionType == TransactionType.INCOME)).where((item)=>(item.name.contains(this._filter))).toList()),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
            }
          },
        ));
  }
}
