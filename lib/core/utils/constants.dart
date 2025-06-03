class AppConstants {
  // App Information
  static const String appName = 'AI Plant Identifier';
  static const String appVersion = '1.0.0';
  
  // SharedPreferences Keys
  static const String hasSeenOnboardingKey = 'hasSeenOnboarding';
  
  // Hive Box Names
  static const String plantsBoxName = 'plantsBox';
  
  // Plant Types
  static const List<String> plantTypes = [
    'Flower',
    'Tree',
    'Shrub',
    'Succulent',
    'Herb',
    'Vine',
    'Grass',
    'Fern',
    'Moss',
    'Other',
  ];
  
  // API Endpoints (for future use)
  static const String baseUrl = 'https://api.plantidentifier.com';
  static const String identifyEndpoint = '/identify';
  
  // Image Settings
  static const double maxImageSize = 1024.0;
  static const int imageQuality = 85;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Error Messages
  static const String networkErrorMessage = 'Please check your internet connection';
  static const String serverErrorMessage = 'Something went wrong. Please try again';
  static const String cacheErrorMessage = 'Failed to load cached data';
  static const String validationErrorMessage = 'Please check your input';
  static const String permissionErrorMessage = 'Permission required to access this feature';
  static const String fileErrorMessage = 'Failed to process file';
  
  // Success Messages
  static const String plantIdentifiedMessage = 'Plant identified successfully!';
  static const String imageSavedMessage = 'Image saved to gallery';
  
  // Onboarding Content
  static const List<OnboardingContent> onboardingPages = [
    OnboardingContent(
      title: "Explore Nature's Diversity",
      description: "Build your personal plant collection, learn about different species, and deepen your connection with the natural world.",
      imagePath: "assets/images/onboarding1.png",
    ),
    OnboardingContent(
      title: "Discover Plant Details & Care",
      description: "Get rich information, including common & scientific names, characteristics, and essential care tips for your identified plants.",
      imagePath: "assets/images/onboarding2.png",
    ),
    OnboardingContent(
      title: "Snap a Plant, Unveil Its Name",
      description: "Use your phone's camera to instantly identify flowers, trees, and other plants around you. It's quick and easy!",
      imagePath: "assets/images/onboarding3.png",
    ),
  ];
}

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;
  
  const OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
