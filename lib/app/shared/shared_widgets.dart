import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redically_local/app/routes/app_pages.dart';
import 'package:xayn_swipe_it/xayn_swipe_it.dart';

import '../CustomClipper/custom_cliper_menu.dart';
import '../CustomClipper/custom_clipper.dart';
import '../config/AppTextStyles.dart';
import '../config/app_colors.dart';
import '../util/util.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  const BackgroundWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundYellow,
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              color: AppColors.backgroundBlue,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          width: Get.width,
          right: -150,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset("assets/images/Mountains.png"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  "assets/images/mountainvector.svg",
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          width: Get.width * 0.72,
          right: 60,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset("assets/images/Mountains.png"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  "assets/images/mountainvector.svg",
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          width: Get.width * 0.8,
          right: 0,
          child: Image.asset("assets/images/darkgreentrees.png"),
        ),
        Scaffold(
          body: child,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}

class BackgroundWrapperMenu extends StatelessWidget {
  final Widget child;
  const BackgroundWrapperMenu({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundBlue,
          child: CustomPaint(
            size: Size(
                Get.width,
                (Get.height)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: CustomClipperMenu(),
          ),
        ),
        Positioned(
          bottom: 0,
          width: Get.width,
          right: -150,
          child: Image.asset("assets/images/Mountains.png"),
        ),
        Positioned(
          bottom: 0,
          width: Get.width * 0.72,
          right: 60,
          child: Image.asset("assets/images/Mountains.png"),
        ),
        Positioned(
          bottom: 0,
          width: Get.width * 0.8,
          right: 0,
          child: Image.asset("assets/images/Trees.png"),
        ),
        Scaffold(
          body: child,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}

Widget buildSlideableButton(
  BuildContext context,
  String text,
  String? Function(Iterable<String>) onclick, {
  bool? selected,
}) {
  return Wrap(
    children: [
      InkWell(
        onTap: () {
          onclick(["NO"]);
        },
        child: Icon(
          Icons.clear_rounded,
          color: AppColors.redColor,
        ),
      ),
      SizedBox(
        width: Get.width - 200,
        height: 90,
        child: Swipe<String>(
          onOptionTap: (option) => print(option.toString()),
          stayOpenedDuration: Duration(milliseconds: 0),
          onFling: onclick,
          opensToPosition: 0.3,
          optionsRight: const ["NO"],
          optionsLeft: const ["YES"],
          optionBuilder: (context, option, index, isSelected) =>
              SwipeOptionContainer(
            option: option,
            color: AppColors.background,
            child: Center(
              child: Text(option.toString()),
            ),
          ),
          child: Container(
            height: 90,
            padding: EdgeInsets.all(10),
            width: Get.width - 200,
            decoration: BoxDecoration(
                color: selected == true
                    ? AppColors.greenColor
                    : selected == false
                        ? AppColors.redColor
                        : AppColors.buttonColor,
                borderRadius: BorderRadius.circular(150)),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Flash(
                    infinite: true,
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white60,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: text == "Submit"
                        ? AppTextStyle.buttonTextUnselected
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w600)
                        : AppTextStyle.buttonTextUnselected,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Flash(
                    infinite: true,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white60,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () {
          onclick(["YES"]);
        },
        child: Icon(
          Icons.check,
          color: AppColors.greenColor,
        ),
      ),
    ],
  );
}

Widget buildTextFeild(
  BuildContext context,
  String hint,
  TextEditingController textController,
  FocusNode node, {
  required GetxController controller,
  double? width,
  double? height,
  TextStyle? hintStyle,
  bool obscure = false,
  TextInputType? inputType,
}
    ) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return Align(
    child: GestureDetector(
      onTap: () {
        node.requestFocus();
        controller.update();
      },
      child: Container(
        height: height ?? 90,
        padding: const EdgeInsets.all(10),
        width: width ?? Get.width - 200,
        decoration: BoxDecoration(
            color: node.hasFocus ? AppColors.white : AppColors.buttonColor,
            borderRadius: BorderRadius.circular(150)),
        child: Center(
          child: TextField(
            keyboardType: inputType,
            focusNode: node,
            onTap: () {
              print("heyy");
              controller.update();
            },
            obscureText: obscure,
            controller: textController,
            textAlign: TextAlign.center,
            cursorColor: node.hasFocus ? AppColors.buttonColor : Colors.white,
            style: obscure
                ? !regex.hasMatch(textController.text)
                    ? AppTextStyle.buttonTextSelected
                        .copyWith(color: Colors.red)
                    : node.hasFocus
                        ? AppTextStyle.buttonTextSelected
                        : AppTextStyle.buttonTextUnselected
                : node.hasFocus
                    ? AppTextStyle.buttonTextSelected
                    : AppTextStyle.buttonTextUnselected,
            decoration: InputDecoration.collapsed(
                hintText: node.hasFocus ? "" : hint,
                hintStyle: node.hasFocus
                    ? hintStyle?.copyWith(color: AppColors.buttonColor) ??
                        AppTextStyle.buttonTextSelected
                    : hintStyle?.copyWith(color: AppColors.white) ??
                        AppTextStyle.buttonTextUnselected),
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget buildAppBar(Widget title) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColors.background,
    title: title,
    leading: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Image.asset(Utils.getIconPath("backButton")),
    ),
    centerTitle: true,
    actions: [
      IconButton(
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
          icon: const Icon(
            Icons.cancel_outlined,
            size: 40,
            color: AppColors.darkGrey,
          )),
      const SizedBox(
        width: 5,
      )
    ],
  );
}

class buildButton extends StatefulWidget {
  BuildContext context;
  String text;
  Function() onPressed;
  double? width;
  double? height;
  TextStyle? textStyle;
  Duration duration;

  buildButton(
    BuildContext context,
    String text,
    Function() onPressed, {
    double? width,
    double? height,
    TextStyle? textStyle,
    int debounceTimeMs = 3000,
  })  : this.text = text,
        this.onPressed = onPressed,
        this.duration = Duration(milliseconds: debounceTimeMs),
        this.width = width,
        this.height = height,
        this.context = context,
        this.textStyle = textStyle;

  @override
  _buildButtonState createState() => _buildButtonState();
}

class _buildButtonState extends State<buildButton> {
  late ValueNotifier<bool> _isEnabled;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _isEnabled = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ValueListenableBuilder(
        valueListenable: _isEnabled,
        builder: (context, isEnabled, child) => GestureDetector(
          onTap: () => isEnabled ? _onButtonPressed() : null,
          child: SizedBox(
            width: widget.width ?? Get.width - 200,
            height: widget.height ?? 90,
            child: Container(
              height: 90,
              padding: EdgeInsets.all(10),
              width: Get.width - 200,
              decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(150)),
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: widget.textStyle ??
                      AppTextStyle.buttonTextUnselected
                          .copyWith(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonPressed() {
    _isEnabled.value = false;
    widget.onPressed();
    _timer = Timer(widget.duration, () => _isEnabled.value = true);
    print("hehehhehe");
  }
}
