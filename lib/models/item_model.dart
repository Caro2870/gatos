import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final String id;
  final String name;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String description;
  final String lifeSpan;
  String imageUrl;

  Item({
    required this.id,
    required this.name,
    required this.origin,
    required this.intelligence,
    required this.adaptability,
    required this.description,
    required this.lifeSpan,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      intelligence: json['intelligence'],
      adaptability: json['adaptability'],
      description: json['description'],
      lifeSpan: json['life_span'],
      imageUrl: json['reference_image_id'] != null
          ? 'https://cdn2.thecatapi.com/images/${json['reference_image_id']}.jpg'
          : '',
    );
  }

  static Future<String> fetchImageUrl(String imageId, String apiKey) async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/$imageId'),
      headers: {
        'x-api-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['url'];
    } else {
      throw Exception('Failed to load image URL');
    }
  }
}
