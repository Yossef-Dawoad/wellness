import 'package:flutter/material.dart';
import 'package:wellness/features/user_questionnaire/presentation/weight_scale_selector_screen.dart';

import '../../../core/common/services/local_database/shared_pref/shared_pref_helper.dart';
import '../../../core/service_locator/sl.dart';
import '../data/user_questionaire_keys.dart';

class HeightPickerScreen extends StatefulWidget {
  @override
  _HeightPickerScreenState createState() => _HeightPickerScreenState();
}

class _HeightPickerScreenState extends State<HeightPickerScreen> {
  final ScrollController _controller = ScrollController();
  double selectedHeight = 136.0;
  bool isCm = true;

  @override
  void initState() {
    super.initState();
    // Set initial scroll
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo((selectedHeight - 100) * 20);
    });
  }

  void _onScroll() {
    double newHeight = (_controller.offset / 20) + 100;
    setState(() {
      selectedHeight = double.parse(newHeight.toStringAsFixed(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(_onScroll);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Text('Your height', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isCm = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: isCm ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('cm', style: TextStyle(color: isCm ? Colors.white : Colors.black)),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isCm = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: !isCm ? Colors.green : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('ft', style: TextStyle(color: !isCm ? Colors.white : Colors.black)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.builder(
                  controller: _controller,
                  itemExtent: 20,
                  itemCount: 200,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CustomPaint(painter: RulerPainter(), child: Container());
                  },
                ),
                // الخط والمؤشر في النص
                Positioned(left: 50, child: Icon(Icons.arrow_right, size: 40, color: Colors.green)),
                Positioned(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${selectedHeight.toStringAsFixed(1)} ${isCm ? 'cm' : 'ft'}",
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Continue', style: TextStyle(fontSize: 18)),
              onPressed: () {
                // Action when continue
                sl<SharedPrefHelper>().setValue<double>(
                  UserQuestionaireKeys.height,
                  selectedHeight,
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => WeightScalePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter لرسم المسطرة
class RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1;

    for (int i = 0; i <= size.height ~/ 20; i++) {
      double y = i * 20.0;
      double lineLength = (i % 5 == 0) ? 30 : 15;
      canvas.drawLine(Offset(0, y), Offset(lineLength, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
