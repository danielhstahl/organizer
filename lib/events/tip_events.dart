import '../models/tip.dart';

abstract class TipEvents {}

class HasDataEvent extends TipEvents {
  final List<Tip> data;

  HasDataEvent(this.data);
}
