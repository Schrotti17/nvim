#include <iostream>
#include <iterator>
#include <ostream>

int main() {
  std::cout << "Hello World" << std::endl;
  return 0;
}

int m1() {
  int x = 0;

  if (x == 5) {
    std::cout << "x is 5" << std::endl;
  } else {
    std::cout << "x is not 5" << std::endl;
  }
  return 1;
}
