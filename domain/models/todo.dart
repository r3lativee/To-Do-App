class Todo {
  final int id;
  final String text;
  final bool iscompleted;

  Todo({
    required this.id,
    required this.text,
    this.iscompleted = false,
  });

  Todo togglecompletion() {
    return Todo(
      id: id,
      text: text,
      iscompleted: !iscompleted,
    );
  }
}
