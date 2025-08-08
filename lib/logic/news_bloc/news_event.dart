import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNews extends NewsEvent {
  final String category;
  final String query;

  const FetchNews({required this.category, this.query = ''});

  @override
  List<Object?> get props => [category, query];
}