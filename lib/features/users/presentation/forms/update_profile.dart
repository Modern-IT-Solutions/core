import 'package:algeria/algeria.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:core/features/users/data/models/permission.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:lib/lib.dart';
import 'package:muskey/muskey.dart';
import 'package:recase/recase.dart';

import '../../data/models/role.dart';

/// [UpdateProfileForm] is a form to update a new user
class UpdateProfileForm extends StatefulWidget {
  final VoidCallback? onCancel;
  final Null Function(ProfileModel user)? onUpdated;
  final Null Function(ProfileModel user)? onCreated;
  final ProfileModel? model;
  const UpdateProfileForm({Key? key, this.onUpdated, this.onCreated, this.onCancel, required this.model}) : super(key: key);

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late ProfileUpdateRequest request;

  bool _loading = false;
  late String? _error;
  late Map<String, String> _errors;
  late ProfileModel model;

  @override
  void initState() {
    super.initState();
    _error = null;
    _errors = {};
    var xpath = FirebaseFirestore.instance.collection('profiles').doc();
    model = widget.model ??
        ProfileModel(
          ref: ModelRef(xpath.path),
          uid: xpath.id,
          displayName: "sss",
          email: "",
          phoneNumber: "",
          photoUrl: "",
          roles: [],
          emailVerified: false,
          disabled: false,
          address: const AddressModel(raw: ""),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
    request = ProfileUpdateRequest(
      id: model.ref.id,
      displayName: model.displayName,
      email: model.email,
      phoneNumber: model.phoneNumber,
      photoUrl: model.photoUrl,
      uid: model.uid,
      roles: model.roles,
      emailVerified: model.emailVerified,
      disabled: model.disabled,
      address: model.address ?? const AddressModel(raw: ""),
    );
    print(request);
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errors = {};
        _error = null;
        _loading = true;
      });
      try {
        var newModel = model.copyWith(
          displayName: request.displayName ?? model.displayName,
          email: request.email ?? model.email,
          photoUrl: request.photoUrl ?? model.photoUrl,
          phoneNumber: request.phoneNumber ?? model.phoneNumber,
          disabled: request.disabled ?? model.disabled,
          roles: request.roles ?? model.roles,
          uid: request.uid ?? model.uid,
          emailVerified: request.emailVerified ?? model.emailVerified,
          address: request.address ?? model.address,
          customClaims: {
            ...?model.customClaims,
            "_password": request.newPassword?.trim().nullIfEmpty,
          }
        );
        if (widget.model == null) {
          await setDocument(
            path: 'profiles/${newModel.ref.id}',
            data: {
              ...newModel.toJson(),
            },
          );
        } else {
          await updateDocument(
            path: 'profiles/${newModel.ref.id}',
            data: {
              ...newModel.toJson(),
            },
          );
        }
        widget.onUpdated?.call(newModel);
      }
      // FirebaseFunctionsException
      on FirebaseFunctionsException catch (e) {
        setState(() {
          _error = e.message;
          if (e.details != null && e.details['code'].toString().contains('phone')) {
            _errors['phone'] = e.details['message'];
          } else if (e.details != null && e.details['code'].toString().contains('email')) {
            _errors['email'] = e.details['message'];
          } else if (e.details != null && e.details['code'].toString().contains('password')) {
            _errors['password'] = e.details['message'];
          } else if (e.details != null && e.details['code'].toString().toLowerCase().contains('name')) {
            _errors['name'] = e.details['message'];
          } else if (e.details != null && e.details['code'].toString().toLowerCase().contains('photo')) {
            _errors['photo'] = e.details['message'];
          } else {
            _error = e.message;
          }
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
      }

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PermissionScope(
      permissions: [
        widget.model == null ? "profiles.{any_uid}.create" : "profiles.{any_uid}.read",
      ],
      child: LoadingBox(
        loading: _loading,
        child: Container(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                          visualDensity: VisualDensity(vertical: -3),
                          title: Text('Profile Information'),
                          enabled: false,
                        ),

                        const SizedBox(height: 10),
                        // preview image
                        Center(
                          child: Container(
                            // border
                            padding: const EdgeInsets.all(2),
                            width: 100,
                            height: 100,
                            child: ProfileAvatar(profile: model),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextFormField.upload(
                          key: Key((request.photoUrl).toString()),
                          initialValue: request.photoUrl,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (v) async {
                            setState(() {
                              request.photoUrl = v;
                            });
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.url()
                          ]),
                          decoration: InputDecoration(
                            errorText: _errors['photoUrl'],
                            prefixIcon: const Icon(FluentIcons.image_28_regular),
                            label: const Text('Photo url'),
                            alignLabelWithHint: true,
                            helperText: 'direct link to the photo',
                          ),
                        ),
                        const SizedBox(height: 10),

                        AppTextFormField(
                          initialValue: (request.displayName),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (v) async {
                            setState(() {
                              request.displayName = v;
                            });
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          decoration: InputDecoration(
                            errorText: _errors['name'],
                            prefixIcon: const SizedBox(child: Icon(FluentIcons.person_24_regular)),
                            label: const Text('Name'),
                            alignLabelWithHint: true,
                            helperText: 'The name of the user, required *',
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// email
                        AppTextFormField(
                          initialValue: (request.email),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (v) async {
                            setState(() {
                              request.email = v;
                            });
                          },
                          validator: FormBuilderValidators.compose([
                            // FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          decoration: InputDecoration(
                            errorText: _errors['email'],
                            prefixIcon: const Icon(FluentIcons.mail_24_regular),
                            label: const Text('Email'),
                            alignLabelWithHint: true,
                            helperText: 'can be null, but must be valid if provided',
                          ),
                        ),

                        const SizedBox(height: 10),
                        // / phone number
                        AppTextFormField(
                          initialValue: (request.phoneNumber),
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (v) async {
                            setState(() {
                              request.phoneNumber = v;
                            });
                          },
                          inputFormatters: [
                            MuskeyFormatter(
                              masks: [
                                '#########'
                              ],
                              overflow: OverflowBehavior.forbidden(),
                            )
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return null;
                            var valicator = FormBuilderValidators.compose([
                              // FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.equalLength(9),
                            ]);
                            return valicator(v);
                          },
                          decoration: InputDecoration(
                            // border radius only for the left side
                            errorText: _errors['phone'],
                            prefixIcon: const Icon(FluentIcons.phone_24_regular),
                            prefixText: "+213",
                            label: const Text('Phone Number'),
                            alignLabelWithHint: true,
                            helperText: 'must be 9 digits, without 0',
                          ),
                        ),
                        const Divider(),
                        // address
                        const ListTile(
                          leading: Icon(FluentIcons.location_24_regular),
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                          visualDensity: VisualDensity(vertical: -3),
                          title: Text("Address"),
                          enabled: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: AppTextFormField(
                                  key: Key((request.address?.state).toString()),
                                  initialValue: (request.address?.state),
                                  onTap: (v) async {
                                    var state = await showStatePicker(context);
                                    if (state != v) {
                                      setState(() {
                                        request.address = request.address?.copyWith(city: null);
                                      });
                                    }
                                    print(state);
                                    if (state != null) {
                                      setState(() {
                                        request.address = request.address?.copyWith(state: state.toLowerCase());
                                      });
                                    }
                                  },
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: InputDecoration(
                                    errorText: _errors['state'],
                                    prefixIcon: const Icon(FluentIcons.location_24_regular),
                                    label: const Text('State'),
                                    alignLabelWithHint: true,
                                    helperText: 'The state of the address, required *',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: AppTextFormField(
                                  key: Key((request.address?.city).toString()),
                                  initialValue: (request.address?.city),
                                  onTap: (value) async {
                                    var city = await showCityPicker(context, state: request.address?.state);
                                    if (city != null) {
                                      setState(() {
                                        request.address = request.address?.copyWith(
                                          city: city["commune_name_ascii"].toString().toLowerCase(),
                                        );
                                      });
                                    }
                                  },
                                  enabled: request.address?.state != null,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  decoration: InputDecoration(
                                    errorText: _errors['city'],
                                    prefixIcon: const Icon(FluentIcons.location_24_regular),
                                    label: const Text('City'),
                                    alignLabelWithHint: true,
                                    helperText: 'The city of the address, required *',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // raw
                        AppTextFormField(
                          initialValue: request.address?.raw,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          onChanged: (v) async {
                            request.address = request.address?.copyWith(raw: v);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                          decoration: InputDecoration(
                            errorText: _errors['raw'],
                            prefixIcon: const Icon(FluentIcons.location_24_regular),
                            label: const Text('Raw'),
                            alignLabelWithHint: true,
                            helperText: 'The raw address, required *',
                          ),
                        ),

                        if (can("profiles.{any_uid}.update.roles", any_uid: model.uid)) ...[
                          const Divider(),
                          const ListTile(
                            leading: Icon(FluentIcons.person_24_regular),
                            contentPadding: EdgeInsets.symmetric(horizontal: 24),
                            visualDensity: VisualDensity(vertical: -3),
                            title: Text("Roles"),
                            enabled: false,
                          ),

                          /// List of chips for roles
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: SizedBox(
                              height: 60,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 24),
                                  // selectable chips for roles
                                  for (var role in DynamicConfigs.roles) ...[
                                    InputChip(
                                      onSelected: (selected) {
                                        // if (selected) {
                                        //   if (true)
                                        //     _roles.value = [];
                                        //   _roles.value.add(role);
                                        // } else {
                                        //   _roles.value.remove(role);
                                        //   setState(() {});
                                        // }
                                        setState(() {
                                          if (selected) {
                                            if (true) request.roles = [];
                                            request.roles!.add(role);
                                          } else {
                                            request.roles!.remove(role);
                                          }
                                        });
                                      },
                                      selected: request.roles!.contains(role),
                                      label: Text(role.name.titleCase),
                                      // onDeleted: () {
                                      //     _roles.value.remove(role);
                                      //       setState(() {

                                      //       });
                                      // },
                                    ),
                                    const SizedBox(width: 10)
                                  ],

                                  const SizedBox(width: 24),
                                ],
                              ),
                            ),
                          ),
                        ],
                        if (can("profiles.{any_uid}.update.advanced", any_uid: model.uid)) ...[
                          const Divider(),
                          const ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 24),
                            visualDensity: VisualDensity(vertical: -3),
                            title: Text("advanced"),
                            enabled: false,
                          ),

                          /// Custom uid
                          AppTextFormField(
                            initialValue: request.uid,
                            enabled: widget.model == null,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            onChanged: (v) async {
                              setState(() {
                                request.uid = v;
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            decoration: InputDecoration(
                              errorText: _errors['uid'],
                              prefixIcon: const Icon(FluentIcons.person_24_regular),
                              label: const Text('Custom uid'),
                              alignLabelWithHint: true,
                              helperText: 'The uid of the user, required *',
                            ),
                          ),
                          const SizedBox(height: 10),
                          // new password
                          AppTextFormField(
                            initialValue: request.newPassword,
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            onChanged: (v) async {
                              setState(() {
                                request.newPassword = v.nullIfEmpty;
                              });
                            },
                            validator: FormBuilderValidators.compose([
                              //
                              FormBuilderValidators.minLength(6, allowEmpty: true),
                            ]),
                            decoration: InputDecoration(
                              errorText: _errors['password'],
                              prefixIcon: const Icon(FluentIcons.password_24_regular),
                              label: const Text('New Password'),
                              alignLabelWithHint: true,
                              helperText: 'The new password of the user, optional',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SwitchListTile(
                              secondary: const Icon(FluentIcons.presence_blocked_24_regular),
                              contentPadding: const EdgeInsets.only(left: 12),
                              visualDensity: const VisualDensity(vertical: -3),
                              title: const Text('Blocked'),
                              // desicibe what happen when accound disabled in firebas
                              subtitle: const Text('when disabled, the user will not be able to login, if he is already logged in, he will be logged out with in 1 hour'),
                              value: request.disabled!,
                              onChanged: (e) => setState(() {
                                request.disabled = e;
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SwitchListTile(
                              secondary: const Icon(FluentIcons.mail_24_regular),
                              contentPadding: const EdgeInsets.only(left: 12),
                              visualDensity: const VisualDensity(vertical: -3),
                              title: const Text('Email Verified'),
                              subtitle: const Text('some features require email to be verified'),
                              value: request.emailVerified!,
                              onChanged: (e) => setState(() {
                                request.emailVerified = e;
                              }),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],

                        /// show dialog to select roles
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 24),
                        //   child: TextButton(
                        //     onPressed: () {
                        //       showDialog(
                        //         context: context,
                        //         builder: (context) {
                        //           return SelectRolesDialog(
                        //             selectedRoles: _roles.value,
                        //             onSelected: (roles) {
                        //               setState(() {
                        //                 _roles.value = roles;
                        //               });
                        //             },
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Text(
                        //       _roles.value.isEmpty ? 'Select roles' : 'Edit roles',
                        //       style: TextStyle(
                        //         color: _roles.value.isEmpty ? Colors.grey : Colors.blue,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              const Divider(
                height: 1,
              ),
              const SizedBox(height: 24),
              // row for 2 buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _submit,
                          child: widget.model == null ? const Text('Create') : const Text('Update'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PermissionScopeBehavior {
  alert,
  hidden,
}

class PermissionScope extends StatefulWidget {
  final Widget child;
  final List<String> permissions;
  final PermissionScopeBehavior behavior;

  const PermissionScope({super.key, required this.child, required this.permissions, this.behavior = PermissionScopeBehavior.alert});
  const PermissionScope.hidden({super.key, required this.child, required this.permissions}) : behavior = PermissionScopeBehavior.hidden;

  @override
  State<PermissionScope> createState() => _PermissionScopeState();
}

class _PermissionScopeState extends State<PermissionScope> {
  @override
  Widget build(BuildContext context) {
    if (getCurrentProfile()!.canAny(widget.permissions)) {
      return widget.child;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          FluentIcons.people_error_24_regular,
          size: 40,
        ),
        const SizedBox(height: 12),
        const Text('You are not allowed to do this'),
        // logout
        TextButton.icon(
          label: const Text('Logout'),
          icon: const Icon(FluentIcons.sign_out_24_regular),
          onPressed: () {
            getAuth().signout();
          },
        ),
      ],
    );
  }
}

Future<String?> showStatePicker(BuildContext context) async {
  return await showDialog(
    useRootNavigator: false,
    context: context,
    builder: (context) {
      return const StatePickerDialog();
    },
  );
}

/// [StatePickerDialog] is a dialog to select a state
class StatePickerDialog extends StatefulWidget {
  const StatePickerDialog({super.key});

  @override
  State<StatePickerDialog> createState() => _StatePickerDialogState();
}

/// use Algeris.states wish is List<String>
/// use [ListTile] to show the state, on tap pop with the state
class _StatePickerDialogState extends State<StatePickerDialog> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // title: Text('Select state'),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 800),
        child: Column(
          children: [
            // search field
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppTextFormField(
                controller: _controller,
                onChanged: (v) async {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(FluentIcons.search_24_regular),
                  labelText: 'Search...',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Algeria.states.length,
                itemBuilder: (context, index) {
                  var city = Algeria.states.entries.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop<String>(context, city.value);
                      },
                      title: Text(city.value),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(city.key.toString(), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// showCityPicker

Future<Map<String, dynamic>?> showCityPicker(BuildContext context, {String? state}) async {
  return await showDialog<Map<String, dynamic>>(
    useRootNavigator: false,
    context: context,
    builder: (context) {
      return CityPickerDialog(state: state);
    },
  );
}

/// [CityPickerDialog] is a dialog to select a state
class CityPickerDialog extends StatefulWidget {
  final String? state;
  const CityPickerDialog({super.key, this.state});

  @override
  State<CityPickerDialog> createState() => _CityPickerDialogState();
}

/// use Algeris.states wish is List<String>
/// use [ListTile] to show the state, on tap pop with the state
class _CityPickerDialogState extends State<CityPickerDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  List<Map<String, dynamic>> get cities {
    List<Map<String, dynamic>> value;
    if (widget.state != null) {
      value = Algeria.citiesByState(widget.state!);
    } else {
      value = Algeria.cites;
    }
    if (_controller.text.isEmpty) {
      return value;
    }
    return value.where((element) => element.toString().toLowerCase().contains(_controller.text.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // title: Text('Select state'),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Column(
          children: [
            // search field
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppTextFormField(
                controller: _controller,
                onChanged: (v) async {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(FluentIcons.search_24_regular),
                  labelText: 'Search...',
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  var city = cities.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop<Map<String, dynamic>>(context, city);
                      },
                      title: Text(city['commune_name_ascii'].toString()),
                      subtitle: Text(city['daira_name_ascii'].toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
