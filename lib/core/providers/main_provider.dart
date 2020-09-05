import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class BusyState extends StateNotifier<bool> {
  BusyState() : super(false);

  static final provider = StateNotifierProvider((_) => BusyState());

  void setBusy() => state = true;
  void setNotBusy() => state = false;
}
