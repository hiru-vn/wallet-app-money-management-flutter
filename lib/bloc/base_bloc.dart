import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:wallet_exe/event/base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  StreamController<Exception> errorStreamControler =
      StreamController<Exception>();

  // dung de day event vao stream
  Sink<BaseEvent> get event => _eventStreamController.sink;

  Stream<Exception> get error => errorStreamControler.stream;

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
    errorStreamControler.close();
  }
}
