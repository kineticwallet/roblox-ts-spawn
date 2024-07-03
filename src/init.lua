--!nocheck
--!optimize 2
--!native

local FREE_THREADS: { thread } = {}

local function runCallback(callback, thread, ...)
	callback(...)
	table.insert(FREE_THREADS, thread)
end

local function yielder()
	while true do
		runCallback(coroutine.yield())
	end
end

return function<T...>(callback: (T...) -> (), ...: T...)
	local thread
	local freeThreadsAmount = #FREE_THREADS

	if freeThreadsAmount > 0 then
		thread = FREE_THREADS[freeThreadsAmount]
		FREE_THREADS[freeThreadsAmount] = nil
	else
		thread = coroutine.create(yielder)
		coroutine.resume(thread)
	end

	task.spawn(thread, callback, thread, ...)
end
