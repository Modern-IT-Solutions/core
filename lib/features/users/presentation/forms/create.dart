// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:lib/lib.dart';
// import 'package:lib/widgets/validators.dart';
// import 'package:muskey/muskey.dart';
// import 'package:nanoid/nanoid.dart';

// import '../../../../shared/widgets/form_field.dart';
// import '../../data/models/user_model.dart';
// import '../../data/repositories/repository.dart';
// import '../../domain/request/requests.dart';

// /// [CreateUserForm] is a form to create a new user
// class CreateUserForm extends StatefulWidget {
//   final VoidCallback? onCancel;
//   final Null Function(UserModel user)? onCreated;
//   const CreateUserForm({Key? key, this.onCreated, this.onCancel})
//       : super(key: key);

//   @override
//   State<CreateUserForm> createState() => _CreateUserFormState();
// }

// class _CreateUserFormState extends State<CreateUserForm> {
//   final _formKey = GlobalKey<FormState>();

//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late bool _emailVerified;
//   late bool _disabled;
//   late Set<String> _roles;
//   late final TextEditingController _phoneController;
//   late final TextEditingController _passwordController;
//   late final TextEditingController _photoUrlController;
//   bool _loading = false;
//   late String? _error;
//   late Map<String, String> _errors;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: '');
//     _emailController = TextEditingController();
//     _emailVerified = false;
//     _disabled = false;
//     _roles = <String>{};
//     _phoneController = TextEditingController(text: '');
//     _passwordController = TextEditingController(text: '');
//     _photoUrlController = TextEditingController();
//     _error = null;
//     _errors = {};
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _errors = {};
//         _error = null;
//         _loading = true;
//       });
//       var createRequest = UserCreateRequest(
//         uid: nanoid(),
//         displayName: _nameController.text,
//         phoneNumber: "+213${_phoneController.text}",
//         emailVerified: _emailVerified,
//         disabled: _disabled,
//         email: _emailController.text,
//         password: _passwordController.text,
//         photoURL: _photoUrlController.text,
//       );
//       try {
//         var userRecord =
//             await UserRepository.instance.create(createRequest);
//         widget.onCreated?.call(userRecord);
//       }
//       // FirebaseFunctionsException
//       on FirebaseFunctionsException catch (e) {
//         setState(() {
//           _error = e.message;
//           if (e.details != null &&
//               e.details['code'].toString().contains('phone')) {
//             _errors['phone'] = e.details['message'];
//           } else if (e.details != null &&
//               e.details['code'].toString().contains('email')) {
//             _errors['email'] = e.details['message'];
//           } else if (e.details != null &&
//               e.details['code'].toString().contains('password')) {
//             _errors['password'] = e.details['message'];
//           } else if (e.details != null &&
//               e.details['code'].toString().toLowerCase().contains('name')) {
//             _errors['name'] = e.details['message'];
//           } else if (e.details != null &&
//               e.details['code'].toString().toLowerCase().contains('photo')) {
//             _errors['photo'] = e.details['message'];
//           } else {
//             _error = e.message;
//           }
//         });
//       } catch (e) {
//         setState(() {
//           _error = e.toString();
//         });
//       }

//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LoadingBox(
//       loading: _loading,
//       child: Container(
//         width: 400,
//         padding: EdgeInsets.only(bottom: 24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // show error if not null, in box with red background rounded corners and icon and dismiss button
//             if (_error != null)
//               Container(
//                 padding: EdgeInsets.all(12),
//                 margin: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.red[100],
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       FluentIcons.people_error_24_regular,
//                       color: Colors.red,
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         _error!,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _error = null;
//                         });
//                       },
//                       icon: Icon(
//                         FluentIcons.dismiss_24_regular,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 24),
//                     visualDensity: VisualDensity(vertical: -3),
//                     title: Text('User Information'),
//                     enabled: false,
//                   ),
//                   AppTextFormField(
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     controller: _nameController,
//                     validator: FormBuilderValidators.compose([
//                       FormBuilderValidators.required(),
//                     ]),
//                     decoration: InputDecoration(
//                       errorText: _errors['name'],
//                       prefixIcon: SizedBox(
//                           child: const Icon(FluentIcons.person_24_regular)),
//                       label: Text('Name'),
//                       alignLabelWithHint: true,
//                       helperText: 'The name of the user, required *',
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   /// phone number
//                   AppTextFormField(
//                     inputFormatters: [
//                       MuskeyFormatter(
//                         masks: ['#########'],
//                         overflow: OverflowBehavior.forbidden(),
//                       )
//                     ],
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     controller: _phoneController,
//                     validator: FormBuilderValidators.compose([
//                       // FormBuilderValidators.required(),
//                       FormBuilderValidators.numeric(),
//                       FormBuilderValidators.equalLength(9),
//                     ]),
//                     decoration: InputDecoration(
//                       errorText: _errors['phone'],
//                       prefixIcon: const Icon(FluentIcons.phone_24_regular),
//                       prefixText: "+213",
//                       label: Text('Phone Number'),
//                       alignLabelWithHint: true,
//                       helperText: 'must be 9 digits, without 0',
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   /// phone number
//                   AppTextFormField(
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     controller: _photoUrlController,
//                     validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.url()]),
//                     decoration: InputDecoration(
//                       errorText: _errors['photoUrl'],
//                       prefixIcon: const Icon(FluentIcons.image_28_regular),
//                       label: Text('Photo url'),
//                       alignLabelWithHint: true,
//                       helperText: 'direct link to the photo',
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   /// email
//                   AppTextFormField(
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     controller: _emailController,
//                     validator: FormBuilderValidators.compose([
//                       // FormBuilderValidators.required(),
//                       FormBuilderValidators.email(),
//                     ]),
//                     decoration: InputDecoration(
//                       errorText: _errors['email'],
//                       prefixIcon: const Icon(FluentIcons.mail_24_regular),
//                       label: Text('Email'),
//                       alignLabelWithHint: true,
//                       helperText: 'can be null, but must be valid if provided',
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   /// password
//                   AppTextFormField(
//                     margin: EdgeInsets.symmetric(horizontal: 24),
//                     controller: _passwordController,
//                     validator: (v) {
//                       if (_emailController.text.isNotEmpty && v!.isEmpty) {
//                         return 'password is required if email is provided';
//                       }
//                       // min length of 6 if provided
//                       if (v!.isNotEmpty && v.length < 6) {
//                         return 'password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       errorText: _errors['password'],
//                       prefixIcon: const Icon(FluentIcons.password_24_regular),
//                       label: Text('Password'),
//                       alignLabelWithHint: true,
//                       helperText: 'required if email is provided',
//                     ),
//                   ),
//                   Divider(),
//                   ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 24),
//                     visualDensity: VisualDensity(vertical: -3),
//                     title: Text('Advanced Options'),
//                     enabled: false,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: SwitchListTile(
//                       secondary:
//                           const Icon(FluentIcons.presence_blocked_24_regular),
//                       contentPadding: EdgeInsets.only(left: 12),
//                       visualDensity: VisualDensity(vertical: -3),
//                       title: Text('Blocked'),
//                       value: _disabled,
//                       onChanged: (e) => setState(() {
//                         _disabled = e;
//                       }),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: SwitchListTile(
//                       contentPadding: EdgeInsets.only(left: 12),
//                       visualDensity: VisualDensity(vertical: -3),
//                       title: Text('Email Verified'),
//                       value: _emailVerified,
//                       onChanged: (e) => setState(() {
//                         _emailVerified = e;
//                       }),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Divider(),
//                   const SizedBox(height: 12),
//                   // row for 2 buttons
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           child: SizedBox(
//                             width: double.infinity,
//                             child: FilledButton(
//                               onPressed: _submit,
//                               child: const Text('Create'),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('Cancel'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
