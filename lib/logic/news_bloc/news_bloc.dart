import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../../core/services/api_service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiService apiService;

  NewsBloc({required this.apiService}) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await apiService.fetchTopHeadlines(
          event.category,
          query: event.query,
        );
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}