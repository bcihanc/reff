//class MockApi implements ApiBase {
//  MockFirestoreInstance firestore;
//
//  static const kCollectionUsers = "users";
//  static const kCollectionQuestions = "questions";
//  static const kCollectionAnswers = "answers";
//  static const kCollectionVotes = "votes";
//
//  Future<void> initialize() async {
//    final firestore = MockFirestoreInstance();
//    mock.userCollectionMock.forEach((e) async => await firestore
//        .collection(kCollectionUsers)
//        .document(e["id"])
//        .setData(e));
//    mock.questionCollectionMock.forEach((e) async => await firestore
//        .collection(kCollectionQuestions)
//        .document(e["id"])
//        .setData(e));
//    mock.answerCollectionMock.forEach((e) async => await firestore
//        .collection(kCollectionAnswers)
//        .document(e["id"])
//        .setData(e));
//    mock.voteCollectionMock.forEach((e) async => await firestore
//        .collection(kCollectionVotes)
//        .document(e["id"])
//        .setData(e));
//    this.firestore = firestore;
//  }
//
//  @override
//  Future<UserModel> getUserByID(String userID) async {
//    assert(userID != null);
//    final snapshot =
//        await firestore.collection(kCollectionUsers).document(userID).get();
//    final model = UserModel.fromJson(snapshot.data);
//    return model;
//  }
//
//  Future<List<QuestionModel>> getQuestionsForToday() async {
//    final snapshot =
//        await firestore.collection(kCollectionQuestions).getDocuments();
//    final questions =
//        snapshot.documents.map((e) => QuestionModel.fromJson(e.data)).toList();
//    return questions;
//  }
//
//  Future<List<QuestionModel>> getQuestionsByUserID(String userID) async {
//    final questions = await getQuestionsForToday();
//
//    if (questions.isNotEmpty) {
//      var available = <QuestionModel>[];
//      for (final question in questions) {
//        final isVoted = await isVotedByUserAndQuestionID(userID, question.id);
//        if (!isVoted) {
//          available.add(question);
//        }
//      }
//      return available;
//    } else {
//      return null;
//    }
//  }
//
//  @override
//  Future<List<AnswerModel>> getAnswersByQuestionID(String questionID) async {
//    assert(questionID != null);
//    final snapshot = await firestore
//        .collection(kCollectionQuestions)
//        .document(questionID)
//        .get();
//
//    final question = QuestionModel.fromJson(snapshot.data);
//    final answersIDs = question.answers;
//    final answers = answersIDs.map((e) async {
//      return await getAnswerByID(e);
//    }).toList();
//
//    return await Future.wait(answers);
//  }
//
//  Future<AnswerModel> getAnswerByID(String answerID) async {
//    assert(answerID != null);
//    final snapshot =
//        await firestore.collection(kCollectionAnswers).document(answerID).get();
//    final model = AnswerModel.fromJson(snapshot.data);
//    return model;
//  }
//
//  @override
//  Future<void> addVote(VoteModel vote) async {
//    throw UnimplementedError();
//  }
//
//  @override
//  Future<bool> isVotedByUserAndQuestionID(
//      String userID, String questionID) async {
//    assert(userID != null);
//    assert(questionID != null);
//
//    final query = await firestore
//        .collection(kCollectionVotes)
//        .where("userID", isEqualTo: userID)
//        .where("questionID", isEqualTo: questionID)
//        .getDocuments();
//
//    final isVoted = query.documents.isNotEmpty;
//    return isVoted;
//  }
//}
