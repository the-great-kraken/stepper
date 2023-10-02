import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepper/bloc/step/bloc.dart';

import '../../bloc/auth/bloc.dart';
import '../../bloc/home/bloc.dart';
import 'achivements_screen.dart';
import 'step_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Stepper'),
          actions: [
            IconButton(
                onPressed: () => context.read<AppBloc>().add(AppLogout()),
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: [const StepCountScreen(), const AchivementsScreen()][state.index],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) =>
              context.read<HomeBloc>().add(TabChange(index)),
          indicatorColor: Theme.of(context).colorScheme.inversePrimary,
          selectedIndex: state.index,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.emoji_events),
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Awards',
            ),
          ],
        ),
      );
    });
  }
}
