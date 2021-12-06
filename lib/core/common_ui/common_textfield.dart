import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {required this.onChanged,
      this.showIcon = false,
      this.label = CommonConstants.searchTitle,
      Key? key})
      : super(key: key);
  final Function onChanged;
  final bool showIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.textFieldContainerColor,
        borderRadius: BorderRadius.circular(CommonConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: CommonConstants.equalPadding),
        child: TextField(
          onChanged: (_) => onChanged(_),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            icon: showIcon ? const Icon(Icons.search) : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
