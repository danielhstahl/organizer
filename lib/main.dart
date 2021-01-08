import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organizeit/blocs/nav_bar/nav_bar_bloc.dart';
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
        home: MultiBlocProvider(providers: [
          BlocProvider<HouseObjectBloc>(
            create: (context) {
              return HouseObjectBloc(
                houseObjectRepository: HouseObjectRepositoryFirestore(),
              )..add(HouseObjectLoad());
            },
          ),
          BlocProvider(
            create: (_) => NavBarCubit(),
          )
        ], child: MyHomePage(title: 'Flutter Demo Home Page')));
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
        actions: <Widget>[
          DropdownButton<String>(
            value: 'One',
            //icon: const Icon(Icons.more),
            //iconSize: 24,
            //elevation: 16,
            //style: TextStyle(color: Colors.deepPurple),
            //underline: Container(
            //  height: 2,
            //  color: Colors.deepPurpleAccent,
            //),
            onChanged: (String newValue) {
              print(newValue);
            },
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          /*PopupMenuButton<int>(
            icon: const Icon(Icons.more),
            tooltip: 'Choose house',
            onSelected: (int result) {
              print(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Working a lot harder'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Being a lot smarter'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Being a self-starter'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Placed in charge of trading charter'),
              ),
            ],
          )*/
        ],
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
      bottomNavigationBar:
          BlocBuilder<NavBarCubit, int>(builder: (context, data) {
        return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: data,
            selectedItemColor: Colors.amber[800],
            onTap: (index) => context.read<NavBarCubit>().set(index));
      }),
    );
  }
}
