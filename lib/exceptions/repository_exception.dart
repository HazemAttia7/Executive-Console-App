class RepositoryException implements Exception {
  final String message;
  final int? statusCode;

  const RepositoryException(this.message, {this.statusCode});

  @override
  String toString() => 'RepositoryException: $message';
}
