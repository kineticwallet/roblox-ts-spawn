declare function Spawn<T extends Array<unknown>>(callback: (...args: T) => void, ...args: T): void;

export = Spawn;
