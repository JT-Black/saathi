// @dart=2.9

import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:saathi/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'list_goal_screen.dart';
import './choose_duration_screen.dart';

class ChooseAmount extends StatefulWidget {
  const ChooseAmount({Key key}) : super(key: key);

  @override
  State<ChooseAmount> createState() => _ChooseAmountState();
}

class _ChooseAmountState extends State<ChooseAmount> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  String selectedCurrency = 'GBP';

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Get.Get.to(ListGoalScreen());
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Choose Amount',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.grey[800],
                child: Center(
                  child: FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(context.watch<PostProvider>().image)),
                ),
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
                        decoration: InputDecoration(
                          labelText: 'choose an amount',
                        ),
                        controller: amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Select Currency'),
                          DropdownButton<String>(
                            value: selectedCurrency,
                            items: const [
                              DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                              DropdownMenuItem(value: 'INR', child: Text('INR')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedCurrency = value;
                              });
                              context.read<PostProvider>().updateCurrency('value');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PostProvider>().updateAmount(int.parse(amountController.text));

                    Get.Get.to(() => ChooseDuration());
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
