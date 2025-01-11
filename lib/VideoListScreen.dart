import 'package:flutter/material.dart';
import 'package:youtube/sevices/youtube.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final YouTubeService _youtubeService = YouTubeService();
  late Future<List<dynamic>> _videos;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videos = _youtubeService.fetchRandomVideos(); // Videos por defecto
  }

  void _searchVideos() {
    setState(() {
      _videos = _youtubeService.searchVideos(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos de YouTube'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar videos...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchVideos,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _videos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final videos = snapshot.data!;
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      final videoId = video['id']['videoId'] ?? video['id'];
                      final thumbnail =
                          video['snippet']['thumbnails']['default']['url'];
                      final title = video['snippet']['title'];
                      final channel = video['snippet']['channelTitle'];

                      return ListTile(
                        leading: Image.network(thumbnail),
                        title: Text(title),
                        subtitle: Text(channel),
                        onTap: () {
                          final url = 'https://www.youtube.com/watch?v=$videoId';
                          print('Abrir: $url');
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No hay videos disponibles.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
