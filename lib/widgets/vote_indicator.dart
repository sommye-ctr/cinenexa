import 'package:flutter/material.dart';

class VoteIndicator extends StatelessWidget {
  final double vote;
  const VoteIndicator({
    Key? key,
    required this.vote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: double.parse((vote / 10).toStringAsFixed(1)),
          strokeWidth: 1,
          backgroundColor: Theme.of(context).hintColor,
        ),
        Text("${(vote * 10).toInt()}")
      ],
    );
  }
}
