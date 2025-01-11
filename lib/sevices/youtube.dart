import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YouTubeService {
  final String _apiKey = dotenv.env['YOUTUBE_API_KEY'] ?? '';
  final String _baseUrl = 'https://www.googleapis.com/youtube/v3';

  // Obtener los videos más populares por defecto
  Future<List<dynamic>> fetchRandomVideos() async {
    final url = Uri.parse(
      '$_baseUrl/videos?part=snippet&chart=mostPopular&maxResults=10&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items']; // Devolver los videos
    } else {
      throw Exception('Error al traer la información de videos');
    }
  }

  // Buscar videos específicos
  Future<List<dynamic>> searchVideos(String query) async {
    final url = Uri.parse(
      '$_baseUrl/search?part=snippet&q=$query&type=video&maxResults=10&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items']; // Devolver los resultados de la búsqueda
    } else {
      throw Exception('Error al buscar videos');
    }
  }
}
