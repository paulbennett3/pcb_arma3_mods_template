// average dir
//
// given the previous average dir and the current dir,
// returns the exponentially smothed weighted average,
// accounting for wrapping 359.9 <-> 0
params ["_avg", "_dir"];

//private _delta = 
