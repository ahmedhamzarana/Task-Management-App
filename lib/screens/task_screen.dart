import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/add_task_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_input.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddTaskProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.bglight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "New Task",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is to be done?",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            CustomInput(
              controller: provider.taskTitleController,
              hintText: "Enter task title",
              prefixIcon: const Icon(
                Icons.check_box_outlined,
                color: AppColors.primary,
              ),
            ),
            CustomInput(
              controller: provider.taskDescriptionController,
              hintText: "Add notes...",
              prefixIcon: const Icon(Icons.notes, color: AppColors.primary),
            ),

            const SizedBox(height: 15),
            const Text(
              "Schedule",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => provider.selectDateTime(context),
                    child: IgnorePointer(
                      child: CustomInput(
                        controller: provider.dueDateController,
                        hintText: "Set Date",
                        prefixIcon: const Icon(
                          Icons.calendar_month,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => provider.selectDateTime(context),
                    child: IgnorePointer(
                      child: CustomInput(
                        controller: provider.timeController,
                        hintText: "Set Time",
                        prefixIcon: const Icon(
                          Icons.access_time_filled,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            CustomInput(
              controller: provider.priorityController,
              hintText: "Set Priority",
              prefixIcon: const Icon(
                Icons.outlined_flag,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 40),

            // Gradient "Add to Calendar" Button
            GestureDetector(
              onTap: provider.isLoading
                  ? null
                  : () => provider.saveTask(context),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondry],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withAlpha(100),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: provider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "CREATE TASK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
