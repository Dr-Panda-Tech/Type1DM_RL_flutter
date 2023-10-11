import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // ダミーのニュースデータ
  final List<Map<String, String>> newsData = [
    {
      'title': 'DMに関する最新の研究',
      'content': 'DMに関する最新の研究が発表されました。詳細はこちら。'
    },
    {
      'title': '糖尿病の新しい治療法',
      'content': '新しい治療法が開発され、多くの患者さんに希望をもたらしています。'
    },
    // その他のニュースデータを追加...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ニュース'),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newsData[index]['title']!),
            subtitle: Text(newsData[index]['content']!),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // 例: ニュースの詳細ページに遷移するなどのアクションをここに記述
            },
          );
        },
      ),
    );
  }
}
