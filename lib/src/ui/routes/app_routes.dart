import 'package:flutter/material.dart';
import 'package:my_puzzle/src/ui/pages/game/game_view.dart';
import 'package:my_puzzle/src/ui/pages/privacy/privacy_view.dart';
import 'package:my_puzzle/src/ui/pages/splash/splash_view.dart';
import 'package:my_puzzle/src/ui/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (_) => const SplashView(),
    Routes.game: (_) => const GameView(),
    Routes.privacy: (_) => const PrivacyView(),
  };
}
