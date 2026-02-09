class CheckQrResponse {
  CheckQrResponse({required this.status});

  final String? status;

  factory CheckQrResponse.fromJson(Map<String, dynamic> json) {
    return CheckQrResponse(status: json["status"] != null ? resultToEnum(json["status"]) : null);
  }

  static String resultToEnum(String status) {
    if (status == QrStatusEnum.ok.name) {
      return QrStatusEnum.ok.result;
    } else if (status == QrStatusEnum.deny.name) {
      return QrStatusEnum.deny.result;
    } else if (status == QrStatusEnum.visited.name) {
      return QrStatusEnum.visited.result;
    } else if (status == QrStatusEnum.wrong.name) {
      return QrStatusEnum.wrong.result;
    } else {
      return status;
    }
  }
}

enum QrStatusEnum {
  ok('Успешно (посещение засчитано)'),
  deny('Нет активной подписки или брони'),
  visited('Визит был зарегистрирован'),
  wrong('Неверный код');

  final String result;

  const QrStatusEnum(this.result);
}
