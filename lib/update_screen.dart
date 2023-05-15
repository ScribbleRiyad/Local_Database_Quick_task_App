// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_database_testing_hive/QuickTask.dart';
import 'package:local_database_testing_hive/home_screen.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final QuickTask? data;
  final titleController;
  final descriptionController;

  const UpdateScreen(
      {super.key,
      required this.index,
      this.data,
      this.titleController,
      this.descriptionController});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late final Box dataBox;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  _updateData() {
    QuickTask newData = QuickTask(
      tasktitle: titleController.text,
      taskdetails: descriptionController.text,
    );
    dataBox.putAt(widget.index, newData);
  }

  @override
  void initState() {
    super.initState();

    dataBox = Hive.box('QuickTaskBox');
    titleController = TextEditingController(text: widget.titleController);
    descriptionController =
        TextEditingController(text: widget.descriptionController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Update Screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: 'Enter Updated Task title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText: 'Enter  Updated Task Details',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _updateData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: const Text('Update Task'),
          ),
        ],
      ),
    );
  }
}
