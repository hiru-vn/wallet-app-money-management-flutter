import 'package:flutter/material.dart';

class CollapseCard extends StatefulWidget {
  @override
  _CollapseCardState createState() => _CollapseCardState();
}

class _CollapseCardState extends State<CollapseCard> {
  bool _collapsed = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              _collapsed ? _collapsed = false : _collapsed = true;
            }),
            child: Row(
              children: <Widget>[
                Text("Đang sử dụng: (1.596.000 đ)"),
                // IconButton(
                //   icon: Icon(Icons.keyboard_arrow_up),
                //   onPressed: () => setState(() {
                //     _collapsed ? _collapsed = false : _collapsed = true;
                //   }),
                // ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            child: Container(
              constraints: _collapsed
                  ? BoxConstraints(maxHeight: 0.0)
                  : BoxConstraints(maxHeight: double.infinity),
              child: Column(
                children: <Widget>[
                  Text("Just some text Lorem Ipsum Dolar Sit"),
                  Text("Just some text Lorem Ipsum Dolar Sit"),
                  Text("Just some text Lorem Ipsum Dolar Sit"),
                  Text("Just some text Lorem Ipsum Dolar Sit"),
                  Text("Just some text Lorem Ipsum Dolar Sit"),
                ],
              ),
              width: double.infinity,
            ),
            color: Colors.tealAccent,
          )
        ],
      ),
    );
  }
}


class AnimateContentExample extends StatefulWidget {
  @override
  _AnimateContentExampleState createState() => new _AnimateContentExampleState();
}

class _AnimateContentExampleState extends State<AnimateContentExample> {
  bool _animatedHeight = false;
  @override
  Widget build(BuildContext context) {
    return Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  onTap: ()=>setState((){
                    _animatedHeight?_animatedHeight=false:_animatedHeight=true;}),
                  child:  new Container(
                  child: new Text("CLICK ME"),
                  color: Colors.blueAccent,
                  height: 25.0,
                    width: 100.0,
                ),),
                new AnimatedContainer(duration: const Duration(milliseconds: 1200),
                  child: new Text("Toggle Me"),
                  height: _animatedHeight?double.infinity:0,
                  color: Colors.tealAccent,
                  width: 100.0,
                )
              ],
            ) ,
          );
  }
}