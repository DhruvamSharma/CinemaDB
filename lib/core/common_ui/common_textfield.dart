import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({required this.onChanged, Key? key}) : super(key: key);
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.textFieldContainerColor,
        borderRadius: BorderRadius.circular(CommonConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: CommonConstants.equalPadding),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
