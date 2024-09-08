import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/data/model/isar_todo.dart';
import 'package:myapp/data/repository/isar_todo_repo.dart';
import 'package:myapp/domain/repository/todo_repo.dart';
import 'package:myapp/presentaion/todo_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dir path
  final dir = await getApplicationDocumentsDirectory();

  // open isar db
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // init our repo
  final isarTodoRepo = IsarTodoRepo(isar);

  // run app
  runApp(MyApp(todoRepo: isarTodoRepo));
}

class MyApp extends StatelessWidget {
  // database injection through the app
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:
            const Color.fromRGBO(0, 0, 0, 1), // Black background for the app
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(34, 33, 33, 1), // Black AppBar
          centerTitle: true, // Center the AppBar title
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:
              Color.fromRGBO(180, 118, 46, 1), // Blue accent for FAB
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(
              const Color.fromARGB(255, 0, 0, 0)), // White check in checkbox
          fillColor: WidgetStateProperty.all(
              const Color.fromRGBO(180, 118, 46, 1)), // Blue for checkbox fill
        ),
      ),
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
