import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuPage());
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final CollectionReference menuCollection =
  FirebaseFirestore.instance.collection('Restaurants').doc('menu').collection('dishes');

  List<Map<String, dynamic>> menuItems = [];

  String newName = '';
  double newPrice = 0.0;
  int editIndex = -1;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'restaurant@gmail.com', password: 'vcet1234');
    // Fetch menu items from Firebase on initialization
    // fetchMenuItems();
  }


  // void fetchMenuItems() async {
  //   QuerySnapshot snapshot = await menuCollection.get();
  //   setState(() {
  //     menuItems = snapshot.docs.map((doc) => doc.data()).toList();
  //   });
  // }

  void addDish(String name, double price) async {
    setState(() {
      menuItems.add({
        "type": "Burger",
        "name": name,
        "price": price,
        "location": "G-1, Nishal Center, Near Nishal Circle, Pal Gam, Adajan, Surat, Gujarat 394510",
        "review": 4.5,
      });
    });
    try {
      await menuCollection.doc(name).set({
        'name': name,
        'price': price,
      });
    } catch (e) {
      print("Error adding dish: $e");
    }
  }

  void updateDish(String name, double price) async {
    setState(() {
      int index = menuItems.indexWhere((dish) => dish['name'] == name);
      if (index != -1) {
        menuItems[index]['price'] = price;
      }
    });
    try {
      await menuCollection.doc(name).update({
        'price': price,
      });
    } catch (e) {
      print("Error updating dish: $e");
    }
  }

  void deleteDish(String name) async {
    setState(() {
      menuItems.removeWhere((dish) => dish['name'] == name);
    });
    try {
      await menuCollection.doc(name).delete();
    } catch (e) {
      print("Error deleting dish: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Menu'),
        ),
        body: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: editIndex == index
                  ? TextField(
                onChanged: (value) {
                  setState(() {
                    newName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Dish Name'),
              )
                  : Text(menuItems[index]['name']),
              subtitle: editIndex == index
                  ? TextField(
                onChanged: (value) {
                  setState(() {
                    newPrice = double.parse(value);
                  });
                },
                decoration: InputDecoration(labelText: 'Price'),
              )
                  : Text('\$${menuItems[index]['price']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteDish(menuItems[index]['name']);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Dish'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            newName = value;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Dish Name'),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            newPrice = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(labelText: 'Price'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        addDish(newName, newPrice);
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
