import 'dart:convert';
import 'package:all_news/modules/newsdata.dart';
import 'package:all_news/widgets/admob_services.dart';
import 'package:all_news/widgets/web.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'modules/categories.dart';
import 'modules/language.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static List<Languages?> _language = [
    Languages(id: 1, lang: "हिंदी"),
    Languages(id: 2, lang: "English"),
    Languages(id: 3, lang: "বাংলা"),
    Languages(id: 4, lang: "ગુજરાતિ"),
    Languages(id: 5, lang: "ಕನ್ನಡ"),
    Languages(id: 6, lang: "ਪੰਜਾਬੀ"),
    Languages(id: 7, lang: "मराठी"),
    Languages(id: 8, lang: "తెలుగు"),
    Languages(id: 9, lang: "தமிழ்"),
    Languages(id: 10, lang: "ଓଡିଆ"),
    Languages(id: 11, lang: "മലയലം"),
  ];

  var loaded;

  AdmobServices admobServices = new AdmobServices();

  static List<Categories?> _category = [
    Categories(id: 1, category: "Tech"),
    Categories(id: 2, category: "Business & Finance"),
    Categories(id: 3, category: "Stocks"),
    Categories(id: 4, category: "Current Affairs"),
    Categories(id: 5, category: "Health"),
    Categories(id: 6, category: "Lifestyle"),
    Categories(id: 7, category: "Sports"),
  ];

  final List _items = _category
      .map((category) =>
          MultiSelectItem<Categories>(category!, category.category))
      .toList();

  List selectedLanguage = [];
  List selectedCategory = [];

  List<String> lan = [];

  @override
  void initState() {
    super.initState();
    loaded = true;
    admobServices.loadRewardedAd();
    loadData();
  }

  var json, decodeData, data;

  changedData(List<String> lang) async {
    print("1st");
    DataModel.data.clear();
    await Future.delayed(Duration(seconds: 2));
    var json = await rootBundle.loadString("assets/news.json");
    var decodeData = jsonDecode(json);
    print("2nd");
    var data;
    List<NewsData> list;
    lang.forEach((element) {
      print(element);
      data = decodeData[element];
      list = List.from(data)
          .map<NewsData>((newsData) => NewsData.fromMap(newsData))
          .toList();
      DataModel.data.addAll(list);
      print(element);
    });
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 1));
    json = await rootBundle.loadString("assets/news.json");
    decodeData = jsonDecode(json);
    data = decodeData["हिंदी"];
    setState(() {
      DataModel.data = List.from(data)
          .map<NewsData>((newsData) => NewsData.fromMap(newsData))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          FittedBox(
            child: MultiSelectDialogField(
              height: MediaQuery.of(context).size.height / 2,
              buttonIcon: Icon(Icons.arrow_drop_down),
              buttonText: Text("Languages"),
              title: Text("Select Language"),
              backgroundColor: Colors.white,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              items: _language.map((e) => MultiSelectItem(e, e!.lang)).toList(),
              listType: MultiSelectListType.LIST,
              onConfirm: (List<Languages?> v) async {
                setState(() {
                  lan = [];
                  selectedLanguage = v;
                });
                selectedLanguage.forEach((element) {
                  lan.add(element.lang);
                });
                if (lan.length == 0 || lan.isEmpty) {
                  DataModel.data.clear();
                  await Future.delayed(Duration(seconds: 1));
                  data = decodeData["हिंदी"];
                  setState(() {
                    DataModel.data = List.from(data)
                        .map<NewsData>((newsData) => NewsData.fromMap(newsData))
                        .toList();
                  });
                } else {
                  DataModel.data.clear();
                  await Future.delayed(Duration(seconds: 1));
                  data = [];
                  List<NewsData> list;
                  lan.forEach((element) {
                    print(element);
                    data = decodeData[element];
                    list = List.from(data)
                        .map<NewsData>((newsData) => NewsData.fromMap(newsData))
                        .toList();
                    setState(() {
                      DataModel.data.addAll(list);
                    });
                    print(element);
                  });
                }
              },
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(35, 47, 52, 1),
        title: Text(
          "All News",
          style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      FittedBox(
                        child: loaded
                            ? Stack(
                                children: [
                                  MultiSelectChipField(
                                    items: _category
                                        .map((e) =>
                                            MultiSelectItem(e, e!.category))
                                        .toList(),
                                    onTap: (values) async {
                                      setState(() {
                                        lan = [];
                                        selectedCategory = values;
                                      });
                                      selectedCategory.forEach((element) {
                                        lan.add(element.category);
                                      });

                                      DataModel.data.clear();
                                      await Future.delayed(
                                          Duration(seconds: 1));
                                      data = [];
                                      List<NewsData> list;
                                      lan.forEach((element) {
                                        print(element);
                                        data = decodeData[element];
                                        list = List.from(data)
                                            .map<NewsData>((newsData) =>
                                                NewsData.fromMap(newsData))
                                            .toList();
                                        setState(() {
                                          DataModel.data.addAll(list);
                                        });
                                        print(element);
                                      });
                                    },
                                    scroll: true,
                                    height: 50,
                                    showHeader: false,
                                    selectedChipColor:
                                        Color.fromRGBO(249, 170, 51, 1),
                                    decoration:
                                        BoxDecoration(color: Colors.white70),
                                    selectedTextStyle:
                                        TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.defaultDialog(
                                          title: "Unlock All Features",
                                          middleText:
                                              "Watch Reward Video to Unlock all Features.",
                                          onCancel: () {},
                                          onConfirm: () {
                                            admobServices.showRewardedAd();
                                            setState(() {
                                              loaded = false;
                                            });
                                            Get.back();
                                          });
                                    },
                                    child: Container(
                                      color: Colors.black.withOpacity(0.4),
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: Center(
                                        child: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                child: MultiSelectChipField(
                                  items: _category
                                      .map((e) =>
                                          MultiSelectItem(e, e!.category))
                                      .toList(),
                                  onTap: (values) async {
                                    if (loaded) {
                                      Get.defaultDialog(
                                          title: "Unlock All features",
                                          middleText:
                                              "Watch Reward ad to unlock all features!",
                                          onCancel: () {},
                                          onConfirm: () {
                                            loaded = false;
                                            setState(() {});
                                          });
                                    } else {
                                      setState(() {
                                        lan = [];
                                        selectedCategory = values;
                                      });
                                      selectedCategory.forEach((element) {
                                        lan.add(element.category);
                                      });

                                      if (lan.length == 0 || lan.isEmpty) {
                                        DataModel.data.clear();
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        data = decodeData["हिंदी"];
                                        setState(() {
                                          DataModel.data = List.from(data)
                                              .map<NewsData>((newsData) =>
                                                  NewsData.fromMap(newsData))
                                              .toList();
                                        });
                                      } else {
                                        DataModel.data.clear();
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        data = [];
                                        List<NewsData> list;
                                        lan.forEach((element) {
                                          print(element);
                                          data = decodeData[element];
                                          list = List.from(data)
                                              .map<NewsData>((newsData) =>
                                                  NewsData.fromMap(newsData))
                                              .toList();
                                          setState(() {
                                            DataModel.data.addAll(list);
                                          });
                                          print(element);
                                        });
                                      }
                                    }
                                  },
                                  scroll: true,
                                  height: 50,
                                  showHeader: false,
                                  selectedChipColor:
                                      Color.fromRGBO(249, 170, 51, 1),
                                  decoration:
                                      BoxDecoration(color: Colors.white70),
                                  selectedTextStyle:
                                      TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      (DataModel.data.isNotEmpty)
                          ? Expanded(
                              child: Container(
                                height: double.maxFinite,
                                width: MediaQuery.of(context).size.width,
                                child: GridView.builder(
                                    padding: EdgeInsets.all(15),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      // childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 40,
                                    ),
                                    itemCount: DataModel.data.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                          child: Card(
                                            elevation: 10,
                                            margin: EdgeInsets.all(2),
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Color.fromRGBO(
                                                      35, 47, 52, 1),
                                                  padding: EdgeInsets.all(5),
                                                  child: Image.asset(
                                                    DataModel.data[index].image,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  height: 90,
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Center(
                                                      child: Text(DataModel
                                                          .data[index].name)),
                                                  height: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            // _launchURLApp(DataModel.data[index].url);
                                            Get.to(() => Web(),
                                                arguments:
                                                    DataModel.data[index].url);
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 70,
                child: AdWidget(
                  key: UniqueKey(),
                  ad: AdmobServices.createBannerAd()..load(),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 100,
      //   child: AdWidget(
      //       key: UniqueKey(), ad: AdmobServices.createBannerAd()..load()),
      // ),
    );
  }
}
