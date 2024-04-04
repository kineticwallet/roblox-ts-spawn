declare function Spawn<T extends unknown[]>(callback: (...args: T) => void, ...args: T): void;

export = Spawn;
