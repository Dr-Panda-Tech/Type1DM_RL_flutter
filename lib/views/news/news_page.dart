import 'package:flutter/material.dart';
import 'package:type1dm_rl_flutter/constants.dart';
import 'package:type1dm_rl_flutter/material/news_data.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // ダミーのニュースデータ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ニュース'),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return Container(
            margin:
                const EdgeInsets.only(bottom: 1), // サムネイル同士の間に細いラインを表示するためのマージン
            color: ColorConstants.pandaGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 8,
                  child: Image.asset(newsData[index]['thumbnail'],
                      fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(newsData[index]['title'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.visibility, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            newsData[index]['views'].toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.thumb_up, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            newsData[index]['likes'].toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
