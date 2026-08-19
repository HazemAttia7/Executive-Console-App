import '../models/employee_model.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getAllEmployees();
  Future<Employee> getEmployeeById(int id);
  Future<List<Employee>> getHighestPaid();
  Future<double> getAverageSalary();
  Future<Employee> createEmployee(Employee employee);
  Future<Employee> updateEmployee(int id, Employee employee);
  Future<void> deleteEmployee(int id);
}
