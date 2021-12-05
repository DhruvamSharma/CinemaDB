import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/features/cinema/data/model/movie_model.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CinemaListingRoute extends StatefulWidget {
  const CinemaListingRoute({Key? key}) : super(key: key);
  static const String routeName = 'yellow-class_app_cinema-listing';

  @override
  State<CinemaListingRoute> createState() => _CinemaListingRouteState();
}

class _CinemaListingRouteState extends State<CinemaListingRoute> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.pushNamed(context, MovieCreationRoute.routeName);
        final keys =
            Hive.box<Map<dynamic, dynamic>>(CommonConstants.cinemaBoxName).keys;
        listKey.currentState?.insertItem(keys.length - 1);
      }),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<Map<dynamic, dynamic>>(CommonConstants.cinemaBoxName)
                .listenable(),
        builder: (context, Box<Map<dynamic, dynamic>> box, widget) {
          return AnimatedList(
            key: listKey,
            initialItemCount: box.keys.length,
            itemBuilder: (_, index, animation) {
              final item = box.getAt(index);
              final movieEntity = MovieModel.from(item!);
              return GestureDetector(
                  onTap: () {
                    listKey.currentState!.removeItem(
                        index,
                        (_, animation) =>
                            sizeIt(context, movieEntity, animation),
                        duration: const Duration(milliseconds: 500));
                    box.delete(box.keyAt(index));
                  },
                  child: sizeIt(_, movieEntity, animation));
            },
          );
        },
      ),
    );
  }

  Widget sizeIt(BuildContext context, MovieEntity item, animation) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline4;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: SizedBox(
        // Actual widget to display
        height: 128.0,
        child: Card(
          child: Center(
            child: Text('Item ${item.name}', style: textStyle),
          ),
        ),
      ),
    );
  }
}
