import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';
import '../models/item_model.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID y nombre en la parte superior
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${item.id} - ${item.name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Text('Más'),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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
          // Información en la mitad inferior
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Origin: ${item.origin}'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Intelligence: ${item.intelligence}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}