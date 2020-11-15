
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smkdevapp/constants.dart';

class EmptyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DefaultDimen.spaceExtraLarge),
      child: Column(
        children: [
          SvgPicture.asset(
            DefaultImageLocation.iconBox,
            height: 150,
            width: 150,
            color: Colors.grey[300],
          ),
          SizedBox(height: DefaultDimen.spaceMedium,),
          Text(
            "Oopps! No item found",
            style: TextStyle(
              fontSize: DefaultDimen.textLarge,
              fontFamily: DefaultFont.PoppinsFont,
              fontWeight: DefaultFontWeight.semiBold,
              color: DefaultColor.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
