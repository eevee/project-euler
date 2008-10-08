/* PROBLEM 3: Find the largest prime factor of a composite number.
 *
 * The prime factors of 13195 are 5, 7, 13 and 29.
 *
 * What is the largest prime factor of the number 600851475143 ?
 */

#include <iostream>
using namespace std;

const long long NUMBER = 600851475143LL;

int main() {
    long long num = NUMBER;
    int current_prime = 2;

    // Loop until we 
    while (current_prime < num) {
        if (num % current_prime != 0) {
            // Doesn't divide evenly; try the next number
            current_prime++;
            continue;
        }

        // Meat of the algorithm: divide the number by this prime.  We know
        // it's prime, or its factors would have been divided out of num by
        // now.  When nothing else less than num divides it, num will be the
        // biggest prime divisor of the original number.
        num /= current_prime;
    }

    cout << num << endl;
    return 0;
}
