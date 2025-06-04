import 'package:flutter/material.dart';

/// Helper class for responsive design across different screen sizes
class ResponsiveHelper {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  /// Check if the current screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Check if the current screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if the current screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Check if the current screen is web
  static bool isWeb() {
    return identical(0, 0.0); // This is a web-specific check
  }

  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    if (isMobile(context)) {
      return baseFontSize;
    } else if (isTablet(context)) {
      return baseFontSize * 1.1;
    } else {
      return baseFontSize * 1.2;
    }
  }

  /// Get responsive grid columns
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive max width for content
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return double.infinity;
    } else if (isTablet(context)) {
      return 800;
    } else {
      return 1200;
    }
  }

  /// Get responsive bottom navigation height
  static double getBottomNavHeight(BuildContext context) {
    if (isMobile(context)) {
      return 70;
    } else {
      return 80;
    }
  }

  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    if (isMobile(context)) {
      return kToolbarHeight;
    } else {
      return kToolbarHeight + 10;
    }
  }

  /// Check if device supports camera
  static bool supportsCameraFeatures(BuildContext context) {
    // On web, camera support is limited
    if (isWeb()) {
      return false; // Disable camera for web for now
    }
    return true;
  }

  /// Get platform-specific image picker options
  static Map<String, dynamic> getImagePickerConfig(BuildContext context) {
    return {
      'showCamera': supportsCameraFeatures(context),
      'showGallery': true,
      'maxWidth': isDesktop(context) ? 1024.0 : 800.0,
      'maxHeight': isDesktop(context) ? 1024.0 : 800.0,
      'imageQuality': 85,
    };
  }

  /// Get responsive layout for different screen sizes
  static Widget responsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  /// Get responsive container constraints
  static BoxConstraints getResponsiveConstraints(BuildContext context) {
    final maxWidth = getMaxContentWidth(context);
    return BoxConstraints(
      maxWidth: maxWidth,
      minHeight: 0,
    );
  }

  /// Get responsive card elevation
  static double getCardElevation(BuildContext context) {
    if (isMobile(context)) {
      return 2.0;
    } else {
      return 4.0;
    }
  }

  /// Get responsive border radius
  static double getBorderRadius(BuildContext context) {
    if (isMobile(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }
}
