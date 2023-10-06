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
  final Future<void> Function(String value)? onChanged;

  /// [onSubmitted] is the onSubmitted of the text field, its not required
  final void Function(String value)? onSubmitted;

  /// [fileUploadTriger] is the fileUploadTriger of the text field, its not required
  final ValueNotifier<Function?>? fileUploadTriger;

  final List<TextInputFormatter>? inputFormatters;
  const AppTextFormField({
    super.key,
    this.onChanged,
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
  });

  /// min constracter
  const AppTextFormField.min({
    super.key,
    this.onChanged,
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
  });

  /// min constracter
  const AppTextFormField.upload({
    super.key,
    this.onChanged,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: widget.margin,
          height: widget.height,
          child: TextFormField(
            onTap: () async {
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
            maxLines: 1,
            scrollPadding: const EdgeInsets.all(0),
            // expands: true,
            decoration: widget.decoration.copyWith(
              isDense: true,
              constraints: BoxConstraints(
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
              suffixIcon: widget.mode == AppTextFormFieldMode.upload
                  ? uploading
                      ? Align(
                          alignment: Alignment.center,
                          child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : TextButton.icon(
                          label: Text('UPLOAD'),
                          onPressed: _trigerUpload,
                          icon: const Icon(FluentIcons.arrow_upload_24_regular),
                        )
                  : null,
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

  Future<void> _trigerUpload() async {
    setState(() {
      uploading = true;
    });
    final file = await pickFile();
    if (file != null) {
      final url = await uploadFile(file);
      if (url != null) {
        _controller.text = url;
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
    final snapshot = await uploadTask.whenComplete(() {});
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
              constraints: BoxConstraints(
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
