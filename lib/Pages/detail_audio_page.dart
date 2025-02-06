// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_this

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook/audio-file.dart';
import 'package:flutter/material.dart';
import 'package:ebook/styles/appColors.dart' as appcolors;

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({super.key, this.booksData, required this.index});

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;

  @override
  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appcolors.audioBluichBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenheight/3,
            child: Container(
              color: appcolors.audioBlueBackground,
          )),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AppBar(
              leading: IconButton(
                onPressed: (){
                  advancedPlayer.stop();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              actions: [
                IconButton(
                onPressed: (){},
                icon: Icon(Icons.search),
              ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenheight*0.2,
            height: screenheight*0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenheight*0.1,),
                  Text(this.widget.booksData[this.widget.index]["title"],
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Avenir"
                  ),
                  ),
                  Text(this.widget.booksData[this.widget.index]["text"],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                  audioFile(advancedPlayer: advancedPlayer, audiopath: this.widget.booksData[this.widget.index]["audio"])
                ],
              ),
            )
          ),
          Positioned(
            top: screenheight*0.12,
            left: (screenwidth-150)/2,
            right: (screenwidth-150)/2,
            height: screenheight*0.16,
            child: Container(
              
              decoration: BoxDecoration(
                color: appcolors.audioGreyBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white,width: 2)
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 5),
                      image: DecorationImage(
                        image:AssetImage(this.widget.booksData[this.widget.index]["img"]),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
          ))
        ],
      ),
    );
  }
}