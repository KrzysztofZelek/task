import 'package:http/http.dart' as http;
import 'package:recruitment_task/model/comment.dart';

class CommentRepository {
  Future<List<Comment>?> getComments() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final comment = Comment.parseComments(response.body);
      return comment;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
