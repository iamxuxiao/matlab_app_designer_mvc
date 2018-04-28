classdef Model < handle
    properties
        balance
    end
    events
        balanceChanged
    end
    methods
        function obj = Model(balance)
            obj.balance = balance;
        end
        function deposit(obj,val)
            obj.balance = obj.balance + val;
            obj.notify('balanceChanged');
            disp('model deposit')
        end
        function withDraw(obj,val)
           obj.balance = obj.balance - val;
           obj.notify('balanceChanged');
           disp('model withdraw')
        end
    end
    
end