import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recruitment_task/model/comment.dart';
import 'package:recruitment_task/repository/comment_repository.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository;

  CommentBloc(this._commentRepository) : super(CommentInitialState()) {
    on<CommentEvent>((event, emit) async {
      if (event is LoadCommentsEvent) {
        emit(CommentLoadingState());
        final comment = await _commentRepository.getComments();
        if (comment == null) {
          emit(CommentErrorState());
        } else {
          emit(CommentLoadedState(comment: comment));
        }
      }
    });
  }
}
