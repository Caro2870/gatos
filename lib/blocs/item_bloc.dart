import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/item_repository.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc({required this.itemRepository})
      : super(const ItemState(items: [], filteredItems: [])) {
    on<LoadItems>(_onLoadItems);
    on<SearchItems>(_onSearchItems);
  }

  void _onLoadItems(LoadItems event, Emitter<ItemState> emit) async {
    try {
      final items = await itemRepository.fetchItems();
      emit(ItemState(items: items, filteredItems: items));
    } catch (e) {
      // Manejar el error
      emit(ItemState(items: [], filteredItems: []));
    }
  }

  void _onSearchItems(SearchItems event, Emitter<ItemState> emit) {
    final filteredItems = state.items
        .where((item) =>
            item.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(ItemState(items: state.items, filteredItems: filteredItems));
  }
}
