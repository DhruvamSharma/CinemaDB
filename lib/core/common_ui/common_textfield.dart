import 'package:cinema_db/core/common_constants.dart';
import 'package:cinema_db/core/custom_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField(
      {required this.onChanged,
      this.showIcon = false,
      this.initialValue,
      this.label = CommonConstants.searchTitle,
      Key? key})
      : super(key: key);
  final Function onChanged;
  final bool showIcon;
  final String label;
  final String? initialValue;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    if (widget.initialValue != null) {
      controller = TextEditingController(text: widget.initialValue);
    } else {
      controller = TextEditingController();
    }
    super.initState();
  }

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
          controller: controller,
          onChanged: (_) => widget.onChanged(_),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.label,
            icon: widget.showIcon ? const Icon(Icons.search) : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
