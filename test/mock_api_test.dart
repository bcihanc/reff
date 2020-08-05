//import 'package:flutter_test/flutter_test.dart';
//import 'package:reff/core/services/reff_shared_preferences.dart';
//import 'package:reff/core/utils/locator.dart';
//import 'package:reff_shared/core/models/models.dart';
//import 'package:reff_shared/core/services/api.dart';
//import 'package:reff_shared/core/utils/utils.dart' as mock;
//import 'package:shared_preferences/shared_preferences.dart';
//
//main() async {
//  await setupLocator();
//
//  group("mock", () {
//    ReffSharedPreferences reffSharedPreferences;
//    BaseApi api;
//    String userID;
//
//    setUpAll(() async {
//      SharedPreferences.setMockInitialValues({"userID": mock.kuserID1});
//      reffSharedPreferences = locator<ReffSharedPreferences>();
////      api = locator<MockApi>();
//      a
//      userID = await reffSharedPreferences.getUserID();
////      await api.initialize();
//    });
//
//    test("api den gelen user json ile mock data aynı olmalı", () async {
//      final user = await api.getUserByID(userID);
//      final userFromMock = mock.userCollectionMock
//          .firstWhere((element) => element["id"] == userID);
//
//      expect(true, user is UserModel);
//      expect(user.toJson(), userFromMock);
//    });
//
//    test("is answers is answer", () async {
//      final questionID = mock.questionCollectionMock.first["id"];
//      final answers = await api.getAnswersByQuestionID(questionID);
//      answers.forEach((answer) {
//        expect(true, answer is AnswerModel);
//      });
//    });
//
//    test("user daha önce oy kullandıysa true", () async {
//      final userID = mock.userCollectionMock.first["id"];
//      final questionID = mock.questionCollectionMock.first["id"];
//
//      final isVoted = await api.isVotedByUserAndQuestionID(userID, questionID);
//      expect(isVoted, true);
//    });
//
//    test("user daha önce oy kullanmadıysa false", () async {
//      final userID = mock.userCollectionMock[1]["id"];
//      final questionID = mock.questionCollectionMock.first["id"];
//
//      final isVoted = await api.isVotedByUserAndQuestionID(userID, questionID);
//      expect(isVoted, false);
//    });
//  });
//}
