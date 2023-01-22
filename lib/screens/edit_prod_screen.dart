// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/config_widgets.dart';

class EditProductsScreen extends StatefulWidget {
  static const String routeName = "/edit-prods";
  const EditProductsScreen({super.key});

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  var _initValues = {
    "id": "",
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final prodId = ModalRoute.of(context)!.settings.arguments;
    if (prodId != null) {
      _editedProduct = Provider.of<ProductsProvider>(
        context,
        listen: false,
      ).findById(prodId.toString());
      _initValues = {
        "title": _editedProduct.title,
        "description": _editedProduct.description,
        "price": _editedProduct.price.toString(),
        "imageUrl": _editedProduct.imageUrl
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != "") {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("An error occurred!"),
              content: const Text("Something went wrong, try again later"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"))
              ],
            );
          },
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
    // Navigator.of(context).pop();
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues["title"],
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
                          isFavourite: _editedProduct.isFavourite,
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
                      initialValue: _initValues["price"],
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
                          isFavourite: _editedProduct.isFavourite,
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
                      initialValue: _initValues["description"],
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
                          isFavourite: _editedProduct.isFavourite,
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
                              ? imageUrlEmpty(context)
                              : previewImage(
                                  Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.contain,
                                  ),
                                  context,
                                  _imageUrlController),
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
                                isFavourite: _editedProduct.isFavourite,
                              );
                            },
                            validator: (newURL) {
                              if (newURL.toString().isEmpty) {
                                return "Enter Image URL";
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
