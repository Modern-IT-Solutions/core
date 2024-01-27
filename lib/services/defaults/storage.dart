import 'package:core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../consts/consts.dart';
import 'service.dart';

/// [StorageServiceConfigs] responsible for storage service configs
class StorageServiceConfigs extends ServiceConfigs {
  /// mediaCacheDaysToExpire
  final int? mediaCacheDaysToExpire;

  /// mediaCacheEncryptionPassword
  final String? mediaCacheEncryptionPassword;

  const StorageServiceConfigs({
    this.mediaCacheDaysToExpire,
    this.mediaCacheEncryptionPassword,
  });
}

/// [StorageService] responsible for storage
/// it will be used to store data locally or remotely on firebase storage
/// it has the ability to cache files locally using [media_cache_manager] package
class StorageService extends Service {
  /// configs
  final StorageServiceConfigs configs;

  StorageService({
    super.id = 'DEFAULT',
    this.configs = const StorageServiceConfigs()});

  @override
  Future<void> init() async {
    await _initCacheManager();
    super.init();
    log.info('App~Service: Storage initialized');
  }

  /// init cache manager
  /// https://pub.dev/packages/media_cache_manager
  Future<void> _initCacheManager() async {
    await MediaCacheManager.instance.init(
      daysToExpire: configs.mediaCacheDaysToExpire,
      encryptionPassword: configs.mediaCacheEncryptionPassword,
    );
    log.info('App~Service: Cache manager initialized');
  }

  /// get file
  // StreamSubscription<DownloadMediaSnapshot> get(Uri uri) {
  //   var controller = StreamController<DownloadMediaSnapshot>();
  //   DownloadMediaBuilderController(
  //     url: uri.toString(),
  //     onSnapshotChanged: (snapshot) {
  //       controller.add(snapshot);
  //       log.info('App~Service: Downloading file: ${snapshot.status}');
  //     },
  //     snapshot: DownloadMediaSnapshot(),
  //   );
  // }


  Future<String> upload(PlatformFile file, void Function(double?) progressCallback) async {
    final ref = FirebaseStorage.instance.ref()
      .child('uploads')
      .child(getCurrentProfile()!.uid)
      .child('${DateTime.now().millisecondsSinceEpoch}');
    late UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = ref.putData(file.bytes!);
    } else {
      uploadTask = ref.putData(await File(file.path!).readAsBytes());
    }
    uploadTask.snapshotEvents.listen((event) {
      if (event.totalBytes != 0) {
        progressCallback(event.bytesTransferred / event.totalBytes);
      }
    });
    final snapshot = await uploadTask.whenComplete(() {
      progressCallback(null);
    });
    if (snapshot.state == TaskState.success) {
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }
    throw Exception('Upload failed');
  }
}
