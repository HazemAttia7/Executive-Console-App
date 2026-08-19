class Employee {
  final int employeeID;
  final String name;
  final int? managerID;
  final double? salary;

  // UI-only fields — known gap: the API does not provide these.
  // Fallback values are used in the UI when these are null.
  final String? department;

  const Employee({
    required this.employeeID,
    required this.name,
    this.managerID,
    this.salary,
    this.department,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeID: json['employeeID'] as int,
      name: json['name'] as String,
      managerID: json['managerID'] as int?,
      salary: (json['salary'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeID': employeeID,
      'name': name,
      'managerID': managerID,
      'salary': salary,
    };
  }

  /// Fallback department label when the API doesn't provide one.
  String get displayDepartment => department ?? 'GENERAL';

  /// Formatted employee ID for display.
  String get displayEmpId => employeeID.toString().padLeft(3, '0');

  /// Formatted manager ID for display, or "—" if null.
  String get displayManagerId =>
      managerID != null ? managerID.toString().padLeft(3, '0') : '—';

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '';
  }
}
