import 'package:flutter/material.dart';

const num FIGMA_DESIGN_WIDTH = 360;
const num FIGMA_DESIGN_HEIGHT = 800;
const num FIGMA_DESIGN_STATUS_BAR = 0;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get h => ((this * _width) / FIGMA_DESIGN_WIDTH);
  double get fSize => ((this * _width) / FIGMA_DESIGN_WIDTH);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context, Orientation orientation, DeviceType deviceType);

class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeUtils.setScreenSize(constraints, orientation);
        return builder(context, orientation, SizeUtils.deviceType);
      });
    });
  }
}

class SizeUtils {
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late DeviceType deviceType;
  static late double height;
  static late double width;

  static void setScreenSize(BoxConstraints constraints, Orientation currentOrientation) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Handle orientation
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = boxConstraints.maxWidth.isNonZero();
    }

    // Determine device type based on screen size
    if (width < 600) {
      deviceType = DeviceType.mobile;
    } else if (width >= 600 && width < 1024) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.desktop;
    }
  }
}



// import 'package:flutter/cupertino.dart';
//
// extension ResponsiveExtension on num {
//   double get _width => SizeUtils.width;
//   double get _height => SizeUtils.height;
//
//   // Convert based on width
//   double get w => (this * _width) / SizeUtils.screenWidth;
//
//   // Convert based on height
//   double get h => (this * _height) / SizeUtils.screenHeight;
//
//   // Font size scaling based on width
//   double get fSize => (this * _width) / SizeUtils.screenWidth;
// }
//
// extension FormatExtension on double {
//   double toDoubleValue({int fractionDigits = 2}) {
//     return double.parse(this.toStringAsFixed(fractionDigits));
//   }
//
//   double isNonZero({num defaultValue = 0.0}) {
//     return this > 0 ? this : defaultValue.toDouble();
//   }
// }
//
// enum DeviceType { mobile, tablet, desktop }
//
// typedef ResponsiveBuild = Widget Function(
//     BuildContext context, Orientation orientation, DeviceType deviceType);
//
// class Sizer extends StatelessWidget {
//   const Sizer({super.key, required this.builder});
//
//   final ResponsiveBuild builder;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return OrientationBuilder(builder: (context, orientation) {
//         SizeUtils.setScreenSize(constraints, orientation, context);
//         return builder(context, orientation, SizeUtils.deviceType);
//       });
//     });
//   }
// }
//
// class SizeUtils {
//   static late BoxConstraints boxConstraints;
//   static late Orientation orientation;
//   static late DeviceType deviceType;
//   static late double height;
//   static late double width;
//   static late double screenWidth;
//   static late double screenHeight;
//
//   static void setScreenSize(BoxConstraints constraints, Orientation currentOrientation, BuildContext context) {
//     boxConstraints = constraints;
//     orientation = currentOrientation;
//
//     // Screen size using MediaQuery for accurate dimensions
//     final mediaQuery = MediaQuery.of(context);
//     screenWidth = mediaQuery.size.width;
//     screenHeight = mediaQuery.size.height;
//
//     if (orientation == Orientation.portrait) {
//       width = boxConstraints.maxWidth.isNonZero(defaultValue: screenWidth);
//       height = boxConstraints.maxHeight.isNonZero(defaultValue: screenHeight);
//     } else {
//       width = boxConstraints.maxHeight.isNonZero(defaultValue: screenHeight);
//       height = boxConstraints.maxWidth.isNonZero(defaultValue: screenWidth);
//     }
//
//     // Determine device type based on screen size
//     if (screenWidth < 600) {
//       deviceType = DeviceType.mobile;
//     } else if (screenWidth >= 600 && screenWidth < 1024) {
//       deviceType = DeviceType.tablet;
//     } else {
//       deviceType = DeviceType.desktop;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// /// Extension for responsive scaling based on screen width and height.
// extension ResponsiveExtension on num {
//   /// Dynamically calculated width based on screen dimensions.
//   double get w => (this * SizeUtils.width) / SizeUtils.designWidth;
//
//   /// Dynamically calculated height based on screen dimensions.
//   double get h => (this * SizeUtils.height) / SizeUtils.designHeight;
//
//   /// Font size scaling based on width for consistent text scaling.
//   double get fSize => (this * SizeUtils.width) / SizeUtils.designWidth;
// }
//
// /// Extension for formatting doubles.
// extension FormatExtension on double {
//   /// Converts the value to a fixed number of decimal places.
//   double toDoubleValue({int fractionDigits = 2}) {
//     return double.parse(this.toStringAsFixed(fractionDigits));
//   }
//
//   /// Returns the value if non-zero, otherwise returns the default value.
//   double isNonZero({num defaultValue = 0.0}) {
//     return this > 0 ? this : defaultValue.toDouble();
//   }
// }
//
// /// Enum to classify device types.
// enum DeviceType { mobile, tablet, desktop }
//
// /// A typedef for the responsive builder function.
// typedef ResponsiveBuild = Widget Function(
//     BuildContext context, Orientation orientation, DeviceType deviceType);
//
// /// A widget to manage responsive layouts for Material apps.
// class Sizer extends StatelessWidget {
//   const Sizer({super.key, required this.builder});
//
//   final ResponsiveBuild builder;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return OrientationBuilder(builder: (context, orientation) {
//         SizeUtils.setScreenSize(constraints, orientation, context);
//         return builder(context, orientation, SizeUtils.deviceType);
//       });
//     });
//   }
// }
//
// /// Utility class for managing screen size and device type.
// class SizeUtils {
//   /// Design dimensions (used for scaling calculations).
//   static const double designWidth = 360;
//   static const double designHeight = 800;
//
//   /// Box constraints and orientation.
//   static late BoxConstraints boxConstraints;
//   static late Orientation orientation;
//
//   /// Device properties.
//   static late DeviceType deviceType;
//   static late double width;
//   static late double height;
//   static late double screenWidth;
//   static late double screenHeight;
//
//   /// Initialize screen size and device type.
//   static void setScreenSize(
//       BoxConstraints constraints, Orientation currentOrientation, BuildContext context) {
//     boxConstraints = constraints;
//     orientation = currentOrientation;
//
//     // Use MediaQuery for accurate screen dimensions.
//     final mediaQuery = MediaQuery.of(context);
//     screenWidth = mediaQuery.size.width;
//     screenHeight = mediaQuery.size.height;
//
//     if (orientation == Orientation.portrait) {
//       width = boxConstraints.maxWidth.isNonZero(defaultValue: screenWidth);
//       height = boxConstraints.maxHeight.isNonZero(defaultValue: screenHeight);
//     } else {
//       width = boxConstraints.maxHeight.isNonZero(defaultValue: screenHeight);
//       height = boxConstraints.maxWidth.isNonZero(defaultValue: screenWidth);
//     }
//
//     // Determine the device type based on screen width.
//     if (screenWidth < 600) {
//       deviceType = DeviceType.mobile;
//     } else if (screenWidth >= 600 && screenWidth < 1024) {
//       deviceType = DeviceType.tablet;
//     } else {
//       deviceType = DeviceType.desktop;
//     }
//   }
// }
