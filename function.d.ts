declare class FunctionWrapper {
    then(fn: (...args: any[]) => any): FunctionWrapper;
}

declare function $F(fn: (...args: any[]) => any): FunctionWrapper;

declare module 'function' {
    export = $F;
}
