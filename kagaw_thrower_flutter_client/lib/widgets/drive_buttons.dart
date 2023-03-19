import 'dart:async';

import 'package:flutter/material.dart';

class DriveButton extends StatefulWidget {
  const DriveButton({super.key, required this.onTapOrHold, required this.icon});

  final VoidCallback onTapOrHold;

  final IconData icon;

  @override
  State<DriveButton> createState() => _DriveButtonState();
}

class _DriveButtonState extends State<DriveButton> {
  bool _isHolding = false;

  _onHoldStart() async {
    if (_isHolding) return;

    _isHolding = true;

    while (_isHolding) {
      widget.onTapOrHold();
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  _onHoldStop() async {
    _isHolding = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onHoldStop(),
      onTapDown: (_) => _onHoldStart(),
      onTapUp: (_) => _onHoldStop(),
      child: Icon(widget.icon),
    );
  }
}


