import 'package:flutter/material.dart';
import 'package:to_do_riverpod/utils/utils.dart';

class CommonContainer extends StatelessWidget {
  final Widget? child;
  final double? height;

  const CommonContainer({
    super.key,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return Container(
      width: deviceSize.width,
      height: deviceSize.height * height!,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.primaryContainer,
      ),
      child: child,
    );
  }
}
