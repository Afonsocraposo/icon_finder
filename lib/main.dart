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
  Iterable<String> iconKeys = ic.icons.keys;
  int previousLength = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                autofocus: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: controller,
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
                  final String filter = text.trim();
                  if (filter.length != previousLength) {
                    if (previousLength > filter.length) {
                      iconKeys = ic.icons.keys;
                    }
                    previousLength = filter.length;
                    Future.delayed(Duration.zero).then((_) => _filter());
                  }
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
              itemCount: iconKeys.length ?? 0,
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

  Future<void> _filter() async {
    final String filter = controller.text.trim();

    if (filter.isNotEmpty) {
      final List<String> filterTerms = filter.split(" ");
      iconKeys = iconKeys.where((String key) => filterTerms
          .map((String term) => key.contains(term))
          .every((bool result) => result));
    }
    setState(() {});
  }

  Widget getIcon(String iconKey) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            ic.icons[iconKey],
            size: ICON_SIZE,
          ),
          SelectableText(
            iconKey,
            textAlign: TextAlign.center,
          ),
        ],
      );
}
