classdef View < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure                   % UI Figure
        LabelNumericEditField  matlab.ui.control.Label            % Balance
        viewBalance            matlab.ui.control.NumericEditField % [-Inf Inf]
        LabelNumericEditField2 matlab.ui.control.Label            % RMB
        viewRMB                matlab.ui.control.NumericEditField % [-Inf Inf]
        DepositButton          matlab.ui.control.Button           % Deposit
        WithDrawButton         matlab.ui.control.Button           % WithDraw

        controlObj
        modelObj 
    end

    methods (Access = private)

        % Code that executes after componmaient creation
        function startupFcn(app)
            app.controlObj = Controller(app,app.modelObj);
            app.attatchToController(app.controlObj);
        end
    end

    % App initialization and construction
    methods (Access = private)
        function attatchToController(obj,controller)
           funcH = @controller.callback_withDrawButton;
           addlistener(obj.WithDrawButton,'ButtonPushed',funcH)
            
           funcH = @controller.callback_depositButton;
           addlistener(obj.DepositButton,'ButtonPushed',funcH)       
 
        end

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure
            app.UIFigure = uifigure;
            app.UIFigure.Position = [100 100 214 151];
            app.UIFigure.Name = 'UI Figure';
            setAutoResize(app, app.UIFigure, true)

            % Create LabelNumericEditField
            app.LabelNumericEditField = uilabel(app.UIFigure);
            app.LabelNumericEditField.HorizontalAlignment = 'right';
            app.LabelNumericEditField.Position = [24.03125 111 44 15];
            app.LabelNumericEditField.Text = 'Balance';

            % Create viewBalance
            app.viewBalance = uieditfield(app.UIFigure, 'numeric');
            app.viewBalance.Position = [83.03125 107 100 22];
            app.viewBalance.Value = 600;

            % Create LabelNumericEditField2
            app.LabelNumericEditField2 = uilabel(app.UIFigure);
            app.LabelNumericEditField2.HorizontalAlignment = 'right';
            app.LabelNumericEditField2.Position = [41.03125 71 27 15];
            app.LabelNumericEditField2.Text = 'RMB';

            % Create viewRMB
            app.viewRMB = uieditfield(app.UIFigure, 'numeric');
            app.viewRMB.Position = [83 67 100 22];
            app.viewRMB.Value = 10;

            % Create DepositButton
            app.DepositButton = uibutton(app.UIFigure, 'push');
            app.DepositButton.Position = [17 23 65 22];
            app.DepositButton.Text = 'Deposit';

            % Create WithDrawButton
            app.WithDrawButton = uibutton(app.UIFigure, 'push');
            app.WithDrawButton.Position = [118 23 65 22];
            app.WithDrawButton.Text = 'WithDraw';
            
            
            app.modelObj.addlistener('balanceChanged',@app.updateBalance);
        end
    end

    methods (Access = public)

        % Construct app
        function app = View(modelObj)
            app.modelObj = modelObj;
            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            
              % register callback 
            if nargout == 0
                clear app
            end
        end

        
        function updateBalance(obj,src,data)
            obj.viewBalance.Value = obj.modelObj.balance;
        end
        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end