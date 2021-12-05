import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/common_ui/common_textfield.dart';
import 'package:cinema_db/features/cinema/data/model/movie_model.dart';
import 'package:cinema_db/features/cinema/domain/entity/movie_entity.dart';
import 'package:cinema_db/features/cinema/presentation/pages/movie_creation_route.dart';
import 'package:cinema_db/features/cinema/presentation/widgets/movie_item.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: CommonConstants.equalPadding * 2 - 10,
                top: CommonConstants.equalPadding * 6,
              ),
              child: Text(
                CommonConstants.homeTitle,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: CommonConstants.equalPadding,
                top: CommonConstants.equalPadding,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 2 * MediaQuery.of(context).size.width / 3,
                    child: CommonTextField(
                      onChanged: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MovieCreationRoute.routeName);
                        },
                        icon: const Icon(Icons.create)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                CommonConstants.equalPadding,
              ),
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Map<dynamic, dynamic>>(
                        CommonConstants.cinemaBoxName)
                    .listenable(),
                builder: (context, Box<Map<dynamic, dynamic>> box, widget) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 10.0),
                    itemBuilder: (_, index) {
                      final item = box.getAt(index);
                      final movieEntity = MovieModel.from(item!);
                      return _sizeIt(_, movieEntity);
                    },
                    itemCount: box.keys.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizeIt(
    BuildContext context,
    MovieEntity item,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovieCreationRoute.routeName);
      },
      child: MovieItem(data: item),
    );
  }
}
