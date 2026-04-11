import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/fetch_task_provider.dart';
import 'package:task_management_app/providers/profile_provider.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/utils/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchUserProfile();
      context.read<FetchTaskProvider>().fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes in the provider
    final profileProvider = Provider.of<ProfileProvider>(context);
    final taskProvider = Provider.of<FetchTaskProvider>(context);
    final String initial =
        (profileProvider.userName != null &&
            profileProvider.userName!.isNotEmpty)
        ? profileProvider.userName![0].toUpperCase()
        : "U";

    return Scaffold(
      backgroundColor: AppColors.bglight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.appmainRoute),
            ),
            const SizedBox(width: 10),
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: profileProvider.isLoading
          ? const LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.bglight,
              minHeight: 1,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.bglight,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondry.withAlpha(80),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: AppColors.primary.withAlpha(150),
                            child: Text(
                              initial,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profileProvider.userName ?? "User Name",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          profileProvider.userEmail ?? "N/A",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- STATS ROW ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatCard(
                          "${taskProvider.tasks.length}",
                          "Tasks",
                          AppColors.success,
                        ),
                        _buildStatCard(
                          "${taskProvider.tasks.where((t) => t['status'] == 'Completed').length}",
                          "Completed",
                          AppColors.info,
                        ),
                        _buildStatCard(
                          "${taskProvider.tasks.where((t) => t['status'] == 'Pending').length}",
                          "Pending",
                          AppColors.danger,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- ACCOUNT INFO SECTION ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Account Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondry,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoTile(
                          Icons.person_outline,
                          "Name",
                          profileProvider.userName ?? "N/A",
                        ),
                        const SizedBox(height: 16),
                        _buildInfoTile(
                          Icons.email_outlined,
                          "Email",
                          profileProvider.userEmail ?? "N/A",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- LOGOUT BUTTON ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => profileProvider.logout(context),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  // Helper methods to keep the build method clean
  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(80), width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withAlpha(180),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.info.withAlpha(30),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.info.withAlpha(60)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondry.withAlpha(150),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondry,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
