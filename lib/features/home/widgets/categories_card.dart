import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
  });

  final String name;
  final String imageUrl;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFF7CA53) : const Color(0xFFF3F3F3),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 25,
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFFE95322) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
