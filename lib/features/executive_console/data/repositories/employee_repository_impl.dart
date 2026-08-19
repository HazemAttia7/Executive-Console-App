import 'package:dio/dio.dart';

import '../../../../core/config/api_config.dart';
import '../../../../exceptions/repository_exception.dart';
import '../models/employee_model.dart';
import 'employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final Dio _dio;

  EmployeeRepositoryImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
        ),
      );

  @override
  Future<List<Employee>> getAllEmployees() async {
    try {
      final response = await _dio.get('/all');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => Employee.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Employee> getEmployeeById(int id) async {
    try {
      final response = await _dio.get('/$id');
      return Employee.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<Employee>> getHighestPaid() async {
    try {
      final response = await _dio.get('/highest-paid');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => Employee.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<double> getAverageSalary() async {
    try {
      final response = await _dio.get('/average-salary');
      return (response.data as num).toDouble();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    try {
      final response = await _dio.post('', data: employee.toJson());
      return Employee.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Employee> updateEmployee(int id, Employee employee) async {
    try {
      final response = await _dio.put('/$id', data: employee.toJson());
      return Employee.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteEmployee(int id) async {
    try {
      await _dio.delete('/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  RepositoryException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const RepositoryException(
          'Connection timed out. Please ensure your phone and PC '
          'are on the same Wi-Fi network.',
        );
      case DioExceptionType.connectionError:
        return const RepositoryException(
          'Unable to connect to the server. Please ensure your phone '
          'and PC are on the same Wi-Fi network.',
        );
      case DioExceptionType.badResponse:
        return RepositoryException(
          'Server returned an error: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
        );
      default:
        return RepositoryException(
          e.message ?? 'An unexpected network error occurred.',
        );
    }
  }
}
