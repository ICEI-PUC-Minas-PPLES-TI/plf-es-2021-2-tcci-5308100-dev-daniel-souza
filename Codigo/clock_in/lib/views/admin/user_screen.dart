// import 'dart:io';

// import 'package:clock_in/models/auth/user_model.dart';
// import 'package:clock_in/stores/add_user_store_copy.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:intl/intl.dart';
// import 'package:mobx/mobx.dart';
// import 'package:clock_in/views/components/utils/error_box.dart';
// import 'package:clock_in/views/components/utils/select_form.dart';
// import 'package:clock_in/views/components/utils/styles.dart';

// import '../components/utils/image_source_modal.dart';

// class MyAccountScreen extends StatefulWidget {
//   MyAccountScreen({
//     Key? key,
//     required this.user,
//   }) : super(key: key);

//   final User user;

//   @override
//   State<MyAccountScreen> createState() => _MyAccountScreen();
// }

// class _MyAccountScreen extends State<MyAccountScreen> {
//   final List<ReactionDisposer> _disposers = [];

//   @override
//   void dispose() {
//     for (var disposer in _disposers) {
//       disposer();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AddUserStoreCopy addUserStore = AddUserStoreCopy(widget.user);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Minha Conta"),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             elevation: 8,
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             child: Observer(builder: (_) {
//               return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 4, vertical: 16),
//                       child: GestureDetector(
//                         onTap: () {
//                           // if (Platform.isAndroid) {
//                           //   showModalBottomSheet(
//                           //     context: context,
//                           //     builder: (_) => ImageSourceModal(
//                           //       onImageSelected: onImageSelected,
//                           //     ),
//                           //   );
//                           // } else {
//                           //   showCupertinoModalPopup(
//                           //     context: context,
//                           //     builder: (_) => ImageSourceModal(
//                           //       onImageSelected: onImageSelected,
//                           //     ),
//                           //   );
//                           // }
//                         },
//                         child: addUserStore.user.photo == null
//                             ? CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: Colors.grey[400],
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Icon(
//                                       Icons.person_pin,
//                                       size: 50,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : CircleAvatar(
//                                 radius: 80,
//                                 backgroundImage: FileImage(addUserStore.user.photo),
//                               ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       child: Observer(builder: (_) {
//                         return TextFormField(
//                           initialValue: addUserStore.user.name,
//                           style: getFormTextStyle(),
//                           textInputAction: TextInputAction.next,
//                           autocorrect: false,
//                           onChanged: addUserStore.setName,
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                             ),
//                             contentPadding: getContentPadding(),
//                             labelText: "Nome *",
//                             labelStyle: getTextLabelStyle(),
//                           ),
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       child: Observer(builder: (_) {
//                         return TextFormField(
//                           initialValue: addUserStore.user.email,
//                           style: getFormTextStyle(),
//                           textInputAction: TextInputAction.next,
//                           onChanged: addUserStore.setEmail,
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                             ),
//                             contentPadding: getContentPadding(),
//                             labelText: "E-mail *",
//                             labelStyle: getTextLabelStyle(),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         );
//                       }),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       child: Observer(
//                         builder: (_) => AppDropdownInput<String>(
//                           hintText: "Cargo *",
//                           options: addUserStore.roles,
//                           value: addUserStore.post,
//                           onChanged: addUserStore.setPost,
//                           getLabel: (String value) => value,
//                         ),
//                       ),
//                     ),
//                     Observer(builder: (_) {
//                       return ErrorBox(
//                         message: addUserStore.error,
//                       );
//                     }),
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(
//                     //     horizontal: 12,
//                     //     vertical: 6,
//                     //   ),
//                     //   child: Observer(
//                     //     builder: (_) => AppDropdownInput<String>(
//                     //       hintText: "Tipo de Usuário *",
//                     //       options: const ['Administrador', 'Comum'],
//                     //       value: addUserStore.userTypeString ?? 'Comum',
//                     //       onChanged: addUserStore.setUserType,
//                     //       getLabel: (String value) => value,
//                     //     ),
//                     //   ),
//                     // ),
//                     Padding(
//                       padding: getContentPadding(),
//                       child: SizedBox(
//                         height: 50,
//                         child: Observer(
//                           builder: (_) => GestureDetector(
//                             onTap: () {},
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               child: Text(
//                                 'Finalizar Cadastro',
//                                 style: addUserStore.isFormValid
//                                     ? getFormTextStyle()
//                                     : getFormTextStyle()
//                                         .copyWith(color: Colors.grey),
//                               ),
//                               style: ButtonStyle(
//                                 enableFeedback: !addUserStore.isFormValid,
//                                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                 shape: MaterialStateProperty.resolveWith(
//                                   (_) => RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                 ),
//                                 backgroundColor: addUserStore.isFormValid
//                                     ? MaterialStateProperty.all(
//                                         const Color.fromARGB(
//                                             255, 109, 209, 218),
//                                       )
//                                     : MaterialStateProperty.all(
//                                         const Color.fromARGB(255, 116, 64, 43)
//                                             .withAlpha(800),
//                                       ),
//                                 foregroundColor:
//                                     MaterialStateProperty.all(Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
