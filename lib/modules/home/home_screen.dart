import 'package:flutter/material.dart';
import 'package:mimic/presentation/resourses/color_manager.dart';
import 'package:mimic/presentation/resourses/font_manager.dart';
import 'package:mimic/presentation/resourses/styles_manager.dart';
import 'package:mimic/shared/methods.dart';
import 'package:mimic/widgets/mimic_icons.dart';
import 'package:mimic/widgets/mimic_logo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: MimicLogo(width: screenWidth(context) * 0.25),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            MimicIcons.menu,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                MimicIcons.notifications,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      drawer: const _HomeDrawer(),
      body: Column(
        children: [
          SizedBox(
              height: screenHeight(context) * 0.2, child: const _Highlights())
        ],
      ),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            const _DrawerHeader(),
            const SizedBox(height: 20),
            _drawerItem('Feed', MimicIcons.feed),
            _drawerItem('Discove peopler', MimicIcons.discover),
            _drawerItem('How To Challenge', MimicIcons.help),
            _drawerItem('Support', MimicIcons.customerService),
            const Divider(),
            _drawerItem('Login/Register', MimicIcons.login),
            const Spacer(),
            MimicLogo(width: screenWidth(context) * 0.2),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon, {VoidCallback? onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: FontSize.s16),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: screenHeight(context) * 0.18,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: ColorManager.white,
              size: 40,
            ),
            const SizedBox(width: 10),
            Text(
              'Guest user account',
              style: getBoldStyle(
                  fontSize: FontSize.s16, color: ColorManager.white),
            )
          ],
        ),
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Highlights',
          style: getBoldStyle(fontSize: FontSize.s18),
        ),
        SizedBox(height: 10),
        ListView.builder(
          itemBuilder: (_, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: _HighlightItem(),
            );
          },
          itemCount: 5,
          scrollDirection: Axis.horizontal,
        )
      ],
    );
  }
}

class _HighlightItem extends StatelessWidget {
  const _HighlightItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorManager.black.withOpacity(0.5)),
          child: Image.asset('assets/images/static/highlight_image.png'),
        ),
        Row(
          children: [
            Image.asset('assets/images/static/avatar.png'),
            Column(
              children: [
                Text(
                  'Ola ahmed',
                  style: getSemiBoldStyle(color: ColorManager.white),
                ),
                Text(
                  '2 Min ago',
                  style: getRegularStyle(color: ColorManager.lightGrey),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
