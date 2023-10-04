import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepper/model/achievement.dart';
import 'package:stepper/widgets/pop_up.dart';

import '../../bloc/app/bloc.dart';
import '../../repository.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: StreamBuilder(
        stream: Repository().fetchItems(),
        builder: streamBuilder,
      ),
    ));
  }

  Widget streamBuilder(context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Achievement> list = snapshot.data as List<Achievement>;

    if (list.isEmpty) {
      return const Center(
        child: Text('You have not any achivements yet'),
      );
    }

    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return GridView.builder(
          itemCount: list.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 16 / 4, crossAxisCount: 1, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PopUpDialog(
                      title: list[index].name,
                      descriptions: list[index].description,
                      img_url: list[index].photo!,
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: state.user.items!.contains(list[index].id)
                      ? Colors.grey[200]
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            foregroundDecoration: state.user.items!
                                    .contains(list[index].id)
                                ? null
                                : const BoxDecoration(
                                    color: Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            height: 55,
                            width: 55,
                            child: Image.network(list[index].photo!),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            list[index].name,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
