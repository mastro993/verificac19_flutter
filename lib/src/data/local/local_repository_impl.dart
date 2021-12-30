import 'package:clock/clock.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:verificac19/src/core/constants.dart';
import 'package:verificac19/src/data/local/local_repository.dart';
import 'package:verificac19/src/data/model/validation_rule.dart';
import 'package:verificac19/verificac19.dart';

class LocalRepositoryImpl implements LocalRepository {
  final HiveInterface _hive;

  LocalRepositoryImpl({HiveInterface? hive}) : _hive = hive ?? Hive;

  @override
  Future<void> setup() async {
    await Hive.initFlutter('/verificac19/cache');
    Hive.registerAdapter(ValidationRuleAdapter());

    await Hive.openBox<dynamic>(DbKeys.dbData);
    await Hive.openBox<String>(DbKeys.dbRevokeList);
  }

  bool _needsUpdate(String key, int updateWindowHours) {
    try {
      final box = _hive.box(DbKeys.dbData);
      final DateTime? lastUpdate = box.get(key);
      if (lastUpdate == null) {
        return true;
      }
      final DateTime expiryDate = lastUpdate.add(
        Duration(hours: updateWindowHours),
      );
      return clock.now().isAfter(expiryDate);
    } catch (e) {
      throw CacheException('Unable to get $key from cache');
    }
  }

  @override
  List<ValidationRule> getRules() {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      return box.get(DbKeys.keyRules, defaultValue: []);
    } catch (e) {
      throw CacheException('Unable to get rules from cache');
    }
  }

  @override
  List<String> getSignaturesList() {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      return box.get(DbKeys.keySignaturesList, defaultValue: []);
    } catch (e) {
      throw CacheException('Unable to get signatures list from cache');
    }
  }

  @override
  Map<String, String> getSignatures() {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      return box.get(DbKeys.keySignatures, defaultValue: {});
    } catch (e) {
      throw CacheException('Unable to get signatures from cache');
    }
  }

  @override
  List<String> getRevokeList() {
    try {
      final Box<String> box = _hive.box(DbKeys.dbRevokeList);
      return box.values.toList();
    } catch (e) {
      throw CacheException('Unable to get revoke list from cache');
    }
  }

  @override
  bool rulesMustBeUpdated([
    int updateWindowHours = UpdateWindowHours.max,
  ]) =>
      _needsUpdate(DbKeys.keyRulesLastUpdate, updateWindowHours);

  @override
  bool signatureListMustBeUpdated([
    int updateWindowHours = UpdateWindowHours.max,
  ]) =>
      _needsUpdate(DbKeys.keySignaturesListLastUpdate, updateWindowHours);

  @override
  bool signaturesMustBeUpdated([
    int updateWindowHours = UpdateWindowHours.max,
  ]) =>
      _needsUpdate(DbKeys.keySignaturesLastUpdate, updateWindowHours);

  @override
  bool revokeListMustBeUpdated([
    int updateWindowHours = UpdateWindowHours.max,
  ]) =>
      _needsUpdate(DbKeys.keyRevokeListLastUpdate, updateWindowHours);

  @override
  Future<void> storeRules(
    List<ValidationRule> rules,
  ) async {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      await box.put(DbKeys.keyRules, rules);
      await box.put(DbKeys.keyRulesLastUpdate, clock.now());
    } catch (e) {
      throw CacheException('Unable to store rules to cache');
    }
  }

  @override
  Future<void> storeSignaturesList(
    List<String> signaturesList,
  ) async {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      await box.put(DbKeys.keySignaturesList, signaturesList);
      await box.put(DbKeys.keySignaturesListLastUpdate, clock.now());
    } catch (e) {
      throw CacheException('Unable to store signatures list to cache');
    }
  }

  @override
  Future<void> storeSignatures(
    Map<String, String> signatures,
  ) async {
    try {
      final Box box = _hive.box(DbKeys.dbData);
      await box.put(DbKeys.keySignatures, signatures);
      await box.put(DbKeys.keySignaturesLastUpdate, clock.now());
    } catch (e) {
      throw CacheException('Unable to store signatures to cache');
    }
  }

  @override
  Future<void> storeRevokeList(
    List<String> revokeList,
  ) async {
    try {
      final Box<String> revokeListBox = _hive.box(DbKeys.dbRevokeList);
      final Box dataBox = _hive.box(DbKeys.dbData);
      await revokeListBox.clear();
      await revokeListBox.addAll(revokeList);
      await dataBox.put(DbKeys.keyRevokeListLastUpdate, clock.now());
    } catch (e) {
      throw CacheException('Unable to store revoke list to cache');
    }
  }

  @override
  bool isUvciRevoked(
    String uvci,
  ) {
    try {
      final Box<String> box = _hive.box(DbKeys.dbRevokeList);
      return box.values.contains(uvci);
    } catch (e) {
      throw CacheException('Unable to check uvci from cached revoke list');
    }
  }
}
