import 'package:baseball_ai/core/utils/const/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:baseball_ai/core/utils/const/app_images.dart'; // For AppImages.avatarLogo

class ImageUtils {
  // Fallback image if no specific default is provided
  static final String _defaultFallbackImage = AppImages.avatarLogo;

  static String _getImageBaseUrl() {
    // Remove /api/v1 from the base URL for image serving
    String baseUrl = ApiConstants.baseUrl;
    if (baseUrl.endsWith('/api/v1')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - '/api/v1'.length);
    }
    // Ensure it doesn't have a trailing slash if it's not just the domain
    if (baseUrl.contains('/') && baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }
    return baseUrl;
  }

  static String getValidImageUrl(String? imageUrl, {String? defaultImage}) {
    final String fallbackImage = defaultImage ?? _defaultFallbackImage;

    if (imageUrl == null || imageUrl.trim().isEmpty) {
      return fallbackImage;
    }

    String trimmedUrl = imageUrl.trim();

    if (trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://')) {
      // Full URL, use as-is
      return trimmedUrl;
    } else if (trimmedUrl.startsWith('www.')) {
      // Starts with www. but no scheme, prepend https
      return 'https://\$trimmedUrl';
    } else {
      // Relative path or just filename
      _getImageBaseUrl();
      if (trimmedUrl.startsWith('/')) {
        // Path starts with a slash, e.g. /uploads/image.jpg
        return '\$imageBaseUrl\$trimmedUrl';
      }
      // Path does not start with a slash, e.g. uploads/image.jpg or image.jpg
      return '\$imageBaseUrl/\$trimmedUrl';
    }
  }

  static String getProfileImageUrl(String? imageUrl) {
    return getValidImageUrl(imageUrl, defaultImage: AppImages.avatarLogo);
  }

  static bool isValidImageUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      return false;
    }
    // Basic check, can be expanded (e.g., regex for common image extensions)
    // For now, if it's not empty and getValidImageUrl doesn't return a fallback, it's considered potentially valid.
    // This doesn't check if the URL actually leads to a valid image resource.
    String validatedUrl = getValidImageUrl(url);
    return validatedUrl != AppImages.avatarLogo && validatedUrl != _defaultFallbackImage;
  }
}

class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCircular;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final String? fallbackAssetImage;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCircular = false,
    this.backgroundColor,
    this.borderRadius,
    this.fallbackAssetImage,
  });

  @override
  Widget build(BuildContext context) {
    final String validUrl = ImageUtils.getValidImageUrl(imageUrl, defaultImage: fallbackAssetImage ?? AppImages.avatarLogo);
    
    Widget imageWidget;

    if (validUrl.startsWith('http')) {
      imageWidget = Image.network(
        validUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: backgroundColor ?? Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return Container(
            width: width,
            height: height,
            color: backgroundColor ?? Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey[600]),
          );
        },
      );
    } else { // Assumes it's an asset path if not http/https
      imageWidget = Image.asset(
        validUrl, // This will be the fallback asset image
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
           // If even the fallback asset fails, show a broken image icon
          return Container(
            width: width,
            height: height,
            color: backgroundColor ?? Colors.grey[300],
            child: Icon(Icons.broken_image, color: Colors.grey[600]),
          );
        },
      );
    }

    if (isCircular) {
      return ClipOval(
        child: imageWidget,
      );
    } else if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }
    return imageWidget;
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final String? fallbackAssetImage;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    this.radius = 25.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.0,
    this.fallbackAssetImage,
  });

  @override
  Widget build(BuildContext context) {
    final String fallbackImage = fallbackAssetImage ?? AppImages.avatarLogo;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null && borderWidth > 0
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: SafeNetworkImage(
        imageUrl: imageUrl,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        isCircular: true,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        fallbackAssetImage: fallbackImage,
      ),
    );
  }
}
