import 'package:flutter/cupertino.dart';
import 'package:voice/core/views/widgets/shimmer_placeholder.dart';

class ShimmerLoading extends StatelessWidget {
  final double height;
  final int count;
  const ShimmerLoading({super.key, this.height=200, this.count=10});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          count,
              (index) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: height, child: CustomShimmer.squarer())),
    );
  }
}
