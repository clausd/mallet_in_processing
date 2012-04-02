import cc.mallet.optimize.*;

void setup() {

  noLoop();
}

void draw() {
  Solveforthis solvable = new Solveforthis(0, 0);
  Optimizer opt = new LimitedMemoryBFGS(solvable);
  boolean converged = false;
  try {
    converged = opt.optimize();
  } 
  catch (IllegalArgumentException e) {
    // This exception may be thrown if L-BFGS
    //  cannot step in the current direction.
    // This condition does not necessarily mean that
    //  the optimizer has failed, but it doesn't want
    //  to claim to have succeeded...
  }
  if (converged) {
    println(solvable.parameters);
  }
}

