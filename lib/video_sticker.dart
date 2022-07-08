import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:svgonvideo/sticker_view.dart';
import 'package:svgonvideo/utils/colorassets.dart';
import 'package:svgonvideo/utils/screen_utils.dart';
import 'package:svgonvideo/video.dart';
import 'package:video_player/video_player.dart';

import 'constant/gif_data.dart';
import 'constant/sticker_data.dart';

class VideoPlayBackScreen extends StatefulWidget {
  String videoPath;
  VideoPlayBackScreen({Key key, this.videoPath}) : super(key: key);

  @override
  _VideoPlayBackScreenState createState() => _VideoPlayBackScreenState();
}

class _VideoPlayBackScreenState extends State<VideoPlayBackScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  List<StickerDrag> attachedList = []; //attachList will have view on all stickers that we will going to place on screen
  List<StickerItem> stickerItems = List();//Sticker items is that on which we will going to perform all actions
  Matrix4 matrix; //Matrix you can from here or in child as well in StickerDrag class
  ValueNotifier<Matrix4> notifier;//Notifier of Matrix
  bool stickerVisible = false;// We will enable sticker view if there is any sticker on the screen in first time
  List<Sticker> _listInfo = List();//This list will contain json data of the sticker file
  List<Gif> _gifListInfo = List();//This list will contain json data of the gif file
  TabController tabController;//Tab Controller will have two views of sticker and gif in bottom sheet

  FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();//Our main key of this demo is this video processing library
  String finalVideoPath;//We will perform all operations on this video path so we will not write onto original video path
  double _rotation = 0.0;//Currently i haven't configured rotation so set it to zero for FFmpeg command
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool _isMergingProcessStart = false;

  @override
  void initState() {
    finalVideoPath = widget.videoPath;
    matrix = Matrix4.identity();
    notifier = ValueNotifier(matrix);
    _playVideo();
    _fetchData();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ///Video-viewer
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FittedBox(
                    fit: BoxFit.fitHeight,
                    child: SizedBox(
                      height: _controller.value.size?.height ?? 0,
                      width: _controller.value.size?.width ?? 0,
                      child: VideoPlayer(
                        _controller,
                      ),
                    ),
                  );
                } else {
                  return Center(child: Container(child: CircularProgressIndicator()));
                }
              },
            ),

            ///Stickers
            Visibility(
              visible: stickerVisible,
              child: Stack(
                children: attachedList,
              ),
            ),

            ///Button for adding stickers
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(Constant.size40)),
                      ),
                      context: context,
                      //customBottomSheet
                      builder: (context) => stickerBottomSheet());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.23,
                  margin: EdgeInsets.only(left: Constant.size12, right: Constant.size12),
                  decoration: BoxDecoration(
                    color: ColorAssets.themeColorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(Constant.size12)),
                  ),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(Constant.size7),
                    child: Text(
                      "Add Stickers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14, color: ColorAssets.colorSheetDarkGrey),
                    ),
                  )),
                ),
              ),
            ),

            ///Next Button
            Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                onTap: () async {
                  if (stickerItems.length > 0) {
                    setState(() {
                      _isMergingProcessStart = true;
                    });
                    await addStickers().then((value) {
                      setState(() {
                        _isMergingProcessStart = false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoViewer(finalVideoPath))).then((value) {
                        setState(() {
                          finalVideoPath=widget.videoPath;
                        });
                      });
                    });
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: EdgeInsets.only(left: Constant.size100, right: Constant.size12),
                  decoration: BoxDecoration(
                    color: ColorAssets.themeColorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(Constant.size12)),
                  ),
                  child: Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16, color: ColorAssets.colorSheetDarkGrey),
                  )),
                ),
              ),
            ),
            Visibility(
              visible: _isMergingProcessStart,
              child: Center(child: CircularProgressIndicator(backgroundColor: ColorAssets.themeColorWhite.withOpacity(0.2),color: ColorAssets.themeColorBlack,)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBarWidget() {
    return Container(
      height: Constant.size60,
      margin: EdgeInsets.only(left: Constant.size20, right: Constant.size20),
      child: DecoratedBox(
        child: TabBar(
          labelPadding: EdgeInsets.all(0.0),
          controller: tabController,
          indicatorColor: Colors.red,
          indicatorWeight: Constant.size2,
          indicator: TabIndicator(
            indicatorHeight: 3.0,
            indicatorColor: ColorAssets.themeColorWhite,
          ),
          unselectedLabelColor: ColorAssets.themeColorWhite.withOpacity(0.5),
          unselectedLabelStyle: TextStyle(fontFamily: "Poppins", fontSize: FontSize.s16, fontWeight: FontWeight.w600),
          labelColor: ColorAssets.themeColorWhite,
          labelStyle: TextStyle(fontFamily: "Poppins", fontSize: FontSize.s16, fontWeight: FontWeight.w600),
          tabs: <Widget>[
            Tab(text: "Stickers"),
            Tab(text: "Gif"),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorAssets.themeColorWhite.withOpacity(0.5),
              width: Constant.size3,
            ),
          ),
        ),
      ),
    );
  }

  Widget stickerBottomSheet() {
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorAssets.colorSheetDarkGrey,
          ),
          child: Column(
            children: [
              buildTabBarWidget(),
              Flexible(
                child: Container(
                  ///Individual tab screens
                  child: new TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      ///Sticker loading
                      Stickers(),
                      ///Gif loading
                      Gifs(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Stickers() {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              _listInfo.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      stickerVisible = true;
                      attachSticker(_listInfo[index].asset,false);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(Constant.size8),
                    padding: EdgeInsets.all(Constant.size8),
                    child: Image.asset(_listInfo[index].asset),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget Gifs() {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(
              _gifListInfo.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      stickerVisible = true;
                      attachSticker(_gifListInfo[index].asset,true);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(Constant.size8),
                    padding: EdgeInsets.all(Constant.size8),
                    child: Image.asset(_gifListInfo[index].asset),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  _fetchData() async {
    String data1 = await DefaultAssetBundle.of(context).loadString("assets/sticker_file.json");
    String data2 = await DefaultAssetBundle.of(context).loadString("assets/gif.json");
    _listInfo = stickerDataModelFromJson(data1);
    _gifListInfo = gifDataModelFromJson(data2);
  }

  void _playVideo() {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _initializeVideoPlayerFuture = _controller.initialize().then((value) {
      _controller.play();
      _controller.setLooping(true);
    });
  }

  //Removing stickers
  void onTapRemoveSticker(StickerDrag sticker) {
    setState(() {
      this.attachedList.removeWhere((s) => s.key == sticker.key);
      this.stickerItems.removeWhere((s) => s.id == sticker.key);
    });
  }

  Future<void> addStickers() async {
    bool callBack;
    for (int i = 0; i < stickerItems.length;) {
      callBack = false;
      callBack = await _mergeStickerToVideo(stickerItems[i].imagePath ?? attachedList[i].image,
          stickerItems[i].x ?? 0.0, stickerItems[i].y ?? 0.0, stickerItems[i].scale ?? 1.0,stickerItems[i].isGif);
      Future.delayed(Duration(seconds: 1), () {});
      if (callBack) {
        i++;
      }
    }
  }

  void attachSticker(String image,bool isGif) {
    setState(() {
      attachedList.add(StickerDrag(
        image,
        valueChanged: (stickerData) {
          if (stickerItems.length > 0) {
            bool present = false;
            int counter = 0;
            for (int i = 0; i < stickerItems.length; i++) {
              counter++;
              if (stickerItems[i].id == stickerData.id) {
                present = true;
                stickerItems[i].x = stickerData.x;
                stickerItems[i].y = stickerData.y;
                stickerItems[i].scale = stickerData.scale;
              } else {
                if (counter == stickerItems.length) {
                  if (present) {
                    continue;
                  } else {
                    stickerItems.add(stickerData);
                  }
                }
              }
            }
          } else {
            stickerItems.add(stickerData);
          }
        },
        matrix: matrix,
        notifier: notifier,
        isGif: isGif,
        key: UniqueKey(),
        onTapRemove: (sticker) {
          this.onTapRemoveSticker(sticker);
        },
      ));
    });
  }

  Future<bool> _mergeStickerToVideo(String imagePath, double xPosition, double yPosition, double scaleFactor,bool isGif) async {
    final filename = 'StickerOutput${DateTime.now().millisecondsSinceEpoch}_output.mp4';
    Directory dir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
    final String dirPath = '${dir.path}/Movies';
    await Directory(dirPath).create(recursive: true);
    final outputPath = dirPath + "/" + filename;
    double xRatio = (_controller.value.size.width / MediaQuery.of(context).size.width);
    double hRatio = (_controller.value.size.height / MediaQuery.of(context).size.height);
    double wData = 380 * scaleFactor;
    final imgPath = await _loadStickerFromAsset(imagePath,isGif);
    String localCommand;

  if(isGif){
    //Hardware accelerated command for ios
    if (Platform.isIOS) {
      localCommand =
      "-i '$finalVideoPath' -ignore_loop 0 -i '$imgPath' -c:v h264_videotoolbox -b:v 2200k -b:a 220k -preset ultrafast -threads 0 -filter_complex '[1:v]format=bgra,rotate=$_rotation:c=none:ow=rotw($_rotation):oh=roth($_rotation)[rotate];[rotate]scale=$wData:$wData[scale];[0:v][scale] overlay=x=${xPosition * xRatio}:y=${yPosition * hRatio}:shortest=1' -c:v h264_videotoolbox -b:v 2200k -b:a 220k -preset ultrafast -threads 0 -r 30 '$outputPath'";
    }
    //Software accelerated command for android
    else {
      localCommand =
      "-i '$finalVideoPath' -ignore_loop 0 -i '$imgPath' -vcodec libx264 -crf 23 -preset ultrafast -threads 0 -filter_complex '[1:v]format=bgra,rotate=$_rotation:c=none:ow=rotw($_rotation):oh=roth($_rotation)[rotate];[rotate]scale=$wData:$wData[scale];[0:v][scale] overlay=x=${xPosition * xRatio}:y=${yPosition * hRatio}:shortest=1' -c:v libx264 -preset ultrafast -threads 0 -r 30 '$outputPath'";
    }
  }
  else{
    //Hardware accelerated command for ios
    if (Platform.isIOS) {
      localCommand =
      "-i '$finalVideoPath' -i '$imgPath' -c:v h264_videotoolbox -b:v 2200k -b:a 220k -preset ultrafast -threads 0 -filter_complex '[1:v]format=bgra,rotate=$_rotation:c=none:ow=rotw($_rotation):oh=roth($_rotation)[rotate];[rotate]scale=$wData:$wData[scale];[0:v][scale] overlay=x=${xPosition * xRatio}:y=${yPosition * hRatio}' -c:v h264_videotoolbox -b:v 2200k -b:a 220k -preset ultrafast -threads 0 -r 30 '$outputPath'";
    }
    //Software accelerated command for android
    else {
      localCommand =
      "-i '$finalVideoPath' -i '$imgPath' -vcodec libx264 -crf 23 -preset ultrafast -threads 0 -filter_complex '[1:v]format=bgra,rotate=$_rotation:c=none:ow=rotw($_rotation):oh=roth($_rotation)[rotate];[rotate]scale=$wData:$wData[scale];[0:v][scale] overlay=x=${xPosition * xRatio}:y=${yPosition * hRatio}' -c:v libx264 -preset ultrafast -threads 0 -r 30 '$outputPath'";
    }
  }
    await _flutterFFmpeg.execute(localCommand).then((value) {
      setState(() {
        finalVideoPath = outputPath;
      });
    });
    return true;
  }

  Future<String> _loadStickerFromAsset(String imagePath,bool isGif) async {
    var bytes;
    String filename;
    if(!isGif){
      filename= 'sticker' + DateTime.now().microsecondsSinceEpoch.toString() + 'sticker.png';
    }
    else{
      filename= 'sticker' + DateTime.now().microsecondsSinceEpoch.toString() + 'sticker.gif';
    }
    bytes = await rootBundle.load(imagePath);
    String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/$filename';
    final buffer = bytes.buffer;
    print(path);
    await File(path).writeAsBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    File file = File('$dir/$filename');
    print('Loaded file ${file.path}');
    return file.path;
  }
}

//for creating custom indicator having top left and top right corners
class TabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const TabIndicator({
    @required this.indicatorHeight,
    @required this.indicatorColor,
  });

  @override
  IndicatorPainter createBoxPainter([VoidCallback onChanged]) {
    return new IndicatorPainter(this, onChanged);
  }
}

class IndicatorPainter extends BoxPainter {
  final TabIndicator decoration;

  IndicatorPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect;
    rect = Offset(offset.dx, (configuration.size.height - decoration.indicatorHeight ?? 3)) &
        Size(configuration.size.width, decoration.indicatorHeight ?? 3);

    final Paint paint = Paint();
    paint.color = decoration.indicatorColor ?? Color(0xFFE12674);
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: Radius.circular(8), topLeft: Radius.circular(8)), paint);
  }
}
