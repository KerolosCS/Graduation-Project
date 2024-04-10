import 'package:flutter/material.dart';

class WordsViewBody extends StatelessWidget {
  const WordsViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> words = [
      "عاطف",
      "فادي",
      "امين",
      "ماركو",
      "مايكل",
      "ابرام",
      "تيمور",
      "وانا وانت",
      "يا حبيبي",
    ];
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: words.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              return GridTile(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(words[index]),
                ),
              ));
            }),
      ),
    );
  }
}
