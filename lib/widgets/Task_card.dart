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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bglight,
        borderRadius: BorderRadius.circular(24), // Softer, more premium radius
        boxShadow: [
          BoxShadow(
            color: AppColors.secondry.withAlpha(20), // Subtle shadow
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        // Subtle border to define the card against bglight
        border: Border.all(color: AppColors.info.withAlpha(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: The Time Column
          Column(
            children: [
              Text(
                time.split(" ")[0],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondry,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                time.split(" ")[1],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              // Vertical timeline accent
              Container(
                width: 3,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.info.withAlpha(40),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondry,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.secondry.withAlpha(150), // Faded text
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                
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
                )
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
        // Using Alpha for the tinted background effect
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