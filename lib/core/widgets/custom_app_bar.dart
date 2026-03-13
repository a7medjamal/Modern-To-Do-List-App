import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final String? iconPath;
  final String? pfpPath;
  final String? pName;
  final String? taskName;
  final bool taskScreen;

  const CustomAppBar({
    super.key,
    this.iconPath,
    this.pfpPath,
    this.pName,
    this.taskName,
    this.taskScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff7A12FF), width: 1)),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: AppBar(
        backgroundColor: const Color(0xff242443),
        toolbarHeight: 80,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskScreen ? (taskName ?? '') : 'Hello ${pName ?? 'User'},',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            if (!taskScreen) ...[
              const SizedBox(height: 5),
              const Text(
                'Keep Plan For 1 Day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          if (iconPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                iconPath!,
                height: 30,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            const SizedBox(width: 1),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: SvgPicture.asset(
            pfpPath ?? 'assets/icons/profile_icon.svg',
            fit: BoxFit.contain,
            height: 32,
          ),
        ),
      ),
    );
  }
}
