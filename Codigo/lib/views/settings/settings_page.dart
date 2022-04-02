// import 'package:flutter/material.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';
//
// // import 'app_settings_page.dart';
// // import 'cache_provider.dart';
//
// class AppBody extends StatefulWidget {
//   @override
//   _AppBodyState createState() => _AppBodyState();
// }
//
// class _AppBodyState extends State<AppBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         _buildClearCacheButton(context),
//         SizedBox(
//           height: 25.0,
//         ),
//         ElevatedButton(
//           onPressed: () {
//             openAppSettings(context);
//           },
//           child: Text('Start Demo'),
//         ),
//       ],
//     );
//   }
//
//   // void openAppSettings(BuildContext context) {
//   //   Navigator.of(context).push(MaterialPageRoute(
//   //     builder: (context) => AppSettings(title: "Configurações"),
//   //   ));
//   // }
//
//   Widget _buildClearCacheButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Settings.clearCache();
//         showSnackBar(
//           context,
//           'Cache cleared for selected cache.',
//         );
//       },
//       child: Text('Clear selected Cache'),
//     );
//   }
// }
//
// class AppSettings {}
//
// void showSnackBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: Theme.of(context).primaryColor,
//     ),
//   );
// }
