import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_bloc.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';

class CustomFunctions {
  static void addSalesman(
    SalesmanBloc salesmanBloc,
    PanelController controller,
    String id,
    String name,
    String tier,
  ) {
    salesmanBloc.add(AddSalesman(id, name, tier));
    controller.close();
    salesmanBloc.add(FetchSalesman());
  }
}
