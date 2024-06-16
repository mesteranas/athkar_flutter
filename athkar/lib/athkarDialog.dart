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
  bool paused=false;
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
    loadAudio();
  }
  void loadAudio(){
    audioPlayer.onPlayerComplete.listen((event) { 
      isPlaying=false;
      setState(() {
        
      });
    });
  }
  void loadCurrentThekr() {
    audioPlayer.stop();
    isPlaying=false;
    var current=athkars[index];
    text=current["text"];
    times=current["times"];
    audio=current["audio"];
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
            ElevatedButton(onPressed: () async{
              await audioPlayer.play(UrlSource(audio));
              isPlaying=true;
              setState(() {
                
              });
            }, child: Text(_("play")))
            else
            if (paused==false)
            ElevatedButton(onPressed: (){
              paused=true;
              audioPlayer.pause();
              setState(() {
                
              });
            }, child: Text(_("pause")))
            else if (paused==true)
            ElevatedButton(onPressed: (){
              paused=false;
              audioPlayer.resume();
              setState(() {
                
              });
            }, child: Text(_("resume"))),
            if (index!=this.athkars.length-1)
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