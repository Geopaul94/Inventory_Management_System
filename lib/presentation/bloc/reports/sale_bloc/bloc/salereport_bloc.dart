// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:inventory_management_system/data/models/sales_model.dart';
// import 'package:inventory_management_system/presentation/screeens/reporsts/sales_report.dart';

// part 'salereport_event.dart';
// part 'salereport_state.dart';

// class SalereportBloc extends Bloc<SalereportEvent, SalereportState> {
//   SalereportBloc() : super(SalereportInitial()) {
//   on<SalesReportFetchEvent>(_salereportfetch);
//   }
//   Future <void>_salereportfetch(SalesReportFetchEvent event, Emitter <SalereportState> emit)async{
//     emit(SalereportLoadingState());

//     try {
      



//       List<SalesDetailsModel>salereport =await SalesReportTab().;
//       emit(SalereportSuccessSate(salesreport: salereport));
//     } catch (e) {
//      emit(SalereportErrorState(error: e.toString())); 
//     }
//   }
// }
