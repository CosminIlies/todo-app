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

                if (dueDate < new Date()) {
                  admin.messaging().sendToDevice(userDoc.data().fcmToken, {
                    notification: {
                      title: todoDoc.data().title + " is overdue",
                      body: "Todo is overdue!",
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
    let counter = 0;

    admin
      .firestore()
      .collection("users")
      .get()
      .then((userSnapshot: any) => {
        counter++;
        userSnapshot.docs.map((userDoc: any) => {
          counter++;
          functions.logger.log("userDoc", userDoc.data().fcmToken);

          admin
            .firestore()
            .collection("users")
            .doc(userDoc.id)
            .collection("todo")
            .get()
            .then((todosSnapshot: any) => {
              counter++;
              todosSnapshot.docs.map((todoDoc: any) => {
                counter++;
                const dueDate = todoDoc.data().dueDate.toDate();

                if (dueDate < new Date()) {
                  counter++;
                  admin.messaging().sendToDevice(userDoc.data().fcmToken, {
                    notification: {
                      title: todoDoc.data().title + " is overdue",
                      body: "Todo is overdue!",
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
      })
      .then(() => {
        const str1 =
          "fXikNrQeTAaDiw7n94TbFG:APA91bE09OXB9pbB7PJhblETViPNhlbOB3-";
        const str2 =
          "aRzOBgd7RlgdT_Geq6aV17Ha8rdCFVdFMaeEmcfcFvBQbpUY0H4Di7WF8";
        const str3 = "FUBz-QjC4nZqWg3bPhR7JkoQv232OJhwdpqwxnwXd8iDvNc4";

        admin.messaging().sendToDevice(str1 + str2 + str3, {
          notification: {
            title: `${counter}`,
            body: "Todo is overdue!",
          },
        });
      });
  });
