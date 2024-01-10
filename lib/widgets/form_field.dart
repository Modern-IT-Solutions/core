import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';

/// [AppTextFormFieldMode] enum for [AppTextFormField] mode
enum AppTextFormFieldMode {
  /// [AppTextFormFieldMode.text] is the normal mode
  text,

  /// [AppTextFormFieldMode.longText] is the normal mode
  longText,

  /// [AppTextFormFieldMode.upload] is the upload mode
  upload,

  /// [AppTextFormFieldMode.date] is the date mode
  date,

  /// time
  time,

  /// date and time
  dateTime,
}

/// [AppTextFormField] is a text field for app
/// its small and has a label and icon and a hint text and controller and validator
class AppTextFormField extends StatefulWidget {
  /// [label] is the label of the text field, its not required
  final Widget? label;

  /// [helper] is a widget
  final Widget? helper;

  /// [height] is the height of the text field, default is 30
  final double? height;

  /// [useButtonHeight] is the useButtonHeight of the text field, default is false
  final bool useButtonHeight;

  /// [validator] is the validator of the text field, its not required
  final String? Function(String?)? validator;

  /// [controller] is the controller of the text field, its not required
  final TextEditingController? controller;

  /// [decoration] is the decoration of the text field, its not required
  final InputDecoration decoration;

  /// [enabled] is the enabled of the text field, its not required
  final bool enabled;

  /// [margin] is the margin of the text field, its not required
  final EdgeInsetsGeometry? margin;

  /// [onChanged] is the onChanged of the text field, its not required
  final void Function(String value)? onChanged;

  /// [onTap] is the onTap of the text field, its not required
  final void Function(String? value)? onTap;

  /// [onSubmitted] is the onSubmitted of the text field, its not required
  final void Function(String value)? onSubmitted;

  /// [fileUploadTriger] is the fileUploadTriger of the text field, its not required
  final ValueNotifier<Function?>? fileUploadTriger;

  /// [initialValue]
  final String? initialValue;

  /// [inputFormatters]
  final List<TextInputFormatter>? inputFormatters;

  /// keyboardType
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    this.useButtonHeight = false,
    this.onChanged,
    this.initialValue,
    this.onTap,
    this.onSubmitted,
    this.label,
    this.helper,
    this.height,
    this.validator,
    this.controller,
    this.enabled = true,
    this.decoration = const InputDecoration(),
    this.inputFormatters,
    this.margin,
    this.mode = AppTextFormFieldMode.text,
    this.fileUploadTriger,
    this.keyboardType,
  });

  /// min constracter
  const AppTextFormField.min({
    super.key,
    this.useButtonHeight = false,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.label,
    this.helper,
    this.inputFormatters,
    this.enabled = true,
    this.height = 32,
    this.validator,
    this.margin,
    this.controller,
    this.decoration = const InputDecoration(),
    this.mode = AppTextFormFieldMode.text,
    this.fileUploadTriger,
    this.keyboardType,
  });

  /// min constracter
  const AppTextFormField.upload({
    super.key,
    this.useButtonHeight = false,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.onSubmitted,
    this.label,
    this.helper,
    this.height,
    this.validator,
    this.controller,
    this.enabled = true,
    this.decoration = const InputDecoration(),
    this.inputFormatters,
    this.margin,
    this.mode = AppTextFormFieldMode.upload,
    this.fileUploadTriger,
    this.keyboardType,
  });


  /// [mode]
  final AppTextFormFieldMode mode;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late TextEditingController _controller;
  String? error;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    // on validation failed set error text
    if (widget.validator != null) {
      _controller.addListener(() {
        setState(() {
          error = widget.validator!(_controller.text);
        });
      });
    }
    if (widget.fileUploadTriger != null) {
      widget.fileUploadTriger!.value = _trigerUpload;
    }
    super.initState();
  }

  bool uploading = false;
  double? uploadingProgress;

  @override
  Widget build(BuildContext context) {
    final BoxConstraints constraints;
    final ThemeData theme = Theme.of(context);
    final Offset densityAdjustment = theme.visualDensity.baseSizeAdjustment;
    constraints = BoxConstraints(
      minWidth: kMinInteractiveDimension + densityAdjustment.dx,
      minHeight: kMinInteractiveDimension + (densityAdjustment.dx) - 8,
      maxHeight: kMinInteractiveDimension + (densityAdjustment.dx) - 8,
    );
    print(densityAdjustment);
    return Container(
      margin: widget.margin,
      height: widget.height,
      constraints:widget.useButtonHeight? constraints: null,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        onTap: () async {
          widget.onTap?.call(_controller.text);
          if (widget.mode == AppTextFormFieldMode.date) {
            var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              _controller.text = date.toIso8601String().split('T').first;
            }
          } else if (widget.mode == AppTextFormFieldMode.time) {
            var time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              _controller.text = time.toString();
            }
          } else if (widget.mode == AppTextFormFieldMode.dateTime) {
            var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              var time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                _controller.text = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                ).toString();
                widget.onChanged?.call(_controller.text);
              }
            }
          }
        },
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        cursorHeight: 30,
        maxLines: widget.mode == AppTextFormFieldMode.longText? null: 1,
        scrollPadding: const EdgeInsets.all(0),
        // expands: true,
        decoration: widget.decoration.copyWith(
          isDense: true,
          alignLabelWithHint: true,
          contentPadding: widget.decoration.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 10),
          filled: widget.decoration.filled ?? true,
          fillColor: widget.decoration.fillColor ??
              Theme.of(context).colorScheme.surfaceVariant,
          border: widget.decoration.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
          helperText: uploadingProgress != null
              ? '${(uploadingProgress! * 100).toStringAsFixed(0)}%'
              : null,
          suffixIcon: widget.mode == AppTextFormFieldMode.upload
              ? uploading
                  ?  Container(
                    padding: const EdgeInsets.all(8),
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: uploadingProgress,
                    ),
                  )
                  : TextButton.icon(
                      label: const Text('UPLOAD',),
                      onPressed: _trigerUpload,
                      icon: const Icon(FluentIcons.arrow_upload_24_regular),
                    )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }

  Future<void> _trigerUpload() async {
    setState(() {
      uploading = true;
    });
    final file = await pickFile();
    if (file != null) {
      final url = await uploadFile(file);
      if (url != null) {
        _controller.text = url;
        widget.onChanged?.call(_controller.text);
      }
    }
    setState(() {
      uploading = false;
    });
  }

  Future<PlatformFile?> pickFile() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }
  }

  uploadFile(PlatformFile file) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('uploads')
        .child('${DateTime.now().millisecondsSinceEpoch}');
    late UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = ref.putData(file.bytes!);
    } else {
      uploadTask = ref.putData(await File(file.path!).readAsBytes());
    }
    uploadTask.snapshotEvents.listen((event) {
      if (event.totalBytes != 0) { 
        setState(() {
          uploadingProgress = event.bytesTransferred / event.totalBytes;
        });
      }
    });
    final snapshot = await uploadTask.whenComplete(() {
      setState(() {
        uploadingProgress = null;
      });
    });
    if (snapshot.state == TaskState.success) {
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }
  }
}

class AppNumberTextFormField extends StatefulWidget {
  /// [label] is the label of the text field, its not required
  final Widget? label;

  /// [helper] is a widget
  final Widget? helper;

  /// [height] is the height of the text field, default is 30
  final double? height;

  /// [validator] is the validator of the text field, its not required
  final String? Function(String?)? validator;

  /// [controller] is the controller of the text field, its not required
  final TextEditingController? controller;

  /// [decoration] is the decoration of the text field, its not required
  final InputDecoration decoration;

  const AppNumberTextFormField({
    Key? key,
    this.label,
    this.helper,
    this.height,
    this.validator,
    this.controller,
    this.decoration = const InputDecoration(),
  }) : super(key: key);

  /// min constracter
  const AppNumberTextFormField.min({
    super.key,
    this.label,
    this.helper,
    this.height = 32,
    this.validator,
    this.controller,
    this.decoration = const InputDecoration(),
  });

  @override
  State<AppNumberTextFormField> createState() => _AppNumberTextFormFieldState();
}

class _AppNumberTextFormFieldState extends State<AppNumberTextFormField> {
  late TextEditingController _controller;
  String? error;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    // on validation failed set error text
    if (widget.validator != null) {
      _controller.addListener(() {
        setState(() {
          error = widget.validator!(_controller.text);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (widget.label != null)
        //   DefaultTextStyle(
        //     style: Theme.of(context).textTheme.caption!,
        //     child: Row(
        //       children: [
        //         widget.label!,
        //         const SizedBox(width: 5),
        //         if (widget.validator != null)
        //           const Text(
        //             '*',
        //             style: TextStyle(color: Colors.red),
        //           ),
        //       ],
        //     ),
        //   ),
        SizedBox(
          height: widget.height,
          child: FormBuilderPhoneField(
            name: 'ho',
            controller: widget.controller,
            // cursorHeight: 30,
            // maxLines: 1,
            scrollPadding: const EdgeInsets.all(0),
            // expands: true,
            decoration: widget.decoration.copyWith(
              isDense: true,
              constraints: const BoxConstraints(
                  // maxHeight: 30,
                  ),
              alignLabelWithHint: true,
              contentPadding: widget.decoration.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 10),
              filled: widget.decoration.filled ?? true,
              fillColor: widget.decoration.fillColor ??
                  Theme.of(context).colorScheme.surfaceVariant,
              border: widget.decoration.border ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
            ),
            validator: widget.validator,
          ),
        ),
        // if (this.widget.helper != null)
        //   DefaultTextStyle(
        //     style: Theme.of(context).textTheme.caption!,
        //     child: widget.helper!,
        //   ),
      ],
    );
  }
}
