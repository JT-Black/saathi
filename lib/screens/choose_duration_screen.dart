// @dart=2.9

import "package:flutter/material.dart";
import "package:get/get.dart" as Get;
import "package:saathi/providers/post_provider.dart";
import "package:provider/provider.dart";
import "list_goal_screen.dart";
import "package:dio/dio.dart";
import "package:saathi/http_service_api.dart";

class ChooseDuration extends StatefulWidget {
  const ChooseDuration({Key key}) : super(key: key);

  @override
  State<ChooseDuration> createState() => _ChooseDurationState();
}

class _ChooseDurationState extends State<ChooseDuration> {
  Response response;
  HttpServiceApi http;

  String selectedDurationType;
  int selectedDuration;

  @override
  void initState() {
    http = HttpServiceApi();

    super.initState();
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
            tooltip: "Comment Icon",
            onPressed: () {
              Get.Get.to(ListGoalScreen());
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          "Choose Duration",
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
                        child: Image.network(context.watch<PostProvider>().image))),
              ),
            ),
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                child: Column(
                  children: [
                    Text("Select Duration"),
                    DropdownButton<int>(
                      value: selectedDuration,
                      items: const [
                        DropdownMenuItem(value: 6, child: Text("6")),
                        DropdownMenuItem(value: 12, child: Text("12")),
                        DropdownMenuItem(value: 18, child: Text("18")),
                        DropdownMenuItem(value: 24, child: Text("24")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value;
                        });
                        context.read<PostProvider>().updateDuration(value);
                      },
                    ),
                    Text("Select Duration Type"),
                    DropdownButton<String>(
                      value: selectedDurationType,
                      items: const [
                        DropdownMenuItem(value: "Week", child: Text("Week")),
                        DropdownMenuItem(value: "Month", child: Text("Month")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedDurationType = value;
                        });
                        context.read<PostProvider>().updateDurationType("value");
                      },
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: ElevatedButton(
                  onPressed: () async {
                    var data = {
                      "name": Provider.of<PostProvider>(context, listen: false).name,
                      "amount": Provider.of<PostProvider>(context, listen: false).amount,
                      "image": Provider.of<PostProvider>(context, listen: false).image,
                      "currency": Provider.of<PostProvider>(context, listen: false).currency,
                      "duration": Provider.of<PostProvider>(context, listen: false).duration,
                      "duration_type":
                          Provider.of<PostProvider>(context, listen: false).durationType,
                      "state": "active",
                    };
                    print(data.runtimeType);
                    response = await http.postRequest("goals", data);

                    Get.Get.to(() => ListGoalScreen());
                  },
                  child: Text(
                    "Create Goal!",
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
