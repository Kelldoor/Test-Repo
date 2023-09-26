
// Review this code as needed



import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Database Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true; // Look at ? towards bottom for info
  bool isLoadingItemsFromDatabase = false;

  List<Item> items = [
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU002"),
        Item("Some Item", 1, 1.99, "SKU003"),
        Item("Some Item", 1, 1.99, "SKU004"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        Item("Some Item", 1, 1.99, "SKU001"),
        // Commit new item
        Item("Some Item", 1, 1.99, "SKU002")
      ];

  void _handleButtonPress() {
    setState(() {
      //need setState for firstpage load
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;

      
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //need setState to update UI (or else itll keep loading)
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: const Text("Load items from database"),
              )
            : isLoadingItemsFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Please wait")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: items.map((item){ // for each item, the below stuff separates each item
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.Name, style: TextStyle(fontSize: 20)),
                              Text("ID: ${item.Id.toString()}"),
                              Text("Price: \$${item.Price.toStringAsFixed(2)}"),
                              Text("SKU: ${item.Sku}"),
                              const Divider()

                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}

class Item {
  String Name;
  int Id;
  double Price;
  String Sku;

  Item(this.Name, this.Id, this.Price, this.Sku);
}
