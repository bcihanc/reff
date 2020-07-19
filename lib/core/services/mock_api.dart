import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:reff/core/models/AnswerModel.dart';
import 'package:reff/core/models/QuestionModel.dart';
import 'package:reff/core/models/UserModel.dart';
import 'package:reff/core/models/VoteModel.dart';
import 'package:reff/core/utils/mock_data.dart' as mock;

abstract class ApiBase {
  Future<UserModel> getUserByID(String userID);
  Future<List<QuestionModel>> getQuestionsByUserID(String userID);
  Future<List<AnswerModel>> getAnswersByQuestionID(String questionID);

  Future<void> addVote(VoteModel model);
  Future<bool> didVotedByUserID(String userID, String questionID);
}

class MockApi implements ApiBase {
  MockFirestoreInstance firestore;

  static const kCollectionUsers = "users";
  static const kCollectionQuestions = "questions";
  static const kCollectionAnswers = "answers";
  static const kCollectionVotes = "votes";

  Future<void> initialize() async {
    final firestore = MockFirestoreInstance();
    mock.userCollectionMock.forEach((e) async => await firestore
        .collection(kCollectionUsers)
        .document(e["id"])
        .setData(e));
    mock.questionCollectionMock.forEach((e) async => await firestore
        .collection(kCollectionQuestions)
        .document(e["id"])
        .setData(e));
    mock.answerCollectionMock.forEach((e) async => await firestore
        .collection(kCollectionAnswers)
        .document(e["id"])
        .setData(e));
    mock.voteCollectionMock.forEach((e) async => await firestore
        .collection(kCollectionVotes)
        .document(e["id"])
        .setData(e));
    this.firestore = firestore;
  }

  @override
  Future<UserModel> getUserByID(String userID) async {
    assert(userID != null);
    final snapshot =
        await firestore.collection(kCollectionUsers).document(userID).get();
    final model = UserModel.fromJson(snapshot.data);
    return model;
  }

  Future<List<QuestionModel>> getQuestionsByUserID(String userID) async {
    throw UnimplementedError();
  }

  @override
  Future<List<AnswerModel>> getAnswersByQuestionID(String questionID) async {
    assert(questionID != null);
    final snapshot = await firestore
        .collection(kCollectionQuestions)
        .document(questionID)
        .get();

    final question = QuestionModel.fromJson(snapshot.data);
    final answersIDs = question.answers;
    final answers = answersIDs.map((e) async {
      return await getAnswerByAnswerID(e);
    }).toList();

    return await Future.wait(answers);
  }

  Future<AnswerModel> getAnswerByAnswerID(String answerID) async {
    assert(answerID != null);
    final snapshot =
        await firestore.collection(kCollectionAnswers).document(answerID).get();
    final model = AnswerModel.fromJson(snapshot.data);
    return model;
  }

  @override
  Future<void> addVote(VoteModel vote) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> didVotedByUserID(String userID, String questionID) async {
    var vote = mock.voteCollectionMock?.firstWhere(
        (vote) => vote["userID"] == userID && vote["questionID"] == questionID);

    return vote != null ? true : false;
  }
}
