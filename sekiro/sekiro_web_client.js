(function () {
  function SekiroClient(e) {
    if (((this.wsURL = e), (this.handlers = {}), (this.socket = {}), !e))
      throw new Error("wsURL can not be empty!!");
    (this.webSocketFactory = this.resolveWebSocketFactory()), this.connect();
  }
  (SekiroClient.prototype.resolveWebSocketFactory = function () {
    if ("object" == typeof window) {
      var e = window.WebSocket ? window.WebSocket : window.MozWebSocket;
      return function (o) {
        function t(o) {
          this.mSocket = new e(o);
        }
        return (
          (t.prototype.close = function () {
            this.mSocket.close();
          }),
          (t.prototype.onmessage = function (e) {
            this.mSocket.onmessage = e;
          }),
          (t.prototype.onopen = function (e) {
            this.mSocket.onopen = e;
          }),
          (t.prototype.onclose = function (e) {
            this.mSocket.onclose = e;
          }),
          (t.prototype.send = function (e) {
            this.mSocket.send(e);
          }),
          new t(o)
        );
      };
    }
    if ("object" == typeof weex)
      try {
        console.log("test webSocket for weex");
        var o = weex.requireModule("webSocket");
        return (
          console.log("find webSocket for weex:" + o),
          function (e) {
            try {
              o.close();
            } catch (t) {}
            return o.WebSocket(e, ""), o;
          }
        );
      } catch (t) {
        console.log(t);
      }
    if ("object" == typeof WebSocket)
      return function (o) {
        return new e(o);
      };
    throw new Error("the js environment do not support websocket");
  }),
    (SekiroClient.prototype.connect = function () {
      console.log("sekiro: begin of connect to wsURL: " + this.wsURL);
      var e = this;
      try {
        this.socket = this.webSocketFactory(this.wsURL);
      } catch (o) {
        console.log("sekiro: create connection failed,reconnect after 2s"),
          setTimeout(function () {
            e.connect();
          }, 2e3);
      }
      this.socket.onmessage(function (o) {
        e.handleSekiroRequest(o.data);
      }),
        this.socket.onopen(function (e) {
          console.log("sekiro: open a sekiro client connection");
        }),
        this.socket.onclose(function (o) {
          console.log("sekiro: disconnected ,reconnection after 2s"),
            setTimeout(function () {
              e.connect();
            }, 2e3);
        });
    }),
    (SekiroClient.prototype.handleSekiroRequest = function (e) {
      console.log("receive sekiro request: " + e);
      var o = JSON.parse(e),
        t = o.__sekiro_seq__;
      if (!o.action)
        return void this.sendFailed(t, "need request param {action}");
      var n = o.action;
      if (!this.handlers[n])
        return void this.sendFailed(t, "no action handler: " + n + " defined");
      var s = this.handlers[n],
        i = this;
      try {
        s(
          o,
          function (e) {
            try {
              i.sendSuccess(t, e);
            } catch (o) {
              i.sendFailed(t, "e:" + o);
            }
          },
          function (e) {
            i.sendFailed(t, e);
          }
        );
      } catch (r) {
        console.log("error: " + r), i.sendFailed(t, ":" + r);
      }
    }),
    (SekiroClient.prototype.sendSuccess = function (e, o) {
      var t;
      if ("string" == typeof o)
        try {
          t = JSON.parse(o);
        } catch (n) {
          (t = {}), (t.data = o);
        }
      else "object" == typeof o ? (t = o) : ((t = {}), (t.data = o));
      (Array.isArray(t) || "string" == typeof t) && (t = { data: t, code: 0 }),
        t.code ? (t.code = 0) : t.status ? (t.status = 0) : (t.status = 0),
        (t.__sekiro_seq__ = e);
      var s = JSON.stringify(t);
      console.log("response :" + s), this.socket.send(s);
    }),
    (SekiroClient.prototype.sendFailed = function (e, o) {
      "string" != typeof o && (o = JSON.stringify(o));
      var t = {};
      (t.message = o), (t.status = -1), (t.__sekiro_seq__ = e);
      var n = JSON.stringify(t);
      console.log("sekiro: response :" + n), this.socket.send(n);
    }),
    (SekiroClient.prototype.registerAction = function (e, o) {
      if ("string" != typeof e) throw new Error("an action must be string");
      if ("function" != typeof o) throw new Error("a handler must be function");
      return (
        console.log("sekiro: register action: " + e), (this.handlers[e] = o), this
      );
    });
})()
