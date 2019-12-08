import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_exe/widgets/card_category_list.dart';
import 'package:wallet_exe/widgets/item_category.dart';

class CategoryPage extends StatefulWidget {
  final List<Category> _categories = [
    Category('Ăn uông', 0),
    Category('Con cái', 0),
    Category('Nhà cửa', 0),
    Category('Học tập', 0)
  ];

  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    //code for controller
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    widget._categories.map((item) {
      print(item.name);
      list.add(ItemCategory(item));
      list.add(Divider());
    });
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
            onPressed: () {},
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
                decoration: BoxDecoration(
                  color: Colors.white,
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
              CardCategoryList('TẤT CẢ', widget._categories),
              SizedBox(
                height: 15,
              ),
              CardCategoryList(
                  'Hạng mục chi',
                  widget._categories.where((item) {
                    return item.type == 0;
                  }).toList()),
              SizedBox(
                height: 15,
              ),
              CardCategoryList(
                  'Hạng mục thu',
                  widget._categories.where((item) {
                    return item.type == 1;
                  }).toList()),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
