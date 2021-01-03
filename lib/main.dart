import 'package:flutter/material.dart';
import 'services/firestore.dart';
import 'blocs/house_objects/house_object_bloc.dart';
import 'blocs/house_objects/house_object_state.dart';
import 'components/house_object_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
      home: RepositoryProvider<HouseObjectRepository>(
        create: (context) => HouseObjectRepositoryFirestore()..refresh(),
        child: BlocProvider(
            create: (context) =>
                HouseObjectBloc(repository: RepositoryProvider.of(context)),
            child: MyHomePage(title: 'Flutter Demo Home Page')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HouseObjectBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context); //BlocProvider.of<TipBloc>(context);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<HouseObjectBloc, HouseObjectState>(
          builder: (context, data) {
            if (data is HouseObjectLoading) {
              return CircularProgressIndicator();
            } else if (data is HouseObjectData) {
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
