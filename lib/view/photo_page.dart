import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recruitment_task/bloc/photo_bloc.dart';
import 'package:recruitment_task/model/photo.dart';
import 'package:recruitment_task/view/photo_detail_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Photos'),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(builder: (context, state) {
        if (state is PhotoInitialState) {
          context.read<PhotoBloc>().add(LoadPhotosEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PhotoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PhotoLoadedState) {
          return buildPhoto(state.photo);
        } else if (state is PhotoErrorState) {
          return errorPhoto(context);
        } else {
          throw Exception('Error!');
        }
      }),
    );
  }

  Widget errorPhoto(BuildContext context) {
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
              context.read<PhotoBloc>().add(LoadPhotosEvent());
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

  Widget buildPhoto(List<Photo> photo) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: photo.length,
        itemBuilder: ((context, index) {
          final photoData = photo[index];
          return ListTile(
            title: Text(photoData.title),
            leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetailPage(photo: photoData)));
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  photoData.thumbnailUrl,
                ),
              ),
            ),
          );
        }));
  }
}
