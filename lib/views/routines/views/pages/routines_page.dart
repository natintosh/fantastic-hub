import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hub/__core__/components/views/widgets/app_rounded_container.dart';
import 'package:hub/views/routines/models/data/routine.dart';
import 'package:hub/views/routines/viewmodels/routine_viewmodel.dart';
import 'package:hub/views/routines/views/widgets/create_route_dialog.dart';
import 'package:hub/views/routines/views/widgets/routine_details.dart';
import 'package:provider/provider.dart';

class RoutinesPage extends StatefulWidget with AutoRouteWrapper {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoutineViewModel(),
      child: this,
    );
  }
}

class _RoutinesPageState extends State<RoutinesPage> {
  late final RoutineViewModel viewModel;

  @override
  void initState() {
    viewModel = context.read<RoutineViewModel>();
    viewModel.getAllRoutine();
    super.initState();
  }

  Future<void> onCreateRoutineButtonPressed() async {
    final routine = await CreateRouteDialog.showDialog(
      context,
      viewModel: viewModel,
    );
    if (routine != null) {
      viewModel.addRoutine(routine);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Routine>>(
        stream: viewModel.routineStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];

          return ListView.separated(
            itemCount: data.length,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
            separatorBuilder: (context, index) {
              return const Gap(16);
            },
            itemBuilder: (context, index) {
              return AppRoundedContainer(
                child: RoutineDetails(
                  routine: data[index],
                ),
              );
            },
          );
        });

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
