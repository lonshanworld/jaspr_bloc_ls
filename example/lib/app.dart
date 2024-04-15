import 'package:jaspr/jaspr.dart';
import 'package:jaspr_bloc/jaspr_bloc.dart';

class App extends StatefulComponent {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Iterable<Component> build(BuildContext context) sync* {
    const Map<String, String> styleForDiv = {
      "display": "flex",
      "flex-direction": "column",
      "justify-content": "center",
    };

    const Map<String, String> styleForH5 = {
      "text-align": "center",
    };

    const Map<String, String> styleForH2 = {
      "text-align": "center",
    };

    const Map<String, String> styleForSmallDiv = {
      "display": "flex",
      "justify-content": "center",
    };


    yield DomComponent(
      tag: 'div',
     
      styles: Styles.raw(
        styleForDiv,
      ),
      children: [
        BlocProvider(
          create: (context) => CounterCubit(),
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, state) sync* {
              yield const DomComponent(
                tag: "h5",
                styles: Styles.raw(
                  styleForH5
                ),
                children: [
                  Text(
                    "Press plus button to increment the counter with jaspr bloc!",
                  ),
                ],
              );
              yield DomComponent(
                tag: 'h2',
                styles: Styles.raw(
                  styleForH2
                ),
                child: Text(state.toString()),
              );

              yield DomComponent(
                tag: 'div',
                styles: Styles.raw(
                  styleForSmallDiv
                ),
                child: DomComponent(
                  tag: 'button',
                  events: {
                    'click': (e) {
                      context.read<CounterCubit>().increment();
                    },
                  },
                  child: const Text('+'),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}
