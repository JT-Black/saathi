// @dart=2.9

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:saathi/screens/list_goal_screen.dart';
import '../http_service_api.dart';
import '../model/goal.dart';
import 'package:get/get.dart' as Get;

class SingleGoalScreen extends StatefulWidget {
  const SingleGoalScreen({Key key}) : super(key: key);

  @override
  _SingleGoalScreenState createState() => _SingleGoalScreenState();
}

class _SingleGoalScreenState extends State<SingleGoalScreen> {
  bool isLoading = false;
  HttpServiceApi http;

  Goal goal;
  String goalId = Get.Get.arguments[0];

  Future getGoal() async {
    Response response;
    try {
      isLoading = true;

      response = await http.getRequest("/goals/$goalId");

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          goal = Goal.fromJson(response.data);
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpServiceApi();

    getGoal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        fit: FlexFit.loose,
                        child: Neumorphic(
                          margin: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 20,
                            bottom: 16,
                          ),
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
                              depth: 5,
                              intensity: 2,
                              lightSource: LightSource.top,
                              color: Colors.grey[500]),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Container(
                                child: NeumorphicText(
                                  'SAATHI',
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    intensity: 2,
                                    lightSource: LightSource.top,
                                    color: Colors.white,
                                  ),
                                  textStyle: NeumorphicTextStyle(
                                    wordSpacing: 30,
                                    fontSize: 58,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 9,
                        fit: FlexFit.loose,
                        child: Neumorphic(
                            margin: const EdgeInsets.only(top: 0, bottom: 5, left: 0, right: 0),
                            style: NeumorphicStyle(
                              depth: 8,
                              intensity: 1,
                              lightSource: LightSource.top,
                              color: Colors.white,
                            ),
                            child: SizedBox(
                                height: 240, child: Image.network(goal.image, fit: BoxFit.cover))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              intensity: .8,
                              depth: -8,
                            ),
                            margin:
                                const EdgeInsets.only(top: 10, bottom: 0, left: 18.0, right: 18.0),
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, right: 8.0, left: 8.0, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Goal: ${goal.name} ${goal.amount}",
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              intensity: .8,
                              depth: -8,
                            ),
                            margin:
                                const EdgeInsets.only(top: 5, bottom: 5, left: 18.0, right: 18.0),
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, right: 8.0, left: 8.0, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Amount: ${goal.currency}  £${goal.amount}",
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              intensity: .8,
                              depth: -8,
                            ),
                            margin:
                                const EdgeInsets.only(top: 0, bottom: 5, left: 18.0, right: 18.0),
                            child: SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, right: 8.0, left: 8.0, bottom: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Duration: ${goal.duration} ${goal.durationType}",
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.Get.to(() => ListGoalScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
