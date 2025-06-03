import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> hasSeenOnboarding();
  Future<void> setOnboardingSeen();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;

  OnboardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> hasSeenOnboarding() async {
    try {
      return sharedPreferences.getBool(AppConstants.hasSeenOnboardingKey) ?? false;
    } catch (e) {
      throw CacheException('Failed to check onboarding status: ${e.toString()}');
    }
  }

  @override
  Future<void> setOnboardingSeen() async {
    try {
      await sharedPreferences.setBool(AppConstants.hasSeenOnboardingKey, true);
    } catch (e) {
      throw CacheException('Failed to set onboarding status: ${e.toString()}');
    }
  }
}
