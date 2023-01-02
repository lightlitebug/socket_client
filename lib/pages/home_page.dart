import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_client/blocs/socket/socket_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SocketBloc>().add(const SocketEvent.connect());
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SocketBloc>()
                        .add(const SocketEvent.disconnect());
                  },
                  child: const Text(
                    'Disconnect',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<SocketBloc>().add(const SocketEvent.sendMessage());
              },
              child: const Text(
                'Send Message',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<SocketBloc, SocketState>(
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return const Text(
                      'initial',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  },
                  connected: (status) {
                    return const Text(
                      'connected',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  },
                  disconnected: () {
                    return const Text(
                      'disconnected',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  },
                  data: (message) {
                    return Text(
                      message,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
