import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:wallet_exe/event/base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController = 
    StreamController<BaseEvent> ();

  // dung de day event vao stream
  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Event khong hop le");
      }

      dispatchEvent(event);
    });
  }

  //phai override ham nay, chua logic khi xay ra event (lam gi?)
  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}