import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

class KeyTile extends StatelessWidget {
  final bool pressed;
  final KeyTileDataModel keyTileDataModel;
  final bool showKeyCount;
  KeyTile({
    super.key,
    required this.keyTileDataModel,
    required this.pressed,
    required this.showKeyCount,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(pressed? keyTileDataModel.style.pressedBorderRadius : keyTileDataModel.style.idleBorderRadius),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 60),
        decoration: BoxDecoration(
          color: Color(pressed ? keyTileDataModel.style.pressedBackgroundColor : keyTileDataModel.style.idleBackgroundColor),
          border: Border.all(
              color: Color(pressed ? keyTileDataModel.style.pressedBorderColor : keyTileDataModel.style.idleBorderColor),
              width: pressed ? keyTileDataModel.style.pressedBorderWidth : keyTileDataModel.style.idleBorderWidth
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              keyTileDataModel.label,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(pressed ? keyTileDataModel.style.pressedKeyFontColor : keyTileDataModel.style.idleKeyFontColor),
                fontWeight: FontWeight.values[pressed ? keyTileDataModel.style.pressedKeyFontWeight : keyTileDataModel.style.idleKeyFontWeight],
                fontSize: pressed ? keyTileDataModel.style.pressedKeyFontSize : keyTileDataModel.style.idleKeyFontSize,
              ),
            ),
            if(showKeyCount)
            Text(
              "${keyTileDataModel.keyCount}",
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color(pressed ? keyTileDataModel.style.pressedKeyFontColor : keyTileDataModel.style.idleCounterFontColor,),
                fontWeight: FontWeight.values[pressed ? keyTileDataModel.style.pressedCounterFontWeight : keyTileDataModel.style.idleCounterFontWeight],
                fontSize: pressed ? keyTileDataModel.style.pressedCounterFontSize : keyTileDataModel.style.idleCounterFontSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}