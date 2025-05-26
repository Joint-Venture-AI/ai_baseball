import 'package:flutter/material.dart';
import 'package:baseball_ai/core/utils/image_utils.dart';
import 'package:baseball_ai/core/utils/const/app_images.dart';

class SafeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? placeholder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final bool isCircular;
  final Color? backgroundColor;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.loadingWidget,
    this.errorWidget,
    this.borderRadius,
    this.isCircular = false,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    final validUrl = ImageUtils.getValidImageUrl(imageUrl, defaultImage: placeholder);
    
    // Debug print to help troubleshoot URL construction
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      print('SafeNetworkImage - Original URL: $imageUrl');
      print('SafeNetworkImage - Constructed URL: $validUrl');
    }
    
    Widget imageWidget;
    
    // Check if it's a local asset or network image
    if (validUrl == AppImages.avatarLogo || validUrl == placeholder) {
      // It's a local asset
      imageWidget = Image.asset(
        validUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {      // It's a network image
      imageWidget = Image.network(
        validUrl,
        width: width,
        height: height,
        fit: fit,
        cacheHeight: height?.toInt(),
        cacheWidth: width?.toInt(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          
          return loadingWidget ?? _buildLoadingWidget(loadingProgress);
        },
        errorBuilder: (context, error, stackTrace) {
          print('SafeNetworkImage - Error loading image: $error');
          print('SafeNetworkImage - Failed URL: $validUrl');
          return _buildErrorWidget();
        },
      );
    }
    
    // Apply styling
    if (backgroundColor != null) {
      imageWidget = Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: imageWidget,
      );
    }
    
    if (isCircular) {
      imageWidget = ClipOval(child: imageWidget);
    } else if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }
    
    return imageWidget;
  }
  
  Widget _buildLoadingWidget(ImageChunkEvent? loadingProgress) {
    if (loadingWidget != null) return loadingWidget!;
    
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? Colors.grey[300],
      child: Center(
        child: SizedBox(
          width: (width != null && width! > 40) ? 24 : 16,
          height: (height != null && height! > 40) ? 24 : 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: loadingProgress?.expectedTotalBytes != null
                ? loadingProgress!.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      ),
    );
  }
  
  Widget _buildErrorWidget() {
    if (errorWidget != null) return errorWidget!;
    
    return Container(
      width: width,
      height: height,
      color: backgroundColor ?? Colors.grey[300],
      child: Image.asset(
        AppImages.avatarLogo,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;
  final Color borderColor;
  final double borderWidth;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    this.radius = 25,
    this.backgroundColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderWidth > 0 
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: SafeNetworkImage(
          imageUrl: imageUrl,
          width: radius * 2,
          height: radius * 2,
          isCircular: false, // We're already clipping with ClipOval
          backgroundColor: backgroundColor,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
