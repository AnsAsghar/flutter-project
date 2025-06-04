import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Service to handle platform-specific functionality
class PlatformService {
  /// Check if running on web
  static bool get isWeb => kIsWeb;

  /// Check if running on mobile (iOS or Android)
  static bool get isMobile => !kIsWeb && (Platform.isIOS || Platform.isAndroid);

  /// Check if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Check if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Check if running on desktop (Windows, macOS, Linux)
  static bool get isDesktop => !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// Check if running on macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Check if running on Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Check if running on Linux
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Get platform name as string
  static String get platformName {
    if (isWeb) return 'Web';
    if (isIOS) return 'iOS';
    if (isAndroid) return 'Android';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    return 'Unknown';
  }

  /// Check if platform supports camera
  static bool get supportsCameraAccess {
    return isMobile; // Only mobile platforms support camera
  }

  /// Check if platform supports file system access
  static bool get supportsFileSystem {
    return !isWeb; // All platforms except web support file system
  }

  /// Check if platform supports local storage
  static bool get supportsLocalStorage {
    return true; // All platforms support some form of local storage
  }

  /// Check if platform supports push notifications
  static bool get supportsPushNotifications {
    return isMobile; // Primarily mobile platforms
  }

  /// Check if platform supports app store features
  static bool get supportsAppStore {
    return isMobile;
  }

  /// Get platform-specific app bar configuration
  static AppBarTheme getAppBarTheme(BuildContext context) {
    if (isIOS) {
      return const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      );
    } else {
      return const AppBarTheme(
        backgroundColor: Color(0xFF4CAF50),
        elevation: 4,
        centerTitle: false,
      );
    }
  }

  /// Get platform-specific navigation style
  static Widget getPlatformNavigation({
    required List<Widget> children,
    required int currentIndex,
    required ValueChanged<int> onTap,
    required List<BottomNavigationBarItem> items,
  }) {
    if (isIOS) {
      // Use Cupertino style for iOS
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final isSelected = currentIndex == index;
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        (items[index].icon as Icon).icon,
                        color: isSelected
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF718096),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFF718096),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    } else {
      // Use Material style for Android and other platforms
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final isSelected = currentIndex == index;
                return GestureDetector(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        (items[index].icon as Icon).icon,
                        color: isSelected
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF718096),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFF718096),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    }
  }

  /// Get platform-specific button style
  static ButtonStyle getPlatformButtonStyle() {
    if (isIOS) {
      return ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      );
    } else {
      return ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      );
    }
  }

  /// Get platform-specific loading indicator
  static Widget getPlatformLoadingIndicator() {
    if (isIOS) {
      return const CircularProgressIndicator.adaptive();
    } else {
      return const CircularProgressIndicator();
    }
  }

  /// Show platform-specific alert dialog
  static Future<void> showPlatformAlert({
    required BuildContext context,
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) async {
    if (isIOS) {
      // Use Cupertino dialog for iOS
      return showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
            if (actionText != null && onAction != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onAction();
                },
                child: Text(actionText),
              ),
          ],
        ),
      );
    } else {
      // Use Material dialog for Android and other platforms
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
            if (actionText != null && onAction != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onAction();
                },
                child: Text(actionText),
              ),
          ],
        ),
      );
    }
  }
}
