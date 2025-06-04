import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/constants.dart';
import 'core/utils/injection_container.dart' as di;
import 'features/onboarding/domain/usecases/check_onboarding_status.dart';
import 'features/onboarding/domain/usecases/complete_onboarding.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/navigation/presentation/pages/main_navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Initialize dependency injection
    await di.init();

    runApp(const MyApp());
  } catch (e) {
    // If initialization fails, run a minimal app
    debugPrint('Initialization error: $e');
    runApp(ErrorApp(error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      home: const AppInitializer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isLoading = true;
  bool _hasSeenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      final checkOnboardingStatus = di.sl<CheckOnboardingStatus>();
      final result = await checkOnboardingStatus();

      result.fold(
        (failure) {
          // If there's an error, assume onboarding hasn't been seen
          setState(() {
            _hasSeenOnboarding = false;
            _isLoading = false;
          });
        },
        (hasSeenOnboarding) {
          setState(() {
            _hasSeenOnboarding = hasSeenOnboarding;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      // If there's an error, assume onboarding hasn't been seen
      setState(() {
        _hasSeenOnboarding = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _completeOnboarding() async {
    final completeOnboarding = di.sl<CompleteOnboarding>();
    await completeOnboarding();

    setState(() {
      _hasSeenOnboarding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.eco, size: 64, color: AppTheme.primaryColor),
              const SizedBox(height: AppConstants.defaultPadding),
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppConstants.largePadding),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (!_hasSeenOnboarding) {
      return OnboardingPage(onComplete: _completeOnboarding);
    }

    return const MainNavigationPage();
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Plant Identifier - Error',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                const SizedBox(height: 24),
                Text(
                  'Initialization Error',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'The app failed to initialize properly. Please restart the app.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  'Error: $error',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
