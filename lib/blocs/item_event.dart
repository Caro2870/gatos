import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class LoadItems extends ItemEvent {}

class SearchItems extends ItemEvent {
  final String query;

  const SearchItems(this.query);

  @override
  List<Object> get props => [query];
}
