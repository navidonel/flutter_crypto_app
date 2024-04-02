
class ResponseModel<T> {
  late SStatus status;
  late T data;
  late String message;

  ResponseModel.loading(this.message) : status = SStatus.LOADING;
  ResponseModel.completed(this.data) : status = SStatus.COMPLETED;
  ResponseModel.error(this.message) : status = SStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum SStatus { LOADING, COMPLETED, ERROR }