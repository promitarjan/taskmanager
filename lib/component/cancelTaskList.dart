import 'package:flutter/material.dart';
import '../Style/Style.dart';
import '../api/apiClient.dart';
import 'TaskList.dart';

class cancelTaskList extends StatefulWidget {
  const cancelTaskList({super.key});
  @override
  State<cancelTaskList> createState() => _cancelTaskListState();
}

class _cancelTaskListState extends State<cancelTaskList> {
  List TaskItems = [];
  bool Loading = true;
  String Status = "Canceled";

  @override
  void initState() {
    CallData();
    super.initState();
  }

  CallData() async {
    var data = await TaskListRequest("Canceled");
    setState(() {
      Loading = false;
      TaskItems = data;
    });
  }

  UpdateStatus(id) async {
    setState(() {
      Loading = true;
    });
    await TaskUpdateRequest(id, Status);
    await CallData();
    setState(() {
      Status = "Canceled";
    });
  }

  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete !"),
            content: const Text("Onece delete, you can't get it back"),
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      Loading = true;
                    });
                    await TaskDeleteRequest(id);
                    await CallData();
                  },
                  child: const Text('Yes')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  StatusChange(id) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(30),
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: const Text("New"),
                    value: "New",
                    groupValue: Status,
                    onChanged: (value) {
                      setState(() {
                        Status = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Progress"),
                    value: "Progress",
                    groupValue: Status,
                    onChanged: (value) {
                      setState(() {
                        Status = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Completed"),
                    value: "Completed",
                    groupValue: Status,
                    onChanged: (value) {
                      setState(() {
                        Status = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Canceled"),
                    value: "Canceled",
                    groupValue: Status,
                    onChanged: (value) {
                      setState(() {
                        Status = value.toString();
                      });
                    },
                  ),
                  ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Confirm'),
                    onPressed: () {
                      Navigator.pop(context);
                      UpdateStatus(id);
                    },
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Loading
        ? (const Center(child: CircularProgressIndicator()))
        : RefreshIndicator(
            onRefresh: () async {
              await CallData();
            },
            child: TaskList(TaskItems, DeleteItem, StatusChange));
  }
}