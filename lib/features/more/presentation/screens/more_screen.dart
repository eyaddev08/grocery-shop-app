import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/widgets/success_dialog_widget.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/custom_themes.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/sliver_delegate_widget.dart';
import '../widgets/custom_container_widget.dart';
import '../widgets/menu_button_widget.dart';
import '../widgets/more_horizontal_section_widget.dart';
import '../widgets/profile_info_section.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final ScrollController _scrollController = ScrollController();
  UserEntity? _lastUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(controller: _scrollController, slivers: [
          const SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryBlue,
            centerTitle: false,
            titleSpacing: 18,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            title: Text('More',
                style: TextStyle(
                    color: kSoftBg, fontSize: 22, fontWeight: FontWeight.w600)),
          ),
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                height: 230,
                child: Hero(
                    tag: 'profile',
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kPrimaryBlue,
                            border: Border.all(color: kPrimaryBlue, width: 0)),
                        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                        child: ProfileInfoSection(
                            user: _lastUser ??
                                const UserEntity(
                                  id: '1',
                                  username: 'username',
                                  fullName: 'fullName',
                                  email: 'email33@gmail.com',
                                  phone: '777777777',
                                )))),
              )),
          SliverToBoxAdapter(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeSmall),
                  child: Center(child: MoreHorizontalSection())),
              const SizedBox(height: 8),
              _buildSectionHeader('General'),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CustomContainerWidget(
                  child: Column(children: [
                    const MenuButtonWidget(
                      image: Images.trackOrder, title: 'Track Order',
                      // navigateTo: const GuestTrackOrderScreen(),
                    ),
                    const MenuButtonWidget(
                      image: Images.personIcon, title: 'Profile',
                      // navigateTo: const ProfileScreen1(),
                    ),
                    MenuButtonWidget(
                      image: Images.address,
                      title: 'Addresses',
                      onTap: () =>
                          NavigationService.navigateTo(AppRoutes.checkout),
                    ),
                    const MenuButtonWidget(
                      image: Images.coupon, title: 'Coupons',
                      // navigateTo: const CouponList(),
                    ),
                    const MenuButtonWidget(
                      image: Images.notification, title: 'Notification',
                      isNotification: true,
                      // navigateTo: const NotificationScreen(),
                    ),
                    const MenuButtonWidget(
                      image: Images.settings, title: 'Settings',
                      // navigateTo: const SettingsScreen(),
                    ),
                  ]),
                ),
              ),
              _buildSectionHeader('Support'),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CustomContainerWidget(
                  child: Column(
                    children: [
                      MenuButtonWidget(
                        image: Images.faq,
                        title: 'Help & FAQ',
                        onTap: () {},
                      ),
                      MenuButtonWidget(
                        image: Images.support,
                        title: 'Contact Support',
                        onTap: () {},
                      ),
                      MenuButtonWidget(
                        image: Images.snackbarWarning,
                        title: 'Security Tips',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
              _buildSectionHeader('Account'),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CustomContainerWidget(
                  child: Column(
                    children: [
                      MenuButtonWidget(
                        image: Images.logout,
                        title: 'Sign Out',
                        onTap: () {
                          showDialog<SuccessDialog>(
                            context: context,
                            builder: (context) => SuccessDialog(
                                title: 'Sign Out',
                                description:
                                    'Are you sure you want to sign out?',
                                onCancle: NavigationService.goBack,
                                titleButton: 'Sign Out',
                                icon: Icons.logout,
                                onRemov: () =>
                                    NavigationService.navigateAndClearStack(
                                        AppRoutes.login)),
                          );
                        },
                      ),
                      MenuButtonWidget(
                        image: Images.delete,
                        title: 'Delete Account',
                        onTap: () {
                          showDialog<SuccessDialog>(
                            context: context,
                            builder: (context) => SuccessDialog(
                                title: 'Delete Account',
                                description:
                                    'This action cannot be undone. All your data will be permanently deleted.',
                                onCancle: NavigationService.goBack,
                                titleButton: 'delete',
                                icon: Icons.delete,
                                onRemov: () =>
                                    NavigationService.navigateAndClearStack(
                                        AppRoutes.login)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]),
          )
        ]),
      );

  Widget _buildSectionHeader(String title) => Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Text(
          title,
          style: textRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge, color: kTextDark),
        ),
      );
}
