import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/add_task_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_input.dart'; // Ensure correct import for your CustomInput

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddTaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.secondry),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "New Task",
          style: TextStyle(
            color: AppColors.secondry,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- TITLE SECTION ---
            _buildSectionLabel("TASK TITLE"),
            const SizedBox(height: 8),
            CustomInput(
              controller: provider.taskTitleController,
              hintText: "Review Project Roadmap",
              prefixIcon: const Icon(
                Icons.assignment_outlined,
                color: AppColors.primary,
                size: 20,
              ),
            ),

            const SizedBox(height: 24),

            // --- DESCRIPTION SECTION ---
            _buildSectionLabel("DESCRIPTION"),
            const SizedBox(height: 8),
            CustomInput(
              controller: provider.taskDescriptionController,
              hintText: "Add specific details or sub-tasks here...",
              maxLines: 4,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Icon(
                  Icons.notes_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- SCHEDULE SECTION ---
            _buildSectionLabel("SCHEDULE"),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSchedulePicker(
                  context,
                  label: provider.dueDateController.text.isEmpty
                      ? "Date"
                      : provider.dueDateController.text,
                  icon: Icons.calendar_today_rounded,
                  onTap: () => provider.selectDateTime(context),
                ),
                const SizedBox(width: 12),
                _buildSchedulePicker(
                  context,
                  label: provider.timeController.text.isEmpty
                      ? "Time"
                      : provider.timeController.text,
                  icon: Icons.schedule_rounded,
                  onTap: () => provider.selectDateTime(context),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --- PRIORITY LEVEL ---
            _buildSectionLabel("PRIORITY LEVEL"),
            const SizedBox(height: 10),
            Row(
              children: ["Low", "Medium", "High"].map((level) {
                return _buildPriorityButton(provider, level);
              }).toList(),
            ),

            const SizedBox(height: 30),

            // --- CREATE BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  provider.saveTask(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Create Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper UI components inside the same class for cleanliness ---

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: Colors.grey,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSchedulePicker(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE9ECEF)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityButton(AddTaskProvider provider, String level) {
    bool isSelected = provider.priorityController.text == level;

    // Dynamic color mapping
    Map<String, Color> theme = {
      "Low": const Color(0xFF4CAF50),
      "Medium": const Color(0xFF2196F3),
      "High": const Color(0xFFF44336),
    };

    Color color = theme[level]!;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.setPriority(level);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? color.withAlpha(26) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color : const Color(0xFFE9ECEF),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              level,
              style: TextStyle(
                color: isSelected ? color : AppColors.secondry,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
