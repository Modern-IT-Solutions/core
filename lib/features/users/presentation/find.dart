import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lib/lib.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

/// [FindProfileForm] is a form to update a new user
class FindProfileForm extends StatefulWidget {
  final String id;
  final ProfileModel? model;
  final VoidCallback? onCancel;
  final void Function(ProfileModel? station)? onFinded;
  final List<Widget> actions;
  const FindProfileForm({
    Key? key,
    this.onFinded,
    this.onCancel,
    required this.id,
    required this.model,
    this.actions = const [],
  }) : super(key: key);

  @override
  State<FindProfileForm> createState() => _FindProfileFormState();
}

class _FindProfileFormState extends State<FindProfileForm> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  late String? _error;
  ProfileModel? station;
  @override
  void initState() {
    super.initState();
    station = widget.model;
    if (station == null) {
      find();
    }
    _error = null;
  }

  Future<void> find() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _error = null;
        _loading = true;
      });
      var request = FindRequest<ProfileModel>(
        id: widget.id,
      );
      try {
        station = await ProfileRepository.instance.find(request);
        widget.onFinded?.call(station);
      }
      // FirebaseFunctionsException
      on FirebaseFunctionsException catch (e) {
        setState(() {
          _error = e.message;
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
        rethrow;
      }

      setState(() {
        _loading = false;
      });
    }
  }

  BooleanValueNotifier notifier = BooleanValueNotifier.instance;
  @override
  Widget build(BuildContext context) {
    return LoadingBox(
      loading: _loading,
      child: Column(
        children: [
          // show error if not null, in box with red background rounded corners and icon and dismiss button
          if (_error != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(
                    FluentIcons.people_error_24_regular,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                    icon: const Icon(
                      FluentIcons.dismiss_24_regular,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  floating: true,
                  excludeHeaderSemantics: true,
                  forceElevated: true,
                  primary: true,
                  snap: true,
                  stretch: true,
                  stretchTriggerOffset: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: station?.photoUrl == null
                                ? null
                                : DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      station!.photoUrl!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.8),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 5,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  onDoubleTap: () {
                                    notifier.toggle();
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: station?.photoUrl == null
                                        ? null
                                        : CachedNetworkImageProvider(
                                            station!.photoUrl.toString(),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              station?.displayName == null
                                  ? const TextPlaceholder()
                                  : Text(
                                      station!.displayName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: const Text('Find Profile'),
                  leading: const BackButton(),
                  actions: [
                    ...widget.actions,
                  ],
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: ProfileSummary(model: station),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BooleanValueNotifier {
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);

  BooleanValueNotifier._notifier();

  static final BooleanValueNotifier instance = BooleanValueNotifier._notifier();

  void toggle() async {
    loadingNotifier.value = true;
    await Future.delayed(const Duration(seconds: 2));
    loadingNotifier.value = false;
    valueNotifier.value = !valueNotifier.value;
  }
}

/// [ProfileSummary]
class ProfileSummary extends StatefulWidget {
  const ProfileSummary({super.key, this.ref, this.model});

  final String? ref;
  final ProfileModel? model;

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  ProfileModel? profile;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    if (widget.model != null) {
      setState(() {
        profile = widget.model;
      });
    } else if (widget.ref != null) {
      var profile = await getModelDocument(
          path: widget.ref!, fromJson: ProfileModel.fromJson);
      setState(() {
        this.profile = profile;
      });
    }
  }

  double get profitsPercentage =>
      double.tryParse((profile?.metadata["profitsPercentage"]).toString()) ??
      1.0;

  BooleanValueNotifier notifier = BooleanValueNotifier.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: GestureDetector(
            onTap: () async {
              if (profile?.photoUrl.nullIfEmpty != null) {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) {
                      return ImageViewer(
                          image: CachedNetworkImageProvider(profile!.photoUrl
                              .replaceAll("=s96-c", "=w1600")));
                    },
                  ),
                );
              }
            },
            child: ProfileAvatar(profile: profile),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(profile!.displayName.nullIfEmpty ?? "(No name)"),
          subtitle: const Text(
            'Name',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.displayName);
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          onTap: () async {
            await launchUrl(Uri.parse('tel:${profile?.phoneNumber}'));
          },
          leading: const Icon(FluentIcons.phone_20_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(("+213${profile!.phoneNumber ?? ""}").nullIfEmpty ??
                  "(No phone number)"),
          subtitle: const Text(
            'Phone',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.phoneNumber);
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(FluentIcons.mail_24_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(profile!.email.nullIfEmpty ?? "(No email)"),
          subtitle: const Text(
            'Email',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.email);
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(FluentIcons.location_24_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(profile!.address?.raw.nullIfEmpty ?? "(No address)"),
          subtitle: const Text(
            'Address',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.address?.raw);
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        const Divider(),
        // wallet section
        ListTile(
          enabled: false,
          leading: const Icon(FluentIcons.wallet_24_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: const Text('Wallet'),
          // for teachers only show button that edit profets percentage
          trailing: profile?.rolesString.contains("teacher") != true
              ? null
              : IconButton(
                  onPressed: () async {
                    GlobalKey<FormState> formKey = GlobalKey<FormState>();
                    var current = double.tryParse(
                        (profile!.metadata["profitsPercentage"]).toString());
                    var controller = TextEditingController(
                        text:
                            (current != null ? current * 100 : 100).toString());

                    var loading = false;
                    await showDialog<double>(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Form(
                            key: formKey,
                            child: SimpleDialog(
                              title: const Text('Edit Profits Percentage'),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      const Text(
                                          'Enter the new profits percentage'),
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: controller,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'Profits Percentage',
                                          prefixText: '%',
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.numeric(),
                                          FormBuilderValidators.min(0),
                                          FormBuilderValidators.max(100),
                                        ]),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          // loading
                                          if (loading)
                                            const CircularProgressIndicator()
                                          else
                                            TextButton(
                                              onPressed: () async {
                                                if (!formKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                setState(() {
                                                  loading = true;
                                                });
                                                var newProfitsPercentage =
                                                    double.tryParse(
                                                        controller.text);
                                                if (newProfitsPercentage !=
                                                    null) {
                                                  try {
                                                    var result = await profile!
                                                        .ref
                                                        .update({
                                                      "metadata.profitsPercentage":
                                                          newProfitsPercentage /
                                                              100,
                                                    });
                                                    profile = profile!
                                                        .copyWith(metadata: {
                                                      ...profile!.metadata,
                                                      "profitsPercentage":
                                                          newProfitsPercentage /
                                                              100,
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content:
                                                            Text('Updated!'),
                                                      ),
                                                    );
                                                    Navigator.of(context).pop();
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content:
                                                            Text('Failed!'),
                                                      ),
                                                    );
                                                  }
                                                }
                                                setState(() {
                                                  loading = false;
                                                });
                                              },
                                              child: const Text('Save'),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                    );
                    setState(() {});
                  },
                  icon: const Icon(FluentIcons.edit_24_regular),
                ),
        ),
        // balance
        ListTile(
          leading: const Icon(FluentIcons.money_24_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${profitsPercentage * (double.tryParse((profile?.customClaims["wallet"]?["balance"]).toString()) ?? 0)} DZD"),
                    Text(
                        "<- ${profitsPercentage * (double.tryParse((profile?.customClaims["wallet"]?["icoming"]).toString()) ?? 0)} DZD"),
                    Text(
                        "-> ${profitsPercentage * (double.tryParse((profile?.customClaims["wallet"]?["outgoing"]).toString()) ?? 0)} DZD"),
                  ],
                ),
          subtitle: const Text(
            'Balance',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context,
                  profile?.customClaims["wallet"]?["balance"]?.toString());
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        const Divider(),
        // sessions
        const ListTile(
          enabled: false,
          leading: Icon(FluentIcons.clock_24_regular),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          visualDensity: VisualDensity(vertical: -3),
          title: Text('Sessions'),
        ),
        for (var session in [...?profile?.sessions.entries])
          ListTile(
            leading: !session.value.valid
                ? const Icon(FluentIcons.circle_off_20_regular,
                    color: Colors.red)
                : const Icon(Icons.done_all, color: Colors.green),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            visualDensity: const VisualDensity(vertical: -3),
            title: Text(session.key),
            subtitle: Text(
              timeago.format(session.value.createdAt),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        const Divider(),
        // metadata
        const ListTile(
          enabled: false,
          leading: Icon(FluentIcons.info_20_regular),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          visualDensity: VisualDensity(vertical: -3),
          title: Text('Metadata'),
        ),
        // uid
        ListTile(
          leading: const Icon(FluentIcons.person_24_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(
                  profile!.uid,
                  overflow: TextOverflow.ellipsis,
                ),
          subtitle: const Text(
            'UID',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.uid);
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        // createdAt
        ListTile(
          leading: const Icon(FluentIcons.calendar_20_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(
                  "${profile!.createdAt}",
                  overflow: TextOverflow.ellipsis,
                ),
          subtitle: const Text(
            'Created At',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.createdAt.toString());
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        // updated at
        ListTile(
          leading: const Icon(FluentIcons.calendar_20_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(
                  "${profile!.updatedAt}",
                  overflow: TextOverflow.ellipsis,
                ),
          subtitle: const Text(
            'Last Update at',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.updatedAt.toString());
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        // disabled
        ListTile(
          leading: const Icon(FluentIcons.circle_20_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(
                  profile!.disabled ? "Disabled" : "Not disabled",
                ),
          subtitle: const Text(
            'Is Disabled',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.disabled.toString());
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        // email verified
        ListTile(
          leading: const Icon(FluentIcons.circle_20_regular),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          visualDensity: const VisualDensity(vertical: -3),
          title: profile == null
              ? const TextPlaceholder()
              : Text(
                  profile!.emailVerified ? "Verified" : "Not verified",
                ),
          subtitle: const Text(
            'Is Email Verified',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              tryCopy(context, profile?.emailVerified.toString());
            },
            icon: const Icon(FluentIcons.copy_24_regular),
          ),
        ),
        // advanced
        const ListTile(
          enabled: false,
          leading: Icon(FluentIcons.settings_20_regular),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          visualDensity: VisualDensity(vertical: -3),
          title: Text('Advanced'),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: notifier.valueNotifier,
            builder: (context, value, child) {
              return value == true
                  ? JsonView.map(profile?.toJson() ?? {})
                  : const SizedBox(
                      height: 10,
                    );
            })
      ],
    );
  }
}

// try copy
Future<void> tryCopy(BuildContext context, String? text) async {
  if (text != null) {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied! ${text.substring(0, 20)}...'),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  ImageViewer({
    super.key,
    required this.image,
  });

  final ImageProvider image;
  var controller = PhotoViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attachment'),
      ),
      body: Stack(
        children: [
          PhotoView(
            enableRotation: true,
            controller: controller,
            imageProvider: image,
          ),
          // toolbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: const EdgeInsets.only(bottom: 24),
              color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.rotation -= pi / 2;
                    },
                    icon: const Icon(
                        FluentIcons.arrow_rotate_counterclockwise_24_regular),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.rotation += pi / 2;
                    },
                    icon: const Icon(
                        FluentIcons.arrow_rotate_clockwise_16_regular),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
