import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onClick;
  const CustomBackButton({
    Key? key,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkResponse(
          splashColor: Theme.of(context).colorScheme.primary,
          highlightColor: Theme.of(context).colorScheme.primary,
          onTap: () {
            onClick?.call();
            Navigator.maybePop(context);
          },
          child: Container(
            color: Colors.white.withOpacity(0.5),
            height: 50,
            width: 50,
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
    );
  }
}
