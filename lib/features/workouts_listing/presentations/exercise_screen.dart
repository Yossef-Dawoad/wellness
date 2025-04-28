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
          Placeholder(

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: (){},
                 child: Text('Next Excercise'),
              ),
              ElevatedButton(
                onPressed: (){},
                 child: Text('Instructions'),
              ),
            ],
          ),
          Spacer(flex: 1,),
          ElevatedButton(
            onPressed: (){},
             child: Text('Start'),
          ),
          Spacer(flex: 2,),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new)),
              Text('00:58'),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
            ],
          )
        ],
      )),
    );
  }
}