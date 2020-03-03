clc;clear all;

myCTRW = CTRW_Ornstein_Uhlenbeck;
myCTRW.numberOfSeconds = 100;
myCTRW.gamma = 0;
myCTRW.alpha = 0.5;
myCTRW.start;

myCTRW.plot;

