import 'package:flutter/material.dart';
import 'repositories/firebase.dart';
import 'repositories/tips.dart';
import 'blocs/tips.dart';
import 'state/tip_state.dart';
import 'components/tip_row.dart';
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
      home: RepositoryProvider<TipRepository>(
        create: (context) => TipRepositoryFirestore()..refresh(),
        child: BlocProvider(
            create: (context) =>
                TipBloc(repository: RepositoryProvider.of(context)),
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
  TipBloc bloc;

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
        child: BlocBuilder<TipBloc, TipState>(
          builder: (context, data) {
            if (data is TipLoadingState) {
              return CircularProgressIndicator();
            } else if (data is TipHasDataState) {
              return ListView(
                  children: data.data
                      .map((item) => TipRow(
                            tip: item,
                          ))
                      .toList());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
