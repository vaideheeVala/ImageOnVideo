import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:svgonvideo/utils/colorassets.dart';
import 'package:svgonvideo/utils/screen_utils.dart';
import 'package:vector_math/vector_math_64.dart';

typedef MathF<T extends num> = T Function(T, T);
typedef VFn = Vector4 Function(double x, double y, double z, double w);
typedef StickeImageRemoveCallback = void Function(StickerDrag sticker);

double _minMax(num _min, num _max, num actual) {
  if (_min == null && _max == null) {
    return actual.toDouble();
  }

  if (_min == null) {
    return min(_max.toDouble(), actual.toDouble());
  }

  if (_max == null) {
    return max(_min.toDouble(), actual.toDouble());
  }

  return min(_max.toDouble(), max(_min.toDouble(), actual.toDouble()));
}

class StickerDrag extends StatefulWidget {
  StickerDrag(
      this.image, {
        this.matrix,
        this.notifier,
        Key key,
        this.videoSize,
        this.valueChanged,
        this.onTapRemove,
        this.x,
        this.y,
        this.isGif
      }) : super(key: key);
  String image;
  double x;
  double y;
  Matrix4 matrix;
  Size videoSize;
  bool isGif;
  ValueNotifier<Matrix4> notifier;
  final ValueChanged<StickerItem> valueChanged;
  final StickeImageRemoveCallback onTapRemove;
  final _FlutterSimpleStickerImageState _flutterSimpleStickerImageState =
  _FlutterSimpleStickerImageState();
  @override
  _FlutterSimpleStickerImageState createState() =>
      _flutterSimpleStickerImageState;
}

class _FlutterSimpleStickerImageState extends State<StickerDrag> {
  bool _isSelected = false;

  _FlutterSimpleStickerImageState();

  bool stickerVisible = false;
  Offset stickerOffset = Offset(0, 0);
  double scale = 1.0;
  double _rotation = 0.0;
  double minScale =0.8;
  double maxScale =1.7;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    widget.valueChanged(StickerItem(
        id: widget.key,
        rotation: _rotation,
        x: stickerOffset.dx,
        y: stickerOffset.dy,
        imagePath: widget.image,
        isGif: widget.isGif,
        scale: scale));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Constant.setScreenAwareConstant(context);
    return MatrixGestureDetector(
      focalPointAlignment: Alignment.center,
      shouldRotate: false,
      shouldScale: true,
      onMatrixUpdate: (m, tm, sm, rm) {
        var finalM = Matrix4.copy(m);
        Map<int, VFn> colMap = {
          0: (x, y, z, w) {
            x = _minMax(minScale, maxScale, x);
            return Vector4(x, y, z, w);
          },
          1: (x, y, z, w) {
            y = _minMax(minScale, maxScale, y);
            return Vector4(x, y, z, w);
          },
          2: (x, y, z, w) {
            z = _minMax(minScale, maxScale, z);
            return Vector4(x, y, z, w);
          },
        };
        for (var col in colMap.keys) {
          var oldCol = m.getColumn(col);
          var colD = colMap[col];
          if (colD != null) {
            finalM.setColumn(col, colD(oldCol.x, oldCol.y, oldCol.z, oldCol.w));
          }
        }
        setState(() {
          widget.matrix = finalM;
        });
        widget.matrix =
            MatrixGestureDetector.compose(widget.matrix, tm, sm, null);

        widget.notifier.value = widget.matrix;
        final val = MatrixGestureDetector.decomposeToValues(widget.matrix);
        scale = val.scale;
        stickerOffset = val.translation;
        _rotation = val.rotation;
        widget.valueChanged(StickerItem(
          isGif: widget.isGif,
            id: widget.key,
            rotation: _rotation,
            x: stickerOffset.dx,
            y: stickerOffset.dy,
            imagePath: widget.image,
            scale: scale));
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: AnimatedBuilder(
              builder: (ctx, child) {
                return Transform(
                  transform: widget.matrix,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected ? _isSelected = false : _isSelected = true;
                      });
                    },
                    child: _isSelected
                        ? Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Constant.size18)),
                              border: Border.all(
                                color: ColorAssets.themeColorWhite,
                                width: ScreenUtil().setWidth(3.0),
                              )),
                          child: Image.asset(
                            widget.image,
                            height: ScreenUtil().setHeight(220.0),
                            width: ScreenUtil().setWidth(220.0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (this.widget.onTapRemove != null) {
                              HapticFeedback.lightImpact();
                              this.widget.onTapRemove(this.widget);
                            }
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(36.0),
                            height: ScreenUtil().setHeight(36.0),
                            child: Icon(
                              Icons.cancel,
                              size: Constant.size32,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorAssets.themeColorWhite,
                            ),
                          ),
                        ),
                      ],
                    )
                        : Image.asset(
                      widget.image,
                      height: ScreenUtil().setHeight(220.0),
                      width: ScreenUtil().setWidth(220.0),
                    ),
                  ),
                );
              },
              animation: widget.notifier,
            ),
          ),
        ],
      ),
    );
  }
}

class StickerItem {
  double scale;
  String imagePath;
  double x;
  double y;
  Key id;
  double rotation;
  bool isGif;
  StickerItem({this.id, this.rotation, this.x, this.y, this.imagePath, this.scale,this.isGif});
}