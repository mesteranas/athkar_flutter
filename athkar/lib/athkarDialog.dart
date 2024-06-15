import 'package:audioplayers/audioplayers.dart';
import 'dart:ffi';

import 'language.dart';
import 'package:flutter/material.dart';
class AthkarDialog extends StatefulWidget{
  List<dynamic> athkars=[];
  AthkarDialog({Key?key,required this.athkars}):super(key:key);
  @override
  State<AthkarDialog> createState()=>_AthkarDialog(athkars);
}
class _AthkarDialog extends State<AthkarDialog>{
  AudioPlayer audioPlayer=AudioPlayer();
  var _=Language.translate;
  bool isPlaying=false;
  String text="";
  int times=1;
  int index=0;
  String audio="";
  List<dynamic> athkars=[];
  _AthkarDialog(this.athkars);
  @override
  void initState(){
    super.initState();
    loadCurrentThekr();
  }
  void loadCurrentThekr() {
    var current=athkars[0][index];
    text=current["text"];
    times=current["times"];
    audio=current["audio"];
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: Text(_("athkar")),
      ) ,
      body: Center(
        child: Column(
          children: [
            ListTile(title: Text(text),),
            ListTile(title: Text(times.toString() + _("times")),),
            if (index!=0)
                        ElevatedButton(onPressed: (){
              index-=1;
              loadCurrentThekr();
            }, child: Text(_("previous thekr"))),
            if (isPlaying==false)
            ElevatedButton(onPressed: (){
              // audioPlayer.play();
              isPlaying=true;
            }, child: Text(_("play"))),
            if (index!=this.athkars[0].length-1)
            ElevatedButton(onPressed: (){
              index+=1;
              loadCurrentThekr();
            }, child: Text(_("next thekr"))),
          ],
        ),
      ),
    );
  }
}