import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/item_bloc.dart';
import 'blocs/item_event.dart';
import 'repositories/item_repository.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart'; // Importa la pantalla de splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ItemRepository(),
      child: BlocProvider(
        create: (context) =>
            ItemBloc(itemRepository: context.read<ItemRepository>())
              ..add(LoadItems()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Roboto', // Configura la fuente globalmente
          ),
          debugShowCheckedModeBanner: false, // Quita el banner de debug
          home:
              const SplashScreen(), // Configura la pantalla de splash como la pantalla inicial
        ),
      ),
    );
  }
}
