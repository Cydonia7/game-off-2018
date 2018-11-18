extends Node

var listeners = {}

func add_listener(listener, events):
	if typeof(events) == TYPE_ARRAY:
		for event in events:
			add_listener(listener, event)
	else:
		var event = events
		
		if not listeners.has(event):
			listeners[event] = []
		
		listeners[event].append(funcref(listener, 'on_' + event))

func trigger(event, data = null):
	if not listeners.has(event):
		return

	for listener in listeners[event]:
		listener.call_func(data)

func reset():
	listeners = {}
