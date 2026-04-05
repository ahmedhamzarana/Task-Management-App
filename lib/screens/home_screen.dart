import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/add_task_provider.dart';
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
    // This runs ONLY ONCE when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final taskProvider = Provider.of<AddTaskProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bglight,
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.bglight,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.secondry],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondry.withAlpha(20),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${profileProvider.userName ?? "User"}!",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.bglight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.success.withAlpha(25),
                                border: Border.all(
                                  color: AppColors.success.withAlpha(60),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "10",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "All Tasks",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.info.withAlpha(25),
                                border: Border.all(
                                  color: AppColors.info.withAlpha(60),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "10",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.info,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Completed Tasks",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.info,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.danger.withAlpha(25),
                                border: Border.all(
                                  color: AppColors.danger.withAlpha(60),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "5",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.danger,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Pending Tasks",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.danger,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: TaskCard(
                    title: "Design Landing Page",
                    description:
                        "Create a responsive landing page for the new product launch.",
                    date: "2024-06-15",
                    time: "2024-06-15 14:00",
                    priority: "High",
                    status: "Pending",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
