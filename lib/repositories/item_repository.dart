import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemRepository {
  final String apiUrl = 'https://api.thecatapi.com/v1/breeds?limit=100';
  final String apiKey =
      'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-api-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Espera a obtener las imágenes para cada item y devuelve una lista de items procesados
      List<Item> items = await Future.wait(data.map((item) async {
        String imageUrl = '';

        // Verifica si hay una referencia de imagen y la busca
        if (item['reference_image_id'] != null) {
          imageUrl =
              await Item.fetchImageUrl(item['reference_image_id'], apiKey);
        }

        // Crea y retorna un objeto Item por cada entrada en el array
        return Item(
          id: item['id'],
          name: item['name'],
          origin: item['origin'],
          intelligence: item['intelligence'],
          adaptability: item['adaptability'],
          description: item['description'],
          lifeSpan: item['life_span'],
          imageUrl: imageUrl,
        );
      }).toList());

      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }
}
