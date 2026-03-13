import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

BottomNavigationBarItem buildNavItem(
  String asset,
  String label,
  int index,
  int selectedIndex,
  VoidCallback onTap,
) {
  final bool isSelected = selectedIndex == index;
  return BottomNavigationBarItem(
    icon: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
        decoration:
            isSelected
                ? BoxDecoration(
                  color: const Color(0xff2E2E5D),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xff7454F8), width: 1),
                )
                : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? const Color(0xffffffff)
                    : const Color(0xff777E99),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color:
                    isSelected
                        ? const Color(0xffffffff)
                        : const Color(0xff777E99),
              ),
            ),
          ],
        ),
      ),
    ),
    label: '',
  );
}
