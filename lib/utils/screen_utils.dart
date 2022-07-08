import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Size screenSize;
double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class Constant {
  /*Padding & Margin Constants*/
  static double size0_45 = 0.45;
  static double size0_5 = 0.5;
  static double size1 = 1.0;
  static double size1_5 = 1.5;
  static double size1_6 = 1.6;
  static double size2 = 2.0;
  static double size3 = 3.0;
  static double size4 = 4.0;
  static double size5 = 5.0;
  static double size6 = 6.0;
  static double size7 = 7.0;
  static double size8 = 8.0;
  static double size9 = 9.0;
  static double size10 = 10.0;
  static double size12 = 12.0;
  static double size14 = 14.0;
  static double size15 = 15.0;
  static double size16 = 16.0;
  static double size18 = 18.0;
  static double size20 = 20.0;
  static double size22 = 22.0;
  static double size21 = 21.0;
  static double size23 = 23.0;
  static double size24 = 24.0;
  static double size25 = 25.0;
  static double size28 = 28.0;
  static double size29 = 29.0;
  static double size30 = 30.0;
  static double size31 = 31.0;
  static double size32 = 32.0;
  static double size34 = 34.0;
  static double size35 = 35.0;
  static double size36 = 36.0;
  static double size38 = 38.0;
  static double size40 = 40.0;
  static double size42 = 42.0;
  static double size44 = 44.0;
  static double size46 = 46.0;
  static double size48 = 48.0;
  static double size50 = 50.0;
  static double size52 = 52.0;
  static double size56 = 56.0;
  static double size60 = 60.0;
  static double size62 = 60.0;
  static double size64 = 64.0;
  static double size68 = 68.0;
  static double size70 = 70.0;
  static double size72 = 72.0;
  static double size75 = 75.0;
  static double size77 = 77.0;
  static double size78 = 78.0;
  static double size80 = 80.0;
  static double size88 = 88.0;
  static double size90 = 90.0;
  static double size96 = 96.0;
  static double size100 = 100.0;
  static double size110 = 110.0;
  static double size115 = 115.0;
  static double size120 = 120.0;
  static double size128 = 128.0;
  static double size130 = 130.0;
  static double size138 = 138.0;
  static double size140 = 140.0;
  static double size150 = 150.0;
  static double size160 = 160.0;
  static double size164 = 164.0;
  static double size176 = 176.0;
  static double size180 = 180.0;
  static double size185 = 185.0;
  static double size195 = 195.0;
  static double size200 = 200.0;
  static double size205 = 205.0;
  static double size210 = 210.0;
  static double size216 = 216.0;
  static double size220 = 220.0;
  static double size230 = 230.0;
  static double size240 = 240.0;
  static double size250 = 250.0;
  static double size256 = 256.0;
  static double size260 = 260.0;
  static double size275 = 275.0;
  static double size280 = 280.0;
  static double size290 = 290.0;
  static double size300 = 300.0;
  static double size310 = 310.0;
  static double size320 = 320.0;
  static double size340 = 340.0;
  static double size360 = 360.0;
  static double size328 = 328.0;
  static double size400 = 400.0;
  static double size430 = 430.0;
  static double size450 = 450.0;
  static double size470 = 470.0;
  static double size490 = 490.0;
  static double size500 = 500.0;
  static double size512 = 512.0;
  static double size520 = 520.0;
  static double size530 = 530.0;
  static double size550 = 550.0;
  static double size600 = 600.0;
  static double size965 = 965.0;
  static double size1000 = 1000.0;
  static double size1024 = 1024.0;

  /// New added
  static double size268 = 268.0;
  static double size370 = 370.0;
  static double size390 = 390.0;

  /*Screen Size dependent Constants*/

  static double screenWidthButton = screenWidth - size64;
  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;
  static double screenWidthSixth = screenWidth / 6;
  static double screenWidthTenth = screenWidth / 10;

  /*Image Dimensions*/

  static double defaultIconSize = 80.0;
  static double defaultImageHeight = 120.0;
  static double snackBarHeight = 50.0;
  static double texIconSize = 30.0;

  /*Default Height&Width*/
  static double defaultIndicatorHeight = 5.0;
  static double defaultIndicatorWidth = screenWidthFourth;

  /*EdgeInsets*/
  static EdgeInsets spacingAllDefault = EdgeInsets.all(size8);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(size12);

  static void setDefaultSize(context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    size24 = 20.0;
    size32 = 30.0;
    size44 = 40.0;
    size56 = 50.0;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;
    screenWidthSixth = screenWidth / 6;
    screenWidthTenth = screenWidth / 10;

    defaultIconSize = 80.0;
    defaultImageHeight = 120.0;
    snackBarHeight = 50.0;
    texIconSize = 30.0;

    defaultIndicatorHeight = 5.0;
    defaultIndicatorWidth = screenWidthFourth;

    spacingAllDefault = EdgeInsets.all(size8);
    spacingAllSmall = EdgeInsets.all(size12);

    FontSize.setDefaultFontSize();
  }

  static void setScreenAwareConstant(context) {
    setDefaultSize(context);

    ScreenUtil.init(
      context,
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    );

    FontSize.setScreenAwareFontSize();

    /*Padding & Margin Constants*/

    size0_5 = ScreenUtil().setWidth(0.5);
    size1 = ScreenUtil().setWidth(1.0);
    size1_5 = ScreenUtil().setWidth(1.5);
    size1_6 = ScreenUtil().setWidth(1.6);
    size3 = ScreenUtil().setWidth(3.0);
    size2 = ScreenUtil().setWidth(2.0);
    size4 = ScreenUtil().setWidth(4.0);
    size5 = ScreenUtil().setWidth(5.0);
    size6 = ScreenUtil().setWidth(6.0);
    size7 = ScreenUtil().setWidth(7.0);
    size8 = ScreenUtil().setWidth(8.0);
    size9 = ScreenUtil().setWidth(9.0);
    size10 = ScreenUtil().setWidth(10.0);
    size12 = ScreenUtil().setWidth(12.0);
    size14 = ScreenUtil().setWidth(14.0);
    size15 = ScreenUtil().setWidth(15.0);
    size16 = ScreenUtil().setWidth(16.0);
    size18 = ScreenUtil().setWidth(18.0);
    size20 = ScreenUtil().setWidth(20.0);
    size22 = ScreenUtil().setWidth(22.0);
    size23 = ScreenUtil().setWidth(23.0);
    size24 = ScreenUtil().setWidth(24.0);
    size25 = ScreenUtil().setWidth(25.0);
    size28 = ScreenUtil().setWidth(28.0);
    size29 = ScreenUtil().setWidth(29.0);
    size30 = ScreenUtil().setWidth(30.0);
    size31 = ScreenUtil().setWidth(31.0);
    size32 = ScreenUtil().setWidth(32.0);
    size34 = ScreenUtil().setWidth(34.0);
    size40 = ScreenUtil().setWidth(40.0);
    size35 = ScreenUtil().setWidth(35.0);
    size36 = ScreenUtil().setWidth(36.0);
    size38 = ScreenUtil().setWidth(38.0);
    size40 = ScreenUtil().setWidth(40.0);
    size42 = ScreenUtil().setWidth(42.0);
    size44 = ScreenUtil().setWidth(44.0);
    size50 = ScreenUtil().setWidth(50.0);
    size48 = ScreenUtil().setWidth(48.0);
    size52 = ScreenUtil().setWidth(52.0);
    size56 = ScreenUtil().setWidth(56.0);
    size60 = ScreenUtil().setWidth(60.0);
    size62 = ScreenUtil().setWidth(62.0);
    size64 = ScreenUtil().setWidth(64.0);
    size72 = ScreenUtil().setWidth(72.0);
    size75 = ScreenUtil().setWidth(75.0);
    size77 = ScreenUtil().setWidth(77.0);
    size80 = ScreenUtil().setWidth(80.0);
    size88 = ScreenUtil().setWidth(88.0);
    size100 = ScreenUtil().setWidth(100.0);
    size110 = ScreenUtil().setWidth(110.0);
    size115 = ScreenUtil().setWidth(115.0);
    size120 = ScreenUtil().setWidth(120.0);
    size128 = ScreenUtil().setWidth(128.0);
    size130 = ScreenUtil().setWidth(130.0);
    size138 = ScreenUtil().setWidth(138.0);
    size140 = ScreenUtil().setWidth(140.0);
    size150 = ScreenUtil().setWidth(150.0);
    size160 = ScreenUtil().setWidth(160.0);
    size164 = ScreenUtil().setWidth(164.0);
    size180 = ScreenUtil().setWidth(180.0);
    size185 = ScreenUtil().setWidth(185.0);
    size195 = ScreenUtil().setWidth(195.0);
    size200 = ScreenUtil().setWidth(200.0);
    size205 = ScreenUtil().setWidth(205.0);
    size210 = ScreenUtil().setWidth(210.0);
    size216 = ScreenUtil().setWidth(216.0);
    size220 = ScreenUtil().setWidth(220.0);
    size230 = ScreenUtil().setWidth(230.0);
    size240 = ScreenUtil().setWidth(240.0);
    size250 = ScreenUtil().setWidth(250.0);
    size256 = ScreenUtil().setWidth(256.0);
    size260 = ScreenUtil().setWidth(260.0);
    size275 = ScreenUtil().setWidth(275.0);
    size280 = ScreenUtil().setWidth(280.0);
    size290 = ScreenUtil().setWidth(290.0);
    size300 = ScreenUtil().setWidth(300.0);
    size310 = ScreenUtil().setWidth(310.0);
    size320 = ScreenUtil().setWidth(320.0);
    size340 = ScreenUtil().setWidth(340.0);
    size360 = ScreenUtil().setWidth(360.0);
    size328 = ScreenUtil().setWidth(328.0);
    size400 = ScreenUtil().setWidth(400.0);
    size430 = ScreenUtil().setWidth(430.0);
    size450 = ScreenUtil().setWidth(450.0);
    size470 = ScreenUtil().setWidth(470.0);
    size490 = ScreenUtil().setWidth(490.0);
    size500 = ScreenUtil().setWidth(500.0);
    size512 = ScreenUtil().setWidth(512.0);
    size520 = ScreenUtil().setWidth(520.0);
    size530 = ScreenUtil().setWidth(530.0);
    size550 = ScreenUtil().setWidth(550.0);
    size600 = ScreenUtil().setWidth(600.0);
    size965 = ScreenUtil().setWidth(965.0);
    size1000 = ScreenUtil().setWidth(1000.0);
    size1024 = ScreenUtil().setWidth(1024.0);

    /// New added
    size15 = ScreenUtil().setWidth(15.0);
    size30 = ScreenUtil().setWidth(30.0);
    size268 = ScreenUtil().setWidth(268.0);
    size370 = ScreenUtil().setWidth(370.0);
    size390 = ScreenUtil().setWidth(390.0);

    /// New added
    size15 = ScreenUtil().setWidth(15.0);
    size268 = ScreenUtil().setWidth(268.0);

    /*EdgeInsets*/

    spacingAllDefault = EdgeInsets.all(size8);
    spacingAllSmall = EdgeInsets.all(size12);

    /*Screen Size dependent Constants*/
    screenWidthHalf = ScreenUtil().scaleWidth / 2;
    screenWidthThird = ScreenUtil().scaleWidth / 3;
    screenWidthFourth = ScreenUtil().scaleWidth / 4;
    screenWidthFifth = ScreenUtil().scaleWidth / 5;
    screenWidthSixth = ScreenUtil().scaleWidth / 6;
    screenWidthTenth = ScreenUtil().scaleWidth / 10;

    /*Image Dimensions*/

    defaultIconSize = ScreenUtil().setWidth(80.0);
    defaultImageHeight = ScreenUtil().setHeight(120.0);
    snackBarHeight = ScreenUtil().setHeight(50.0);
    texIconSize = ScreenUtil().setWidth(30.0);

    /*Default Height&Width*/
    defaultIndicatorHeight = ScreenUtil().setHeight(5.0);
    defaultIndicatorWidth = screenWidthFourth;
  }
}

class FontSize {
  static double s9 = 9.0;
  static double s10 = 10.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s16 = 16.0;
  static double s18 = 18.0;
  static double s20 = 20.0;
  static double s21 = 21.0;
  static double s22 = 22.0;
  static double s24 = 24.0;
  static double s26 = 26.0;
  static double s28 = 28.0;
  static double s30 = 30.0;
  static double s32 = 32.0;
  static double s36 = 36.0;
  static double s40 = 40.0;
  static double s42 = 42.0;
  static double s48 = 48.0;
  static double s190 = 190.0;

  static setDefaultFontSize() {
    s9 = 9.0;
    s10 = 10.0;
    s12 = 12.0;
    s13 = 13.0;
    s14 = 14.0;
    s16 = 16.0;
    s18 = 18.0;
    s20 = 20.0;
    s22 = 22.0;
    s24 = 24.0;
    s26 = 26.0;
    s28 = 28.0;
    s30 = 30.0;
    s32 = 32.0;
    s36 = 36.0;
    s40 = 40.0;
    s42 = 42.0;
    s48 = 48.0;
    s190 = 190.0;
  }

  static setScreenAwareFontSize() {
    s10 = ScreenUtil().setSp(10.0);
    s12 = ScreenUtil().setSp(12.0);
    s13 = ScreenUtil().setSp(13.0);
    s14 = ScreenUtil().setSp(14.0);
    s16 = ScreenUtil().setSp(16.0);
    s18 = ScreenUtil().setSp(18.0);
    s20 = ScreenUtil().setSp(20.0);
    s22 = ScreenUtil().setSp(22.0);
    s24 = ScreenUtil().setSp(24.0);
    s26 = ScreenUtil().setSp(26.0);
    s28 = ScreenUtil().setSp(28.0);
    s30 = ScreenUtil().setSp(30.0);
    s32 = ScreenUtil().setSp(32.0);
    s36 = ScreenUtil().setSp(36.0);
    s40 = ScreenUtil().setSp(40.0);
    s42 = ScreenUtil().setSp(42.0);
    s48 = ScreenUtil().setSp(48.0);
    s9 = ScreenUtil().setSp(9.0);
    s10 = ScreenUtil().setSp(10.0);
    s190 = ScreenUtil().setSp(190.0);
  }
}
