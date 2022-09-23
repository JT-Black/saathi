// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:saathi/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'choose_image_screen.dart';
import 'list_goal_screen.dart';

class ChooseGoalName extends StatefulWidget {
  const ChooseGoalName({Key key}) : super(key: key);

  @override
  State<ChooseGoalName> createState() => _ChooseGoalNameState();
}

class _ChooseGoalNameState extends State<ChooseGoalName> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  FocusNode focusNode;
  void _printLatestValue() {
    print('text field: ${nameController.text}');
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    // Start listening to changes.
    nameController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    focusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            tooltip: 'Comment Icon',
            onPressed: () {
              Get.Get.to(() => ListGoalScreen());
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Choose Goal Name',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.grey[800],
                child: Center(child: Icon(Icons.image, color: Colors.white, size: 76)),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        focusNode: focusNode,
                        autofocus: true,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (!isKeyboard)
              Flexible(
                flex: 1,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context.read<PostProvider>().updateName(nameController.text);
                        Get.Get.to(() => ChooseImage(), arguments: [nameController.text]);
                        // _printLatestValue();
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
