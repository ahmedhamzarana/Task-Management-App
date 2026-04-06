import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchTaskProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  // --- STATE ---
  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- METHODS ---
  Future<void> fetchTasks() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Supabase returns a List<Map<String, dynamic>>
      final List<dynamic> response = await supabase
          .from("tbl_tasks")
          .select("*")
          .eq("user_id", user.id)
          .order("created_at", ascending: false);

      // We cast the dynamic list to our local list
      _tasks = List<Map<String, dynamic>>.from(response);

      debugPrint("Tasks fetched: ${_tasks.length}");
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}