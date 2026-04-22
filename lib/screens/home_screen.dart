import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/edit_task_provider.dart';
import 'package:task_management_app/providers/fetch_task_provider.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/providers/profile_provider.dart';
import 'package:task_management_app/utils/app_routes.dart';
import 'package:task_management_app/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();
      Provider.of<FetchTaskProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final taskProvider = Provider.of<FetchTaskProvider>(context);
    final tasks = taskProvider.tasks;
    return Scaffold(
      backgroundColor: AppColors.bglight,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Task Sync",
          style: TextStyle(
            color: AppColors.bglight,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.profileRoute),
              child: SizedBox(
                height: 25,
                child: CircleAvatar(
                  backgroundColor: AppColors.bglight,
                  child: Text(
                    profileProvider.userName != null &&
                            profileProvider.userName!.isNotEmpty
                        ? profileProvider.userName![0].toUpperCase()
                        : "U",
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.primary,
      ),
      body: taskProvider.isLoading
          ? const LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.bglight,
              minHeight: 1,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  // --- HEADER STATS CONTAINER ---
                  _buildHeaderStats(profileProvider, tasks),

                  const SizedBox(height: 20),

                  // --- TASK LIST SECTION ---
                  Expanded(
                    child: // Show loader
                    tasks.isEmpty
                        ? const Center(
                            child: Text("No tasks found"),
                          ) // Show empty state
                        : GridView.builder(
                            itemCount: tasks.length, // Dynamic count
                            padding: const EdgeInsets.only(bottom: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width / 200,
                                ),
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskCard(
                                title: task["title"] ?? "No Title",
                                description:
                                    task["description"] ?? "No Description",
                                date: task["display_date"] ?? "No Date",
                                time: task["time"] ?? "00:00 AM",
                                priority: task["priority"] ?? "Low",
                                status: task["status"] ?? "Pending",
                                onStatusToggle: () async {
                                  // 1. Perform the update
                                  await context
                                      .read<EditTaskProvider>()
                                      .updateStatus(
                                        task['id'].toString(),
                                        task['status'],
                                      );

                                  // 2. Refresh the list so the UI shows the new data
                                  if (context.mounted) {
                                    context
                                        .read<FetchTaskProvider>()
                                        .fetchTasks();
                                  }
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

  // Refactored Header for clarity
  Widget _buildHeaderStats(ProfileProvider profile, List tasks) {
    // Basic logic to calculate stats (you can move this to provider later)
    int completed = tasks.where((t) => t['status'] == 'Completed').length;
    int pending = tasks.where((t) => t['status'] == 'Pending').length;

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondry],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Hi, ${profile.userName ?? "User"}!",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _statBox("All", "${tasks.length}", AppColors.success),
              const SizedBox(width: 10),
              _statBox("Done", "$completed", AppColors.info),
              const SizedBox(width: 10),
              _statBox("Pending", "$pending", AppColors.danger),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Expanded(
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
