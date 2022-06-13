import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recruitment_task/model/photo.dart';
import 'package:recruitment_task/repository/photo_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository _photoRepository;

  PhotoBloc(this._photoRepository) : super(PhotoInitialState()) {
    on<PhotoEvent>((event, emit) async {
      if (event is LoadPhotosEvent) {
        emit(PhotoLoadingState());
        List<Photo>? photo = await _photoRepository.getPhotos();
        if (photo == null) {
          emit(PhotoErrorState());
        } else {
          emit(PhotoLoadedState(photo: photo));
        }
      }
    });
  }
}
