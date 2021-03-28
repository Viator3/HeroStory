import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(MyHeroStory());
}

class MyHeroStory extends StatefulWidget {
  @override
  MyTemplateState createState() => MyTemplateState();
}

class MyTemplateState extends State<MyHeroStory> {
  bool _isButtonDisabled = false;
  String door = '';
  String choiceDoors = 'Four closed doors. Which one do you want to open: n/s/e/w/end:';
  int rooms = 10;
  int lives = 5;
  int resultInRoom = 0;
  String goingOnRoom = '';
  String roomDescription = 'NEW GAME';
  String situation = 'Hero alive';
  AssetImage image = AssetImage('assets/fall_game.png');
  RoomDescriptions roomDescriptions = RoomDescriptions();

  void _travel(String partWorld) {
    if (partWorld != 'END GAME') {
      RoomAction roomAction = randomRoom();
      resultInRoom = roomAction.resultInRoom;
      goingOnRoom = roomAction.goingOnRoom;

      roomDescription = roomDescriptions.get();

      lives += resultInRoom;
      rooms--;
    }
    setState(() {
      door = 'You opened $partWorld door';

      if (lives < 1 || partWorld == 'END GAME') {
        image = AssetImage('assets/fall_lose_2.png');
        situation = 'Hero DIED';
        _isButtonDisabled = true;
        door = 'GAME OVER';
        choiceDoors = '';
      } else if (rooms < 1 && lives > 0) {
        image = AssetImage('assets/fall_win.png');
        situation = 'Hero WON';
        _isButtonDisabled = true;
        door = 'GAME OVER';
        choiceDoors = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: double.infinity, // MediaQuery.of(context).size.width
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/rpg.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          roomDescription,
                          style: TextStyle(
                            fontFamily: 'NewTegominRegular',
                              fontSize: 17
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          goingOnRoom,
                          style: TextStyle(
                            fontFamily: 'NewTegominRegular',
                              fontSize: 25
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            '$resultInRoom',
                            style: TextStyle(
                              fontFamily: 'NewTegominRegular',
                              fontSize: 30
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // color: Colors.green[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // color: Colors.red,
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Rooms: $rooms',
                                        style: TextStyle(
                                          fontFamily: 'NewTegominRegular',
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Lives: $lives',
                                        style: TextStyle(
                                            fontFamily: 'NewTegominRegular',
                                            fontSize: 20
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        situation,
                                        style: TextStyle(
                                            fontFamily: 'NewTegominRegular',
                                            fontSize: 17
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: const Icon(AntDesign.upcircleo,),
                                  color: Colors.indigo,
                                  iconSize: 70,
                                  // onPressed: _isButtonDisabled ? null : _travel,
                                  onPressed: () => _isButtonDisabled ? null : _travel('NORTH'),
                                ),
                                // color: Colors.red,
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: image,
                                  ),
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: IconButton(
                                  icon: const Icon(AntDesign.leftcircleo,),
                                  color: Colors.indigo,
                                  iconSize: 70,
                                  // onPressed: _isButtonDisabled ? null : _travel,
                                  onPressed: () => _isButtonDisabled ? null : _travel('WEST'),
                                ),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: IconButton(
                                  icon: const Icon(AntDesign.rightcircleo,),
                                  color: Colors.indigo,
                                  iconSize: 70,
                                  // onPressed: _isButtonDisabled ? null : _travel,
                                  onPressed: () => _isButtonDisabled ? null : _travel('EAST'),
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                // color: Colors.red,
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                child: IconButton(
                                  icon: const Icon(AntDesign.downcircleo,),
                                  color: Colors.indigo,
                                  iconSize: 70,
                                  // onPressed: _isButtonDisabled ? null : _travel,
                                  onPressed: () => _isButtonDisabled ? null : _travel('SOUTH'),
                                ),
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                // color: Colors.red,
                                width: 100,
                                height: 100,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: TextButton(
                                          child: Text(
                                            'END GAME',
                                            style: TextStyle(
                                              fontFamily: 'NewTegominRegular',
                                              color: Colors.red,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          // onPressed: _isButtonDisabled ? null : _travel,
                                          onPressed: () => _isButtonDisabled ? null : _travel('END GAME'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  margin: EdgeInsets.all(5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            choiceDoors,
                            style: TextStyle(fontFamily: 'NewTegominRegular',),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          door,
                          style: TextStyle(fontFamily: 'NewTegominRegular',),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomAction {
  String goingOnRoom;
  int resultInRoom;

  RoomAction(this.goingOnRoom, this.resultInRoom);
}

RoomAction randomRoom(){
  List<RoomAction> result = [RoomAction('Room is empty', 0), RoomAction('Here is a health potion!', 1), RoomAction('Monster in the room! Angar!', -2)];
  return result[Random().nextInt(3)];
}

class RoomDescriptions {
  List<String> roomDescriptions = [
    '1 - A gloomy dungeon, a bare brick wall, a collapsed ceiling, several doors leading in different directions',
    '2 - Apparently this is the former armory room. But everything has long been rusted and covered with dust',
    '3 - All in a spider web, would rather get to another room',
    '4 - Drip-Drip-Drip - there is a sound of falling drops. Damp and disgusting',
    '5 - Bare stone walls, nothing seems to be here',
    '6 - The remains of furniture suggested that there was once a comoro',
    '7 - Four walls, dry air, nothing special',
    '8 - An ordinary room is four meters by four',
    '9 - This room is larger than usual, but it looks like there is nothing in it',
    '10 - Apart from the skeleton on the floor, nothing interesting',
    '11 - Long corridor at the end of which doors are visible',
    '12 - Looks like a guard room, a few bunks and a broken cauldron in the corner',
    '13 - Looks like something was stored here, wooden shelves, bags',
    '14 - An ordinary room, bare walls and stone underfoot',
  ];

  String get(){
    return roomDescriptions.removeAt(Random().nextInt(roomDescriptions.length));
  }
}