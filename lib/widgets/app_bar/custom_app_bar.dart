// import 'package:flutter/material.dart';
// import 'package:wallpaper_2/core/app_export.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
//   const CustomAppBar(
//       {Key? key,
//         this.height,
//         this.shape,
//         this.leadingWidth,
//         this.leading,
//         this.title,
//         this.centerTitle,
//         this.actions
//       })
//       : super(key: key);
//
//   final double? height;
//   final ShapeBorder? shape;
//   final double? leadingWidth;
//   final Widget? leading;
//   final Widget? title;
//   final bool? centerTitle;
//   final List<Widget>? actions;
//
//   // @override
//   // final Size preferredSize;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       clipBehavior: Clip.none,
//       shape: shape,
//       toolbarHeight: height ?? 32.h,
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       leadingWidth: leadingWidth ?? 0,
//       leading: leading,
//       title: title,
//       titleSpacing: 0,
//       centerTitle: centerTitle ?? false,
//       actions: [
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: actions!,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size(SizeUtils.width, height ?? 32.h);
// }
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:wallpaper_2/core/app_export.dart';
// //
// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// //   const CustomAppBar({
// //     Key? key,
// //     this.height,
// //     this.shape,
// //     this.leadingWidth,
// //     this.leading,
// //     this.title,
// //     this.centerTitle,
// //     this.actions,
// //     this.bottomText, // Add optional bottom text
// //   }) : super(key: key);
// //
// //   final double? height;
// //   final ShapeBorder? shape;
// //   final double? leadingWidth;
// //   final Widget? leading;
// //   final Widget? title;
// //   final bool? centerTitle;
// //   final List<Widget>? actions;
// //   final String? bottomText; // Optional parameter for additional text below the app bar
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         AppBar(
// //           elevation: 0,
// //           shape: shape,
// //           toolbarHeight: height ?? 32.h,
// //           leadingWidth: leadingWidth ?? 0,
// //           leading: leading,
// //           title: title,
// //           titleSpacing: 0,
// //           centerTitle: centerTitle ?? false,
// //           actions: actions != null
// //               ? [
// //             SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: Row(
// //                 children: actions!,
// //               ),
// //             ),
// //           ]
// //               : null,
// //         ),
// //         if (bottomText != null) // Conditionally display the bottom text
// //           Padding(
// //             padding: EdgeInsets.only(left: 16.h, top: 10.h),
// //             child: Text(
// //               bottomText!,
// //               style: theme.textTheme.headlineSmall,
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   Size get preferredSize => Size(SizeUtils.width, height ?? 32.h);
// // }



import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.height,
    this.shape,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  final double? height;
  final ShapeBorder? shape;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56.h,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: shape ?? RoundedRectangleBorder(),
      ),
      //padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading widget
          leading != null
              ? SizedBox(
            width: leadingWidth ?? 56.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: leading,
            ),
          )
              : SizedBox(width: leadingWidth ?? 56.0),

          // Title
          if (title != null)
            Expanded(
              child: Align(
                alignment:
                centerTitle == true ? Alignment.center : Alignment.centerLeft,
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleLarge!,
                  child: title!,
                ),
              ),
            ),

          // Actions
          if (actions != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(SizeUtils.width, height ?? 32.h);
}
