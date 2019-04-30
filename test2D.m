clc;clear all;

myCTRW = CTRW2D_Ornstein_Uhlenbeck;
myCTRW.numberOfSeconds = 5;
myCTRW.alpha = 1;
myCTRW.start;

%%
myCTRW.plot;