classdef Controller < handle 
   properties
       viewObj;
       modelObj;
   end
   methods
       function obj = Controller(viewObj,modelObj)
          obj.viewObj = viewObj;
          obj.modelObj = modelObj;
       end
       function callback_withDrawButton(obj,src,event)
          obj.modelObj.withDraw(obj.viewObj.viewRMB.Value); 
       end
       function callback_depositButton(obj,src,event)
          obj.modelObj.deposit(obj.viewObj.viewRMB.Value); 
       end
   end
    
end