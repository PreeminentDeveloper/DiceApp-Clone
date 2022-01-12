import 'package:dice_app/core/util/injection_container.dart';
import 'package:dice_app/views/home/provider/home_provider.dart';
import 'package:dice_app/views/profile/provider/profile_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(create: (_) => HomeProvider(inject())),
    ChangeNotifierProvider(create: (_) => ProfileProvider(inject()))
  ];
}
