class UpdateWindowHours {
  static const int max = 24;
  static const int min = 1;
}

class DbKeys {
  static const String dbData = 'verificac19_data_box';
  static const String dbCRL = 'verificac19_crl_box';
  static const String dbUpdates = 'verificac19_updates_box';

  static const String keySignatures = 'signatures';
  static const String keyRules = 'rules';
  static const String keySignaturesList = 'signatures_list';
  static const String keyRulesUpdate = 'rules_update';
  static const String keySignaturesUpdate = 'signatures_update';
  static const String keySignaturesListUpdate = 'signatures_list_update';
  static const String keyCRLUpdate = 'crl_update';
  static const String keyCRLVersion = 'crl_version';
}

class RuleName {
  static const String blackListUvci = 'black_list_uvci';
  static const String vaccineStartDayNotComplete =
      'vaccine_start_day_not_complete';
  static const String vaccineEndDayNotComplete = 'vaccine_end_day_not_complete';
  static const String vaccineStartDayComplete = 'vaccine_start_day_complete';
  static const String vaccineEndDayComplete = 'vaccine_end_day_complete';
  static const String molecularTestStartHours = 'molecular_test_start_hours';
  static const String molecularTestEndHours = 'molecular_test_end_hours';
  static const String rapidTestStartHours = 'rapid_test_start_hours';
  static const String rapidTestEndHours = 'rapid_test_end_hours';
  static const String recoveryCertStartDay = 'recovery_cert_start_day';
  static const String recoveryCertEndDay = 'recovery_cert_end_day';
  static const String recoveryCertPvStartDay = 'recovery_pv_cert_start_day';
  static const String recoveryCertPvEndDay = 'recovery_pv_cert_end_day';
}

class RuleType {
  static const String generic = "GENERIC";
}

class TestResult {
  static const String detected = "260373001";
}

class TestType {
  static const String rapid = 'LP217198-3';
  static const String molecular = 'LP6464-4';
}

class VaccineType {
  static const String johnson = 'EU/1/20/1525';
  static const String sputnik = 'Sputnik-V';
}

class Country {
  static const String italy = 'IT';
  static const String sanMarino = 'SM';
}

class OID {
  static const String recovery = '1.3.6.1.4.1.1847.2021.1.3';
  static const String altRecovery = '1.3.6.1.4.1.0.1847.2021.1.3';
}
