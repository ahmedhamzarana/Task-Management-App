import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final String priority;
  final String status;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Split safely to avoid RangeError
    List<String> timeParts = time.split(" ");
    String hourPart = timeParts.isNotEmpty ? timeParts[0] : "--:--";
    String amPmPart = timeParts.length > 1 ? timeParts[1] : "";

    return Container(
      // --- FIXED HEIGHT HERE ---
      height: 180, 
      // -------------------------
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
          // Left: The Time Column
          Column(
            children: [
              Text(
                hourPart,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondry,
                  letterSpacing: -0.5,
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
              // Use Expanded here so the line stretches exactly to the available space
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

          // Right: Content Details
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
                        letterSpacing: 1.1,
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondry,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                // Description with constrained height
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondry.withAlpha(150),
                    height: 1.5,
                  ),
                ),
                
                // This pushes the Status Row to the very bottom of the fixed height
                const Spacer(),

                // Bottom Status Row
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sync, size: 14, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isHigh ? AppColors.primary.withAlpha(25) : AppColors.info.withAlpha(25),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: isHigh ? AppColors.primary : AppColors.info,
        ),
      ),
    );
  }
}