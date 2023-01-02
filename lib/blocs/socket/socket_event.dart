part of 'socket_bloc.dart';

@freezed
class SocketEvent with _$SocketEvent {
  const factory SocketEvent.connect() = _SocketConnect;
  const factory SocketEvent.connecting() = _SocketConnectingEvent;
  const factory SocketEvent.onConnect() = _SocketOnConnect;
  const factory SocketEvent.onConnectError() = _SocketConnectErrorEvent;
  const factory SocketEvent.onConnectTimeout() = _SocketConnectTimeoutEvent;
  const factory SocketEvent.onError() = _SocketErrorEvent;
  const factory SocketEvent.onJoined() = _SocketJoinedEvent;
  const factory SocketEvent.disconnect() = _SocketDisconnect;
  const factory SocketEvent.onDisconnect() = _SocketOnDisconnect;
  const factory SocketEvent.sendMessage() = _SocketSendMessage;
  const factory SocketEvent.receiveMessage(String message) =
      _SocketReceiveMessage;
}
