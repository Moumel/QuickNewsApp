import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../core/services/api_service.dart';
import '../../logic/news_bloc/news_bloc.dart';
import '../../logic/news_bloc/news_event.dart';
import '../../logic/news_bloc/news_state.dart';
import '../widgets/article_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final NewsBloc newsBloc;
  late final TabController tabController;
  final TextEditingController searchController = TextEditingController();

  final List<String> categories = ['technology', 'business', 'sports', 'health'];

  @override
  void initState() {
    super.initState();

    final apiKey = dotenv.env['NEWSAPI_KEY'] ?? '';
    final apiService = ApiService(apiKey: apiKey);

    newsBloc = NewsBloc(apiService: apiService);
    tabController = TabController(length: categories.length, vsync: this);

    newsBloc.add(FetchNews(category: categories[0]));

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        final category = categories[tabController.index];
        newsBloc.add(FetchNews(category: category));
        searchController.clear();
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    newsBloc.close();
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    final category = categories[tabController.index];
    newsBloc.add(FetchNews(category: category, query: query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: newsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quick News'),
          bottom: TabBar(
            controller: tabController,
            tabs: categories.map((c) => Tab(text: c.capitalize())).toList(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onSubmitted: onSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search articles...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NewsLoaded) {
                    final articles = state.articles;
                    if (articles.isEmpty) {
                      return const Center(child: Text('No articles found.'));
                    }
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return ArticleListItem(article: articles[index]);
                      },
                    );
                  } else if (state is NewsError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}