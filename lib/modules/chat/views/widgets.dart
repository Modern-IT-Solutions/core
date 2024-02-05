// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, use_build_context_synchronously

// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:math';
import 'package:core/modules/chat/views/audio_recorder.dart';
import 'package:record_platform_interface/src/types/record_config.dart';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:core/features/users/presentation/find.dart';
import 'package:core/modules/chat/room/embedded_chat_room_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lib/lib.dart';
import 'package:mime/mime.dart';
import 'package:motif/motif.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:universal_io/io.dart';
// import 'package:video_player/video_player.dart';
import 'package:zplayer/zplayer.dart';

import 'audio_player.dart';

// [EmbeddedChatRoomWidget]
class EmbeddedChatRoomWidget extends StatefulWidget {
  const EmbeddedChatRoomWidget({
    super.key,
    required this.roomRef,
    this.room,
    this.createFunction,
  });

  final ModelRef roomRef;
  final EmbeddedChatRoomModel? room;
  final EmbeddedChatRoomModel Function()? createFunction;

  @override
  State<EmbeddedChatRoomWidget> createState() => _EmbeddedChatRoomWidgetState();
}

class _EmbeddedChatRoomWidgetState extends State<EmbeddedChatRoomWidget> {
  EmbeddedChatRoomModel? room;
  var loading = false;
  double? uploadingProgress;
  bool isRecording = false;
  int mode = 0;
  final _messageController = TextEditingController();
  StreamSubscription<Map<String, dynamic>>? _streamSubscription;
  final ScrollController _scrollController = ScrollController();
  // focus
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    room = widget.room;
    _initStream();
    // focus
  }

  void nextMode() {
    if (mode == 2) {
      mode = 0;
    } else {
      mode++;
    }
    setState(() {});
  }

  // scrolldown
  void _scrollDown() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _createRoom() async {
    setState(() {
      loading = true;
    });
    try {
      var newRoom = widget.createFunction!.call();
      await widget.roomRef.create(newRoom.toJson());
      _initStream();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  ProfileModel? getProfileByRef(ModelRef ref) {
    return room?.profiles.firstWhereOrNull((element) => element.ref == ref);
  }

  Future<void> sendMessage(EmbeddedChatRoomMessage message) async {
    setState(() {
      loading = true;
    });
    try {
      var data = {
        "messages": FieldValue.arrayUnion([
          message.toJson()
        ]),
      };
      // if current profile not in profiles added it
      if (!room!.profilesRefs!.any((e) => e.path == getCurrentProfile()!.ref.path)) {
        data["profiles"] = FieldValue.arrayUnion([
          getCurrentProfile()!.toJson()
        ]);
        data["profilesRefs"] = FieldValue.arrayUnion([
          getCurrentProfile()!.ref.toJson()
        ]);
      }
      await widget.roomRef.update(data);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
    // _focusNode
    _focusNode.requestFocus();
  }

  Future<void> _sendTextMessage(String text) async {
    if (text.isEmpty) {
      return;
    }
    var message = EmbeddedChatRoomTextMessage(
      profileRef: getCurrentProfile()!.ref,
      text: text,
      createdAt: DateTime.now(),
    );
    await sendMessage(message);
  }

  void _initStream() async {
    await _streamSubscription?.cancel();
    _streamSubscription = getDocumentStream(ref: widget.roomRef).listen((event) {
      setState(() {
        room = EmbeddedChatRoomModel.fromJson(event);
      });
      _scrollDown();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  final ImagePicker picker = ImagePicker();

  Future<PlatformFile?> showImagePickerDialog(BuildContext context, {bool compress = true}) async {
    return await showDialog<PlatformFile>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick an image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(FluentIcons.image_24_regular),
                title: const Text("Gallery"),
                onTap: () async {
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: compress ? 70 : 90,
                    maxWidth: compress ? 1080 : 1600,
                    maxHeight: compress ? 720 : 1600,
                  );
                  Navigator.of(context).pop(image == null
                      ? null
                      : PlatformFile(
                          name: image.name,
                          path: image.path,
                          size: await image.length(),
                          bytes: await image.readAsBytes(),
                        ));
                },
              ),
              ListTile(
                leading: const Icon(FluentIcons.camera_24_regular),
                title: const Text("Camera"),
                onTap: () async {
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: compress ? 70 : 90,
                    maxWidth: compress ? 1080 : 1600,
                    maxHeight: compress ? 720 : 1600,
                  );
                  Navigator.of(context).pop(image == null
                      ? null
                      : PlatformFile(
                          name: image.name,
                          path: image.path,
                          size: await image.length(),
                          bytes: await image.readAsBytes(),
                        ));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> sendRecordMessage() async {
  //   setState(() {
  //     loading = false;
  //     uploadingProgress = 0.0;
  //     isRecording = true;
  //   });
  //   try {

  //     var url = await getStorage().upload(pickedFile, (progress) {
  //       setState(() {
  //         uploadingProgress = progress;
  //       });
  //     });

  //     EmbeddedChatRoomMessage message;
  //     await sendMessage(message);
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     setState(() {
  //       loading = false;
  //       uploadingProgress = null;
  //     });
  //   }
  // }

  Future<void> sendFileMessage(FileType type) async {
    setState(() {
      loading = true;
      uploadingProgress = 0.0;
    });
    try {
      PlatformFile? pickedFile;
      if (type == FileType.image) {
        pickedFile = await showImagePickerDialog(context);
        if (pickedFile == null) {
          return;
        }
      } else {
        pickedFile = await pickFile(type);
      }
      if (pickedFile == null) {
        throw Exception("No file picked");
      }
      // sizw must be less then 50MB
      if (pickedFile.size > 50 * 1024 * 1024) {
        throw Exception("File size must be less then 50MB");
      }
      // allow only image/video/audio
      if (lookupMimeType(pickedFile.name, headerBytes: pickedFile.bytes)!.startsWith("image")) {
        type = FileType.image;
      } else if (lookupMimeType(pickedFile.name, headerBytes: pickedFile.bytes)!.startsWith("video")) {
        type = FileType.video;
      } else if (lookupMimeType(pickedFile.name, headerBytes: pickedFile.bytes)!.startsWith("audio")) {
        type = FileType.audio;
      } else {
        throw Exception("Unsupported file type");
      }

      var url = await getStorage().upload(pickedFile, (progress) {
        setState(() {
          uploadingProgress = progress;
        });
      });
      EmbeddedChatRoomMessage message;
      if (type == FileType.audio) {
        message = EmbeddedChatRoomAudioMessage(
          profileRef: getCurrentProfile()!.ref,
          audioUrl: url,
          createdAt: DateTime.now(),
        );
      } else if (type == FileType.video) {
        int? width, height, size = pickedFile.size;
        try {
          // VideoPlayerController controller = VideoPlayerController.file(File(pickedFile.path!));
          // await controller.initialize();
          // width = controller.value.size.width.toInt();
          // height = controller.value.size.height.toInt();
        } catch (e) {}
        message = EmbeddedChatRoomVideoMessage(
          profileRef: getCurrentProfile()!.ref,
          videoUrl: url,
          size: size,
          width: width?.toDouble(),
          height: height?.toDouble(),
          createdAt: DateTime.now(),
        );
      } else if (type == FileType.image) {
        int? width, height, size = pickedFile.size;
        String? hash;
        try {
          var decodedImage = await decodeImageFromList(pickedFile.bytes!);
          width = decodedImage.width;
          height = decodedImage.height;
          try {
            var image = img.decodeImage(pickedFile.bytes!);
            hash = BlurHash.encode(image!).hash;
          } catch (e) {
            print(e);
          }
        } catch (e) {
          print(e);
        }
        message = EmbeddedChatRoomImageMessage(
          profileRef: getCurrentProfile()!.ref,
          imageUrl: url,
          width: width?.toDouble(),
          height: height?.toDouble(),
          blurHash: hash,
          size: size,
          createdAt: DateTime.now(),
        );
        await sendMessage(message);
      } else {
        throw Exception("Unsupported file type");
      }
      await sendMessage(message);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
        uploadingProgress = null;
      });
    }
  }

  Future<PlatformFile?> pickFile(FileType type) async {
    var result = await FilePicker.platform.pickFiles(
      type: type,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      // propose to create a new room
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox.square(dimension: 24),
          Icon(
            FluentIcons.chat_24_regular,
            size: 48,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          ),
          const SizedBox.square(dimension: 24),
          const Text("No chat room"),
          if (widget.createFunction != null && !loading)
            TextButton.icon(
              onPressed: _createRoom,
              icon: const Icon(FluentIcons.add_24_regular),
              label: const Text("Setup the room"),
            ),
          if (loading)
            const SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
              ),
            ),
          const SizedBox.square(dimension: 24),
        ],
      );
    }
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                  child: SinosoidalMotif(
                bounds: const Size(30, 30),
                color: Theme.of(context).colorScheme.secondary,
              )),
              // Positioned.fill(
              //   child: Image(image: getTheme().backgroundImage!, fit: BoxFit.cover),
              // ),
              ListView(
                controller: _scrollController,
                reverse: true,
                children: [
                  // for (int i = 0; i < room!.messages.length; i++)
                  for (int i = room!.messages.length - 1; i >= 0; i--)
                    if (room!.messages[i] is Object
                        //  EmbeddedChatRoomTextMessage || room!.messages[i] is EmbeddedChatRoomImageMessage
                        ) ...[
                      if (mode > 1)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Expanded(child: Divider()),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.yMMMMEEEEd().format(room!.messages[i].createdAt),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                                    ),
                              ),
                              const SizedBox(width: 8),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                      _buildMessage(
                        i == 0 ? null : room!.messages[i - 1],
                        i == room!.messages.length - 1 ? null : room!.messages[i + 1],
                        room!.messages[i],
                        context,
                      ),
                    ],
                  const SizedBox(height: 6),
                  // Text shows the members of the chat
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Members: ${room!.profiles.map((e) => "${e.displayName} (${e.roles.firstOrNull?.name})").join(", ")},",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (loading)
          const SizedBox(
            height: 2,
            child: LinearProgressIndicator(),
          )
        else
          const Divider(height: 1),
        // input
        Row(
          children: [
            MenuAnchor(
              builder: (context, controller, _) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: uploadingProgress != null
                      ? SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: uploadingProgress!,
                          ),
                        )
                      : const Icon(FluentIcons.attach_32_regular),
                );
              },
              menuChildren: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (Platforms.isAndroid || Platforms.isIOS) ...[
                        ListTile(
                          leading: const Icon(FluentIcons.image_24_regular),
                          title: const Text("Image"),
                          onTap: () async {
                            await sendFileMessage(FileType.image);
                          },
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.video_24_regular),
                          title: const Text("Video"),
                          onTap: () async {
                            await sendFileMessage(FileType.video);
                          },
                        ),
                        ListTile(
                          leading: const Icon(FluentIcons.headphones_sound_wave_20_regular),
                          title: const Text("Audio"),
                          onTap: () async {
                            await sendFileMessage(FileType.audio);
                          },
                        ),
                      ],
                      ListTile(
                        leading: const Icon(FluentIcons.mic_24_regular),
                        title: const Text("Record"),
                        onTap: () async {
                          String? audioPath;
                          if (Platforms.isWeb) {
                            audioPath = await showDialog(context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Recorder(
                                    onStop: (path) {
                                      Navigator.of(context).pop(path);
                                    },
                                  ),
                                );    
                              },
                            );
                          } else {
                            audioPath = await showRecordDialog(context);
                          }
                          if (audioPath != null) {
                            var file = File(audioPath);
                            var url = await getStorage().upload(
                                PlatformFile(
                                  name: 'audio',
                                  size: await file.length(),
                                  path: audioPath,
                                ), (progress) {
                              setState(() {
                                loading = true;
                                uploadingProgress = progress;
                              });
                            });
                            EmbeddedChatRoomMessage message = EmbeddedChatRoomAudioMessage(
                              profileRef: getCurrentProfile()!.ref,
                              audioUrl: url,
                              createdAt: DateTime.now(),
                            );
                            await sendMessage(message);
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(FluentIcons.document_24_regular),
                        title: const Text("File"),
                        onTap: () async {
                          await sendFileMessage(FileType.any);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _messageController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type a message...",
                ),
                onSubmitted: loading
                    ? null
                    : (value) async {
                        await _sendTextMessage(value);
                        _messageController.clear();
                      },
              ),
            ),
            IconButton(
              onPressed: loading
                  ? null
                  : () async {
                      await _sendTextMessage(_messageController.text);
                      _messageController.clear();
                    },
              icon: const Icon(FluentIcons.send_24_regular),
            ),
          ],
        ),
        // const Divider(height: 1),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     "This is an embedded chat room, its limited and cant be over 500kb, wish is about 500 messages or less",
        //     textAlign: TextAlign.center,
        //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //           color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        //         ),
        //   ),
        // ),
      ],
    );
  }

  BorderRadius _getBorderRadius(bool hasPrev, bool hasNext, {double max = 8, double min = 16, bool inverse = false}) {
    return BorderRadius.circular(min);
    if (hasPrev && hasNext) {
      BorderRadius b;
      if (inverse) {
        b = BorderRadius.horizontal(
          left: Radius.circular(min),
          right: Radius.circular(max),
        );
      } else {
        b = BorderRadius.horizontal(
          left: Radius.circular(max),
          right: Radius.circular(min),
        );
      }
      return b;
    }
    if (hasPrev) {
      var b = BorderRadius.vertical(
        top: Radius.circular(max),
        bottom: Radius.circular(min),
      );
      if (inverse) {
        return b.copyWith(
          bottomLeft: b.topLeft,
          bottomRight: b.topRight,
          topLeft: b.bottomLeft,
          topRight: b.bottomRight,
        );
      }
    }
    if (hasNext) {
      var b = BorderRadius.vertical(
        top: Radius.circular(min),
        bottom: Radius.circular(max),
      );
      return b;
    }
    var b = BorderRadius.all(Radius.circular(min));
    if (inverse) {
      b = b.copyWith(
        topLeft: Radius.circular(max),
        bottomLeft: Radius.circular(max),
      );
    } else {
      b = b.copyWith(
        topRight: Radius.circular(max),
        bottomRight: Radius.circular(max),
      );
    }
    return b;
  }

  InkWell _buildMessage(EmbeddedChatRoomMessage? prevMessage, EmbeddedChatRoomMessage? nextMessage, EmbeddedChatRoomMessage message, BuildContext context) {
    var isPrevMessageSameProfile = prevMessage?.profileRef == message.profileRef;
    var isNextMessageSameProfile = nextMessage?.profileRef == message.profileRef;
    var showTime = prevMessage?.createdAt.hour == message.createdAt.hour && prevMessage?.createdAt.day == message.createdAt.day && prevMessage?.createdAt.month == message.createdAt.month && prevMessage?.createdAt.year == message.createdAt.year;
    var avatar = Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 30,
      height: 30,
      child: _avatarOf(message.profileRef),
    );

    Widget child = const SizedBox();
    if (message is EmbeddedChatRoomTextMessage) {
      child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          message.text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: getCurrentProfile()?.ref == message.profileRef ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
              ),
        ),
      );
    } else if (message is EmbeddedChatRoomImageMessage) {
      child = Material(
        borderRadius: _getBorderRadius(isPrevMessageSameProfile, isNextMessageSameProfile),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ImageViewer(image: CachedNetworkImageProvider(message.imageUrl));
                },
              ),
            );
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250, maxWidth: 250),
            child: CachedNetworkImage(
              // imageUrl: "${message.imageUrl}?w=${Random().nextInt(1000) + 1000}",
              imageUrl: message.imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) => AspectRatio(
                key: ValueKey(downloadProgress.progress),
                aspectRatio: (message.width ?? 1) / (message.height ?? 1),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: downloadProgress.progress,
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                String errorMessage = "Failed to load image";
                // try {
                //   errorMessage=(error as dynamic).message.toString();
                // } catch (e) {
                //   if (error is Exception) {
                //     errorMessage = error.toString();
                //   }
                // }

                return AspectRatio(
                  aspectRatio: (message.width ?? 1) / (message.height ?? 1),
                  child: Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Theme.of(context).colorScheme.onErrorContainer),
                        const SizedBox(height: 4),
                        Text(
                          errorMessage,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else if (message is EmbeddedChatRoomAudioMessage) {
      child = Material(
        borderRadius: _getBorderRadius(isPrevMessageSameProfile, isNextMessageSameProfile),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          // onTap: () async {
          //   await Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) {
          //         return ImageViewer(image: CachedNetworkImageProvider(message.imageUrl));
          //       },
          //     ),
          //   );
          // },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 148, maxWidth: 350),
            child: AudioPlayer(
              source: message.audioUrl,
            ),

            //  SingleSourceMediaPlayer(
            //   type: SingleSourceMediaPlayerType.audio,
            //   source: Uri.parse(message.audioUrl),
            // ),
          ),
        ),
      );
    } else if (message is EmbeddedChatRoomVideoMessage) {
      child = Material(
        borderRadius: _getBorderRadius(isPrevMessageSameProfile, isNextMessageSameProfile),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          // onTap: () async {
          //   await Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) {
          //         return ImageViewer(image: CachedNetworkImageProvider(message.imageUrl));
          //       },
          //     ),
          //   );
          // },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 250, maxWidth: 250 * (16 / 9)),
            child: SingleSourceMediaPlayer(
              type: SingleSourceMediaPlayerType.audio,
              source: Uri.parse(message.videoUrl),
            ),
          ),
        ),
      );
    }
    var body = Container(
        decoration: BoxDecoration(
          color: getCurrentProfile()?.ref == message.profileRef ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          borderRadius: _getBorderRadius(isPrevMessageSameProfile, isNextMessageSameProfile),
        ),
        child: child);
    var metadata = Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getProfileByRef(message.profileRef)?.displayName ?? "(No name)",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
          ),
        ),
        if (mode > 0) ...[
          Icon(
            FluentIcons.circle_12_filled,
            size: 5,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeago.format(message.createdAt),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  ),
            ),
          )
        ]
      ],
    );
    return InkWell(
      onTap: nextMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            if (!isPrevMessageSameProfile)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46),
                child: Row(
                  mainAxisAlignment: getCurrentProfile()?.ref != message.profileRef ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getProfileByRef(message.profileRef)?.displayName ?? "(No name)",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                            ),
                      ),
                    ),
                    Icon(
                      FluentIcons.circle_12_filled,
                      size: 5,
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        timeago.format(message.createdAt),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                            ),
                      ),
                    )
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: getCurrentProfile()?.ref != message.profileRef ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (getCurrentProfile()?.ref == message.profileRef) ...[
                  isPrevMessageSameProfile ? const SizedBox(width: 46) : avatar,
                  Flexible(child: body),
                  const SizedBox(width: 46),
                ] else ...[
                  const SizedBox(width: 46),
                  Flexible(child: body),
                  isPrevMessageSameProfile ? const SizedBox(width: 46) : avatar,
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarOf(ModelRef profileRef) {
    var profile = getProfileByRef(profileRef);
    return ProfileAvatar(profile: profile);
  }
}

enum SingleSourceMediaPlayerType {
  video,
  audio,
}

class SingleSourceMediaPlayer extends StatefulWidget {
  const SingleSourceMediaPlayer({
    super.key,
    required this.source,
    required this.type,
  });

  final Uri source;
  final SingleSourceMediaPlayerType type;

  @override
  State<SingleSourceMediaPlayer> createState() => _SingleSourceMediaPlayerState();
}

class _SingleSourceMediaPlayerState extends State<SingleSourceMediaPlayer> {
  // ChewieController? chewieController;
  // late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // initializePlayer();
  }

  Future<void> initializePlayer() async {
    // _videoPlayerController = VideoPlayerController.networkUrl(widget.source);
    // _videoPlayerController.initialize();
    // chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   autoPlay: false,
    //   looping: false,
    //   allowPlaybackSpeedChanging: false,
    //   allowFullScreen: false,
    //   allowMuting: false,
    //   showControls: true,
    //   showOptions: false,
    //   showControlsOnInitialize: false,
    //   aspectRatio: _videoPlayerController.value.aspectRatio,
    //   autoInitialize: true,
    //   placeholder: Container(
    //     color: Colors.black,
    //   ),
    // );
    // setState(() {});
  }

  bool showPlayer = false;

  @override
  Widget build(BuildContext context) {
    if (!showPlayer) {
      return InkWell(
        onTap: () {
          showPlayer = true;
          initializePlayer();
          setState(() {});
        },
        child: Container(
          color: Colors.black,
          child: const Center(
            child: Icon(
              FluentIcons.play_24_regular,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return ZPlayer(title: const Text("Media"), streams: {
      ZMuxedStream(
        src: widget.source.toString(),
        resolution: const Size(480, 360),
        qualityLabel: 'SD',
      ),
    });
    // if (chewieController == null) {
    //   return AspectRatio(
    //     aspectRatio: 16 / 9,
    //     child: Container(
    //       color: Colors.black,
    //       child: const Center(
    //         child: CircularProgressIndicator.adaptive(
    //           strokeWidth: 2,
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // return Chewie(
    //   controller: chewieController!,
    // );
  }
}

/// [showRecordDialog]
Future<String?> showRecordDialog(BuildContext context) async {
  final record = AudioRecorder();
  bool isRecording = false;
  String defaultPath = "${(await getTemporaryDirectory()).path}/audio.m4a";
  String? path;
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (path != null)
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: AudioPlayer(
                        source: path!,
                        onDelete: () {
                          setState(() => path = null);
                        },
                      ),
                    )
                  else if (!isRecording)
                    IconButton(
                      onPressed: () async {
                        if (await record.hasPermission()) {
                          await record.start(RecordConfig(
                            encoder:Platforms.isWeb? AudioEncoder.wav: AudioEncoder.aacLc,
                            bitRate: 128000,
                            sampleRate: 44100,
                          ), path: defaultPath);
                        }
                        setState(() {
                          isRecording = true;
                        });
                      },
                      icon: const Icon(
                        FluentIcons.mic_24_regular,
                        size: 60,
                      ),
                      // label: const Text("Record"),
                    ),
                  if (isRecording)
                    IconButton(
                      onPressed: () async {
                        path = await record.stop();
                        setState(() {
                          isRecording = false;
                        });
                      },
                      icon: const Icon(
                        FluentIcons.stop_24_filled,
                        size: 60,
                      ),
                      // label: const Text("Record"),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (isRecording) record.stop();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      if (path != null)
                        TextButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop(path);
                          },
                          icon: const Icon(FluentIcons.send_20_regular),
                          label: const Text("Send"),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
