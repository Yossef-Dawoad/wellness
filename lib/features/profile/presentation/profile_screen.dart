import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wellness/features/workouts_listing/presentations/dashboard_screen.dart';
import 'widgets/bmi_box.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showRatingDialog(BuildContext context) {
    double rating = 3; // initial value
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rating app'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 35,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
            ],
          ),
          actions: [
            TextButton(child: Text('Cancel'), onPressed: () => Navigator.of(context).pop()),
            TextButton(
              child: Text('Done'),
              onPressed: () {
                print("User rated: $rating");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _shareApp() {
    Share.share('https://yourapp.link.here', subject: 'Share App');
  }

  Widget buildBox({required String text, required VoidCallback onTap, required IconData xIcon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 30,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(xIcon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: TextStyle(color: Colors.black, fontSize: 18))),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.black45, size: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainHomeScreen()));
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // create a profile image with a circular border
          // with a modern lool
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Icon(Icons.person, color: Colors.white, size: 50),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back', style: TextStyle(color: Colors.black45, fontSize: 16)),
                    Text('John Doe', style: TextStyle(color: Colors.black, fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          BMiContainer(),
          buildBox(text: 'Rating Us', onTap: () => _showRatingDialog(context), xIcon: Icons.star),
          buildBox(text: 'Share with', onTap: _shareApp, xIcon: Icons.share),
        ],
      ),
    );
  }
}
