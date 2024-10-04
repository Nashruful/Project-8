import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataLayer {
  final supabase = Supabase.instance.client;
  Map? currentUserInfo = {};

  String? firstTimeJoin ;

  final box = GetStorage();
  List<Map> itemsList = [];

  DataLayer() {
    print("heeeeeeeereeeeeeeeeeeee $firstTimeJoin ---- $currentUserInfo");
    loadData();
  }

  void addToCart({required Map<String, dynamic> item}) {
    if (!itemsList.contains(item)) {
      //  item['quantity'] = 1; //add quantity key to the map
      itemsList.add(item); //add the item to list
    }

    box.write('ProductsList', itemsList); // Store the item in the box
  }

  void removeFromCart({required Map<String, dynamic> item}) {
    //func to remove from cart
  }

  void incrementItemQuantity({required Map<String, dynamic> item}) {
    //func to increment quantity
    item['quantity'] = item['quantity']++;
  }

  List<Map<String, dynamic>> viewCartItems() {
    // Retrieve the stored item
    var storedItem = box.read('ProductsList') ?? [];
    return List<Map<String, dynamic>>.from(storedItem);
    // print('Stored Item: $storedItem');
    // print(storedItem.length);
  }

  getUserInfo() async {
    currentUserInfo = await supabase
        .from("users")
        .select()
        .eq("user_id", supabase.auth.currentUser!.id)
        .single();

    box.write("currentUser", currentUserInfo);
  }

  firstVisit() {
    firstTimeJoin = "true";
    box.write("firstTime", "true");
  }

  loadData() {
    // if (box.hasData("currentUser")) {
    //   currentUserInfo =  box.read("currentUser");
    // }
    if (box.hasData("firstTime")) {
      firstTimeJoin =  box.read("firstTime");
    }
  }
}
