import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/app/setting_app.dart';

class KeyTileGroupButton extends StatefulWidget {
  final KeyTileDataGroupModel group;
  final bool isSelected;
  final void Function() onTap;
  final void Function(KeyTileDataGroupModel group) onRemove;

  KeyTileGroupButton({
    super.key,
    required this.isSelected,
    required this.group,
    required this.onTap,
    required this.onRemove,
  });

  @override
  State<KeyTileGroupButton> createState() => _KeyTileGroupButtonState();
}

class _KeyTileGroupButtonState extends State<KeyTileGroupButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (v){
        setState(() {
          isHover = true;
        });
      },
      onExit: (v){
        setState(() {
          isHover = false;
        });
      },
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: FilledButton(
                  onPressed: widget.onTap,
                  child: Text(widget.group.name),
                style: FilledButton.styleFrom(
                  backgroundColor: widget.isSelected ? SettingsTokens.primary : SettingsTokens.onSurface,
                ),
              )),
          if(isHover)
          Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () => widget.onRemove(widget.group),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                  ),
                  child: Icon(Icons.remove, size: 12,),
                ),
              )),
        ],
      ),
    );
  }
}