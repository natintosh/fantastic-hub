import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/views/dashboard/views/widgets/routine_preview.dart';
import 'package:hub/views/routines/views/widgets/create_route_dialog.dart';
import 'package:hub/views/routines/views/widgets/routine_details.dart';

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  List<RoutineDetails> routines =
      List.generate(6, (index) => const RoutineDetails());

  void onCreateRoutineButtonPressed() {
    CreateRouteDialog.showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final content = ListView.separated(
      itemCount: routines.length,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
      separatorBuilder: (context, index) {
        return const Gap(16);
      },
      itemBuilder: (context, index) {
        return routines[index];
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onCreateRoutineButtonPressed,
        label: const Text('Create Routine'),
      ),
      body: content,
    );
  }
}
