const functions = require("firebase-functions");
const admin = require("firebase-admin");
const mqtt = require("mqtt");

admin.initializeApp();

const client = mqtt.connect('mqtt://ggaomyqh:3wjA27NFU3ET@m16.cloudmqtt.com:16319/');

client.on("connect", function () {
  console.log("Ready To Rock!!");
});

client.on("reconnect", () => {
  console.log("MQTT client is reconnecting...");
});

client.on("disconnect", () => {
  console.log("MQTT client is disconnecting...");
});

client.on("error", function () {
  console.log("Can't connect");
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
        console.log("Error:" + err);
        response.send("Error:" + err);
        reject();
      }
    });

    return Promise.resolve();
  });
