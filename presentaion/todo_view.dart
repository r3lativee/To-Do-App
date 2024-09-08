import 'package:flutter/cupertino.dart'; // For CupertinoSwitch
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/domain/models/todo.dart';
import 'package:myapp/presentaion/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: 'Enter new to-do'),
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          // add button
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(50.0), // Set the height of the AppBar
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16.0), // Set rounded corners
          ),
          child: AppBar(
            centerTitle: false,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            elevation: 10,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 0, 0, 0)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  // Handle menu action based on selected value
                },
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem<String>(
                      value: 'Option1',
                      child: Text('Dark Mode'),
                    ),
                    PopupMenuItem<String>(
                      value: 'option2',
                      child: Text('Light Mode'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adding padding to the whole body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title "To-do List"
            const Text(
              'To-Do List',
              style: TextStyle(
                fontSize: 35,
                color: Color.fromARGB(255, 236, 236, 236),
                fontFamily: 'poppins',
                fontWeight: FontWeight
                    .bold, // Optional: Adjust color to your preference
              ),
            ),

            // Subtitle "Get Started"
            const Text(
              'Get started by adding your tasks below!',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 110, 110, 110),
                fontFamily:
                    'poppins', // Optional: Adjust color to your preference
              ),
            ),
            const Text(
              'R 3 L A T I V E',
              style: TextStyle(
                fontSize: 8,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'poppins',
                fontWeight: FontWeight
                    .bold, // Optional: Adjust color to your preference
              ),
            ),
            const SizedBox(height: 30), // Adding some space after the subtitle

            Expanded(
              child: BlocBuilder<TodoCubit, List<Todo>>(
                builder: (context, state) {
                  return GridView.builder(
                    itemCount: state.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns in the grid
                      childAspectRatio: 2 / 2, // Adjust for tile height
                      crossAxisSpacing:
                          10, // Spacing between grid items horizontally
                      mainAxisSpacing:
                          10, // Spacing between grid items vertically
                    ),
                    itemBuilder: (context, index) {
                      final todo = state[index];

                      // Define the color of the container based on whether the switch is on/off
                      final containerColor = todo.iscompleted
                          ? const Color.fromARGB(
                              255, 27, 27, 27) // Darker shade when completed
                          : const Color.fromARGB(255, 82, 81,
                              81); // Original color when not completed

                      return Container(
                        padding: const EdgeInsets.all(
                            12.0), // Padding inside the tile
                        decoration: BoxDecoration(
                          color: containerColor, // Dynamic background color
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 48, 48, 48),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title at the top
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                todo.text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                            const Spacer(), // Spacer to push content to the bottom

                            // Leading (CupertinoSwitch) and Trailing (Delete Icon) at the bottom
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Leading switch
                                Transform.scale(
                                  scale:
                                      0.7, // Adjust the scale to your preference
                                  child: CupertinoSwitch(
                                    value: todo.iscompleted,
                                    onChanged: (value) =>
                                        todoCubit.toggleCompletion(todo),
                                    activeColor: const Color.fromARGB(
                                        255, 0, 0, 0), // Switch "on" color
                                  ),
                                ),
                                // Trailing delete icon
                                Transform.scale(
                                  scale: 1.2, // Scale up the delete icon
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221),
                                    onPressed: () => todoCubit.deleteTodo(todo),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
