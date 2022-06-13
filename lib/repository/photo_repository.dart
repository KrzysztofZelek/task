import 'package:http/http.dart' as http;
import 'package:recruitment_task/model/photo.dart';

class PhotoRepository {
  Future<List<Photo>?> getPhotos() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final photo = Photo.parsePhotos(response.body);
      return photo;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
