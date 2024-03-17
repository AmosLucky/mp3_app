import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  AssetsAudioPlayer? _player;
  bool isPlaying = false;
 


  void _play() {
    _player =  AssetsAudioPlayer();
    _player!.open(
    Audio("assets/audio/in_forest.mp3"),
);
 setState(() {
      isPlaying = true;
    });
  }

  _pause()async{
    _player!.pause();
    // if(_player!.isPlaying.value){
    //   _player!.pause();
    // }
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }
  int current = 0;
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text("MP3 App")),
      body: Container(
        padding: EdgeInsets.all(20),
        child:  Column(children: [
         const Text(
              'Click on the play button to play a sound',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: AudioWidget.assets(
                     path: "assets/audio/in_forest.mp3",
                     play: isPlaying,
                     child: Container(
                      margin: const EdgeInsets.all(10),
                       child: Column(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("${(duration/60).toInt()} : ${current.toString()}"),const Text('  / '),Text("${duration.toString()} mins")
                          ],),

                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: LinearProgressIndicator(value: (current/100),)),
                           CircleAvatar(
                             child: InkWell(
                                   child: Icon(
                                                isPlaying ? Icons.pause : Icons.play_arrow,
                                   ),
                                   onTap: () {
                                                setState(() {
                             isPlaying = !isPlaying;
                                                });
                                   }
                              ),
                           ),
                         ],
                       ),
                     ),
                      onReadyToPlay: (duration) {
                          //onReadyToPlay
                      },
                      onPositionChanged: (_current, _duration) {
                        setState(() {
                          current =_current.inSeconds;
                          duration =_duration.inMinutes;
                        });

                        
                          //onPositionChanged
                      },
                  ),
              ),
            ),


      ]),),
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        tooltip: 'Play',
        child: const Icon(Icons.volume_up),
      ),
    );
  }
}