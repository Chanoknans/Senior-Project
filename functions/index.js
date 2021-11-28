const functions = require("firebase-functions");
const admin = require("firebase-admin");
const mqtt = require("mqtt");

admin.initializeApp();

const client = mqtt.connect('mqtt://ggaomyqh:3wjA27NFU3ET@m16.cloudmqtt.com:16319/');

client.on("connect", function () {
  functions.logger.info("Ready To Rock!!");
});

client.on("reconnect", () => {
  functions.logger.info("MQTT client is reconnecting...");
});

client.on("disconnect", () => {
  functions.logger.info("MQTT client is disconnecting...");
});

client.on("error", function () {
  functions.logger.error("Can't connect");
  client.reconnect();
});

exports.createUserAudioGram = functions
  .region("asia-southeast1")
  .firestore.document("users/{userId}/audiogram_history/{audiogram_historyId}")
  .onCreate((snapshot, __) => {
    functions.logger.info(snapshot.data());

    let trigg_message = {
      userID: __.params.userId,
      audiogramID: __.params.audiogram_historyId,
      lValue: snapshot.data().Left,
      rValue: snapshot.data().Right,
    };

    client.publish("/audiogram", JSON.stringify(trigg_message), function (err) {
      if (err) {
        functions.logger.error("Error:" + err);
        response.send("Error:" + err);
        reject();
      }
    });

    return Promise.resolve();
  });

exports.updateUserAudioGram = functions
  .region("asia-southeast1")
  .firestore.document("users/{userId}/audiogram_history/{audiogram_historyId}")
  .onUpdate((snapshot, __) => {
    functions.logger.info(snapshot.before.data());
    functions.logger.info(snapshot.after.data());
    return Promise.resolve();
  });