import 'package:flutter/material.dart';
import '../../../../core/utils/functions/show_address_menu.dart';
import '../../../../core/utils/functions/show_within_menu.dart';
import 'widgets/content_section.dart';
import 'widgets/header_section.dart';

class GroceryHomeScreen extends StatefulWidget {
  const GroceryHomeScreen({super.key});
  @override
  State<GroceryHomeScreen> createState() => _GroceryHomeScreenState();
}

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  // keys for anchored menus
  final GlobalKey _addressKey = GlobalKey();
  final GlobalKey _withinKey = GlobalKey();
  String selectedAddress = 'Green Way 3000, Sylhet';
  String selectedWithin = '1 Hour';

  // Design width reference (the screenshot uses ~375 width). We'll scale all sizes by s.
  double s(BuildContext context) => MediaQuery.of(context).size.width / 375.0;

  @override
  Widget build(BuildContext context) {
    final scale = s(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(240),
          child: HeaderSection(
            scale: scale,
            addressKey: _addressKey,
            withinKey: _withinKey,
            selectedAddress: selectedAddress,
            selectedWithin: selectedWithin,
            onSearchTap: () =>
                Navigator.of(context).push<Widget>(MaterialPageRoute<Widget>(
              builder: (_) => const SizedBox(),
            )),
            onAddressTap: () => showAddressMenu(
                context, _addressKey, selectedAddress, (fn) => setState(() {})),
            onWithinTap: () => showWithinMenu(
                context, _withinKey, selectedWithin, (fn) => setState(() {})),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContentSection(
              scale: scale,
            ),
          ],
        ),
      ),

      // bottom nav: pill shaped with special home circle
    );
  }
}
