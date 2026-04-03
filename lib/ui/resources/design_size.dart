import 'dart:developer';
import 'package:flutter/cupertino.dart';

enum DeviceType {
  mobile,
  foldOuter,
  tablet,
  macBookAir,
  desktopMedium, // Your 1440x1024 Figma
  macBookPro,
  desktopLarge,
  desktopExtraLarge,
  desktopSmall,  // Added for short browser windows
}

const _viewMap = {
  DeviceType.desktopExtraLarge: Size(2560, 1440),
  DeviceType.desktopLarge: Size(1920, 1080),
  DeviceType.macBookPro: Size(1512, 982),
  DeviceType.desktopMedium: Size(1440, 1024), // Main Figma Anchor
  DeviceType.macBookAir: Size(1280, 832),
  DeviceType.desktopSmall: Size(1024, 700),   // Short Desktop View
  DeviceType.tablet: Size(768, 1024),
  DeviceType.mobile: Size(390, 844),
  DeviceType.foldOuter: Size(320, 800),
};

Size getDesignSize(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final width = size.width;
  final height = size.height;
  final orientation = MediaQuery.orientationOf(context);

  DeviceType deviceType;

  // 1. Check for Foldables/Small Mobiles with height
  if (width < 360) {
    deviceType = (height > 750) ? DeviceType.foldOuter : DeviceType.mobile;
  }
  // 2. Standard Mobile
  else if (width < 600) {
    deviceType = DeviceType.mobile;
  }
  // 3. Tablet vs. Short Desktop
  else if (width < 1024) {
    // If screen is short, it's likely a desktop browser window, not a tablet
    deviceType = (height < 700) ? DeviceType.desktopSmall : DeviceType.tablet;
  }
  // 4. MacBook Air / Laptop
  else if (width < 1366) {
    deviceType = DeviceType.macBookAir;
  }
  // 5. Your 1440 Figma Design (Desktop Medium)
  else if (width < 1550) {
    deviceType = DeviceType.desktopMedium;
  }
  // 6. MacBook Pro
  else if (width < 1720) {
    deviceType = DeviceType.macBookPro;
  }
  // 7. Large Desktop
  else if (width < 2200) {
    deviceType = DeviceType.desktopLarge;
  }
  // 8. 4K / Ultra-wide
  else {
    deviceType = DeviceType.desktopExtraLarge;
  }

  log('DEVICE: $deviceType | W: ${width.toInt()} H: ${height.toInt()}');

  Size designSize = _viewMap[deviceType]!;

  // Swap dimensions for mobile/tablet landscape to prevent stretching
  if (orientation == Orientation.landscape && width < 1024) {
    return Size(designSize.height, designSize.width);
  }

  return designSize;
}
