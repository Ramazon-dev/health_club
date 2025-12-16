// import 'package:flutter/widgets.dart';

// import '../../generated/l10n.dart';

// extension LocalizationExtension on BuildContext {
//   AppLocalization get lang => AppLocalization.of(this);
//
//   Future<AppLocalization> loadLocale(String code) async {
//     final locale = Locale(code);
//     return await AppLocalization.load(locale);
//   }
// }

// extension MapExt on Map<String, String> {
//   String lang(BuildContext context) {
//     late String lang;
//     if (context.lang.lang == 'langEn') {
//       lang = this['langEn'] ?? '';
//     } else if (context.lang.lang == 'langRu') {
//       lang = this['langRu'] ?? '';
//     } else {
//       lang = this['langUz'] ?? '';
//     }
//     return lang;
//   }
// }

// extension BackendErrorExt on AppLocalization {
//   String? errorByKey(String? key, {String? fallback}) {
//     switch (key) {
//       case 'not_found':
//         return not_found;
//       case 'not_in_branch':
//         return not_in_branch;
//       case 'have_schedule_in_another_branch':
//         return have_schedule_in_another_branch;
//       case 'branch_closed':
//         return branch_closed;
//       case 'work_time_required':
//         return work_time_required;
//       case 'branch_opens_at':
//         return branch_opens_at;
//       case 'branch_closes_at':
//         return branch_closes_at;
//       case 'working_time_invalid':
//         return working_time_invalid;
//       case 'booking_crosses_day':
//         return booking_crosses_day;
//       case 'outside_branch_hours':
//         return outside_branch_hours;
//       case 'booking_time_overlaps':
//         return booking_time_overlaps;
//       case 'attach_treatments_failed':
//         return attach_treatments_failed;
//       case 'cannot_progress_cancelled_booking':
//         return cannot_progress_cancelled_booking;
//       case 'booking_already_completed':
//         return booking_already_completed;
//       case 'status_transition_unsupported':
//         return status_transition_unsupported;
//       case 'cannot_cancel_in_current_status':
//         return cannot_cancel_in_current_status;
//       case 'completed_cannot_cancel':
//         return completed_cannot_cancel;
//       case 'status_invalid':
//         return status_invalid;
//       case 'reminders_change_not_allowed':
//         return reminders_change_not_allowed;
//       case 'invalid_credentials':
//         return invalid_credentials;
//       case 'permission_denied':
//         return permission_denied;
//       case 'unauthorized':
//         return unauthorized;
//       case 'validation_error':
//         return validation_error;
//       case 'conflict':
//         return conflict;
//       case 'gone':
//         return gone;
//       case 'too_many_requests':
//         return too_many_requests;
//       case 'internal_error':
//         return internal_error;
//       case 'token_expired':
//         return token_expired;
//       case 'password_update_failed':
//         return password_update_failed;
//       case 'cannot_delete_self':
//         return cannot_delete_self;
//       case 'missing_header':
//         return missing_header;
//       case 'admin_no_branch':
//         return admin_no_branch;
//       case 'branch_not_in_chain':
//         return branch_not_in_chain;
//       case 'ttl_hours_invalid':
//         return ttl_hours_invalid;
//       case 'treatments_required':
//         return treatments_required;
//       case 'treatments_not_approved':
//         return treatments_not_approved;
//       case 'sort_conflict':
//         return sort_conflict;
//       case 'invalid_json':
//         return invalid_json;
//       case 'invite_expired':
//         return invite_expired;
//       case 'invite_already_in_status':
//         return invite_already_in_status;
//       case 'invite_already_processed':
//         return invite_already_processed;
//       case 'branch_not_deleted':
//         return branch_not_deleted;
//       case 'chain_not_deleted':
//         return chain_not_deleted;
//       case 'no_fields_to_update':
//         return no_fields_to_update;
//       case 'moderation_already_approved':
//         return moderation_already_approved;
//       case 'reason_required':
//         return reason_required;
//       case 'date_range_invalid':
//         return date_range_invalid;
//       case 'schedule_has_bookings':
//         return schedule_has_bookings;
//       case 'status_final_no_changes':
//         return status_final_no_changes;
//       case 'master_not_working':
//         return master_not_working;
//       case 'outside_master_schedule':
//         return outside_master_schedule;
//       case 'master_break_overlap':
//         return master_break_overlap;
//       case 'phone_already_registered':
//         return phone_already_registered;
//       case 'email_already_used':
//         return email_already_used;
//       case 'work_time_order_invalid':
//         return work_time_order_invalid;
//       default:
//         return null;
//         // return fallback?.trim().isNotEmpty == true ? fallback! : unknownError;
//     }
//   }
// }

// String? localizeBackendError(
//   BuildContext context, {
//   required String? key,
//   String? fallback,
// }) {
//   return context.lang.errorByKey(key, fallback: fallback);
// }
