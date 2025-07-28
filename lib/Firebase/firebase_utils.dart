import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Model/task_model.dart';
import 'package:todo_app/Model/user_model.dart';

class FirebaseUtils {
  ///task
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionpath)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  ///addTask
  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTaskCollection();
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  ///deleteTask
  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }
  ///isDoneTask
  static Future<void> isDoneUpdate(Task task) {
    return getTaskCollection().doc(task.id).update({
      'isDone':! task.isDone!,
    });
  }
  ///EditTsk
  static Future<void> editTask(Task task) {
    return getTaskCollection().doc(task.id).update(task.toFireStore());
  }

  ///user
  static CollectionReference<MyUser> getMyuserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionUser)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myuser, options) => myuser.toFireStore(),
        );
  }

  ///addMyuser
  static Future<void> addMyUserToFireStore(MyUser myUser) {
    return getMyuserCollection().doc(myUser.id).set(myUser);
  }

  ///readMyuser
  static Future<MyUser?> readeMyuserFromFireStore(String uId) async {
    var querySnapshot = await getMyuserCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
