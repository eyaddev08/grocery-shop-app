import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/widgets/confirm_dialog_widget.dart';
import 'package:grocery_shop_app/features/profile/presentation/manager/profile_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/sliver_delegate_widget.dart';
import '../widgets/custom_container_widget.dart';
import '../widgets/menu_button_widget.dart';
import '../widgets/more_horizontal_section_widget.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/profile_info_section_shimmer.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final ScrollController _scrollController = ScrollController();

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
              floating: true,
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
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const ProfileInfoSectionShimmer();
                          } else if (state is ProfileLoaded) {
                            return ProfileInfoSection(user: state.profile);
                          } else if (state is ProfileError) {
                            return Text(state.message);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    )),
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
                    MenuButtonWidget(
                      image: Images.trackOrder,
                      title: 'Track Order',
                      onTap: () =>
                          NavigationService.navigateTo(AppRoutes.guestTrackOrder),
                    ),
                    MenuButtonWidget(
                      image: Images.personIcon,
                      title: 'Profile',
                      onTap: () =>
                          NavigationService.navigateTo(AppRoutes.profile),
                    ),
                    MenuButtonWidget(
                      image: Images.address,
                      title: 'Addresses',
                      onTap: () =>
                          NavigationService.navigateTo(AppRoutes.checkout),
                    ),
                    MenuButtonWidget(
                      image: Images.mapImage,
                      title: 'Map',
                      onTap: () =>
                          NavigationService.navigateTo(AppRoutes.mapPicker),
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
                        iconColor: errorColor,
                        onTap: () {
                          showDialog<ConfirmDialogWidget>(
                            context: context,
                            builder: (context) => ConfirmDialogWidget(
                                title: 'Sign Out',
                                description:
                                    'Are you sure you want to sign out?',
                                onCancle: NavigationService.goBack,
                                titleButton: 'Sign Out',
                                icon: Icons.logout,
                                isFailed: true,
                                onPressed: () {
                                  context.read<ProfileCubit>().logoutAction();
                                  NavigationService.navigateAndClearStack(
                                      AppRoutes.login);
                                }),
                          );
                        },
                      ),
                      MenuButtonWidget(
                        image: Images.delete,
                        title: 'Delete Account',
                        iconColor: errorColor,
                        onTap: () {
                          showDialog<ConfirmDialogWidget>(
                            context: context,
                            builder: (context) => ConfirmDialogWidget(
                                title: 'Delete Account',
                                description:
                                    'Are you sure you want to delete your account? This action cannot be undone.',
                                onCancle: NavigationService.goBack,
                                titleButton: 'Delete',
                                icon: Icons.delete,
                                isFailed: true,
                                onPressed: () {
                                  context
                                      .read<ProfileCubit>()
                                      .deleteAccountAction();
                                  NavigationService.navigateAndClearStack(
                                      AppRoutes.login);
                                }),
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
