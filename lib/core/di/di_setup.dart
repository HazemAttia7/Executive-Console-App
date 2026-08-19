import 'package:get_it/get_it.dart';

import '../../features/executive_console/presentation/managers/cubits/employee_directory_cubit.dart';
import '../../features/executive_console/data/repositories/employee_repository.dart';
import '../../features/executive_console/data/repositories/employee_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDI() async {
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(),
  );

  sl.registerFactory<EmployeeDirectoryCubit>(
    () => EmployeeDirectoryCubit(sl<EmployeeRepository>()),
  );
}
