import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_task/bloc/comment_bloc.dart';
import 'package:recruitment_task/model/comment.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Comments'),
      ),
      body: BlocBuilder<CommentBloc, CommentState>(builder: ((context, state) {
        if (state is CommentInitialState) {
          context.read<CommentBloc>().add(LoadCommentsEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CommentLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CommentLoadedState) {
          return buildComment(state.comment);
        } else if (state is CommentErrorState) {
          return commentError(context);
        } else {
          throw Exception('Error!');
        }
      })),
    );
  }

  Widget commentError(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Something went wrong!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        ElevatedButton(
            onPressed: () {
              context.read<CommentBloc>().add(LoadCommentsEvent());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Refresh',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.restart_alt,
                )
              ],
            ))
      ],
    );
  }

  Widget buildComment(List<Comment> comment) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: comment.length,
        itemBuilder: ((context, index) {
          final commentData = comment[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              tileColor: Colors.indigo,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              title: Text(
                commentData.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentData.body,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white70,
                    ),
                  ),
                  Text(commentData.email,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.amber[400],
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          );
        }));
  }
}
