import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'socket_bloc.freezed.dart';
part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  late final Socket _socket;
  static int count = 1;

  SocketBloc() : super(const SocketState.initial()) {
    _socket = io(
      'http://localhost:3000',
      OptionBuilder()
          .setTimeout(3000)
          .setReconnectionDelay(5000)
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnecting((data) => add(const _SocketConnectingEvent()));
    _socket.onConnect((_) => add(const _SocketOnConnect()));
    _socket.onConnectError((data) => add(const _SocketConnectErrorEvent()));
    _socket.onConnectTimeout((data) => add(const _SocketConnectTimeoutEvent()));
    _socket.onDisconnect((_) => add(const _SocketOnDisconnect()));
    _socket.onError((data) => add(const _SocketErrorEvent()));
    _socket.on('joined', (data) => add(const _SocketJoinedEvent()));
    _socket.on('message', (data) {
      print('Message from server: $data');
      add(_SocketReceiveMessage(data));
    });

    _socket.onConnect((_) {
      print('onConnect');
      _socket.emit('message', 'Client message 20');
    });

    on<_SocketSendMessage>((event, emit) {
      _socket.emit('message', 'Client message ${20 * ++count}');
    });

    on<_SocketReceiveMessage>((event, emit) {
      print('_SocketReceivedMessage event: ${event.message}');
      emit(SocketState.data(event.message));
    });

    // User events
    on<_SocketConnect>((event, emit) {
      _socket.connect();
      print('Socket.connect...');
    });

    on<_SocketDisconnect>((event, emit) {
      _socket.disconnect();
      print('Socket.disconnect...');
    });
    // Socket events
    on<_SocketConnectingEvent>((event, emit) {
      emit(const SocketState.connected("Connecting"));
      print('SocketState.connecte(Connecting)');
    });
    on<_SocketOnConnect>((event, emit) {
      emit(SocketState.connected(_socket.id!));
      print('SocketState.connected(${_socket.id})');
    });
    on<_SocketConnectErrorEvent>((event, emit) {
      emit(const SocketState.connected("Connection Error"));
      print('SocketState.connected(Connection Error)');
    });
    on<_SocketConnectTimeoutEvent>((event, emit) {
      emit(const SocketState.connected("Connection timeout"));
      print('SocketState.connected(Connection timeout)');
    });
    on<_SocketOnDisconnect>((event, emit) {
      emit(const SocketState.disconnected());
      print('SocketState.disconnected()');
    });
    on<_SocketErrorEvent>((event, emit) {
      emit(const SocketState.connected("ErrorEvent"));
      print('SocketState.connected(ErrorEvent)');
    });
    on<_SocketJoinedEvent>((event, emit) {
      emit(const SocketState.connected("JoinedEvent"));
      print('SocketState.connected(JoinedEvent)');
    });
  }
  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }
}
