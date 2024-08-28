import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:to_do_riverpod/utils/utils.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;

  const CommonTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),
        TextField(
          readOnly: readOnly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
