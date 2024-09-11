import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/item_bloc.dart';
import '../blocs/item_event.dart';
import '../blocs/item_state.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Breeds'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                context.read<ItemBloc>().add(SearchItems(query));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.filteredItems.length,
                  itemBuilder: (context, index) {
                    return ItemCard(item: state.filteredItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
