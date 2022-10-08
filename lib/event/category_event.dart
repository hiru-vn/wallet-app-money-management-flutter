import 'package:wallet_exe/data/model/Category.dart';
import 'package:wallet_exe/event/base_event.dart';

class AddCategoryEvent extends BaseEvent {
  Category category;

  AddCategoryEvent(category);
}

class DeleteCategoryEvent extends BaseEvent {
  Category category;

  DeleteCategoryEvent(category);
}

class UpdateCategoryEvent extends BaseEvent {
  Category category;

  UpdateCategoryEvent(category);
}
