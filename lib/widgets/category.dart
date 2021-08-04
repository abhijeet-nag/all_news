// import 'package:all_news/modules/categories.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
//
// class Category extends StatefulWidget {
//   const Category({Key? key}) : super(key: key);
//
//   @override
//   _CategoryState createState() => _CategoryState();
// }
//
// class _CatgoryState extends State<Category> {
//   static List<Categories?> _category = [
//     Categories(id: 1, category: "Tech"),
//     Categories(id: 2, category: "Business & Finance"),
//     Categories(id: 3, category: "Stocks"),
//     Categories(id: 4, category: "Current Affairs"),
//     Categories(id: 5, category: "Health"),
//     Categories(id: 6, category: "Lifestyle"),
//     Categories(id: 7, category: "Sports"),
//   ];
//
//   final List _items = _category
//       .map((category) =>
//           MultiSelectItem<Categories>(category!, category.category))
//       .toList();
//
//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       child: Container(
//         // padding: EdgeInsets.symmetric(horizontal: 5),
//         width: MediaQuery.of(context).size.width,
//         child: MultiSelectChipField(
//           items: _category.map((e) => MultiSelectItem(e, e!.category)).toList(),
//           onTap: (values) {
//             //_selectedAnimals4 = values;
//           },
//           scroll: true,
//           title: Text(
//             "Select You Favorite Category",
//             style: TextStyle(color: Colors.white),
//           ),
//           showHeader: false,
//           selectedChipColor: Color.fromRGBO(249, 170, 51, 1),
//           decoration: BoxDecoration(color: Colors.white70),
//           selectedTextStyle: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
