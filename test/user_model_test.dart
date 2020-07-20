import 'package:flutter_test/flutter_test.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/utils/utils.dart' as mock;

main() async {
  group("user model tests", () {
    UserModel user;
    setUpAll(() {
      user = UserModel(
        id: mock.userCollectionMock.first["id"],
        age: mock.userCollectionMock.first["age"],
        gender: Gender.MALE,
        location: mock.userCollectionMock.first["location"],
      );
    });

    test("user model toJson ile mock aynı olmalı", () async {
      expect(user.toJson(), mock.userCollectionMock.first);
    });

    test("mock fromJson ile user model aynı olmalı", () async {
      final fromJsonUser = UserModel.fromJson(mock.userCollectionMock.first);
      expect(fromJsonUser, user);
    });

    test("id null ise copywith ile eklenebilmeli", () {
      final userWithoutID =
          UserModel(age: 0, gender: Gender.MALE, location: "izmir");

      final id = "yeni-bir-id";
      final userWithID = userWithoutID.copyWith.call(id: id);
      final addIDNullIDsUser = userWithoutID.toJson()..addAll({"id": id});

      expect(userWithID, UserModel.fromJson(addIDNullIDsUser));
    });
  });
}
