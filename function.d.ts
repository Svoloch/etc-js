interface FunctionWrapper extends Function {
    then(fn: (...args: any[]) => any): FunctionWrapper;

    catch(fn: (e: any) => void, ...args: any[]): FunctionWrapper;
    catchCond(cond: (any) => boolean, fn: (any) => void, ...args:any[]): FunctionWrapper;
    catchVal(val: any, fn: (any) => void): FunctionWrapper;
    catchType(type: Function, fn: (any) => void): FunctionWrapper;
    
    bind(self: any): FunctionWrapper;
    bindArgsStrict(...args: any[]): FunctionWrapper;
    bindArgs(...args: any[]): FunctionWrapper;

    loop<T>(fn: (val: T) => T): FunctionWrapper;
    curry(times?: number): FunctionWrapper;
    bindedCurry(times?: number): FunctionWrapper;
    curryBreak(...steps: number[]): FunctionWrapper; // TODO: Clarify argument type.
    preprocessAll(fn: (args: any[]) => any[]): FunctionWrapper;
    flip(from?: number, to?: number): FunctionWrapper;
    preprocess(...fns: { (arg: any): any }[]): FunctionWrapper;
    preprocessStrict(...fns: { (arg: any): any }[]): FunctionWrapper;

    guard(cond: (any) => boolean): FunctionWrapper;
    guardType(type: Function): FunctionWrapper;
    guardArgs(...conds: { (any): boolean; }[]): FunctionWrapper;
    guardArgsTypes(...types: Function[]): FunctionWrapper;

    zipper(): FunctionWrapper;
    zipWith(self: (arg: any[]) => any, ...arrs: any[][]): FunctionWrapper;
    zip(...arrs: any[][]): FunctionWrapper;
    objectZipper(dest: any): FunctionWrapper;

    commonKeys(...objs: any[]): string[];

    zipObjects(...objs: any[]): any;
    zipObjectsWith(self: (any) => any, ...objs: any[]): any;
    zipObjectsTo(dest: any, ...objs: any[]): any;

    cell(...params: any[]): ()=>any; // TODO: Clarify types.
}

interface $FError {
    toString(): string;
}

interface $FStatic {
    (fn: (...args: any[]) => any): FunctionWrapper;
    
    times<T>(times: number, self: (number) => T): T[];
    repeat<T>(times: number, self: (number) => T): FunctionWrapper;
    cell<T>(value: T): T;
    as(value: any, type: any): boolean;

    Error(): $FError;
}

declare var $F: $FStatic;

declare module 'function' {
    export = $F;
}
