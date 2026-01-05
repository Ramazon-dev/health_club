class ForecastResponse {
  ForecastResponse({
    required this.finalTargetBodyFatPercent,
    required this.finalTargetMuscleMassKg,
    required this.finalTargetTotalWeightKg,
    required this.finalContractRefundThresholdKg,
    required this.startTargetBodyFatPercent,
    required this.startTargetMuscleMassKg,
    required this.startTargetTotalWeightKg,
    required this.startContractRefundThresholdKg,
  });

  final int? finalTargetBodyFatPercent;
  final double? finalTargetMuscleMassKg;
  final double? finalTargetTotalWeightKg;
  final double? finalContractRefundThresholdKg;
  final int? startTargetBodyFatPercent;
  final double? startTargetMuscleMassKg;
  final double? startTargetTotalWeightKg;
  final double? startContractRefundThresholdKg;

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    return ForecastResponse(
      finalTargetBodyFatPercent: json["final_target_body_fat_percent"],
      finalTargetMuscleMassKg: json["final_target_muscle_mass_kg"],
      finalTargetTotalWeightKg: json["final_target_total_weight_kg"],
      finalContractRefundThresholdKg: json["final_contract_refund_threshold_kg"],
      startTargetBodyFatPercent: json["start_target_body_fat_percent"],
      startTargetMuscleMassKg: json["start_target_muscle_mass_kg"],
      startTargetTotalWeightKg: json["start_target_total_weight_kg"],
      startContractRefundThresholdKg: json["start_contract_refund_threshold_kg"],
    );
  }
}
