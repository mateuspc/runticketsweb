
class ApiResponse<T> {
  late bool ok = false;
  late String? msg;
  late int? code;
  late T result;


  ApiResponse.ok(this.result, {this.msg}) {
    ok = true;
  }

  ApiResponse.error(this.result, {this.msg, this.code}) {
    ok = false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ApiResponse &&
              runtimeType == other.runtimeType &&
              ok == other.ok &&
              result == other.result;

  @override
  int get hashCode => ok.hashCode ^ result.hashCode;
}