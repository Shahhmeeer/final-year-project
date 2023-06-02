import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp/widgets/custom_bottom_modal.dart';
import 'package:fyp/widgets/custom_button.dart';
import 'package:fyp/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  XFile? _image;
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productCategoryController = TextEditingController();

  @override
  void dispose() {
    _productCategoryController.dispose();
    _productDescriptionController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  Future _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = XFile(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.only(right: 5.0),
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => CustomBottomModal(
                          onPressed: _pickImage,
                        ),
                      );
                    },
                    child: const Text('Choose Product Image'),
                  ),
                  _image == null
                      ? Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green.shade700,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Add Image'),
                        )
                      : SizedBox(
                          width: 150.0,
                          height: 150.0,
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                controller: _productNameController,
                hintText: 'Product Name: ',
                isPasswordType: false,
                obsureText: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                controller: _productDescriptionController,
                hintText: 'Product Description: ',
                isPasswordType: false,
                obsureText: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextField(
                controller: _productCategoryController,
                hintText: 'Product Category ',
                isPasswordType: false,
                obsureText: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomButton(
                onTap: () {},
                message: 'Add Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
