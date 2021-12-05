import 'package:cinema_db/core/common_constants.dart';
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
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<Map<String, dynamic>>(CommonConstants.cinemaBoxName)
                .listenable(),
        builder: (context, Box<Map<String, dynamic>> box, widget) {
          return AnimatedList(
            key: listKey,
            initialItemCount: box.length,
            itemBuilder: (_, index, animation) {
              return GestureDetector(
                  onTap: () {
                    listKey.currentState!.removeItem(index,
                        (_, animation) => sizeIt(context, index, animation),
                        duration: const Duration(milliseconds: 500));
                    box.delete(box.keyAt(index));
                  },
                  child: sizeIt(_, index, animation));
            },
          );
        },
      ),
    );
  }

  Widget sizeIt(BuildContext context, int item, animation) {
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
          color: Colors.primaries[item % Colors.primaries.length],
          child: Center(
            child: Text('Item $item', style: textStyle),
          ),
        ),
      ),
    );
  }
}
