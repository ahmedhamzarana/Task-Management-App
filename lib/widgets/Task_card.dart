import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String priority;
  final String status;
  final VoidCallback? onStatusToggle; // Rename for clarity

  const TaskCard({
    super.key,
    required this.onStatusToggle,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    List<String> timeParts = time.split(" ");
    String hourPart = timeParts.isNotEmpty ? timeParts[0] : "--:--";
    String amPmPart = timeParts.length > 1 ? timeParts[1] : "";

    bool isCompleted = status.toLowerCase() == 'completed';

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bglight,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondry.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.info.withAlpha(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Column
          Column(
            children: [
              Text(
                hourPart,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isCompleted ? Colors.grey : AppColors.secondry,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              if (amPmPart.isNotEmpty)
                Text(
                  amPmPart,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: AppColors.info.withAlpha(40),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.info,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildPriorityTag(priority),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.grey : AppColors.secondry,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const Spacer(),

                // Status Row
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? Colors.green.withAlpha(30)
                        : AppColors.primary.withAlpha(15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle_outline : Icons.sync,
                        size: 14,
                        color: isCompleted ? Colors.green : AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          color: isCompleted ? Colors.green : AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onStatusToggle,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            isCompleted
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            size: 20,
                            color: isCompleted
                                ? Colors.green
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityTag(String priority) {
    bool isHigh = priority.toLowerCase() == 'high';
    bool isMedium = priority.toLowerCase() == 'medium';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isHigh
            ? AppColors.primary.withAlpha(25)
            : isMedium
            ? AppColors.success.withAlpha(25)
            : AppColors.info.withAlpha(25),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: isHigh
              ? AppColors.primary
              : isMedium
              ? AppColors.success
              : AppColors.info,
        ),
      ),
    );
  }
}
