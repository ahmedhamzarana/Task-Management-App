import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_management_app/utils/app_routes.dart';

class ProfileProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  String? userName;
  String? userEmail;
  bool isLoading = false;

  Future<void> fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    isLoading = true;
    notifyListeners();

    try {
      // Fixed: Removed trailing comma in select string
      final profileData = await supabase
          .from("tbl_users")
          .select("id, name, email")
          .eq("user_id", user.id)
          .single();

      // Store the data in provider variables
      userName = profileData['name'];
      userEmail = profileData['email'];

      debugPrint("User Profile Loaded: $profileData");
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "useremail");
    await supabase.auth.signOut();

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
    }
  }
}
