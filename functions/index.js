const functions = require("firebase-functions");
const admin = require("firebase-admin");
const mqtt = require("mqtt");

admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.createUser = functions.firestore
  .document("users/{userId}/audiogram_history/{audiogram_historyId}")
  .onCreate((snap) => {
    // Get an object representing the document
    // e.g. {'name': 'Marie', 'age': 66}
    const newValue = snap.data.data();

    // access a particular field as you would any JS property
    const name = newValue.name;
    const Left_value = newValue.Left;
    const Right_value = newValue.Right;
    console.log(`Trigger value`);

    function publishToMqtt(topic, message) {

      return new Promise((resolve, reject) => {
        var options = {
          port: functions.config().mqtt.server.port,
          host: functions.config().mqtt.server.host,
          clientId: "mqttjs_" + Math.random().toString(16).substr(2, 8),
          username: functions.config().mqtt.server.user,
          password: functions.config().mqtt.server.password,
          keepalive: 60,
          reconnectPeriod: 1000,
          protocolId: "MQIsdp",
          protocolVersion: 3,
          clean: true,
          encoding: "utf8",
        };

        var client = mqtt.connect(functions.config().mqtt.server.host, options);

        client.on("connect", function () {
          console.log("client connected");
        });

        client.on("error", function (err) {
          console.error(err); 
          reject();
        });

        client.subscribe("response");
        client.publish(topic, message, function (err) {


          if (err) {
            console.log("Error:" + err);
            response.send("Error:" + err);
            reject();
          }
        });

        client.on("message", function (topic, message) {
          console.log("client on");
          let output = message.toString();

          resolve(output);
          client.end();
          clearTimeout(noResp); 
        });
        let noResp = setTimeout(() => {
          console.log("No connection");
          reject();
          client.end();
        }, 2000);
      });
    }

    // perform desired operations ...
  });
