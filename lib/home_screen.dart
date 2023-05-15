import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_database_testing_hive/QuickTask.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:local_database_testing_hive/update_screen.dart';

import 'service/notification.dart';

DateTime scheduleTime = DateTime.now();
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box dataBox;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
     tz.initializeTimeZones();
    dataBox = Hive.box('QuickTaskBox');
    
  }

  deleteData(int index) {
    dataBox.deleteAt(index);
  }

  createData() {
    QuickTask newData = QuickTask(
      tasktitle: taskController.text,
      taskdetails: taskDetailsController.text,
    );

    dataBox.add(newData);
  }






 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Task App'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('You have no task'),
            );
          } else {
            return ListView.builder(
              itemCount: dataBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var getData = box.getAt(index);

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8.00, right: 8.00, top: 5.00, bottom: 5.00),
                  child: Column(
                    children: [
                   DatePickerTxt(),
            ScheduleBtn(), Card(
                        color: Colors.yellowAccent,
                        elevation: 5,
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                        
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    index: index,
                                    data: getData,
                                    titleController: getData.tasktitle,
                                    descriptionController: getData.taskdetails,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          title: Text(getData.tasktitle),
                          subtitle: Text(getData.taskdetails),
                          trailing: IconButton(
                            onPressed: () {
                              deleteData(index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewTask(context),
      ),
    );
  }

  addNewTask(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("New Task")),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: taskController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter  your Task Title',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  controller: taskDetailsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter  your Task Details',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      createData();
                
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        
                        ),
                      );
                          
                    },
                    child: const Text("Add Task")),
              ],
            ),
          );
        });
  }
}
class DatePickerTxt extends StatefulWidget {
  const DatePickerTxt({
    Key? key,
  }) : super(key: key);

  @override
  State<DatePickerTxt> createState() => _DatePickerTxtState();
}

class _DatePickerTxtState extends State<DatePickerTxt> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          onChanged: (date) => scheduleTime = date,
          onConfirm: (date) {},
        );
      },
      child: const Text(
        'Select Date Time',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

class ScheduleBtn extends StatelessWidget {
  const ScheduleBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Schedule notifications'),
      onPressed: () {
        debugPrint('Notification Scheduled for $scheduleTime');
        NotificationService().scheduleNotification(
            title: 'Scheduled Notification',
            body: '$scheduleTime',
            scheduledNotificationDateTime: scheduleTime);
      },
    );
  }
}