import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_task/bloc/comment_bloc.dart';
import 'package:recruitment_task/bloc/photo_bloc.dart';
import 'package:recruitment_task/repository/comment_repository.dart';
import 'package:recruitment_task/repository/photo_repository.dart';
import 'package:recruitment_task/view/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recruitment Task',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<PhotoBloc>(
            create: (context) => PhotoBloc(PhotoRepository())),
        BlocProvider<CommentBloc>(
            create: (context) => CommentBloc(CommentRepository())),
      ], child: const HomePage()),
    );
  }
}
