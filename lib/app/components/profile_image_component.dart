import 'package:flutter/material.dart';

typedef void TapAction();

class ProfileImage extends StatelessWidget {
  final ImageProvider profileImage;
  final Size imageSize;
  final EdgeInsets padding;
  final TapAction onTapAction;
  ProfileImage(this.profileImage, this.imageSize,
      {this.padding = EdgeInsets.zero, this.onTapAction});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (this.onTapAction != null) {
          this.onTapAction();
        }
      },
      child: Container(
        padding: padding,
        child: Container(
          width: imageSize.width,
          height: imageSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: profileImage,
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
