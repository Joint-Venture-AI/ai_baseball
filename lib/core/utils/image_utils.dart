import 'package:baseball_ai/core/utils/const/api_constants.dart';
import 'package:baseball_ai/core/utils/const/app_images.dart';

class ImageUtils {  /// Converts any image path/URL to a proper full URL or returns a default image
  /// 
  /// Handles these cases:
  /// - Full URL (https://example.com/image.jpg) -> returns as is
  /// - Relative path (uploads/image.jpg) -> adds base URL
  /// - Path with leading slash (/images/scaled_image.webp) -> adds base URL
  /// - Just filename (image.jpg) -> adds base URL
  /// - null or empty -> returns default image
  /// - invalid URL -> returns default image
  static String getValidImageUrl(String? imageUrl, {String? defaultImage}) {
    // Use provided default or app default
    final fallbackImage = defaultImage ?? AppImages.avatarLogo;
    
    // Handle null or empty cases
    if (imageUrl == null || imageUrl.trim().isEmpty) {
      return fallbackImage;
    }
    
    final trimmedUrl = imageUrl.trim();
    
    try {
      // Check if it's already a full URL (starts with http or https)
      if (trimmedUrl.toLowerCase().startsWith('http://') || 
          trimmedUrl.toLowerCase().startsWith('https://')) {
        return trimmedUrl;
      }
      
      // For relative paths, construct full URL with base URL
      String baseUrl = ApiConstants.baseUrl;
      
      // Remove '/api/v1' from base URL for image serving
      // Images are typically served from the root domain, not the API path
      if (baseUrl.endsWith('/api/v1')) {
        baseUrl = baseUrl.substring(0, baseUrl.length - 7);
      }
      
      // Ensure base URL doesn't end with slash
      if (baseUrl.endsWith('/')) {
        baseUrl = baseUrl.substring(0, baseUrl.length - 1);
      }
      
      // Handle paths that start with '/' or don't
      String cleanPath = trimmedUrl.startsWith('/') 
          ? trimmedUrl  // Keep the leading slash for absolute paths
          : '/$trimmedUrl'; // Add leading slash for relative paths
      
      return '$baseUrl$cleanPath';
      
    } catch (e) {
      // If any error occurs during URL construction, return fallback
      return fallbackImage;
    }
  }
  
  /// Get profile image URL specifically for user profiles
  static String getProfileImageUrl(String? imageUrl) {
    return getValidImageUrl(imageUrl, defaultImage: AppImages.avatarLogo);
  }
  
  /// Check if the URL is a valid image URL
  static bool isValidImageUrl(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    
    final trimmedUrl = url.trim().toLowerCase();
    
    // Check if it's a URL
    if (trimmedUrl.startsWith('http://') || trimmedUrl.startsWith('https://')) {
      return true;
    }
    
    // Check if it's a relative path with image extension
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'];
    return imageExtensions.any((ext) => trimmedUrl.endsWith(ext));
  }
  
  /// Get image URL for different contexts (profile, gallery, etc.)
  static String getContextualImageUrl(String? imageUrl, ImageContext context) {
    String defaultImage;
    
    switch (context) {
      case ImageContext.profile:
        defaultImage = AppImages.avatarLogo;
        break;
      case ImageContext.gallery:
        defaultImage = AppImages.avatarLogo; // You can add a gallery placeholder
        break;
      case ImageContext.thumbnail:
        defaultImage = AppImages.avatarLogo; // You can add a thumbnail placeholder
        break;
    }
    
    return getValidImageUrl(imageUrl, defaultImage: defaultImage);
  }
}

enum ImageContext {
  profile,
  gallery,
  thumbnail,
}
