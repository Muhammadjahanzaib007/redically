import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redically_local/app/config/AppTextStyles.dart';
import 'package:redically_local/app/shared/shared_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_colors.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getIconPath(String name, {String format = 'png'}) {
    return 'assets/icons/$name.$format';
  }

  static String getCuisineIconPath(String name, {String format = 'png'}) {
    return 'assets/icons/cusines/$name.$format';
  }

  static showSnackBar(
      {required String title, required String message, bool? error}) {
    Get.snackbar(
      title,
      message,
      colorText: AppColors.kWhite,
      backgroundColor: error == null
          ? AppColors.buttonColor
          : error
              ? AppColors.redColor
              : AppColors.kSecondary,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  static showDialog(
      {required String msg,
      required final VoidCallback function,
      String? buttonText,
      bool success = false}) {
    Get.defaultDialog(
        title: "",
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 260,
          width: Get.width - 20,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  success
                      ? Utils.getImagePath("Success2")
                      : Utils.getImagePath("warning"),
                  height: 150,
                ),
                Text(
                  msg,
                  style: AppTextStyle.semiBold.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                buildButton(
                  Get.context!,
                  buttonText ?? "Ok",
                  () async => {Get.back(), function()},
                  height: 40,
                  width: 150,
                  textStyle: AppTextStyle.regularPeta
                      .copyWith(color: Colors.white, fontSize: 12),
                )
              ]),
        ));
  }

  static bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool validateUrl(String value) {
    String pattern =
        r"^https://(www.)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static Future getFileFromGallery() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        withReadStream: true,
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ["jpg", "png", "jpeg", "gif", "bmp"]);
    if (file != null) {
      File? returnFile = await refineImage(File(file.files.single.path!));
      Get.log(
          '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }

  static Future getImageFromGallery() async {
    PermissionStatus p = await Permission.photos.status;
    if (p.isPermanentlyDenied || p.isRestricted) {
      Permission.photos.request();
      Utils.showDialog(
        msg: "Permission denied",
        function: () async {
          openAppSettings();
        },
      );
    }
    var file = await ImagePicker.platform.getImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      // File? returnFile = await refineImage(File(file.path));
      File? returnFile = File(file.path);
      Get.log(
          '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }

  VoidCallback? onTap;

  static Future getVideoFromGallery() async {
    var file = await ImagePicker.platform.getVideo(
        source: ImageSource.gallery, maxDuration: Duration(seconds: 60));
    if (file != null) {
      Get.log('${DateTime.now()} [RefineImage.getImageFromGallery]');
      return File(file.path);
    }
  }

  static Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File? returnFile = await refineImage(File(pickedFile.path));
      Get.log(
          '${DateTime.now()} [RefineImage.getImageFromGallery] $returnFile');
      return returnFile;
    }
  }

  static Future<File?> refineImage(File pickedFile) async {
    // final tempDir = await getTemporaryDirectory();

    File toCompress = pickedFile;

    print(toCompress.path);
    //
    // CompressObject compressObject = CompressObject(
    //   imageFile: toCompress,
    //   //image
    //   path: tempDir.path,
    //   // path: "/data/user/0/com.foodleapp/cache/file_picker/", //compress to path
    //   quality: 85,
    //   //first compress quality, default 80
    //   step: 9,
    //   //compress quality step, The bigger the fast, Smaller is more accurate, default 6
    //   mode: CompressMode.LARGE2SMALL, //default AUTO
    // );
    // String? path = await Luban.compressImage(compressObject);
    //
    // print(path);
    //
    // if (path != null) {
    //   toCompress = File(path);
    // }
    //
    // print("FILE SIZE  before: " + toCompress.lengthSync().toString());

    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      compressQuality: 10,
      sourcePath: toCompress.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Refine Image',
            toolbarColor: AppColors.kSecondary,
            toolbarWidgetColor: AppColors.kWhite,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: AppColors.kSecondary,
            backgroundColor: AppColors.kSecondary,
            statusBarColor: AppColors.kSecondary,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Refine Image',
        )
      ],
    );
    if (croppedFile != null) {
      pickedFile = File(croppedFile.path);
      Get.log('[Utils.refineImage] called ${pickedFile.lengthSync()}');
      return pickedFile;
    } else {
      return pickedFile;
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map';
    }
  }

  static String getDay(DateTime createdAt) {
    //DateTime currentDate = DateTime.now();
    final today = DateTime.now().subtract(const Duration(days: 0));
    final thisWeek7 = DateTime.now().subtract(const Duration(days: 7));
    final thisWeek6 = DateTime.now().subtract(const Duration(days: 6));
    final thisWeek5 = DateTime.now().subtract(const Duration(days: 5));
    final thisWeek4 = DateTime.now().subtract(const Duration(days: 4));
    final thisWeek3 = DateTime.now().subtract(const Duration(days: 3));
    final thisWeek2 = DateTime.now().subtract(const Duration(days: 2));
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    //final earlier = DateTime.now().subtract(const Duration(days: 7));

    if (today.day == createdAt.day) {
      return "Today";
    }

    // else if ((currentDate.day - createdAt.day <= 1) || (currentDate.day - createdAt.day == -29)  || (currentDate.day - createdAt.day == -30) || (currentDate.day - createdAt.day == -27)) {
    //   return "Yesterday";
    // }

    else if (yesterday.day == createdAt.day) {
      return "Yesterday";
    }
    // else if (currentDate.day - createdAt.day == 7 ||
    //     currentDate.day - createdAt.day < 0) {
    //   return "This Week";
    // }
    else if (thisWeek7.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek6.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek5.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek4.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek3.day == createdAt.day) {
      return "This Week";
    } else if (thisWeek2.day == createdAt.day) {
      return "This Week";
    }
    // else if (currentDate.day - createdAt.day > 7 &&
    //     currentDate.month - createdAt.month >= 1) {
    //   return "Earlier";
    // }
    return "Earlier";
  }

  // static void launchWebUri(url) async{
  //    String webUri = url ?? "";
  //    if (url != null) {
  //      String webUri = url??"";
  //      print(webUri);
  //      if (!await launchUrl(
  //          Uri.parse(webUri.replaceAll('http://', 'https://'))))
  //        throw 'Could not launch';
  //    }
  //  }

/* static showBottomSheetWidget() {
    showModalBottomSheet(
        context: Get.context!,
        builder: (ctx) {
          return UnAuthorizedBottomSheet();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))));
  }*/

}
