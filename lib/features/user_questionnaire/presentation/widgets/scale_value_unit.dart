import 'package:flutter/material.dart';

class ScaleValueUnit extends StatelessWidget {
  const ScaleValueUnit({
    super.key,
    required this.scaleValueNotifier,
    required this.isKgSelectedNotifier,
  });

  final ValueNotifier<int> scaleValueNotifier;
  final ValueNotifier<bool> isKgSelectedNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: scaleValueNotifier,
        builder: (context, value, child) {
          return ValueListenableBuilder<bool>(
            valueListenable: isKgSelectedNotifier,
            builder: (context, isKgSelected, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value.toString(),
                    style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      isKgSelected ? 'kg' : 'lb',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
