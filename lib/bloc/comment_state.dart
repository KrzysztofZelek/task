part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitialState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comment> comment;

  const CommentLoadedState({required this.comment});

  @override
  List<Object> get props => [comment];
}

class CommentErrorState extends CommentState {}
