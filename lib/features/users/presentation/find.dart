import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:lib/lib.dart';

import '../../../core/data/requests.dart';


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
      var request = FindRequest<ProfileModel> (
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

  @override
  Widget build(BuildContext context) {
    return LoadingBox(
      loading: _loading,
      child: Column(
        children: [
          // show error if not null, in box with red background rounded corners and icon and dismiss button
          if (_error != null)
            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    FluentIcons.people_error_24_regular,
                    color: Colors.red,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                    icon: Icon(
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
                  flexibleSpace:  FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: station?.photoUrl == null
                                      ? null
                                      : DecorationImage(
                                          image: NetworkImage(
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 5,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: station?.photoUrl ==
                                                null
                                            ? null
                                            : NetworkImage(
                                                station!.photoUrl.toString(),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    station?.displayName == null
                                        ? TextPlaceholder()
                                        : Text(
                                            station!.displayName,
                                            style: TextStyle(
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
                  title: Text('Find Profile'),
                  leading: const BackButton(),
                  actions: [
                    ...widget.actions,
                  ],
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: ConstrainedBox(
                      /// max width is 600
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            ListTile(
                              leading: Icon(FluentIcons.gas_pump_24_regular),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 24),
                              visualDensity: VisualDensity(vertical: -3),
                              title: station?.displayName == null
                                  ? TextPlaceholder()
                                  : Text(station!.displayName),
                              subtitle: Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: Icon(FluentIcons.location_24_regular),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 24),
                              visualDensity: VisualDensity(vertical: -3),
                              title: station?.displayName == null
                                  ? TextPlaceholder()
                                  : Text(station!.address?.raw ?? ''),
                              subtitle: Text(
                                'Address',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: Icon(FluentIcons.location_24_regular),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 24),
                              visualDensity: VisualDensity(vertical: -3),
                              title: station?.displayName == null
                                  ? TextPlaceholder()
                                  : Text(
                                      "${station!.address?.location?.geopoint.latitude}, ${station!.address?.location?.geopoint.longitude}"),
                              subtitle: Text(
                                'Location',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: Icon(FluentIcons.phone_24_regular),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 24),
                              visualDensity: VisualDensity(vertical: -3),
                              title: station?.displayName == null
                                  ? TextPlaceholder()
                                  : Text(
                                      station!.phoneNumber
                                    ),
                              subtitle: Text(
                                'Phone Numbers',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListTile(
                              leading: Icon(FluentIcons.mail_24_regular),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 24),
                              visualDensity: VisualDensity(vertical: -3),
                              title: station?.displayName == null
                                  ? TextPlaceholder()
                                  : Text(station!.email.toString()),
                              subtitle: Text(
                                'Email',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
