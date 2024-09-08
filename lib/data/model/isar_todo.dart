import 'package:isar/isar.dart';
import 'package:myapp/domain/models/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool iscompleted;

  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      iscompleted: iscompleted,
    );
  }

  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..iscompleted = todo.iscompleted;
  }
}
