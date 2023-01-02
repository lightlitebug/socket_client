part of 'socket_bloc.dart';

@freezed
class SocketState with _$SocketState {
  const factory SocketState.initial() = _SocketInitial;
  const factory SocketState.connected(String status) = _SocketConnected;
  const factory SocketState.disconnected() = _SocketDisonnected;
  const factory SocketState.data(String message) = _SocketData;
}
