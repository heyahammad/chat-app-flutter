import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
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
    final double avatarSize = 50.0;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: _buildAvatar(avatarSize),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(username),
      ),
    );
  }

  Widget _buildAvatar(double size) {
    if (image.isEmpty) {
      return CircleAvatar(radius: size / 2, child: const Icon(Icons.person));
    }
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (context, url, error) =>
          CircleAvatar(radius: size / 2, child: const Icon(Icons.error)),
    );
  }
}
