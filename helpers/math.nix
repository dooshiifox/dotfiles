# Also see https://github.com/xddxdd/nix-math
{ lib, inputs, ... }:
let
  math = inputs.nix-math.lib.math;
in
math
// rec {
  pi = 3.14159265358979323846264338327950288;

  /**
    Type abs :: Float -> Float
  */
  abs = num: if num < 0 then -num else num;

  pow =
    base: exponent:
    if exponent > 1 then
      let
        x = pow base (exponent / 2);
        odd_exp = lib.trivial.mod exponent 2 == 1;
      in
      x * x * (if odd_exp then base else 1)
    else if exponent == 1 then
      base
    else if exponent == 0 && base == 0 then
      throw "undefined"
    else if exponent == 0 then
      1
    else
      throw "undefined";
  powi = base: exponent: if exponent == 0 then 1 else base * (powi base (exponent - 1));
  rootimpl =
    base: root: x: iter:
    if iter == 0 then
      x
    else
      # newtons method to solve for f(x) = 0, where
      # f(x) = x^(root) - base
      # ie, x^(root) = base
      # thus f'(x) = root * x^(root - 1)
      let
        f = (powi x root) - base;
        fp = root * (powi x (root - 1));
        x_next = x - f / fp;
      in
      if abs (x - x_next) < 0.0000001 then x else rootimpl base root x_next (iter - 1);
  rooti = base: root: rootimpl base root 1.0 25;
  powf =
    base: fraction-numerator: fraction-denominator:
    powi (rooti base fraction-denominator) fraction-numerator;

  sqrt = num: rooti num 2;
  cbrt = num: rooti num 3;

  clamp =
    num: min: max:
    if num < min then
      min
    else if num > max then
      max
    else
      num;

  lerp =
    a: b: t:
    a * (1 - t) + (b * t);

  mod =
    mod: base:
    if base >= 0 && base < mod then
      base
    else
      let
        mul = lib.floor (base / mod);
      in
      base - (mul * mod);

  atan2 =
    y: x:
    if x > 0 then
      math.atan (y / x)
    else if x < 0 && y >= 0 then
      (math.atan (y / x)) + pi
    else if x < 0 && y < 0 then
      (math.atan (y / x)) - pi
    else if x == 0 && y > 0 then
      pi / 2
    else if x == 0 && y < 0 then
      -pi / 2
    else
      throw "both args to arctan2 are 0";
}
