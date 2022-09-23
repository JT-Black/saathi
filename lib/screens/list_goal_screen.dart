// @dart=2.9

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:dio/dio.dart';
import 'package:saathi/screens/single_goal_screen.dart';
import '../http_service_api.dart';
import '../model/goal.dart';
import 'package:get/get.dart' as Get;
import 'choose_goal_name_screen.dart';

class ListGoalScreen extends StatefulWidget {
  const ListGoalScreen({Key key}) : super(key: key);

  @override
  _ListGoalScreenState createState() => _ListGoalScreenState();
}

class _ListGoalScreenState extends State<ListGoalScreen> {
  bool isLoading = false;
  HttpServiceApi http;

  List<Goal> goals;

  Future getListGoal() async {
    Response response;

    try {
      isLoading = true;

      response = await http.getRequest("/goals");
      // print(response);

      isLoading = false;

      if (response.statusCode == 200) {
        goals = response.data.map<Goal>((i) => Goal.fromJson(i)).toList();
        print(goals[0]);

        setState(() {});
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
    getListGoal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Neumorphic(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                      top: 20,
                      bottom: 10,
                    ),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
                        depth: 1,
                        intensity: 0.8,
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
                  Neumorphic(
                    style: NeumorphicStyle(
                        lightSource: LightSource(-.5, -.6),
                        shape: NeumorphicShape.flat,
                        intensity: 1,
                        depth: -4,
                        color: Colors.white),
                    margin: const EdgeInsets.only(left: 20.0, right: 20, top: 0, bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Savings Balance',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Text('£ 7,724.12',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Neumorphic(
                    margin: const EdgeInsets.only(left: 20.0, right: 20, top: 0, bottom: 10),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
                        depth: 3,
                        intensity: 0.8,
                        lightSource: LightSource(-.5, -.6),
                        color: Colors.grey[500]),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeumorphicText(
                            'GOALS',
                            style: NeumorphicStyle(
                              depth: 1,
                              intensity: 2,
                              lightSource: LightSource.top,
                              color: Colors.white,
                            ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Get.Get.to(() => ChooseGoalName());
                              },
                              child: NeumorphicIcon(
                                Icons.add_circle,
                                size: 50,
                                style: NeumorphicStyle(
                                  depth: 2,
                                  intensity: 2,
                                  lightSource: LightSource.top,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final goal = goals[index];
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 4, right: 18.0, left: 18.0, bottom: 4),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                depth: 2,
                                intensity: 1,
                                lightSource: LightSource(-.5, -.6),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ListTile(
                                onTap: () {
                                  Get.Get.to(() => SingleGoalScreen(), arguments: [goal.id]);
                                },
                                title: Text(
                                  goal.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading: Image.network(goal.image, errorBuilder:
                                    (BuildContext context, Object exception,
                                        StackTrace stackTrace) {
                                  return Text('image not found');
                                }),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "£ ",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          "${goal.amount}",
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      goal.state,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: goals.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
