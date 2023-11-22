import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:valiq_editor_demo/constants/layout_constants.dart';

class ColorPicketWidget extends StatefulWidget {
  final String label;
  final String description;
  final Color initialColor;
  final Function(Color) onColorChanged;
  final EdgeInsetsGeometry? contentPadding;
  const ColorPicketWidget(
      {super.key,
      required this.label,
      this.contentPadding,
      required this.initialColor,
      required this.onColorChanged,
      required this.description});

  @override
  State<ColorPicketWidget> createState() => _ColorPicketWidgetState();
}

class _ColorPicketWidgetState extends State<ColorPicketWidget> {
  late Color pickedColor;

  @override
  void initState() {
    super.initState();
    pickedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: widget.contentPadding ?? const EdgeInsets.all(0),
          title: Text(widget.label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  )),
          subtitle: Text(widget.description,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.7),
                  )),
          style: ListTileStyle.drawer,
          onTap: () =>
              colorPickerDialog(context).then((picked) => picked ? widget.onColorChanged(pickedColor) : null),
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: widget.initialColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: .5,
              ),
            ),
          ),
        ),
        ColorPicker(
            color: widget.initialColor, onColorChanged: (Color color) => widget.onColorChanged(color)),
      ],
    );
  }

  Future<bool> colorPickerDialog(BuildContext context) async {
    return ColorPicker(
      color: widget.initialColor,
      onColorChanged: (Color color) => setState(() => pickedColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      padding: const EdgeInsets.all(kDefaultPadding),
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showColorCode: true,
      title: Text(
        widget.label,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      showColorName: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: false,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      elevation: 5,
      constraints: const BoxConstraints(maxWidth: 400),
    );
  }
}
