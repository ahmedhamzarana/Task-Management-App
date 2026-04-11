import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class AddTaskProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  DateTime? _rawDate;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      _rawDate = pickedDate;
      dueDateController.text = DateFormat('E MMM d, y').format(pickedDate);

      if (context.mounted) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          final now = DateTime.now();
          final dt = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          timeController.text = DateFormat('h:mm a').format(dt);
        }
      }
      notifyListeners();
    }
  }

  bool validateInputs() {
    return taskTitleController.text.isNotEmpty &&
        dueDateController.text.isNotEmpty &&
        timeController.text.isNotEmpty;
  }

  Future<void> saveTask(BuildContext context) async {
    if (!validateInputs()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter Title, Date, and Time")),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final user = _supabase.auth.currentUser;

      await _supabase.from('tbl_tasks').insert({
        'user_id': user?.id,
        'title': taskTitleController.text.trim(),
        'description': taskDescriptionController.text.trim(),
        'due_date': _rawDate?.toIso8601String(),
        'display_date': dueDateController.text,
        'time': timeController.text,
        'priority': priorityController.text.isEmpty
            ? "Medium"
            : priorityController.text,
        'status': statusController.text.isEmpty
            ? "Pending"
            : statusController.text,
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task Synced successfully!")),
        );
        Navigator.pushNamed(context, "/appmain");
        clearInputs();
      }
    } catch (e) {
      debugPrint("Error saving task: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearInputs() {
    taskTitleController.clear();
    taskDescriptionController.clear();
    dueDateController.clear();
    timeController.clear();
    priorityController.clear();
    statusController.clear();
    _rawDate = null;
    notifyListeners();
  }

  void setPriority(String level) {
    priorityController.text = level;
    notifyListeners();
  }
}
