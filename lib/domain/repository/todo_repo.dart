import 'package:myapp/domain/models/todo.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();

  Future<void> addTodo(Todo newTodo);

  Future<void> deleteTodo(Todo todo);

  Future<void> updateTodo(Todo todo);
}
