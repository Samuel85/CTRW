classdef CTRW2D_Ornstein_Uhlenbeck < handle
properties
    ds
    dt
    numberOfSeconds
    gamma
    xs
    ys
    ts
    x
    y
    alpha
    t
end
methods
    function obj = CTRW2D_Ornstein_Uhlenbeck()
        obj.ds              = 0.0001;
        obj.dt              = 0.001;
        obj.numberOfSeconds = 1;
        obj.gamma = 1;
    
        obj.xs      = 1;
        obj.ys      = 1;
        obj.ts      = 0;
        obj.alpha   = 1;
    end
    function start(obj)
        obj.t = 0:obj.dt:obj.numberOfSeconds;
        obj.x=zeros(length(obj.t),1);
        obj.y=zeros(length(obj.t),1);
        
        for j=1:length(obj.t)     
            while obj.ts < obj.t(j)
                % Generate the jumps n(s,ds)
                % Gaussian pdf with variance sigma^2 = ds
                % note: normrnd needs the std as a second parameter
                ns = normrnd(0,sqrt(obj.ds),1,1);
                es = normrnd(0,sqrt(obj.ds),1,1);

                % Ec. 12a
                obj.xs = obj.xs - obj.ds*obj.gamma*obj.xs + ns;
                obj.ys = obj.ys - obj.ds*obj.gamma*obj.ys + es;

                % calculate waiting time, tau(s,ds);
                u1 = rand(1,1);
                u2 = rand(1,1);

                % Ec. A1
                v = pi*(u1-1/2);        
                % Ec. A2
                w = -log(u2);

                tau = (obj.ds^(1/obj.alpha))*(sin(obj.alpha*(v+pi/2))/(cos(v)^(1/obj.alpha)))*...
                      (cos(v-obj.alpha*(v+pi/2))/w)^((1-obj.alpha)/obj.alpha);

                % Ec. 12b
                obj.ts = obj.ts + tau;        
            end
        obj.x(j)=obj.xs;        
        obj.y(j)=obj.ys;        
        end        
    end 
    function plot(obj)
        figure;
        plot(obj.x, obj.y);
        xlabel('time[s]');
        title(['\alpha=',num2str(obj.alpha)]);
        xlim([min(obj.x) max(obj.x)]);
        ylim([min(obj.y) max(obj.y)]);
    end     
end
end