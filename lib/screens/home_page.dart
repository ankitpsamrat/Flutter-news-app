import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

  List<NewsModel> allNewsList = [];
  List<String> navBarItem = [
    "Top News",
    "India",
    "World",
    "Finacnce",
    "Health",
    'Education',
    'Science',
    'Business',
    'Sports',
    'Technology',
  ];

  Future<void> getNewsByQuery(String query) async {
    try {
      final String formattedDate = DateTime.now()
          .subtract(const Duration(days: 7))
          .toIso8601String()
          .substring(0, 10);

      final Response response = await get(Uri.parse(
          "https://newsapi.org/v2/everything?q=$query&language=en&from=$formattedDate&sortBy=publishedAt&apiKey=9bb7bf6152d147ad8ba14cd0e7452f2f"));

      if (response.statusCode == 200) {
        final Map data = jsonDecode(response.body);

        setState(() {
          data["articles"].forEach((element) {
            NewsModel newsModel = NewsModel.fromJson(element);
            allNewsList.add(newsModel);
          });
        });
      } else {
        debugPrint('Status code error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Unable to fetch data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsByQuery("india");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SAMRAT NEWS"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: ListView.builder(
              itemCount: navBarItem.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      debugPrint(navBarItem[index]);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blueAccent,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            navBarItem[index],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allNewsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final NewsModel newsInfo = allNewsList[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            newsModel: newsInfo,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: (newsInfo.imgUrl.isEmpty)
                              ? Image.asset('assets/images/news.jpg')
                              : Image.network(newsInfo.imgUrl),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 10, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12.withOpacity(0),
                                  Colors.black
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsInfo.title.length > 65
                                      ? '${newsInfo.title.substring(0, 60)}...'
                                      : newsInfo.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  newsInfo.title.length > 65
                                      ? '${newsInfo.title.substring(0, 60)}...'
                                      : newsInfo.desc,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
