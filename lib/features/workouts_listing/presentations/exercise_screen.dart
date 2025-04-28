import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
      ),
      body: SafeArea(child: 
      Column(
        children: [
          Row(
            children: [
              Text('Target Muscle'),
              SizedBox(width: 5,),
              Text('Exercise Name'),
            ],
          ),
          SizedBox(height: 10,),
          Image.asset(
            'images/gif1.gif',
            height: 125,
            width: 200,
          ),
          // Placeholder(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
            onPressed: (){},
             child: Text('Start'),
          ),
              ElevatedButton(
                onPressed: (){},
                 child: Text('Instructions'),
              ),
            ],
          ),
          Spacer(flex: 1,),
          Container(

            decoration: BoxDecoration(
              color: Colors.blueAccent
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new)),
                Row(
                  children: [
                    Text('00:58'),
                    IconButton(onPressed: (){}, icon: Icon(Icons.square)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.pause)),
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
              ],
            ),
          )
        ],
      )),
    );
  }
}