import functions = require("firebase-functions");
import admin = require("firebase-admin");
// import onSchedule = require("firebase-functions/v2/scheduler");

admin.initializeApp();
exports.sendNotificationsWhenDueDateIsClose = functions.pubsub
  .schedule("0 * * * *")
  .onRun(() => {
    admin
      .firestore()
      .collection("users")
      .get()
      .then((userSnapshot: any) => {
        userSnapshot.docs.map((userDoc: any) => {
          functions.logger.log("userDoc", userDoc.data().fcmToken);

          admin
            .firestore()
            .collection("users")
            .doc(userDoc.id)
            .collection("todo")
            .get()
            .then((todosSnapshot: any) => {
              todosSnapshot.docs.map((todoDoc: any) => {
                const dueDate = todoDoc.data().dueDate.toDate();

                const today = new Date();
                today.setHours(today.getHours() - 1);

                if (dueDate < today && !todoDoc.data().isDone) {
                  admin.messaging().sendToDevice(userDoc.data().fcmToken, {
                    notification: {
                      title: "Hurry up!",
                      body:
                        "You have one hour to complete " + todoDoc.data().title,
                    },
                  });
                }
              });
            });
          // admin.messaging().sendToDevice(userDoc.data().fcmToken, {
          //   notification: {
          //     title: "New todo added",
          //     body: "Todo was added!",
          //   },
        });
      });
  });

exports.sendNotifications = functions.firestore
  .document("todos/{todoId}")
  .onCreate((snapshot: any, context: any) => {
    admin
      .firestore()
      .collection("users")
      .get()
      .then((userSnapshot: any) => {
        userSnapshot.docs.map((userDoc: any) => {
          admin
            .firestore()
            .collection("users")
            .doc(userDoc.id)
            .collection("todo")
            .get()
            .then((todosSnapshot: any) => {
              todosSnapshot.docs.map((todoDoc: any) => {
                const dueDate = todoDoc.data().dueDate.toDate();

                const today = new Date();
                today.setHours(today.getHours() - 1);

                if (
                  dueDate < today &&
                  dueDate > new Date() &&
                  !todoDoc.data().isDone
                ) {
                  admin.messaging().sendToDevice(userDoc.data().fcmToken, {
                    notification: {
                      title: "Hurry up!",
                      body:
                        "You have one hour to complete " + todoDoc.data().title,
                    },
                  });
                }
              });
            });
          // admin.messaging().sendToDevice(userDoc.data().fcmToken, {
          //   notification: {
          //     title: "New todo added",
          //     body: "Todo was added!",
          //   },
        });
      });
  });
