import 'package:flutter/material.dart';
import 'package:news_app/model/news_model.dart';

class DetailsScreen extends StatelessWidget {
  final NewsModel newsModel;

  const DetailsScreen({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (newsModel.imgUrl.isEmpty)
                ? Image.asset('assets/images/news.jpg')
                : Image.network(newsModel.imgUrl),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                newsModel.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Published at: ${newsModel.publishedAt.day}-${newsModel.publishedAt.month}-${newsModel.publishedAt.year}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10).copyWith(bottom: 50),
              child: Text(
                newsModel.desc,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          debugPrint(newsModel.url);
        },
        icon: const Icon(Icons.link),
        label: const Text('Open link'),
      ),
    );
  }
}
