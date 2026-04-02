import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/custom_input.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bglight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: AppColors.bglight,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.bglight,
          child: Column(children: [
            CustomInput(controller: TextEditingController(), hintText: "Title"),
            CustomInput(controller: TextEditingController(), hintText: "Description"),
            CustomInput(controller: TextEditingController(), hintText: "Due Date"),
            CustomInput(controller: TextEditingController(), hintText: "Time"),
            CustomInput(controller: TextEditingController(), hintText: "Priority"),
            CustomInput(controller: TextEditingController(), hintText: "Status"),
          ]),
        ),
      ),
    );
  }
}
