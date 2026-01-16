import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({
    super.key,
    required this.image,
    required this.title,
    required this.username,
  });

  final String title;
  final String username;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: image,
                key: ValueKey(image),
                imageBuilder: (context, imageProvider) =>
                    CircleAvatar(radius: 22, backgroundImage: imageProvider),

                placeholder: (context, url) => CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 22,
                  child: const CircularProgressIndicator(),
                ),

                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 22,
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withAlpha(200),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    username,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black.withAlpha(150),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
