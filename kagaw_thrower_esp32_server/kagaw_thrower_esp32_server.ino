#include <ESPAsyncWebSrv.h>
#include <WiFi.h>

// constants
// TODO ilislan and mga pin ka motor
#define ARM_MOTOR_PIN_1 15
#define ARM_MOTOR_PIN_2 2

enum PullMotorStatus {
  stop,
  pull,
  reset,
  lock

};

// wifi constants
const char *ssid = "itlog2323";
const char *password = "hotdog1234";

AsyncWebServer server(80);
AsyncWebSocket webSocket("/ws");

// motor status buffer
PullMotorStatus pullMotorStatus = stop;

void setup() {
  Serial.begin(115200);
  setupMotorPins();
  setupWifiAP();
  setupWebSocket();
}

void loop() {
  //
}

//*********************************************
//* FUNCTIONS
//*********************************************

void setupMotorPins() {
  pinMode(ARM_MOTOR_PIN_1, OUTPUT);
  pinMode(ARM_MOTOR_PIN_2, OUTPUT);
}

void setupWifiAP() {
  WiFi.disconnect();    // added to start with the wifi off, avoid crashing
  WiFi.mode(WIFI_OFF);  // added to start with the wifi off, avoid crashing

  Serial.println();
  Serial.println("Configuring access point...");

  if (!WiFi.softAP(ssid, password)) {
    log_e("Soft AP creation failed.");
    while (1)
      ;
  }
  IPAddress myIP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(myIP);
  server.begin();

  Serial.println("Server started");
}

void setupWebSocket() {
  webSocket.onEvent(webSocketEventHandler);
  server.addHandler(&webSocket);
}

void webSocketEventHandler(AsyncWebSocket *server,
                           AsyncWebSocketClient *client,
                           AwsEventType type,
                           void *arg,
                           uint8_t *data,
                           size_t len) {
  if (type == WS_EVT_CONNECT) {
    Serial.println("Websocket client connection received");
    client->text("Connected");
  } else if (type == WS_EVT_DISCONNECT) {
    Serial.println("Client disconnected");
  } else if (type == WS_EVT_DATA) {
    WsDataEventHandler(arg, data, len);
  } else {
    Serial.println("Cannot process websocket message");
  }
}

void WsDataEventHandler(void *arg, uint8_t *data, size_t len) {

  AwsFrameInfo *info = (AwsFrameInfo *)arg;
  if (info->final && info->index == 0 && info->len == len && info->opcode == WS_TEXT) {
    data[len] = 0;

   // ArmMotorEventHandler(data);
    TestEventHandler(data);
  }
}

void ArmMotorEventHandler(uint8_t *data) {

  if (strcmp((char *)data, "ArmMotorPull") == 0) {

    if (pullMotorStatus == stop) {
      pullMotorStatus = pull;
    }
  }
  if (strcmp((char *)data, "ArmMotorReset") == 0) {

    if (pullMotorStatus == lock) {
      pullMotorStatus = reset;
    }
  }
}

void TestEventHandler(uint8_t *data) {

  Serial.println((char *)data);
  
}