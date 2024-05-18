#include <iostream>
#include <cassert>

class VectorDisperso {
 public:
  int GetN() const { return n_; }
  int GetNz() const { return nz_; }
  int* GetInx() const { return inx_; }
  double* GetVal() const { return val_; }
 private:
  double* val_;
  int* inx_;
  int nz_;
  int n_;
};

double ProductoEscalar(const VectorDisperso &a, const VectorDisperso &b) {
  assert (a.GetN() == b.GetN());
  double proudcto_escalar{0};
  for (int i{0}; i < a.GetNz(); ++i) {
    for (int j{0}; j < b.GetNz() && b.GetInx()[j] <= a.GetInx()[i]; ++j) {
     if (a.GetInx()[i] == b.GetInx()[j]) {
        proudcto_escalar += a.GetVal()[a.GetInx()[i]] * b.GetVal()[b.GetInx()[i]];
     }
    }
  }
}

int main() {
  int* aux1 = {1, 5, 7, 8, 9, 12, 18};
  int* aux2 = {10, 20, 30, 40, 50, 60, 70};
  VectorDisperso uno{aux2, aux1, 7, 20};
  int* aux3 = {1, 6, 7, 8, 11, 14, 18};
  int* aux4 = {10, 20, 30, 40, 50, 60, 70};
  VectorDisperso dos(aux4, aux3, 7, 20);
  std::cout << ProductoEscalar(uno, dos) << std::endl;
  return 0;
}