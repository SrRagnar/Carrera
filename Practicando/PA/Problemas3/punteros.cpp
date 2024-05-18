#include <iostream>

int main() {
  int* p = new int[2];
  p[0] = 3;
  std::cout << p[0] << std::endl;
  return 0;
}