import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lib/lib.dart';
import 'package:muskey/muskey.dart';
import 'package:recase/recase.dart';

import '../../data/models/role.dart';
import '../../domain/request/profile_requests.dart';

/// [CreateProfileForm] is a form to create a new user
class CreateProfileForm extends StatefulWidget {
  final VoidCallback? onCancel;
  final Null Function(ProfileModel user)? onCreated;
  const CreateProfileForm({Key? key, this.onCreated, this.onCancel})
      : super(key: key);

  @override
  State<CreateProfileForm> createState() => _CreateProfileFormState();
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _photoUrlController;
  late final TextEditingController _phoneController;
  late final TextEditingController _uidController;

  late final TextEditingController _addressController;

  late final ValueNotifier<List<Role>> _roles;

  late bool _emailVerified;
  late bool _disabled;

  bool _loading = false;
  late String? _error;
  late Map<String, String> _errors;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _photoUrlController = TextEditingController();
    _phoneController = TextEditingController();
    _uidController = TextEditingController(
        text: FirebaseFirestore.instance.collection('profiles').doc().id);

    _roles = ValueNotifier<List<Role>>([]);

    _emailVerified = false;
    _disabled = false;
    _error = null;
    _errors = {};
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errors = {};
        _error = null;
        _loading = true;
      });
      var createRequest = ProfileCreateRequest(
        displayName: _nameController.text,
        email: _emailController.text,
        photoUrl: _photoUrlController.text,
        phoneNumber: _phoneController.text,
        disabled: _disabled,
        roles: _roles.value,
        uid: _uidController.text,
        emailVerified: _emailVerified,
      );
      try {
        var userRecord = await ProfileRepository.instance.create(createRequest);
        widget.onCreated?.call(userRecord);
      }
      // FirebaseFunctionsException
      on FirebaseFunctionsException catch (e) {
        setState(() {
          _error = e.message;
          if (e.details != null &&
              e.details['code'].toString().contains('phone')) {
            _errors['phone'] = e.details['message'];
          } else if (e.details != null &&
              e.details['code'].toString().contains('email')) {
            _errors['email'] = e.details['message'];
          } else if (e.details != null &&
              e.details['code'].toString().contains('password')) {
            _errors['password'] = e.details['message'];
          } else if (e.details != null &&
              e.details['code'].toString().toLowerCase().contains('name')) {
            _errors['name'] = e.details['message'];
          } else if (e.details != null &&
              e.details['code'].toString().toLowerCase().contains('photo')) {
            _errors['photo'] = e.details['message'];
          } else {
            _error = e.message;
          }
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
      child: Container(
        width: 400,
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text('Profile Information'),
                        enabled: false,
                      ),
            
                      const SizedBox(height: 10),
                      // preview image
                      Center(
                        child: ListenableBuilder(
                          listenable: _photoUrlController,
                          builder: (context, _) {
                            return CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(_photoUrlController.text),
                              child: Center(
                                child:
                                    Icon(FluentIcons.image_28_regular, size: 30),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppTextFormField.upload(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        controller: _photoUrlController,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.url()]),
                        decoration: InputDecoration(
                          errorText: _errors['photoUrl'],
                          prefixIcon: const Icon(FluentIcons.image_28_regular),
                          label: Text('Photo url'),
                          alignLabelWithHint: true,
                          helperText: 'direct link to the photo',
                        ),
                      ),
                      const SizedBox(height: 10),
            
                      AppTextFormField(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        controller: _nameController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: InputDecoration(
                          errorText: _errors['name'],
                          prefixIcon: SizedBox(
                              child: const Icon(FluentIcons.person_24_regular)),
                          label: Text('Name'),
                          alignLabelWithHint: true,
                          helperText: 'The name of the user, required *',
                        ),
                      ),
                      const SizedBox(height: 10),
            
                      /// email
                      AppTextFormField(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        controller: _emailController,
                        validator: FormBuilderValidators.compose([
                          // FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                        decoration: InputDecoration(
                          errorText: _errors['email'],
                          prefixIcon: const Icon(FluentIcons.mail_24_regular),
                          label: Text('Email'),
                          alignLabelWithHint: true,
                          helperText:
                              'can be null, but must be valid if provided',
                        ),
                      ),
            
                      const SizedBox(height: 10),
                      // / phone number
                      AppTextFormField(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        controller: _phoneController,
                        inputFormatters: [
                          MuskeyFormatter(
                            masks: ['#########'],
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
                          label: Text('Phone Number'),
                          alignLabelWithHint: true,
                          helperText: 'must be 9 digits, without 0',
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("Other information"),
                        enabled: false,
                      ),
            
                      /// Custom uid
                      AppTextFormField(
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        controller: _uidController,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        decoration: InputDecoration(
                          errorText: _errors['uid'],
                          prefixIcon: const Icon(FluentIcons.person_24_regular),
                          label: Text('Custom uid'),
                          alignLabelWithHint: true,
                          helperText: 'The uid of the user, required *',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SwitchListTile(
                          secondary:
                              const Icon(FluentIcons.presence_blocked_24_regular),
                          contentPadding: EdgeInsets.only(left: 12),
                          visualDensity: VisualDensity(vertical: -3),
                          title: Text('Blocked'),
                          value: _disabled,
                          onChanged: (e) => setState(() {
                            _disabled = e;
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.only(left: 12),
                          visualDensity: VisualDensity(vertical: -3),
                          title: Text('Email Verified'),
                          value: _emailVerified,
                          onChanged: (e) => setState(() {
                            _emailVerified = e;
                          }),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: const Icon(FluentIcons.person_24_regular),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("Roles"),
                        enabled: false,
                      ),
            
                      /// List of chips for roles
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: ListenableBuilder(
                          listenable: _roles,
                          builder: (context,_) {
                            return SizedBox(
                              height: 60,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 24),
                                  // selectable chips for roles
                                  for (var role in [Role('admin'),Role('user')])
                                    ...[InputChip(
                                      onSelected: (selected) {
                                          if (selected) {
                                            if (true)
                                              _roles.value = [];
                                            _roles.value.add(role);
                                          } else {
                                            _roles.value.remove(role);
                                            setState(() {});
                                          }
                                        },
                                      selected: _roles.value.contains(role),
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
                            );
                          }
                        ),
                      ),
            
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

            Divider(
              height: 1,
            ),
            const SizedBox(height: 12),
            // row for 2 buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _submit,
                        child: const Text('Create'),
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
    );
  }
}

/// [SelectTechniciansDialog] is a dialog that have search bar and list of technicians [CheckboxListTile]
class SelectTechniciansDialog extends StatefulWidget {
  /// list of selected technicians [Profile.uid]
  final List<ProfileModel> selected;

  const SelectTechniciansDialog({super.key, this.selected = const []});

  @override
  _SelectTechniciansDialogState createState() =>
      _SelectTechniciansDialogState();
}

class _SelectTechniciansDialogState extends State<SelectTechniciansDialog> {
  final _searchController = TextEditingController();
  final _selected = <ProfileModel>[];
  ListResult<ProfileModel>? technicians;
  var loading = false;

  @override
  void initState() {
    super.initState();
    _selected.addAll(widget.selected);
    loadAfter();
  }

  loadAfter([String? next]) async {
    if (loading) return;
    setState(() {
      loading = true;
    });
    SearchQuery? query;
    if (_searchController.text.isNotEmpty) {
      query = SearchQuery(
        field: 'displayName',
        value: _searchController.text,
      );
    }
    technicians =
        await ProfileRepository.instance.list(
          ListRequest(
            searchQuery: query,
            // TODO: add pagination
            // startAfter: next,
          ),
        );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Technicians'),
      content: Container(
        width: 600,
        constraints: BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppTextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(FluentIcons.search_24_regular),
                hintText: 'Search',
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: technicians == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: technicians!.items.length,
                      itemBuilder: (context, index) {
                        var technician = technicians!.items[index];
                        var selected = _selected
                            .map((e) => e.uid)
                            .contains(technician.uid);
                        return CheckboxListTile(
                          value: selected,
                          onChanged: (e) {
                            setState(() {
                              if (e == true) {
                                _selected.add(technician);
                              } else {
                                _selected.remove(technician);
                              }
                            });
                          },
                          title: Text(technician.displayName ?? 'No name'),
                          subtitle: Text(technician.email ?? 'No email'),
                          secondary: CircleAvatar(
                            backgroundImage: technician.photoUrl == null
                                ? null
                                : NetworkImage(technician.photoUrl!),
                            child: technician.photoUrl == null
                                ? Icon(FluentIcons.person_24_regular)
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        FilledButton.icon(
          icon: Icon(FluentIcons.add_24_regular),
          onPressed: () {
            Navigator.pop(context, _selected);
          },
          label: Text('Save'),
        ),
      ],
    );
  }
}

/// [SelectRolesDialog] is a dialog that have search bar and list of roles [CheckboxListTile]
class SelectRolesDialog extends StatefulWidget {
  /// list of selected roles [Role.name]
  final List<Role> selectedRoles;

  /// return false to prevent select role
  final bool? Function(List<Role> roles)? onSelected;
  const SelectRolesDialog(
      {super.key, this.selectedRoles = const [], this.onSelected});

  @override
  State<SelectRolesDialog> createState() => _SelectRolesDialogState();
}

class _SelectRolesDialogState extends State<SelectRolesDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Roles'),
      content: Container(
        width: 600,
        constraints: BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var role in [Role('admin'),Role('user')])
              SwitchListTile(
                value: widget.selectedRoles.contains(role),
                onChanged: (e) {
                  if (widget.onSelected != null) {
                    if (widget.onSelected!(widget.selectedRoles) == false) {
                      return;
                    }
                  }
                  setState(() {
                    if (e == true) {
                      if (true)
                      widget.selectedRoles.clear();
                      widget.selectedRoles.add(role);
                    } else {
                      widget.selectedRoles.remove(role);
                    }
                  });
                },
                title: Text(role.name.titleCase),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        FilledButton.icon(
          icon: Icon(FluentIcons.add_24_regular),
          onPressed: () {
            Navigator.pop<List<Role>>(context, widget.selectedRoles);
          },
          label: Text('Save'),
        ),
      ],
    );
  }
}
