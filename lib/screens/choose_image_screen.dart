// @dart=2.9

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../http_unsplash.dart';
import '../model/unsplash_model.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import 'package:get/get.dart' as Get;
import 'list_goal_screen.dart';
// import 'dart:convert';

import 'choose_amount_screen.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({Key key}) : super(key: key);

  @override
  _ChooseImageState createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  bool isLoading = false;
  HttpUnsplash http;
  String query = Get.Get.arguments[0];

  List<UnsplashModel> images;

  Future getListUnsplashModel() async {
    Response response;

    try {
      isLoading = true;

      response = await http.getRequest("search/photos?query=$query");
      // response = await http.getRequest("/photos?query=cat");
      // print(response.data['results']);

      isLoading = false;

      if (response.statusCode == 200) {
        images =
            response.data['results'].map<UnsplashModel>((i) => UnsplashModel.fromJson(i)).toList();
        // print(jsonEncode(images));

        setState(() {});
        return images;
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  Future myFuture;
  @override
  void initState() {
    http = HttpUnsplash();
    myFuture = getListUnsplashModel();
    // print(images);
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
            tooltip: 'Comment Icon',
            onPressed: () {
              Get.Get.to(() => ListGoalScreen());
            },
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Choose Image',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 16,
              fit: FlexFit.tight,
              child: FutureBuilder(
                  future: myFuture,
                  builder: (context, snapshot) {
                    // print(snapshot);
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          final image = images[index];

                          return InkWell(
                            onTap: (() {
                              context.read<PostProvider>().updateImage(image.url);
                              Get.Get.to(() => ChooseAmount());
                            }),
                            child: Card(
                              color: Colors.grey,
                              child: Image.network(
                                image.url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // getListUnsplashModel();
                      // Get.Get.to(() => ChooseAmount());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
