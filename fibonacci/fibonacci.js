"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.fibResult = void 0;
exports.fibonacci = fibonacci;
function fibonacci(n) {
    let a = 0, b = 1;
    for (let i = 0; i < n; i++) {
        [a, b] = [b, a + b];
    }
    return a;
}
exports.fibResult = fibonacci(100000);
console.log(exports.fibResult);
