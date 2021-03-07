import 'package:flutter/material.dart';
import 'icons.dart' as ic;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Icon Finder",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const CONTAINER_SIZE = 128.0;
const ICON_SIZE = 48.0;

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  String filter = "";
  Iterable<String> iconKeys = ic.icons.keys;
  bool grow = false;
  int previousLength = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (grow && filter.isNotEmpty) {
      final List<String> filterTerms = filter.split(" ");
      iconKeys = iconKeys.where((String key) => filterTerms
          .map((String term) => key.contains(term))
          .any((bool result) => result));
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "FLUTTER ICON FINDER",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 32),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search for icon",
                  hintStyle: TextStyle(color: Colors.white54),
                  errorBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                onChanged: (String text) {
                  final String trimmed = text.trim();
                  previousLength = filter.length;
                  if (previousLength < trimmed.length) {
                    grow = true;
                    if (trimmed != filter) {
                      setState(() {});
                    }
                  } else {
                    if (grow) {
                      grow = false;
                      setState(() {
                        iconKeys = ic.icons.keys;
                      });
                    }
                  }
                  filter = trimmed;
                },
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: iconKeys.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: CONTAINER_SIZE,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: CONTAINER_SIZE,
              ),
              itemBuilder: (BuildContext context, int index) =>
                  getIcon(iconKeys.elementAt(index)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Divider(),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Text("Made by Afonso Raposo - https://afonsoraposo.com"),
          ),
        ],
      ),
    );
  }

  Widget getIcon(String iconKey) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            ic.icons[iconKey],
            size: ICON_SIZE,
          ),
          Text(
            iconKey,
            textAlign: TextAlign.center,
          ),
        ],
      );
}
