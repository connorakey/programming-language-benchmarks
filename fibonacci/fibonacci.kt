import java.math.BigInteger

fun fibonacci(n: Int): BigInteger {
    var a: BigInteger = BigInteger.ZERO
    var b: BigInteger = BigInteger.ONE
    for (i in 0 until n) {
        val temp = a
        a = b
        b = b.add(temp)
    }
    return a
}

fun main() {
    val result = fibonacci(100000)
    println(result)
}
