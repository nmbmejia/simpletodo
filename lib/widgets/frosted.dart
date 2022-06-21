import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FrostedGlass extends StatefulWidget {
  const FrostedGlass(
      {Key? key,
      required this.width,
      required this.height,
      required this.innerWidget})
      : super(key: key);

  final double width;
  final double height;
  final Widget innerWidget;

  @override
  State<FrostedGlass> createState() => _FrostedGlassState();
}

class _FrostedGlassState extends State<FrostedGlass> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: widget.innerWidget)),
      ),
    );
  }
}
