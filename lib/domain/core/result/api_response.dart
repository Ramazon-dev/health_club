class ApiResponse<T> {
  ApiResponse(
      this.data, {
        this.message,
        this.meta,
      });

  final T? data;
  final dynamic message;
  final dynamic meta;
}
