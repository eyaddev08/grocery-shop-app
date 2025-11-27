import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/custom_themes.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/bouncy_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    NavigationService.navigateFromSplash();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kPrimaryBlue,
        key: _globalKey,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            BouncyWidget(
                duration: const Duration(milliseconds: 2000),
                lift: 50,
                ratio: 0.5,
                pause: 0.25,
                child: SizedBox(
                  width: 150,
                  child: Image.asset(
                    Images.logo,
                    width: 150,
                    height: 150,
                  ),
                )),
            Text(AppConstants.appName,
                style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Colors.white)),
            Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                child: Text(AppConstants.slogan,
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Colors.white)))
          ]),
        ),
      );
}
