// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductsScreen extends StatefulWidget {
  static const String routeName = "/edit-prods";
  const EditProductsScreen({super.key});

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  Widget ConfigElevatedButton(
      IconData icon, String buttonText, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(buttonText),
          ],
        ),
      ),
    );
  }

  Widget imageUrlEmpty() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
            width: 1.8,
          ),
          borderRadius: BorderRadius.circular(18)),
      child: Center(
        child: FittedBox(
          child: Text(
            "Enter Url",
            style: TextStyle(
                fontSize: 23, color: Theme.of(context).primaryColorLight),
          ),
        ),
      ),
    );
  }

  Widget previewImage(Widget Child) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                width: 100,
                height: 300,
                child: Image.network(
                  _imageUrlController.text,
                  fit: BoxFit.contain,
                ),
              );
            });
      },
      child: ClipRRect(borderRadius: BorderRadius.circular(18), child: Child),
    );
  }

  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    _form.currentState!.save();

    if (!isValid) {
      return;
    }
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.title);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight,
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newTitle) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: newTitle.toString(),
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (newTitle) {
                  if (newTitle.toString().isEmpty) {
                    return "Enter a Valid Title";
                  }

                  return null; //Inpur is Correct
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColorLight,
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (newPrice) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(newPrice.toString()),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (newPrice) {
                  if (newPrice.toString().isEmpty) {
                    return "Enter valid price";
                  }
                  if (double.tryParse(newPrice.toString()) == null) {
                    return "Enter a Numeric Value";
                  }
                  if (double.parse(newPrice.toString()) <= 0) {
                    return "Enter a number greater than 0";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).primaryColorLight,
                    labelText: "Description",
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (newDesc) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: newDesc.toString(),
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (newDesc) {
                  if (newDesc.toString().isEmpty) {
                    return "Enter Product Description";
                  }
                  if (newDesc.toString().length < 10) {
                    return "Should be atleast 10 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    child: _imageUrlController.text.isEmpty
                        ? imageUrlEmpty()
                        : previewImage(
                            Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 250,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).primaryColorLight,
                        labelText: "Image URL",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (newURL) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: newURL.toString(),
                        );
                      },
                      validator: (newURL) {
                        if (newURL.toString().isEmpty) {
                          return "Enter Image URL";
                        }
                        if (!newURL.toString().startsWith("http") ||
                            newURL.toString().startsWith("https")) {
                          return "Enter a valid URL";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ConfigElevatedButton(Icons.save, "SUBMIT", _saveForm),
                  ConfigElevatedButton(Icons.delete, "RESET", () => null),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
