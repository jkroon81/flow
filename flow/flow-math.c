/*
 * Flow - Copyright (C) 2009 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

float flow_math_sqrt(float number) {
  long i;
  float f = 1.5;
  float x = number / 2;
  float y = number;

  i = *((unsigned long*)&y);
  i = 0x5f3759df - (i >> 1);
  y = *(float*)&i;
  y = y * (f - x*y*y);
  return number * y;
}
