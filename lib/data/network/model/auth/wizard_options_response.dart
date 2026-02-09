class WizardOptionsResponse {
  WizardOptionsResponse({required this.step, required this.data, required this.options});

  final int? step;
  final WizardDataResponse? data;
  final List<WizardOptionResponse> options;

  factory WizardOptionsResponse.fromJson(Map<String, dynamic> json) {
    return WizardOptionsResponse(
      step: json["step"],
      data: json["data"] == null ? null : WizardDataResponse.fromJson(json["data"]),
      options: json["options"] == null
          ? []
          : List<WizardOptionResponse>.from(json["options"]!.map((x) => WizardOptionResponse.fromJson(x))),
    );
  }
}

class WizardDataResponse {
  WizardDataResponse({required this.text, required this.isCustom});

  final String? text;
  final bool? isCustom;

  factory WizardDataResponse.fromJson(Map<String, dynamic> json) {
    return WizardDataResponse(text: json["text"], isCustom: json["is_custom"]);
  }
}

class WizardOptionResponse {
  WizardOptionResponse({required this.text, required this.answer, required this.selected});

  final String? text;
  final String? answer;
  final bool? selected;

  factory WizardOptionResponse.fromJson(Map<String, dynamic> json) {
    return WizardOptionResponse(text: json["text"], answer: json["answer"], selected: json["selected"]);
  }

  WizardOptionResponse copyWith({bool? selected}) {
    return WizardOptionResponse(text: text, answer: answer, selected: selected ?? this.selected);
  }
}
