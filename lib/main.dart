// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:energy_calculator/game.dart';
import 'package:energy_calculator/widget_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final VideoPlayerController _controller =
      VideoPlayerController.asset("videos/long.webm");

  late Game game;

  bool animated = false;

  double height = 0;
  double width = 0;
  double padding = 0;

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
      setState(() {
        animated = true;
      });
    });
    game = Game();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    padding = (height < width) ? height / 30 : width / 30;
    return Scaffold(
        body: Stack(children: <Widget>[
      (animated) ? backgroundVideo() : backgroundImage(),
      Container(
          height: height,
          width: width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // ROUND & ENERGY
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          Text(
                            'Round ${game.round}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              borderButton(
                                  onPressed: () {
                                    setState(() {
                                      game.substractEnergy();
                                    });
                                  },
                                  color: Colors.orange,
                                  width: 50,
                                  height: 50,
                                  text: '-',
                                  fontSize: 40),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                game.energy.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 70, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              borderButton(
                                  onPressed: () {
                                    setState(() {
                                      game.addEnergy();
                                    });
                                  },
                                  color: Colors.orange,
                                  width: 50,
                                  height: 50,
                                  text: '+',
                                  fontSize: 40),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    borderButton(
                        onPressed: () {
                          setState(() {
                            game.endTurn();
                          });
                        },
                        color: Colors.amber.shade500,
                        width: 280,
                        height: 50,
                        text: 'End Turn')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    borderButton(
                        onPressed: () {
                          setState(() {
                            game.reset();
                          });
                        },
                        color: Colors.red.shade400,
                        width: 210,
                        height: 50,
                        text: 'Reset'),
                    SizedBox(
                      width: 10,
                    ),
                    borderButton(
                        onPressed: () {
                          setState(() {
                            game.setLastTurnState();
                          });
                        },
                        color: Colors.orange,
                        width: 50,
                        height: 50,
                        icon: Icons.restart_alt),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(padding / 2),
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange,
                          child: InkWell(
                            splashColor: Colors.white,
                            child: const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            onTap: () {
                              setState(() {
                                animated = !animated;
                                if (animated) {
                                  _controller.play();
                                } else {
                                  _controller.pause();
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ))
    ]));
  }

  backgroundVideo() {
    return SizedBox.expand(
        child: FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: _controller.value.size.width,
        height: _controller.value.size.height,
        child: VideoPlayer(_controller),
      ),
    ));
  }

  backgroundImage() {
    return SizedBox.expand(
        child: FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        child: Image.asset("images/long_image.png"),
      ),
    ));
  }
}
