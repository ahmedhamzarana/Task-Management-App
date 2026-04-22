import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditTaskProvider extends ChangeNotifier {
  static final supabase = Supabase.instance.client;

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  bool isLoading = false;

  void loadTaskData(Map<String, dynamic> task) {
    taskTitleController.text = task['title'] ?? '';
    taskDescriptionController.text = task['description'] ?? '';
    dueDateController.text = task['due_date'] ?? '';
    timeController.text = task['time'] ?? '';
    priorityController.text = task['priority'] ?? '';
    statusController.text = task['status'] ?? '';
    notifyListeners();
  }

  // UPDATED: Set a specific status from a dropdown
  Future<void> updateStatus(String taskId, String newStatus) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase
          .from("tbl_tasks")
          .update({"status": newStatus})
          .eq("id", taskId)
          .eq("user_id", user.id);

      statusController.text =
          newStatus; // Update controller if on Detail Screen
      debugPrint("Task $taskId status updated to: $newStatus");
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating status: $e");
    }
  }

  // Keep your existing updateTask for the "Save Changes" button
  Future<void> updateTask(BuildContext context, String taskId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase
          .from("tbl_tasks")
          .update({
            "title": taskTitleController.text,
            "description": taskDescriptionController.text,
            "due_date": dueDateController.text,
            "time": timeController.text,
            "priority": priorityController.text,
            "status": statusController.text,
          })
          .eq("id", taskId)
          .eq("user_id", user.id);

      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint("Error updating task: $e");
    }
  }

  Future<void> deleteTask(BuildContext context, String taskId) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase
          .from("tbl_tasks")
          .delete()
          .eq("id", taskId)
          .eq("user_id", user.id);

      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      debugPrint("Error deleting task: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Error deleting task")));
      }
    }
  }
}
