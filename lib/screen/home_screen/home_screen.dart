import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/bloc.dart';
import '../../bloc/home/bloc.dart';
import 'achievements_screen.dart';
import 'step_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<AppBloc>().state.user.items!.isEmpty) {
      context.read<AppBloc>().add(const AddAchievement('1'));
    }

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Stepper',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () => context.read<AppBloc>().add(AppLogout()),
                  icon: const Icon(Icons.logout)),
            ),
          ],
        ),
        body: [
          const StepCountScreen(),
          const AchievementsScreen()
        ][state.index],
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
