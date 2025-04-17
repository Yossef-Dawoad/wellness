import 'package:flutter/material.dart';

class UnitToggleButton extends StatelessWidget {
  const UnitToggleButton({super.key, required this.isKgSelectedNotifier});
  final ValueNotifier<bool> isKgSelectedNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: ValueListenableBuilder<bool>(
          valueListenable: isKgSelectedNotifier,
          builder: (context, isKgSelected, _) {
            return Row(
              children: [
                // kg toggle
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isKgSelected) {
                        isKgSelectedNotifier.value = true;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isKgSelected ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: isKgSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // lb toggle
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isKgSelected) {
                        isKgSelectedNotifier.value = false;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isKgSelected ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'lb',
                          style: TextStyle(
                            color: !isKgSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
