import 'package:flutter/material.dart';
import '../models/article_data.dart';
import '../services/data_fetcher.dart';
import '../widgets/article_card.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({Key? key}) : super(key: key);

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  late Future<List<ArticleData>> _articlesFuture;
  final DataFetcher _dataFetcher = DataFetcher();

  @override
  void initState() {
    super.initState();
    _articlesFuture = _dataFetcher.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Daily Insights',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ArticleData>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingIndicator();
          }
          
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const CustomEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _articlesFuture = _dataFetcher.getArticles();
              });
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: snapshot.data![index]);
              },
            ),
          );
        },
      ),
    );
  }
}
