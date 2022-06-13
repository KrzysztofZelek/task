import 'package:flutter/material.dart';
import 'package:recruitment_task/model/photo.dart';

class PhotoDetailPage extends StatelessWidget {
  const PhotoDetailPage({Key? key, required this.photo}) : super(key: key);
  final Photo photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Details'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              photo.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15.0),
          Image.network(photo.url),
        ],
      ),
    );
  }
}
