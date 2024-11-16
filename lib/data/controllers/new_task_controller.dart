import 'package:get/get.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/models/task_list_model.dart';
import 'package:taskmanager/data/models/task_model.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/utils/urls.dart';

class NewTaskController extends GetxController {
  String? _errorMessage;
  bool _isLoading = false;
  List<TaskModel> _newTaskList = [];

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _newTaskList.clear();
    _isLoading = true;
    update();

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getNewTaskList);
    if (response.isSuccess) {
      TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    update();
    return isSuccess;
  }
}
