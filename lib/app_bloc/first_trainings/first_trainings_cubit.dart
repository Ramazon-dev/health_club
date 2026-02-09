import 'package:health_club/data/network/model/first_training_response.dart';
import 'package:health_club/data/network/provider/main_provider.dart';

import '../app_bloc.dart';

part 'first_trainings_state.dart';

class FirstTrainingsCubit extends Cubit<FirstTrainingsState> {
  final MainProvider mainProvider;

  FirstTrainingsCubit(this.mainProvider) : super(FirstTrainingsInitial()) {
    fetchTrainings();
  }

  Future<void> fetchTrainings() async {
    emit(FirstTrainingsLoading());
    final res = await mainProvider.getPlanedFirstTrainings();
    final data = res.data;
    if (data != null) {
      emit(FirstTrainingsLoaded(data));
    } else {
      emit(FirstTrainingsError(res.message));
    }
  }
}
