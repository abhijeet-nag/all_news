// import 'package:all_news/modules/language.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multi_select_flutter/util/multi_select_list_type.dart';
//
// import '../homePage.dart';
//
// class ChooseLanguage extends StatefulWidget {
//   const ChooseLanguage({Key? key}) : super(key: key);
//
//   @override
//   ChooseLanguageState createState() => ChooseLanguageState();
// }
//
// class ChooseLanguageState extends State<ChooseLanguage> {
//   static List<Languages?> _language = [
//     Languages(id: 1, lang: "हिंदी"),
//     Languages(id: 2, lang: "English"),
//     Languages(id: 3, lang: "বাংলা"),
//     Languages(id: 4, lang: "ગુજરાતિ"),
//     Languages(id: 5, lang: "ಕನ್ನಡ"),
//     Languages(id: 6, lang: "ਪੰਜਾਬੀ"),
//     Languages(id: 7, lang: "मराठी"),
//     Languages(id: 8, lang: "తెలుగు"),
//     Languages(id: 9, lang: "தமிழ்"),
//     Languages(id: 10, lang: "ଓଡିଆ"),
//     Languages(id: 11, lang: "മലയലം"),
//   ];
//
//   List selectedLanguage = [];
//
//   List<String> lan = [];
//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       child: MultiSelectDialogField(
//         height: MediaQuery.of(context).size.height / 2,
//         buttonIcon: Icon(Icons.arrow_drop_down),
//         buttonText: Text("Languages"),
//         title: Text("Select Language"),
//         backgroundColor: Colors.white,
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//         ),
//         items: _language.map((e) => MultiSelectItem(e, e!.lang)).toList(),
//         listType: MultiSelectListType.LIST,
//         onConfirm: (List<Languages?> v) {
//           setState(() {
//             lan = [];
//             selectedLanguage = v;
//           });
//           selectedLanguage.forEach((element) {
//             lan.add(element.lang);
//           });
//           HomePageState().changedData(["English"]);
//         },
//       ),
//     );
//   }
// }
