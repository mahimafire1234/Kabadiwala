import 'package:flutter/material.dart';

typedef OnDelete();

class
ItemForm extends StatefulWidget {
  final Item item;
  final state = _ItemFormState();
  final OnDelete onDelete;

  ItemForm({Key? key, required this.item, required this.onDelete}) : super(key: key);
  @override
  _ItemFormState createState() => state;

  bool isValid() => state.validate();
}

class _ItemFormState extends State<ItemForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(

                    initialValue: widget.item.category,
                    onSaved: (val) => widget.item.category = val!,
                    validator: (val) =>
                    val!.isNotEmpty ? null : 'Category is empty',
                    decoration: const InputDecoration(
                      hintText: 'Category',
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                flex: 1,
                  child: TextFormField(
                  initialValue: widget.item.amount,
                  onSaved: (val) => widget.item.amount = val!,
                  validator: (val) =>
                  val!.isNotEmpty ? null : 'Amount is empty',
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    isDense: true,
                  ),
                )
              ),
              SizedBox(width: 5.0),
              Expanded(
                flex: 1,
                  child: TextButton(
                    onPressed: widget.onDelete,
                    child: const Text(
                        '-',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF0000)
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}

class Item {
  String category;
  String amount;

  Item({this.category = '', this.amount = ''});
}
