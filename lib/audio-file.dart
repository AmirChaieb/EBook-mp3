// ignore_for_file: file_names, camel_case_types, unnecessary_new, prefer_final_fields, unnecessary_this, avoid_unnecessary_containers

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class audioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audiopath;

  const audioFile({super.key, required this.advancedPlayer, required this.audiopath});

  @override
  State<audioFile> createState() => _audioFileState();
}

class _audioFileState extends State<audioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState(){
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d){setState(() {
      _duration=d;
    });});
    this.widget.advancedPlayer.onPositionChanged.listen((p){setState(() {
      _position=p;
    });});

    this.widget.advancedPlayer.setSourceUrl(this.widget.audiopath);
    this.widget.advancedPlayer.onPlayerComplete.listen((event){
      setState(() {
        _position = Duration(seconds: 0);

        if(isRepeat==true){
          isPlaying=true;
        }
        else{
          isPlaying=false;
          isRepeat=false;
        }


      });
    });
  }

  Widget btnStart(){
    return IconButton(
      onPressed: (){
        if (isPlaying==false){
          this.widget.advancedPlayer.play(UrlSource(this.widget.audiopath));
          setState(() {
            isPlaying=true;
          });
        }
        else if(isPlaying==true){
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }        
      }, 
      icon:isPlaying==false? Icon(_icons[0], size: 50, color: Colors.blue,): Icon(_icons[1], size: 50, color: Colors.blue,)
    );
  }

  Widget loadAsset(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop()
        ],
      ),
    );
  }

  Widget slider(){
    return Slider(
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      value: _position.inSeconds.toDouble(), 
      onChanged: (double value){
        setState(() {
          changeToSecond(value.toInt());
          value=value;
        });
      }
    );
  }

  Widget btnFast(){
    return IconButton(
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      }, 
      icon: ImageIcon(
        AssetImage("img/forward.png"),
        size: 15,
        color: Colors.black,
      )
    );
  }

  Widget btnSlow(){
    return IconButton(
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      }, 
      icon: ImageIcon(
        AssetImage("img/backword.png"),
        size: 15,
        color: Colors.black,
      )
    );
  }

  Widget btnLoop(){
    return IconButton(
      onPressed: (){
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      }, 
      icon: ImageIcon(
        AssetImage("img/loop.png"),
        size: 15,
        color: Colors.black,
      )
    );
  }

  Widget btnRepeat(){
    return IconButton(
      onPressed: (){
        if(isRepeat==false){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });
        }
        else if(isRepeat==true){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat=false;
            color=Colors.black;
          });
        }
      }, 
      icon: ImageIcon(
        AssetImage("img/repeat.png"),
        size: 15,
        color: color,
      )
    );
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(_position.toString().split(".")[0],style: TextStyle(fontSize: 16),),
                Text(_duration.toString().split(".")[0],style: TextStyle(fontSize: 16),),
              ],
            ),
            ),
            slider(),
            loadAsset(),
        ],
      ),
    );
  }
}