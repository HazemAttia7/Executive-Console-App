import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../exceptions/repository_exception.dart';
import '../../../data/models/employee_model.dart';
import '../../../data/repositories/employee_repository.dart';

// --- States ---

abstract class EmployeeDirectoryState {}

class EmployeeDirectoryInitial extends EmployeeDirectoryState {}

class EmployeeDirectoryLoading extends EmployeeDirectoryState {}

class EmployeeDirectoryLoaded extends EmployeeDirectoryState {
  final List<Employee> employees;
  final double avgSalary;
  final List<Employee> highestPaid;

  EmployeeDirectoryLoaded({
    required this.employees,
    required this.avgSalary,
    required this.highestPaid,
  });
}

class EmployeeDirectorySearching extends EmployeeDirectoryState {
  final List<Employee> employees;
  final double avgSalary;
  final List<Employee> highestPaid;

  EmployeeDirectorySearching({
    required this.employees,
    required this.avgSalary,
    required this.highestPaid,
  });
}

class EmployeeDirectoryError extends EmployeeDirectoryState {
  final String message;

  EmployeeDirectoryError(this.message);
}

// --- Cubit ---

class EmployeeDirectoryCubit extends Cubit<EmployeeDirectoryState> {
  final EmployeeRepository _repository;

  List<Employee> _allEmployees = [];
  double _avgSalary = 0;
  List<Employee> _highestPaid = [];

  EmployeeDirectoryCubit(this._repository) : super(EmployeeDirectoryInitial());

  Future<void> loadData() async {
    emit(EmployeeDirectoryLoading());

    try {
      final results = await Future.wait([
        _repository.getAllEmployees(),
        _repository.getAverageSalary(),
        _repository.getHighestPaid(),
      ]);

      final employees = results[0] as List<Employee>;
      final avgSalary = results[1] as double;
      final highestPaid = results[2] as List<Employee>;

      _allEmployees = employees;
      _avgSalary = avgSalary;
      _highestPaid = highestPaid;

      emit(
        EmployeeDirectoryLoaded(
          employees: employees,
          avgSalary: avgSalary,
          highestPaid: highestPaid,
        ),
      );
    } on RepositoryException catch (e) {
      emit(EmployeeDirectoryError(e.message));
    } catch (e) {
      emit(
        EmployeeDirectoryError(
          'Unable to load employees. Please ensure your phone '
          'and PC are on the same Wi-Fi network.',
        ),
      );
    }
  }

  Future<void> searchEmployeeById(String value) async {
    final id = int.tryParse(value.trim());

    if (id == null) {
      return;
    }

    final currentEmployees = state is EmployeeDirectoryLoaded
        ? (state as EmployeeDirectoryLoaded).employees
        : _allEmployees;

    emit(
      EmployeeDirectorySearching(
        employees: currentEmployees,
        avgSalary: _avgSalary,
        highestPaid: _highestPaid,
      ),
    );

    try {
      final employee = await _repository.getEmployeeById(id);

      emit(
        EmployeeDirectoryLoaded(
          employees: [employee],
          avgSalary: _avgSalary,
          highestPaid: _highestPaid,
        ),
      );
    } on RepositoryException catch (e) {
      emit(EmployeeDirectoryError(e.message));
    } catch (e) {
      emit(EmployeeDirectoryError('Unable to search for the employee.'));
    }
  }

void clearSearch() {
  emit(
    EmployeeDirectoryLoaded(
      employees: _allEmployees,
      avgSalary: _avgSalary,
      highestPaid: _highestPaid,
    ),
  );
}

  Future<bool> createEmployee(Employee employee) async {
    try {
      final createdEmployee = await _repository.createEmployee(employee);

      _allEmployees = [..._allEmployees, createdEmployee];

      emit(
        EmployeeDirectoryLoaded(
          employees: _allEmployees,
          avgSalary: _avgSalary,
          highestPaid: _highestPaid,
        ),
      );

      return true;
    } on RepositoryException catch (e) {
      emit(EmployeeDirectoryError(e.message));
      return false;
    }
  }

  Future<bool> updateEmployee(int id, Employee employee) async {
    try {
      final updatedEmployee = await _repository.updateEmployee(id, employee);

      _allEmployees = _allEmployees.map((e) {
        return e.employeeID == id ? updatedEmployee : e;
      }).toList();

      _highestPaid = _highestPaid.map((e) {
        return e.employeeID == id ? updatedEmployee : e;
      }).toList();

      emit(
        EmployeeDirectoryLoaded(
          employees: _allEmployees,
          avgSalary: _avgSalary,
          highestPaid: _highestPaid,
        ),
      );

      return true;
    } on RepositoryException catch (e) {
      emit(EmployeeDirectoryError(e.message));
      return false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await _repository.deleteEmployee(id);

      _allEmployees = _allEmployees.where((e) => e.employeeID != id).toList();

      _highestPaid = _highestPaid.where((e) => e.employeeID != id).toList();

      emit(
        EmployeeDirectoryLoaded(
          employees: _allEmployees,
          avgSalary: _avgSalary,
          highestPaid: _highestPaid,
        ),
      );
    } on RepositoryException catch (e) {
      emit(EmployeeDirectoryError(e.message));
    }
  }

  Future<void> retry() => loadData();
}
