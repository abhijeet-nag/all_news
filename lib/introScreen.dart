import 'package:all_news/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      onDone: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomePage()));
      },
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
            title: "Now, All App at one Place 😀",
            body: "Now You can watch any app news Here!",
            image: Image.asset('images/introImages/Intro1.jpg'),
            decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                bodyTextStyle: TextStyle(fontSize: 15, color: Colors.grey))),
        PageViewModel(
            title: "Stay Free To Find News App",
            body: "Keep Calm and Enjoy!",
            image: Image.asset('images/introImages/Intro2.jpg'),
            decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                bodyTextStyle: TextStyle(fontSize: 15, color: Colors.grey))),
        PageViewModel(
            title: "Explore News in Every Language",
            body: "Language Restriction is Over.",
            image: Image.asset('images/introImages/Intro3.jpg'),
            decoration: PageDecoration(
                titleTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                bodyTextStyle: TextStyle(fontSize: 15, color: Colors.grey))),
      ],
    );
  }
}
