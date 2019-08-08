package states;

class State<T> {
    // lifecycles
    public function initialize(data: T) {}
    public function destroy(data: T) {}
    public function enter(data: T) {}
    public function leave(data: T) {}

    // events
    public function onResize(data: T) {}

    // logic
    public function update(data: T, dt: Float): Transition<T> {
        return Transition.None;
    }
}

enum Transition<T> {
    None;
    Pop;
    Push(newState: State<T>);
    Switch(newState: State<T>);
}

class Manager<T> {

    var data: T;
    var queue: List<State<T>>;

    public function new(data: T, initial: State<T>){
        this.data = data;
        this.queue = new List<State<T>>();

        pushState(initial);
    }

    private function currentState(): State<T> {
        return queue.first();
    }

    private function switchState(newState: State<T>) {
        var top = queue.pop();
        top.leave(data);
        top.destroy(data);

        newState.initialize(data);
        newState.enter(data);
        queue.push(newState);
    }

    private function popState() {
        var top = queue.pop();
        top.leave(data);
        top.destroy(data);

        var first = queue.first();
        if (first != null){
            first.enter(data);
        }
    }

    private function pushState(newState: State<T>) {
        var first = queue.first();
        if (first != null){
            first.leave(data);
        }

        newState.initialize(data);
        newState.enter(data);
        queue.push(newState);
    }

    public function update(dt: Float) {
        switch currentState().update(data, dt) {
            case Pop: popState();
            case Switch(newState): switchState(newState);
            case Push(newState): pushState(newState);
            case None:
        }
    }

    public function onResize() {
        currentState().onResize(data);
    }

    public function isExhausted(): Bool {
        return queue.isEmpty();
    }
}