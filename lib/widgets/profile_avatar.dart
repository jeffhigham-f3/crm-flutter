import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:verb_crm_flutter/config/palette.dart';
import 'package:animate_do/animate_do.dart';
import 'package:verb_crm_flutter/service/import.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String imageAsset;
  final bool isActive;
  final bool hasBorder;
  final double radius; // 20.0
  final Color backgroundColor; // Colors.grey[200]
  final Color borderColor; // Colors.white
  final String initials;
  final IconData sourceIcon;

  const ProfileAvatar({
    Key key,
    this.imageUrl,
    this.imageAsset,
    @required this.radius,
    @required this.backgroundColor,
    @required this.borderColor,
    this.initials = "",
    this.isActive = false,
    this.hasBorder = false,
    this.sourceIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    final borderThickness = hasBorder
        ? radius < 20
            ? 14.5
            : radius - 2.5
        : radius;
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: borderColor,
          child: CircleAvatar(
            radius: borderThickness,
            backgroundColor: backgroundColor,
            backgroundImage: imageUrl != null ? CachedNetworkImageProvider(imageUrl) : null,
            child: (imageUrl == null && imageAsset == null)
                ? Text(
                    initials == null ? '' : initials,
                    style: TextStyle(color: borderColor, fontSize: radius * .75),
                  )
                : imageAsset != null
                    ? Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(imageAsset),
                      )
                    : null,
          ),
        ),
        isActive
            ? Positioned(
                bottom: radius / 12,
                right: radius / 12,
                child: Pulse(
                  duration: Duration(seconds: 1),
                  child: GestureDetector(
                    onTap: () => {print('"Online" clicked!')},
                    child: Container(
                      height: radius / 2,
                      width: radius / 2,
                      decoration: BoxDecoration(
                        color: themeService.online,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: hasBorder ? 2.0 : 0.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        sourceIcon != null
            ? Positioned(
                left: 0.0,
                bottom: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    sourceIcon,
                    color: Colors.grey[500],
                    size: radius * .45,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
