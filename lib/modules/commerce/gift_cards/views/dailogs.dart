import 'package:core/core.dart';
import 'package:core/features/users/presentation/forms/create_profile.dart';
import 'package:core/features/users/presentation/forms/update_profile.dart';
import 'package:core/modules/commerce/gift_cards/models/gift_card_order_model.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lib/lib.dart';
import 'package:muskey/muskey.dart';
import 'package:recase/recase.dart';

import '../../shipping/shipping_model.dart';
import '../models/gift_card_order_request.dart';

// update gift card order
Future<GiftCardOrderModel?> showUpdateGiftCardOrderModelDailog(BuildContext context, GiftCardOrderModel? model) async {
  var child = Container(
    constraints: const BoxConstraints(maxWidth: 500),
    child: Center(
      child: GiftCardOrderForm.update(
        model: model,
        onUpdated: (context, model) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              width: 400.0,
              content: Text('#${model.shortId} updated'),
              action: SnackBarAction(
                label: 'Show',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showUpdateGiftCardOrderModelDailog(context, model);
                },
              ),
            ),
          );
          Navigator.of(context).pop(model);
          // load();
        },
      ),
    ),
  );
  return await showDialog<GiftCardOrderModel?>(
    context: context,useRootNavigator: false,
    builder: (context) {
      if (MediaQuery.of(context).size.width > 600) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      } else {
        return Dialog.fullscreen(
          child: child,
        );
      }
    },
  );
}

// create gift card order
Future<GiftCardOrderModel?> showCreateGiftCardOrderModelDailog(BuildContext context) async {
  var child = Container(
    constraints: const BoxConstraints(maxWidth: 500),
    child: GiftCardOrderForm.create(
      onCreated: (context, model) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 400.0,
            content: Text('#${model.shortId} created'),
            action: SnackBarAction(
              label: 'Show',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showUpdateGiftCardOrderModelDailog(context, model);
              },
            ),
          ),
        );
        Navigator.of(context).pop(model);
        // load();
      },
    ),
  );
  return await showDialog<GiftCardOrderModel?>(
    context: context,useRootNavigator: false,
    builder: (context) {
      if (MediaQuery.of(context).size.width > 600) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      } else {
        return Dialog.fullscreen(
          child: child,
        );
      }
    },
  );
}

/// [UpdateGiftCardOrderForm] is a form to update a new user
class GiftCardOrderForm extends StatefulWidget {
  final VoidCallback? onCancel;
  final Null Function(BuildContext context, GiftCardOrderModel model)? onUpdated;
  final Null Function(BuildContext context, GiftCardOrderModel model)? onCreated;
  final GiftCardOrderModel? model;
  // create
  const GiftCardOrderForm.create({Key? key, this.onCreated, this.onCancel})
      : model = null,
        onUpdated = null,
        super(key: key);
  // update
  const GiftCardOrderForm.update({Key? key, this.onUpdated, this.onCancel, required this.model})
      : onCreated = null,
        super(key: key);

  @override
  State<GiftCardOrderForm> createState() => _GiftCardOrderFormState();
}

class _GiftCardOrderFormState extends State<GiftCardOrderForm> {
  final _formKey = GlobalKey<FormState>();

  late GiftCardOrderRequest request;

  bool _loading = false;
  late String? _error;
  late Map<String, String> _errors;
  late GiftCardOrderModel model;

  @override
  void initState() {
    super.initState();
    _error = null;
    _errors = {};
    var xpath = FirebaseFirestore.instance.collection('giftCardOrders').doc();
    request = GiftCardOrderRequest(
      ref: ModelRef(widget.model?.ref.path ?? xpath.path),
      createdAt: widget.model?.createdAt ?? DateTime.now(),
      updatedAt: widget.model?.updatedAt ?? DateTime.now(),
      deletedAt: widget.model?.deletedAt,

      ///
      amount: widget.model?.amount,
      status: widget.model?.status ?? OrderStatus.pending,
      profile: widget.model?.profile,
      note: widget.model?.note,
      shipping: widget.model?.shipping ?? ShippingModel.empty,
      metadata: widget.model?.metadata ?? {},
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
        GiftCardOrderModel newModel = GiftCardOrderModel(
          ref: request.ref,
          createdAt: request.createdAt!,
          updatedAt: request.updatedAt!,
          deletedAt: request.deletedAt,

          ///
          amount: request.amount!,
          status: request.status!,
          profile: request.profile!,
          note: request.note,
          shipping: request.shipping!,
          metadata: request.metadata!,
        );
        if (widget.model == null) {
          await setDocument(
            path: '${GiftCardOrderModel.description.path}/${newModel.ref.id}',
            data: newModel.toJson(),
          );
          widget.onCreated?.call(context,newModel);
        } else {
          await updateDocument(
            path: '${GiftCardOrderModel.description.path}/${newModel.ref.id}',
            data: newModel.toJson(),
          );
          widget.onUpdated?.call(context,newModel);
        }
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

  TextEditingController _phoneTmpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingBox(
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

            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const SizedBox(height: 10),
            const ListTile(
              leading: Icon(FluentIcons.status_24_regular),
              visualDensity: VisualDensity(vertical: -3),
              title: Text("Current status"),
              enabled: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: MenuAnchor(
                menuChildren: <Widget>[
                  for (final item in OrderStatus.values)
                    MenuItemButton(
                      leadingIcon: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(item.name.titleCase),
                      onPressed: request.status == item
                          ? null
                          : () => setState(
                                () {
                                  request = request.copyWith(status: item);
                                },
                              ),
                    ),
                ],
                builder: (BuildContext context, MenuController controller, Widget? child) {
                  return ListTile(
                    leading: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: request.status?.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 12),
                    visualDensity: VisualDensity(vertical: -3),
                    title: Text(request.status!.name.titleCase),
                    subtitle: Text("Select Status"),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Icon(FluentIcons.chevron_down_24_regular),
                    ),
                    onTap: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                  );
                },
              ),
            ),
            Divider(),
                      const ListTile(
                        leading: Icon(FluentIcons.settings_20_regular),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("basics"),
                        enabled: false,
                      ),

                      /// email
                      AppTextFormField(
                        initialValue: request.amount?.toString(),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        onChanged: (v) async {
                          setState(() {
                            request = request.copyWith(amount: double.tryParse(v));
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          // FormBuilderValidators.required(),
                          FormBuilderValidators.min(0),
                          FormBuilderValidators.numeric(),
                        ]),
                        inputFormatters: [
                          MuskeyFormatter(masks: [
                            '#'
                          ], overflow: OverflowBehavior.onlyDigits())
                        ],
                        decoration: InputDecoration(
                          errorText: _errors['amount'],
                          prefixIcon: const Icon(FluentIcons.money_24_regular),
                          label: const Text('amount'),
                          alignLabelWithHint: true,
                          helperText: 'the amount of the gift card, required *',
                        ),
                      ),

                      const Divider(),
                      // address
                      const ListTile(
                        leading: Icon(FluentIcons.location_24_regular),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("Shipping & Address"),
                        enabled: false,
                      ),
                      // / phone numbers
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 24),
                          Flexible(
                            child: AppTextFormField(
                              controller: _phoneTmpController,
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
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(40),
                                  ),
                                ),
                                errorText: _errors['phone'],
                                prefixIcon: const Icon(FluentIcons.phone_24_regular),
                                prefixText: "+213",
                                label: const Text('Phone Number'),
                                alignLabelWithHint: true,
                                helperText: 'must be 9 digits, without 0',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: FilledButton.icon(
                              // radius only for the left side
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(40),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_phoneTmpController.text.isNotEmpty) {
                                  request = request.copyWith(
                                    shipping: request.shipping.copyWith(
                                      phoneNumbers: [
                                        ...request.shipping.phoneNumbers!,
                                        _phoneTmpController.text,
                                      ],
                                    ),
                                  );
                                  _phoneTmpController.clear();
                                }
                                setState(() {});
                              },
                              label: const Text('Add'),
                              icon: const Icon(FluentIcons.add_24_regular),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                      Wrap(
                        children: [
                          for (var phone in request.shipping.phoneNumbers)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(phone),
                                onDeleted: () {
                                  setState(() {
                                    request = request.copyWith(
                                      shipping: request.shipping.copyWith(
                                        phoneNumbers: [
                                          ...request.shipping.phoneNumbers.where((element) => element != phone),
                                        ],
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppTextFormField(
                                key: Key((request.shipping.address?.state).toString()),
                                initialValue: (request.shipping.address?.state),
                                onTap: (v) async {
                                  var state = await showStatePicker(context);
                                  if (state != v) {
                                    setState(() {
                                      // request.address = request.address?.copyWith(city: null);
                                      request = request.copyWith(
                                        shipping: request.shipping.copyWith(
                                          address: request.shipping.address.copyWith(
                                            state: state!.toLowerCase(),
                                            city: null,
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                  print(state);
                                  if (state != null) {
                                    setState(() {
                                      // request.address = request.address?.copyWith(state: state.toLowerCase());
                                      request = request.copyWith(
                                        shipping: request.shipping.copyWith(
                                          address: request.shipping.address.copyWith(
                                            state: state.toLowerCase(),
                                            city: null,
                                          ),
                                        ),
                                      );
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
                                key: Key((request.shipping.address.city).toString()),
                                initialValue: (request.shipping.address.city),
                                onTap: (value) async {
                                  var city = await showCityPicker(context, state: request.shipping.address.state);
                                  if (city != null) {
                                    setState(() {
                                      // request.address = request.address?.copyWith(
                                      //   city: city["commune_name_ascii"].toString().toLowerCase(),
                                      // );
                                      request = request.copyWith(
                                        shipping: request.shipping.copyWith(
                                          address: request.shipping.address.copyWith(
                                            city: city["commune_name_ascii"].toString().toLowerCase(),
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                },
                                enabled: request.shipping.address?.state != null,
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
                        initialValue: request.shipping.address?.raw,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        onChanged: (v) async {
                          // request.address = request.address?.copyWith(raw: v);
                          request = request.copyWith(
                            shipping: request.shipping.copyWith(
                              address: request.shipping.address.copyWith(
                                raw: v,
                              ),
                            ),
                          );
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
                      const Divider(),

                      const ListTile(
                        leading: Icon(FluentIcons.person_20_regular),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("buyer"),
                        enabled: false,
                      ),
                      // select teacher
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListTile(
                          leading: ProfileAvatar(profile: request.profile),
                          contentPadding: const EdgeInsets.only(left: 12),
                          visualDensity: const VisualDensity(vertical: -3),
                          title: Text(request.profile?.displayName ?? "Select The customer"),
                          subtitle: const Text("Select customer"),
                          trailing: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(FluentIcons.chevron_down_24_regular),
                          ),
                          onTap: () async {
                            var profiles = await showProfilesPickerDialog(context,
                                filters: [
                                  // IndexViewFilter(
                                  //   name: "Teachers",
                                  //   active: true,
                                  //     local: (model) => model.roles.map((e) => e.name).contains("teacher"),
                                  //   remote: (query) => query.where("roles", arrayContains: "teacher"),
                                  //   strict: false,
                                  //   fixed: true,
                                  // )
                                ],
                                length: 1);
                            if (profiles != null && profiles.isNotEmpty) {
                              // request.teacher = profiles.first;
                              setState(() {
                                request = request.copyWith(
                                  profile: profiles.first,
                                );
                              });
                            }
                          },
                        ),
                      ),

                      const Divider(),
                      const ListTile(
                        leading: Icon(FluentIcons.info_16_regular),
                        contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        visualDensity: VisualDensity(vertical: -3),
                        title: Text("metadata"),
                        enabled: false,
                      ),
                      AppTextFormField(
                        mode: AppTextFormFieldMode.longText,
                        height: 100,
                        initialValue: request.note,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        onChanged: (v) async {
                          setState(() {
                            request = request.copyWith(note: v);
                          });
                        },
                        validator: FormBuilderValidators.compose([]),
                        decoration: InputDecoration(
                          errorText: _errors['note'],
                          prefixIcon: const Icon(FluentIcons.password_24_regular),
                          label: const Text('General Note'),
                          alignLabelWithHint: true,
                          helperText: 'this note can help you to remember something about this user',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: SwitchListTile(
                      //     secondary: const Icon(FluentIcons.presence_blocked_24_regular),
                      //     contentPadding: const EdgeInsets.only(left: 12),
                      //     visualDensity: const VisualDensity(vertical: -3),
                      //     title: const Text('Blocked'),
                      //     // desicibe what happen when accound disabled in firebas
                      //     subtitle: const Text('when disabled, the user will not be able to login, if he is already logged in, he will be logged out with in 1 hour'),
                      //     value: request.disabled!,
                      //     onChanged: (e) => setState(() {
                      //       request.disabled = e;
                      //     }),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: SwitchListTile(
                      //     secondary: const Icon(FluentIcons.mail_24_regular),
                      //     contentPadding: const EdgeInsets.only(left: 12),
                      //     visualDensity: const VisualDensity(vertical: -3),
                      //     title: const Text('Email Verified'),
                      //     subtitle: const Text('some features require email to be verified'),
                      //     value: request.emailVerified!,
                      //     onChanged: (e) => setState(() {
                      //       request.emailVerified = e;
                      //     }),
                      //   ),
                      // ),

                      const SizedBox(height: 10),
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
    );
  }
}



