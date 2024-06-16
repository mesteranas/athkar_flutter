import 'package:video_player/video_player.dart';
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
  var audioPlayer;
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
  void _onVerticalSwipe(DragUpdateDetails details){
    if (details.delta.dy<0){
                    index+=1;
              loadCurrentThekr();

    } else if(details.delta.dy>0){
                    index-=1;
              loadCurrentThekr();

    }
  }
  void initState(){
    super.initState();
    loadCurrentThekr();
    loadAudio();
  }

  void loadAudio(){
    try{
    audioPlayer.addListener(() { 
      if (audioPlayer.value.position.toString() == audioPlayer.value.duration.toString()){
      isPlaying=false;
      paused=false;
      setState(() {
        
      });
    } else {
            isPlaying=true;
      setState(() {
        
      });

    }
    
    });
 } catch(error){
  print(error);

}
  }

  void loadCurrentThekr() {
    try{
    audioPlayer.dispose();
    } catch(error){

    }
    isPlaying=false;
    var current=athkars[index];
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
      body: GestureDetector(onVerticalDragUpdate: _onVerticalSwipe,
      child:Center(
        child: Column(
          children: [
            ListTile(title: Text(text),),
            ListTile(title: Text(times.toString() + " "+_("times")),),
            if (index!=0)
                        ElevatedButton(onPressed: (){
              index-=1;
              loadCurrentThekr();
            }, child: Text(_("previous thekr"))),
            if (isPlaying==false)
            ElevatedButton(onPressed: () async{
              audioPlayer=VideoPlayerController.networkUrl(Uri.parse(audio))..initialize().then((value) => null);
              loadAudio();
              audioPlayer.play();
              isPlaying=true;
              paused=false;
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
              audioPlayer.play();
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
    ));
  }
}