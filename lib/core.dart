library core;

import 'package:core/features/users/data/models/role.dart';

export 'core/data/datasource.dart';
export 'core/data/model.dart';
export 'core/data/requests.dart';
export 'core/data/results.dart';
export 'core/domain/repository.dart';
export 'core/extensions/extensions.dart';
export 'core/model_manager.dart';
export 'services/services.dart';
export 'services/defaults/service.dart';

/// models
export 'models/notification_model.dart';
export 'models/address_model.dart';
export 'modules/commerce/gift_cards/models/gift_card_order_model.dart';
// export 'models/attachment_model.dart';

/// features
export 'features/users/users.dart';

/// widgets
export './widgets/form_field.dart';
export './widgets/profile_avatar.dart';
export './widgets/data_flag.dart';

export './imports/firebase.dart';
export './converters.dart';
export './models/address_model.dart';
export './features/users/data/models/role.dart';
export './models/base.dart';

export './temp.dart';

export './services/defaults/preferences.dart';
export './services/defaults/theme.dart';
export './services/defaults/firebase/database.dart';
export './services/defaults/helpers.dart';
/// UI
export './features/users/presentation/index.dart';



/// ironpark
/// models
export './models/stadium_model.dart';
export './models/stadium_rental_model.dart';



/// nullIfEmpty extension to String
extension NullIfEmpty on String {
  String? get nullIfEmpty => isEmpty ? null : this;
  // firstCharOrNull
  String get firstCharOrNull => nullIfEmpty == null ? "?" : this[0];

}


class DynamicConfigs {
  static Set<Role> _roles = {Role("admin", permissions: []),Role("user",permissions: [])};
  // set roles
  static void setRoles(Set<Role> roles) {
    _roles = roles;
  }
  // get roles
  static Set<Role> get roles => _roles;
}




/// RECLEAN
/// #modules
/// #commerce
