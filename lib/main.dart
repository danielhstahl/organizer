import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'blocs/house_objects/house_object_events.dart';
import 'services/firestore.dart';
import 'blocs/house_objects/house_object_bloc.dart';
import 'blocs/house_objects/house_object_state.dart';
import 'components/house_object_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'blocs/simple_bloc_observer.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firestore Demo app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<HouseObjectBloc>(
            create: (context) {
              return HouseObjectBloc(
                houseObjectRepository: HouseObjectRepositoryFirestore(),
              )..add(HouseObjectLoad());
            },
            child: MyHomePage(title: 'Flutter Demo Home Page')));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: BlocBuilder<HouseObjectBloc, HouseObjectState>(
          builder: (context, data) {
            if (data is HouseObjectLoadInProgress) {
              return CircularProgressIndicator();
            } else if (data is HouseObjectLoadSuccess) {
              return HouseObjectList(houseObjects: data.data);
            } else {
              return Text("Should never get here");
            }
          },
        ),
      ),
    );
  }
}
