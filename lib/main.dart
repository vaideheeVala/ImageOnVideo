
import 'package:file_picker/file_picker.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svgonvideo/utils/colorassets.dart';
import 'package:svgonvideo/utils/screen_utils.dart';
import 'package:svgonvideo/video_sticker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      home: ChooseFile(),
    );
  }
}

class ChooseFile extends StatefulWidget {
  @override
  _ChooseFileState createState() => _ChooseFileState();
}

class _ChooseFileState extends State<ChooseFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorAssets.colorSheetDarkGrey,
        centerTitle: true,
        title: Text(
          'Sticker Demo',
          style: TextStyle(color: ColorAssets.themeColorWhite,letterSpacing: 2.0,fontSize: FontSize.s18,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
       height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: FlareActor("assets/background_2.flr", alignment:Alignment.center, fit:BoxFit.cover, animation:"Blue"),
            ),
            GestureDetector(
              onTap: () async {
                //First we will choose a file from the gallery and this code will work mainly for portrait videos only so choose portrait ones for now
                var result = await FilePicker.platform.pickFiles(type: FileType.video,allowMultiple: false);
                if(result!=null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayBackScreen(videoPath: result.paths[0],)));
                }
              },
              child: Center(
                child: Container(
                  height:Constant.size80,
                  width:Constant.size200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(Constant.size44)), color: ColorAssets.colorSheetDarkGrey),
                  child: Center(
                      child: Text(
                        'Choose a video',
                        style: TextStyle(color: ColorAssets.themeColorWhite,letterSpacing: 2.0,fontSize: 16,fontWeight: FontWeight.bold,),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

