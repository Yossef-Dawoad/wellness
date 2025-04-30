import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/features/workouts_listing/datasources/exercice_model.dart';
import 'package:wellness/features/workouts_listing/datasources/exercices_service.dart';
import 'package:wellness/features/workouts_listing/datasources/exerice_repo.dart';
import 'package:wellness/features/workouts_listing/logic/bloc/exerices_bloc.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _exericeBloc = ExericesBloc(ExericeRepository(exericeService: RapidAPIExerciseDB()));
    final exerciseByName = ModalRoute.of(context)!.settings.arguments as Exercise;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
      ),
      body: BlocProvider(
        create: (context) => _exericeBloc..add(FetchExercisesByName(exerciseByName.name)),
        child:BlocBuilder<ExericesBloc, ExericesState>(
          buildWhen: (previous, current) => 
                current is FetchExerciseByNameLoadInSuccess ||
                current is ExericesError ||
                current is FetchExerciseByNameLoadInProgress,
          builder: (context, state){
            if (state is FetchExerciseByNameLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if(state is ExericesError){
              return Center(child: Text('Error: ${state.message}'));
            } else {

            
            return SafeArea(child: 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
          child: Column(
            children: [
              Text('00:58', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Image.network(
                exerciseByName.gifUrl,
                height: 250,
                width: double.infinity,
              ),
              // Placeholder(),
              //Buttons
              
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(exerciseByName.target.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        SizedBox(width: 8,),
                        Text(exerciseByName.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                        IconButton(onPressed: (){
                          showModalBottomSheet(
                            context: context, 
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height/3,
                                // color: Colors.amberAccent,
                                child: ListView.builder(
                                  itemCount: exerciseByName.instructions.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(exerciseByName.instructions[index], maxLines: 2,),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },);
                        }, icon: Icon(Icons.error, color: Colors.blue,))
                  ],
                ),
              ),
        
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_back, color: Colors.white,size: 24,), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),),
                    ),
                  ),
              
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                        onPressed: (){},
                         child: Icon(Icons.pause, color: Colors.white,size: 24,),
                         style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        minimumSize: Size(MediaQuery.of(context).size.width/2, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      ),
                    ),
                  ),
                ],
              ),
        
              Spacer(),
        
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Placeholder(fallbackWidth: 30,),
                        SizedBox(width: 6,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Next', style: TextStyle(color: Colors.white70, fontSize: 12),),
                            Text('Rest Time', style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 32,))
                  ],
                ),
              )
              
            ],
          ),
        ),
        
        );
          }
          }
        )
      ),
    );
  }
}

