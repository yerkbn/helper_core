import 'dart:async';

import 'package:flutter/material.dart';

class FadeWrapper extends StatefulWidget {
  final Widget child;
  final void Function()? whenCompleted;
  final Duration? closeDuration;

  const FadeWrapper({
    super.key,
    required this.child,
    this.whenCompleted,
    this.closeDuration,
  });

  @override
  State<FadeWrapper> createState() => _FadeWrapperState();
}

class _FadeWrapperState extends State<FadeWrapper> {
  static const Duration _fadeDuration = Duration(milliseconds: 100);
  late final Timer _timer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
    });

    if (widget.closeDuration != null) {
      _timer = Timer(widget.closeDuration!, () async {
        setState(() {
          _visible = false;
        });
        await Future.delayed(_fadeDuration);
        if (widget.whenCompleted != null) {
          widget.whenCompleted!;
        }
      });

      // Future.delayed(widget.closeDuration!, () async {
      //   setState(() {
      //     _visible = false;
      //   });
      //   await Future.delayed(_fadeDuration);
      //   if (widget.whenCompleted != null) widget.whenCompleted!();
      // });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: _fadeDuration,
      child: widget.child,
    );
  }
}
