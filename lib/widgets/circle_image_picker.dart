import 'package:flutter/material.dart';

class FlutterCircleImagePicker {
  static Future<String> showCircleImagePicker(BuildContext context,
      {double imageSize,
      ShapeBorder imagePickerShape,
      Widget title,
      Widget closeChild,
      String searchHintText,
      String noResultsText}) async {
    String imagePicked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: imagePickerShape,
            title: title,
            content: Container(
              constraints: BoxConstraints(maxHeight: 350, minWidth: 450),
              child: Column(children: <Widget>[
                //SearchBar(searchHintText: searchHintText),
                Flexible(
                    child: CircleImagePicker(
                        noResultsText: noResultsText, imageSize: imageSize))
              ]),
            ),
            actions: [
              FlatButton(
                padding: EdgeInsets.only(right: 20),
                onPressed: () => Navigator.of(context).pop(),
                child: closeChild,
              )
            ]);
      },
    );

    if (imagePicked != null) {
      return imagePicked;
    }
    return null;
  }
}

class CircleImagePicker extends StatefulWidget {
  final double imageSize;
  final String noResultsText;
  static Function reload;
  static Map<String, String> imgMap;

  CircleImagePicker({this.imageSize, this.noResultsText, Key key}) : super(key: key);

  @override
  _CircleImagePickerState createState() => _CircleImagePickerState();
}

class _CircleImagePickerState extends State<CircleImagePicker> {
  @override
  void initState() {
    super.initState();
    CircleImagePicker.imgMap = imgUrl;
    CircleImagePicker.reload = setState;
  }

  _buildImages(context) {
    List<Widget> result = [];

    CircleImagePicker.imgMap.forEach((String key, String imgUrl) {
      result.add(InkResponse(
        onTap: () => Navigator.pop(context, imgUrl),
        child: SizedBox(
          height: widget.imageSize,
          width: widget.imageSize,
          child: Image.asset(imgUrl),
        ),
      ));
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: CircleImagePicker.imgMap.length != 0
                  ? _buildImages(context)
                  : [
                      Center(
                        child: Text(widget.noResultsText), //+
                            //' ' +
                            //SearchBar.searchTextController.text),
                      ),
                    ]),
        ),
      ),
      IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.lerp(Alignment.topCenter, Alignment.center, .1),
                colors: [Colors.white, Colors.white.withOpacity(.1)],
                stops: [0.0, 1.0]),
          ),
          child: Container(),
        ),
      ),
      IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.lerp(
                    Alignment.bottomCenter, Alignment.center, .1),
                colors: [Colors.white, Colors.white.withOpacity(.1)],
                stops: [0.0, 1.0]),
          ),
          child: Container(),
        ),
      )
    ]);
  }
}

// class SearchBar extends StatefulWidget {
//   final String searchHintText;
//   static TextEditingController searchTextController =
//       new TextEditingController();

//   SearchBar({this.searchHintText, Key key}) : super(key: key);

//   @override
//   _SearchBarState createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   _search(String searchValue) {
//     Map<String, ImageData> searchResult = new Map<String, ImageData>();

//     imgUrl.forEach((String key, String val) {
//       if (key.toLowerCase().contains(searchValue.toLowerCase())) {
//         //searchResult.putIfAbsent(key, () => val);
//       }
//     });

//     setState(() {
//       if (searchResult.length != 0) {
//         CircleImagePicker.imageMap = searchResult;
//       } else {
//         CircleImagePicker.imageMap = {};
//       }
//       CircleImagePicker.reload(() => {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: (val) => _search(val),
//       controller: SearchBar.searchTextController,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(top: 15),
//         hintText: widget.searchHintText,
//         prefixImage: Image(Images.search),
//         suffixImage: AnimatedSwitcher(
//           child: SearchBar.searchTextController.text.isNotEmpty
//               ? ImageButton(
//                   image: Image(Images.close),
//                   onPressed: () => setState(() {
//                     SearchBar.searchTextController.clear();
//                     CircleImagePicker.imageMap = images;
//                     CircleImagePicker.reload(() => {});
//                   }),
//                 )
//               : SizedBox(
//                   width: 10,
//                 ),
//           duration: Duration(milliseconds: 300),
//         ),
//       ),
//     );
//   }
// }

Map<String, String> imgUrl = {
  'bank': 'assets/logo.png',
  'wallet': 'assets/bank.png',
  'dollar': 'assets/dollar.png',
  'jp-yen': 'assets/jp-yen.png',
  'e-wallet': 'assets/e-wallet.png',
  'bitcocin': 'assets/bitcoin.png',
  'bank-card': 'assets/bank-card.png',
  'credit': 'assets/credit.png',
  'phone-wallet': 'assets/phone-wallet.png',
  'saving-pig': 'assets/saving-pig.png',
};
