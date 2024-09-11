import 'package:equatable/equatable.dart';
import '../models/item_model.dart';

class ItemState extends Equatable {
  final List<Item> items;
  final List<Item> filteredItems;

  const ItemState({required this.items, required this.filteredItems});

  @override
  List<Object> get props => [items, filteredItems];
}
