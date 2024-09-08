import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/domain/models/todo.dart';
import 'package:myapp/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //Reference the repo
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );
    await todoRepo.addTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);

    loadTodos();
  }

  //toggle

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.togglecompletion();

    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }
}
