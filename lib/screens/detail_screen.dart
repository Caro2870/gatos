import 'package:flutter/material.dart';
import '../models/item_model.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        children: [
          // Imagen centrada en la parte superior
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: item.imageUrl.isNotEmpty
                  ? Image.network(
                      item.imageUrl,
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Container(
                          width: screenWidth * 0.8,
                          height: screenWidth * 0.8,
                          color: Colors.grey,
                          child:
                              Icon(Icons.error, size: 50, color: Colors.white),
                        );
                      },
                    )
                  : Container(
                      width: screenWidth * 0.8,
                      height: screenWidth * 0.8,
                      color: Colors.grey,
                      child: Icon(Icons.image, size: 50, color: Colors.white),
                    ),
            ),
          ),
          // Espacio de 30 píxeles debajo de la imagen
          const SizedBox(height: 30),
          // Contenido de texto con scroll
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ${item.description}',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Origin: ${item.origin}',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Intelligence: ${item.intelligence}',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Adaptability: ${item.adaptability}',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Lifespan: ${item.lifeSpan}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}