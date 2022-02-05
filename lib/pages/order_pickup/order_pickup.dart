import 'package:flutter/material.dart';
import 'package:login_sprint1/pages/order_pickup/items_form.dart';
import 'package:login_sprint1/pages/order_pickup/set_information_order.dart';
import 'package:flutter/cupertino.dart';

class OrderPickup extends StatefulWidget {
  const OrderPickup({Key? key}) : super(key: key);

  @override
  _OrderPickupState createState() => _OrderPickupState();
}

class _OrderPickupState extends State<OrderPickup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home"),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.arrow_left, color: Colors.white),
          ),
          backgroundColor: Color(0xff0077B6)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height - 80,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(19),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Text(
                          'Items',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0077B6),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          children: const [
                            Text(
                              'Set Items',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Flexible(child: MultiForm()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<ItemForm?> items = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEEEEEE),
                Color(0xFFEAEAEA),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: items.length <= 0
              ? Center(
                  child: Text("Tap + icon to add items"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  itemCount: items.length,
                  itemBuilder: (_, i) => items[i]!,
                ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF31B400),
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
              ),
              onPressed: onAddForm,
              child: Text("+"))
        ]),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Divider(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
                onPressed: onSave,
                child: const Text(
                  "Add Schedule",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(6),
                    shadowColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 7, 153)),
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 0, 119, 182)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))))),
          ),
        ),
      ],
    );
  }

  ///on form user deleted
  void onDelete(Item _item) {
    setState(() {
      var find = items.firstWhere(
        (it) => it!.item == _item,
        orElse: () => null,
      );
      if (find != null) items.removeAt(items.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _item = Item();
      items.add(ItemForm(
        item: _item,
        onDelete: () => onDelete(_item),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (items.length > 0) {
      var allValid = true;
      items.forEach((form) => allValid = allValid && form!.isValid());
      if (allValid) {
        var data = items.map((it) => it!.item).toList();
        var body = List<dynamic>.filled(data.length, {}, growable: true);
        for (int i = 0; i < data.length; i++) {
          var category_amount = {
            "category": data[i].category,
            "amount": data[i].amount,
          };
          body[i] = category_amount;
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => SetInformationOrder(
                      data: body,
                    )));
      }
    }
  }
}
