--#region Framework

local Framework = {}; 


Framework.Class = 
{
 Classes = {}; 

 AutoInit = function (
  tbl, name
 ) 
  local Looptrough = {tbl}; 

  while (
    true 
  ) do 
   
   if (
    #Looptrough == 0
   ) then 
    break; end 
    
   for _, loopTroughElement in pairs(
    Looptrough
   ) do 

    for __, memData in pairs(
      loopTroughElement
    ) do 

      if (
        type(memData) == "table"
      ) then 
        Looptrough[
          #Looptrough + 1
        ] = memData; 
      end; 

      if (
        type(memData) == "function"
      ) then 
        if (
          string.find(__, name)
        ) then 
          memData(loopTroughElement); 
          print("Auto init: ", __);
        end; end  

    end; 

    table.remove(
      Looptrough, _
    );
   end; end 
 end; 
};

Framework.Color = 
{
  Correspond = function ()
    return {
      Group = {}; 
      Cloned = {}; 

      New = function 
        (
          self, colorRef
        ) 
        self.Group[ 
          #self.Group + 1
        ] = colorRef; 

        self.Cloned[ 
          #self.Cloned + 1
        ] = color(colorRef.r, colorRef.g, colorRef.b, colorRef.a);
      end; 

      InsertTable = function 
        (
          self, tbl 
        ) 
        for _, col in pairs(
          tbl 
        ) do
          self:New(col);
        end
      end; 

      ChangeParamValueByMaximal = function 
        (
          self, param, value 
        ) 
        for _, col in pairs(
          self.Group
        ) do 
          if (
            col[
              param
            ] > value
          ) then 
            col[ 
              param
            ] = value; 
          end; end 
      end; 

      ChangeParamValueByProcentage = function 
        (
          self, param, procentageFloat
        ) 
        for _, col in pairs(
          self.Group
        ) do 
         col[
          param 
         ] = self.Cloned[_][
          param
         ]*procentageFloat;
        end 
      end; 

      RevertChanges = function 
        (
          self 
        )
        for _, col in pairs(
         self.Group
        ) do 
          local Revert = {"r", "g", "b", "a"}

          for __, revertParam in pairs (
            Revert
          ) do 
            self.Group[
              _
            ][revertParam] = self.Cloned[ 
              _
            ][revertParam]; 
          end; 
        end;
      end;
    }
  end
};

Framework.Input = 
{
  Keyboard = function () 
    local Engine = { 
      KeyLimit = 1;
      Data = {}; 
      Callbacks = {}; 

      ToggleCallback = function 
        (
          self, key, func
        )
        if (
          self.Callbacks[
            key
            ] == nil
        ) then 
          self.Callbacks[
            key
          ] = {};
        end; 
          
        self.Callbacks[
          key
        ][#self.Callbacks[
          key
          ] + 1] = func;


        return {
          Revert = function () 
            local CallbacksRehashed = {}; 

            for _, funcPtr in pairs(
              self.Callbacks[key]
            ) do 
              if (
                funcPtr ~= func
              ) then 
                CallbacksRehashed[
                  #CallbacksRehashed + 1
                ] = funcPtr; 
              end; end 
            self.Callbacks[key] = CallbacksRehashed;
          end; 
        }
      end; 

      IsDown = function 
        (
          key 
        )
        return common.is_button_down(
          key
        ); 
      end;

      IsToggled = function 
        (
         self, key
        )
        if (
          self.Data[
            key
            ] == nil 
        ) then 
          return false; end 
        
        return self.Data[
          key
        ].toggled;
      end;

      IsKeyboardMapToggled = function 
        (
          self 
        ) 

        local KeyboardMap = 
        {
          MOUSE1 =    0x01;
          MOUSE2 =    0x02;
          CANCEL =    0x03;
          BACKSPACE = 0x08;
          TAB =        0x9;
          ENTER =    	0x0D;
          SHIFT =     0x10;
          CTRL =    	0x11;
          ALT =       0x12;
          ["0"] =    	0x30;
          ["1"] =    	0x31;
          ["2"] =     0x32;
          ["3"] =     0x33; 
          ["4"] =   	0x34;
          ["5"] =   	0x35;
          ["6"] =     0x36;
          ["7"] =     0x37; 
          ["8"] =     0x38;
          ["9"] =    	0x39;
          A =        	0x41;
          B =        	0x42;
          C =        	0x43;
          D =         0x44;
          E =         0x45;
          F =         0x46;
          G =        	0x47;
          H =        	0x48;
          I =        	0x49;
          J =        	0x4A;
          K =        	0x4B;
          L =        	0x4C;
          M =       	0x4D;
          N =       	0x4E;
          O =        	0x4F;
          P =       	0x50;
          Q =       	0x51;
          R =       	0x52;
          S =         0x53;
          T =        	0x54;
          U =       	0x55;
          V =        	0x56;
          W =        	0x57;
          X =         0x58;
          Y =        	0x59;
          Z =         0x5A; 
          ["-"] =     0xBD;
          ["="] =     0xBB;
          ["\\"] =    0xDC;
          ["["] =     0xDB;
          ["]"] =     0xDD;
          [";"] =     0xBA;
          ["'"] =     0xDE;
          [" "] =     0x20;
          ["."] =     0xBE;
          [","] =     0xBC;
          ["/"] =     0xBF;
        };

        local TransformedChars = {"1234567890-=;\'.,/", "!@#$%^&*()_+:\"><?"}; 

        for kMappedStr, kIndex in pairs(
          KeyboardMap
        ) do 
          if (
            self:IsToggled(kIndex)
          ) then 
            if (
              #kMappedStr ~= 1
            ) then 
              return kMappedStr; end 

            if (
              self.IsDown(160)
            ) then 
              
              for char = 1, #TransformedChars[1] do 
                if (
                  string.sub(TransformedChars[1], char, char) == kMappedStr
                ) then 
                  return string.sub(TransformedChars[2], char, char);
                end; end 
                
              
             return string.upper(
              kMappedStr
             ); 
            end;

            return string.lower(
              kMappedStr
            ); 
          end; end 

        return false;
      end; 

      UpdateKeys = function 
        (
          self 
        ) 
        
        for Key = 1, self.KeyLimit do 
          local KeyData = self.Data[
            Key
          ]; 

          if (
            KeyData == nil 
          ) then 
            self.Data[
              Key 
            ] = {
              toggled = false; 
              lastHold = 0; 
            }
            return;
          end; 

          KeyData.toggled = false; 

          if (
            globals.frametime*4 <= (globals.realtime - KeyData.lastHold)
          ) then 
            if (
              common.is_button_down(Key)
            ) then 
              KeyData.toggled = true; 
              print(Key);
              if (
                self.Callbacks[Key] ~= nil
              ) then 
                for _, vfunc in pairs(
                  self.Callbacks[Key]
                ) do 
                  vfunc(); 
                end; end 
            end; end 

          if (
            common.is_button_down(Key)
          ) then 
            KeyData.lastHold = globals.realtime; 
          end; 
        end; 
      end; 

      SetKeyLimit = function 
        (
         self, limit 
        ) 
        self.KeyLimit = limit;
      end; 
      
      Clipboard = require("neverlose/clipboard");

      _init_ = function 
        (
          self
        ) 

        events.render:set(
          function () 
            self:UpdateKeys();
          end 
        )
      end; 
    }

    Engine:_init_(); 

    return Engine;
  end;

  Mouse = function () 
    return {
      ElementList = function 
        (
          this
        )

        return 
        {
          Elements = {}; 

          NewElement = function 
            (
              self, ElementTable, ElementThis, functionCall
            ) 
            self.Elements[
              #self.Elements + 1 
            ] = { 
              Body = ElementTable; 
              MainBody = ElementThis; 
              Call = functionCall; 
            }; 
          end;

          CallElementsIfInBounds = function 
            (
              self 
            )
            for _, Element in pairs( 
              self.Elements
            ) do 
              local EntryPosition = Element.Body:GetStartingPosition(Element.MainBody); 
              local ExitPosition = Element.Body:GetFinalPosition(Element.MainBody); 

              if (
                this.IsInBounds(EntryPosition, ExitPosition)
              ) then 
                if (
                  Element:Call(Element.MainBody)
                ) then return; end  
              end; 
            end;
          end;

          Awake = function 
            (
              self 
            )
            self:CallElementsIfInBounds(); 
          end; 
        }
      end; 

      GetPosition = function ()
        return ui.get_mouse_position();
      end; 

      IsInBounds = function 
        (
          vector1, vector2 
        )
        
        local mousePosition = ui.get_mouse_position(); 

        if (
          mousePosition.x < vector1.x or vector2.x < mousePosition.x 
        ) then 
          return false; end 

        if (
          mousePosition.y < vector1.y or vector2.y < mousePosition.y
        ) then 
          return false; end 

        return true; 
      end; 
    }
  end; 
};

Framework.Table =
{
  UnpackInto = function (tbl, insert) 
    for _, paramVal in pairs(
      insert
    ) do 
      tbl[
        _
      ] = paramVal; 
    end; 
  end; 

  Stringify = function (tbl) 
    local TblStr = "";

    for _, userdata in pairs(
      tbl
    ) do 
      TblStr = string.format(
        "%s\n%s", TblStr, userdata
      ); end 

    return TblStr;
  end; 
};

Framework.Animation = 
{
  
  New = function (...)
    local Engine = 
    {
      Value = 0;
      Destination = 0;
      Speed = 0;
      CallbackFunc = nil;

      Get = function 
        (
          self 
        )
        return self.Value;
      end; 

      SetDestination = function 
        (
          self, destination 
        ) 
        self.Destination = destination;
      end; 

      SetCallback = function 
        (
          self, func 
        )
        self.CallbackFunc = func; 
      end; 

      SetSpeed = function 
        (
          self, val  
        )
        self.Speed = val; 
      end;

      GetDestination = function 
        (
          self 
        ) 
        return self.Destination; 
      end;

      UpdateValue = function 
        (
          self 
        ) 
        
        if (
          self.Value == self.Destination
        ) then 
          return false; end 

        if (
          self.Value > self.Destination
        ) then 
          self.Value = math.max(self.Destination, self.Value - (
            self.Speed * globals.frametime
          )); return true; 
        end; 

        self.Value = math.min(self.Destination, self.Value + (
          self.Speed * globals.frametime
        ));
        return true; 
      end; 

      _init_ = function 
        (
          self, currentValue, speed
        ) 
        self.Value = currentValue;
        self.Speed = speed; 
        self.Destination = currentValue;

        events.render:set(
          function () 
            if (
              self:UpdateValue()
            ) then 
              if (
                self.CallbackFunc ~= nil 
              ) then 
                self.CallbackFunc(
                  self:Get()
                ); 
              end; end 
          end
        )
      end; 
    }

    Engine:_init_(
      ...
    );

    return Engine;
  end;

}

Framework.Callback = 
{

  New = function () 
    return { 
      List = {}; 

      Add = function 
        (
          self, func 
        )
        self.List[
          #self.List + 1
        ] = func; 
      end; 

      Call = function 
        (
          self, ... 
        ) 
        for _, func in pairs(
          self.List 
        ) do 
          func(
            ...
          ); 
        end; 
      end; 
    }
  end; 
}

Framework.Tree = function (tbl) 
  return {
    Recursive = function (name)
      
    end; 
  }
end; 

Framework.String = function (str)
  return {
    GetColors = function ()
      local Colors = {}; 

      local LastAt = 0;

      for x = 1, #str do 
        if (
          string.find(string.sub(str, x, x + 1), "\a")
        ) then
          Colors[
            #Colors + 1
          ] = {
            At = x; 
            Value = function ()
              return string.sub(
                str, x + 1, x + 8
              );
            end;
          }
        end
      end; 

      return Colors; 
    end;

    Raw = function 
      (
        self 
      )
      local StrClone = str; 

      if (
        str == nil 
      ) then 
        return ""; end 

      for ad = 1, 100 do 
        local FoundColor = false; 

        for x = 1, #StrClone do 
          if (
            string.find(string.sub(StrClone, x, x + 1), "\a")
          ) then 
            FoundColor = true; 

            local StrFirstPart = string.sub(
              StrClone, 1, x - 1
            ); 

            local StrSecondPart = string.sub(
              StrClone, x + 9
            ); 

            StrClone = string.format(
              "%s%s", StrFirstPart, StrSecondPart
            );
          end; 
        end; 

        if (
          not FoundColor
        ) then 
          break; end 
      end; 

      return StrClone;
    end;
  }
end

Framework.Class.AutoInit(Framework, "_AUTOinit");
Framework.Input.Keyboard = Framework.Input.Keyboard();
Framework.Input.Keyboard:SetKeyLimit(400);


--#endregion 

--[[
  Program
]]

--#region console

local Program = {};


Program = function () 
  local Engine = {
    Data = 
    {};

    Object = 
    {
      Data = 
      {
        Opened = true; 
        OpenAndCloseKeyboardKey = 35;

        ResizeLockedIn = false;
        ResizeLockMousePosition = vector(0, 0);

        MoveLockedIn = false; 
        MoveLockedInMousePosition = vector(0, 0);

        Commands = {

          list = function ()

          end;

          performance = function ()
            utils.console_exec("fps_max_menu 0");
            return "Performance unlocked."
          end; 

          readfile = function (this, Arguments)
            if (
              #Arguments ~= 1
            ) then 
              return; end 

            return files.read(
              Arguments[1]
            );
          end; 

          clear = function (this) 
            this.CommandLine:ClearLists(
              this
            );
          end; 

          readsite = function (this, Arguments)
            if (
              #Arguments ~= 1
            ) then
              return; end 

            return network.get(
              Arguments[1]
            );
          end; 

          struct = function (this) 
            local Structure = {};  
            
            for name, userdata in pairs(
              this 
            ) do 
              if (
                type(userdata) == "table"
              ) then 
                for fname, _ in pairs(
                  userdata
                ) do 
                  if (
                    type(_) == "function"
                  ) then 
                    Structure[
                      #Structure + 1 
                    ] = string.format(
                      "this.%s:\a%s%s()", name, color(0, 180, 255, 255):to_hex(), fname 
                    )
              end; end; end; end;

            return Framework.Table.Stringify(Structure);
          end; 

          modify = function (this, Arguments) 
            local Structure = {}; 

            if (
              #Arguments < 1
            ) then
              return; end 

            for name, userdata in pairs(
              this
            ) do 
              if (
                type(userdata) == "table"
              ) then 
                for fname, _ in pairs(
                  userdata
                ) do 
                  Structure[
                    string.format(
                      "this.%s:%s", name, fname
                    ) 
                  ] = {
                    func = _, 
                    self = userdata;
                  }; 
              end; end; end 
            
            local Struct = Structure[
              Arguments[1]
            ];

            if (
              Struct == nil
            ) then 
              return string.format("\a%sIncorrect struct name.", color(255, 20, 20, 255):to_hex()); end 

            local ArgumentsToStruct = {}; 

            for _, arg in pairs(
              Arguments
            ) do 
              if (
                arg == "self" 
              ) then 
                ArgumentsToStruct[_ - 1] = Struct.self; end 
                
              if (
                arg == "this"
              ) then 
                ArgumentsToStruct[_ - 1] = this; end 

              if (
                arg ~= "self" and arg ~= "this"
              ) then 
                local ReFormatedArg = arg; 

                if (
                  string.sub(arg, 1, 6) == "color:"
                ) then 
                  
                  ReFormatedArg = color(
                    string.sub(arg, 7)
                  ); 
                end;
                
                if (
                  string.sub(arg, 1, 7) == "vector:"
                ) then 
                  local ArgumentValues = string.sub(arg, 7);

                  local x = tonumber(
                    string.sub(
                      ArgumentValues, 2, string.find(ArgumentValues, ",") - 1
                    ));

                  local y = tonumber(
                    string.sub(
                      ArgumentValues, string.find(ArgumentValues, ",") + 1
                    ));

                  ReFormatedArg = vector(
                    x, y
                  );
                end;
                
                if (
                  string.sub(arg, 1, 15) == "function.print:"
                ) then 

                  ReFormatedArg = function () 
                    this.CommandLine:NewTextLine(this, 
                      string.sub(arg, 16)
                    );
                  end; 
                end; 

                if (
                  string.sub(arg, 1, 22) == "function.obtainstruct:"
                ) then 
                  local Cstrct = Structure[
                    string.sub(arg, 23)
                  ]

                  ReFormatedArg = Cstrct.func(Cstrct.self, this);
                end; 

                if (
                  string.sub(arg, 1, 28) == "function.obtainstruct.print:"
                ) then 
                  local Cstrct = Structure[
                    string.sub(arg, 29)
                  ]; 

                  ReFormatedArg = function ()
                    this.CommandLine:NewTextLine(this, tostring(Cstrct.func(Cstrct.self, this)));
                  end
                end;

                ArgumentsToStruct[_ - 1] = ReFormatedArg; 
              end; end 

            local Response = Struct.func(
              unpack(ArgumentsToStruct)
            );

            if (
              Response == nil
            ) then 
              return "Modified successfully."; end 

            if (
              type(Response) == "table"
            ) then 
              return json.stringify(Response); end 

            return tostring(Struct.func(
              unpack(ArgumentsToStruct)
            ));
          end; 
        }; 

        UserInput = "";
        AllowUserInput = true; 

        StartedDeletion = 0;
      };

      Dynamic = 
      {
        OpenAndCloseKeyboardCallback = nil;

        OpenAndCloseCallback = Framework.Callback.New();
        OpenedCallback = Framework.Callback.New();

        ResizingCallback = Framework.Callback.New();
        StoppedResizingCallback = Framework.Callback.New(); 
        StartedResizingCallback = Framework.Callback.New();
      
        MovingCallback = Framework.Callback.New(); 
        MouseElementCalls = Framework.Input.Mouse():ElementList();

        UserInputCallback = Framework.Callback.New(); 
        UserEnterCallback = Framework.Callback.New();

        UserDeletionCallback = Framework.Callback.New();
      };

      GetUserInputCallback = function 
        (
          self 
        )
        return self.Dynamic.UserInputCallback; 
      end;

      GetUserEnterCallback = function 
        (
          self 
        )
        return self.Dynamic.UserEnterCallback;
      end;

      OpenAndCloseKeyboardKey = function 
        (
          self, key
        )
        self.Data.OpenAndCloseKeyboardKey = key; self:HookOpenAndCloseKeyboardCallback();
      end; 

      GetOpenAndCloseKeyboardKey = function 
        (
          self
        )
        return self.Data.OpenAndCloseKeyboardKey;
      end; 

      IsOpened = function 
        (
          self 
        )
        return self.Data.Opened; 
      end;

      GetSwitchCallback = function 
        (
          self 
        ) 
        return self.Dynamic.OpenAndCloseCallback;
      end; 

      GetOpenedCallback = function 
        (
          self 
        ) 
        return self.Dynamic.OpenedCallback;
      end; 

      OpenAndCloseByKeyboard = function 
        (
          self, this 
        )

        self.Data.Opened = not self:IsOpened();

        self:GetSwitchCallback():Call(
          self:IsOpened()
        );
      end; 

      GetOpenAndCloseKeyboardCallback = function 
        (
          self
        )
        return self.Dynamic.OpenAndCloseKeyboardCallback; 
      end;

      SetOpenAndCloseKeyboardCallback = function 
        (
          self, callback
        )
        self.Dynamic.OpenAndCloseKeyboardCallback = callback;
      end;

      HookOpenAndCloseKeyboardCallback = function 
        (
          self
        )
        if (
          self:GetOpenAndCloseKeyboardCallback() ~= nil 
        ) then 
          self:GetOpenAndCloseKeyboardCallback().Revert(); 
        end; 

        self:SetOpenAndCloseKeyboardCallback(
          Framework.Input.Keyboard:ToggleCallback(
            self:GetOpenAndCloseKeyboardKey(), function () self:OpenAndCloseByKeyboard() end 
          ));
      end;

      HookOpenedCallback = function 
        (
          self, this
        ) 

        events.render:set(
          function () 
            if (
              not self:IsOpened()
            ) then return; end 


            self.Dynamic.OpenedCallback:Call(this);
          end
        )
      end; 

      ResizeByMouse = function 
        (
          self, this 
        )

        if (
          self.Data.ResizeLockedIn
        ) then return; end 

        if (
          not Framework.Input.Keyboard:IsToggled(1)
        ) then 
          return; end 

        if (
          Framework.Input.Mouse().IsInBounds(
            this.ResizeIcon:GetStartingPosition(this), this.ResizeIcon:GetFinalPosition(this)
          ) == false 
        ) then 
          self.Data.ResizeLockedIn = false; return; end 

        self.Data.ResizeLockedIn = true;

        self.Data.ResizeLockMousePosition = 
        (
          this.Frame:GetFinalPosition() - Framework.Input.Mouse().GetPosition()
        );

        self.Dynamic.StartedResizingCallback:Call();
      end; 

      HandleResizeByMouseCallback = function 
        (
          self, this 
        ) 

        if (
          not Framework.Input.Keyboard.IsDown(1)
        ) then 
          if (
            self.Data.ResizeLockedIn
          ) then 
            self.Dynamic.StoppedResizingCallback:Call(); 
          end; 

          self.Data.ResizeLockedIn = false; return; end 
        
        if (
          not self.Data.ResizeLockedIn
        ) then
          return; end 
        
        self.Dynamic.ResizingCallback:Call();
      end; 

      IsResizing = function 
        (
          self, this 
        )

      end;  

      HandleResizingByMouse = function 
        (
          self, this 
        )
        
        local MouseOff = 
        (
          self.Data.ResizeLockMousePosition
        );

        local OverridenSize = 
        (
          Framework.Input.Mouse().GetPosition() - this.Frame:GetStartingPosition() + MouseOff
        );

        local MinimalSize = this.Frame:GetMinimalSize();

        OverridenSize.x = math.max(
          MinimalSize.x, OverridenSize.x
        );

        OverridenSize.y = math.max(
          MinimalSize.y, OverridenSize.y
        );

        this.Frame:SetSize(
          OverridenSize
        );
      end; 

      GetResizingCallback = function 
        (
          self
        )
        return self.Dynamic.ResizingCallback;
      end;

      GetStartedResizingCallback = function 
        (
          self 
        )
        return self.Dynamic.StartedResizingCallback; 
      end; 

      GetStoppedResizingCallback = function 
        (
          self 
        )
        return self.Dynamic.StoppedResizingCallback;
      end; 

      MovingByMouse = function 
        (
          self, this
        ) 

        if (
          not Framework.Input.Keyboard:IsToggled(1) 
        ) then 
          return; end 

        self.Data.MoveLockedIn = true; 

        self.Data.MoveLockedInMousePosition = 
        (
          Framework.Input.Mouse().GetPosition() - this.Frame:GetStartingPosition()
        );
      end; 

      HandleMovingByMouseCallback = function 
        (
          self, this 
        ) 

        if (
          not Framework.Input.Keyboard.IsDown(1)
        ) then 
          self.Data.MoveLockedIn = false; end 

        if (
          not self.Data.MoveLockedIn 
        ) then 
          return; end 

        self.Dynamic.MovingCallback:Call(); 
      end; 

      GetMovingCallback = function 
        (
          self 
        )
        return self.Dynamic.MovingCallback; 
      end;

      HandleMovingByMouse = function 
        (
          self, this 
        ) 

        local NewPosition = 
        (
          Framework.Input.Mouse().GetPosition() - self.Data.MoveLockedInMousePosition
        );

        this.Frame:SetPosition(NewPosition);
      end; 

      CloseByIcon = function 
        (
          self, this 
        ) 

        if (
          not Framework.Input.Keyboard:IsToggled(1) 
        ) then 
          return; end
        
        self.Data.Opened = false;

        self:GetSwitchCallback():Call(
          self:IsOpened()
        );
      end;  

      GetUserInputAllowedState = function 
        (
          self
        ) 
        return self.Data.AllowUserInput;
      end; 

      GetUserInputArguments = function 
        (
          UserInput  
        ) 
        
        local FunctionName = ""; local Arguments = {};

        if (
          #UserInput == 0 
        ) then 
          return 
          {
            FunctionName = nil;
            Args = {}; 
          }; end 

        for char = 1, #UserInput do 
          if (
            string.sub(UserInput, char, char) ~= " "
          ) then 
            UserInput = string.sub(
              UserInput, char
            ); break; 
          end; end 

        for CharIndex = 1, #UserInput do
          local char = string.sub(
            UserInput, CharIndex, CharIndex
          ); 

          if (
            char == " "
          ) then 
            break; end;

          FunctionName = string.format(
            "%s%s", FunctionName, char
          );
        end

        local OpenedString = nil; local OpenedWith = "";

        for CharIndex = 1, #UserInput do 
          local char = string.sub(
            UserInput, CharIndex, CharIndex
          );
          
          if (
            (char == "\"") or (char == "\'")
          ) then 
            if (
              OpenedString ~= nil
            ) then  
              if (
                OpenedWith == char
              ) then 
                Arguments[
                  #Arguments + 1
                ] = string.sub(
                  UserInput, OpenedString + 1, CharIndex - 1
                ); 

                OpenedString = nil;
                OpenedWith = nil;
              end;
            else OpenedString = CharIndex; OpenedWith = char;
          end; end 
        end; 

        return 
        {
          FunctionName = FunctionName;
          Args = Arguments;
        }
      end; 

      GetUserInput = function 
        (
          self
        )
        return self.Data.UserInput; 
      end;

      GetUserInputCommands = function 
        (
          self 
        )
        return self.Data.Commands;
      end; 

      GetSimiliarCommands = function 
        (
          self, FunctionName
        ) 

        local Commands = self:GetUserInputCommands(); 
        local Similiar = {}; local SimiliarStr = "";

        for name, _ in pairs(
          Commands
        ) do 
          if (
            string.find(name, FunctionName)
          ) then 
            Similiar[
              #Similiar + 1
            ] = name; 
          end; end 
        
        for _, SimiliarCommand in pairs(
          Similiar
        ) do 
          if (
            _ == #Similiar
          ) then 
            SimiliarStr = string.format(
              "%s%s", SimiliarStr, SimiliarCommand
            ); 
          else 
            SimiliarStr = string.format(
              "%s%s, ", SimiliarStr, SimiliarCommand
            ); 
          end; end 

        return string.format(
          "%s", SimiliarStr
        );
      end; 

      AwakeUserInputCommand = function 
        (
          self, this, userinput
        )

        local UserInputData = self.GetUserInputArguments(
          userinput
        );

        local Commands = self:GetUserInputCommands();

        if (
          UserInputData.FunctionName == nil 
        ) then 
          this.CommandLine:NewTextLine(
            this, string.format("\a%sIncorrect input syntax.", color(255, 50, 50, 255):to_hex())
          );
          return; end 

        if (
          Commands[ 
            UserInputData.FunctionName
          ] == nil 
        ) then 
          local SimiliarCommands = self:GetSimiliarCommands(UserInputData.FunctionName);

          this.CommandLine:NewTextLine(
            this, string.format("\a%sFailed to find command named: \a%s\"%s\"\a%s.\a%s %s", 

              color(255, 50, 50, 255):to_hex(),
              color(255, 255, 0, 255):to_hex(),

              UserInputData.FunctionName, 

              color(255, 50, 50, 255):to_hex(),
              this.CommandLine:GetTextColor():to_hex(),

              #SimiliarCommands ~= 0 and string.format("Similiar: %s", SimiliarCommands) or "" 
            )
          );
          return; end 

        local CommandVcall = Commands[
          UserInputData.FunctionName
        ](this, UserInputData.Args);

        if (
          CommandVcall == nil 
        ) then 
          return; end 

        this.CommandLine:NewTextLine(
          this, CommandVcall
        );
      end; 

      HandleUserInputEnter = function 
        (
          self, this 
        )

        if (
          not self:GetUserInputAllowedState()
        ) then 
          return; end 

        self:AwakeUserInputCommand(this, self:GetUserInput());          
        self:SetupUserInput(this);

        self:GetUserEnterCallback():Call();
        
        self.Data.UserInput = "";
      end; 

      HandleUserInputPaste = function 
        (
          self, this 
        )

        local Clipboard = Framework.Input.Keyboard.Clipboard.get();

        if (
          Clipboard == nil
        ) then 
          return; end 
      
        local List = this.CommandLine:GetList(); 
        local FormatedList = this.CommandLine:GetFormatedList();

        if (
          not Framework.Input.Keyboard.IsDown(162)
        ) then 
          return; end 

        if (
          not Framework.Input.Keyboard:IsToggled(86)
        ) then 
          return; end 


        List[
          #List
        ] = string.format(
          "%s%s", List[#List], Clipboard
        );

        FormatedList[
          #FormatedList
        ] = string.format(
          "%s%s", FormatedList[#FormatedList], Clipboard
        );

        self.Data.UserInput = string.format(
          "%s%s", self.Data.UserInput, Clipboard
        );

        this.CommandLine:ReFormatList(this);
        self:GetUserInputCallback():Call();

        return true; 
      end; 

      UserInputAutoCompletion = function 
        (
          self, this 
        )

        local List, FormatedList = this.CommandLine:GetList(), this.CommandLine:GetFormatedList(); 

        local LastLineOfList = List[
          #List
        ];

        local LastLineOfListCloned = LastLineOfList;
        local CommandNameInInput = nil; 

        for x = 1, #LastLineOfList do 
          if (
            string.sub(LastLineOfList, x, x) ~= " "
          ) then 
            LastLineOfListCloned = string.sub(
              LastLineOfList, x
            ); break; end; end;

        local AllowedChars = "1234567890qwertyuiopasdfghjklzxcvbnm";

        for x = 1, math.max(1, #LastLineOfList) do 
          local Allowed = false; 
          for y = 1, #AllowedChars do 
            if (
              string.sub(LastLineOfList, x, x) == string.sub(AllowedChars, y, y)
            ) then
              Allowed = true; 
            end; end 

          if (
            not Allowed
          ) then 
            return; 
          end; end
            
        if (
          string.find(LastLineOfList, " ")
        ) then 
          return; end 

        for name, _ in pairs(
          self:GetUserInputCommands()
        ) do 
          if (
            string.find(name, LastLineOfListCloned) == 1
          ) then 
            FormatedList[
              #FormatedList
            ] = string.format(
              "%s\a%s%s\a%s", LastLineOfListCloned, color(255, 255, 255, 255):alpha_modulate(100):to_hex(), string.sub(name, #LastLineOfList + 1), this.CommandLine:GetTextColor():to_hex()
            ); 
            
            if (
              Framework.Input.Keyboard.IsDown(9) 
            ) then 
              List[
                #List
              ] = name;

              FormatedList[
                #FormatedList
              ] = string.format("%s", name);

              self.Data.UserInput = name;
            end;

            return true; end; end

        FormatedList[
          #FormatedList
        ] = List[
          #List
        ];
      end;  

      GetUserDeletionCallback = function 
        (
          self 
        )
        return self.Dynamic.UserDeletionCallback; 
      end;

      HandleUserInputDeletion = function 
        (
          self, this 
        )

        if (
          not self:GetUserInputAllowedState() 
        ) then
          return; end 

        local DeleteChar = function ()
          local L, Lf = this.CommandLine:GetList(), this.CommandLine:GetFormatedList();

          L[ 
            #L  
          ] = string.sub(
            L[#L], 1, #L[#L] - 1);

          Lf[ 
            #Lf  
          ] = string.sub(
            Lf[#Lf], 1, #Lf[#Lf] - 1);

          self.Data.UserInput = string.sub(
            self.Data.UserInput, 1, #self.Data.UserInput - 1
          );
          
          this.CommandLine:FormatList(this);
          self.Dynamic.UserDeletionCallback:Call();
        end;

        if (
          Framework.Input.Keyboard:IsToggled(8)
        ) then 
          DeleteChar();

          self.Data.StartedDeletion = globals.realtime + 0.5;
        end; 

        if (
          Framework.Input.Keyboard.IsDown(8)
        ) then 
          if (
            self.Data.StartedDeletion > globals.realtime
          ) then 
            return; end 

          DeleteChar();

          self.Data.StartedDeletion = globals.realtime + 0.05;
        end; 
      end;

      HandleUserInputRealtime = function 
        (
          self, this 
        ) 

        if (
          not self:GetUserInputAllowedState() 
        ) then
          return; end 

        if (
          self:HandleUserInputPaste(this)
        ) then 
          return; end 
        
        local KeyMapToggled = Framework.Input.Keyboard:IsKeyboardMapToggled(); 
        
        if (
          KeyMapToggled == false
        ) then 
          return; end 

        if (
          KeyMapToggled == "ENTER"
        ) then 
          self:HandleUserInputEnter(this); 
          
          this.CommandLine:FormatList(this);

          return; end;

        if (
          KeyMapToggled == "TAB"
        ) then
          self:UserInputAutoCompletion(this); end 
        
        if (
          #KeyMapToggled ~= 1
        ) then 
          return; end 

        local List = this.CommandLine:GetList(); 
        local FormatedList = this.CommandLine:GetFormatedList();
        
        local CursorAtChar = this.CommandLineCursor:GetAtChar();
        local CursorAtLine = this.CommandLineCursor:GetAtLine();

        List[
            #List
          ] = string.format(
            "%s%s", List[#List], KeyMapToggled
          );

          FormatedList[
            #FormatedList
          ] = string.format(
            "%s%s", FormatedList[#FormatedList], KeyMapToggled
          );
       
       

        self:UserInputAutoCompletion(this);

        self.Data.UserInput = string.format(
          "%s%s", self.Data.UserInput, KeyMapToggled
        );

        this.CommandLine:ReFormatList(this);
        this.CommandLine:FullScroll(this);
        self:GetUserInputCallback():Call();
      end;

      SetupUserInput = function 
        (
          self, this 
        ) 
        
        this.CommandLine:NewTextLine(this, "");
        self:GetUserInputCallback():Call();
      end; 

      Object = function 
        (
          self, this 
        )

        self.Dynamic.MouseElementCalls:NewElement(
          this.ResizeIcon, this, function () 
            self:ResizeByMouse(this);
          end
        );

        self.Dynamic.MouseElementCalls:NewElement(
          this.CloseIcon, this, function () 
            self:CloseByIcon(this);
          end 
        ); 

        self.Dynamic.MouseElementCalls:NewElement(
          this.Bar, this, function () 
            self:MovingByMouse(this);
          end
        );
        
        self:GetOpenedCallback():Add(
          function (...) 
            self.Dynamic.MouseElementCalls:Awake(); 

            self:HandleResizeByMouseCallback(
              this, ...
            );

            self:HandleMovingByMouseCallback(
              this, ... 
            );

            self:HandleUserInputRealtime(
              this, ...
            );

            self:HandleUserInputDeletion(
              this, ...
            );
          end 
        )

        self:GetResizingCallback():Add(
          function (...)
            self:HandleResizingByMouse(
              this, ...
            );
          end
        )

        self:GetMovingCallback():Add(
          function (...) 
            self:HandleMovingByMouse(
              this, ... 
            ); 
          end 
        )
        
        
        self:HookOpenAndCloseKeyboardCallback();
        self:HookOpenedCallback(this);

        self:SetupUserInput(this);
      end;
    }; 

    Frame = 
    {
      Data = 
      {
        Position = vector(20, 20); 
        Size = vector(1000, 700);
        MinimalSize = vector(700, 500);
      };

      Colors = 
      {
        FrameLayers = 
        {
          color(0, 0, 0, 255), 
          color(255, 255, 255, 35)
        }
      };

      Dynamic = 
      {
        SetSizeCallback = Framework.Callback.New();
      };

      GetMinimalSize = function 
        (
          self 
        ) 
        return self.Data.MinimalSize;
      end; 

      SetMinimalSize = function 
        (
          self, val
        ) 
        self.Data.MinimalSize = val;
      end; 

      GetStartingPosition = function 
        (
          self 
        ) 
        return self.Data.Position;
      end;

      GetSize = function 
        (
          self 
        ) 
        return self.Data.Size; 
      end; 

      SetSize = function 
        (
          self, val 
        ) 
        self.Data.Size = val; 
        self.Dynamic.SetSizeCallback:Call(val);
      end; 

      GetSetSizeCallback = function 
        (
          self 
        )
        return self.Dynamic.SetSizeCallback; 
      end;

      SetPosition = function 
        (
          self, val 
        )
        self.Data.Position = val; 
      end; 

      GetFinalPosition = function 
        (
          self 
        ) 
        return self:GetStartingPosition() + self:GetSize();
      end; 

      GetFrameColorLayers = function 
        (
          self 
        )
        return self.Colors.FrameLayers;
      end; 

      RenderObject = function 
        (
          self, this 
        )

        for _, currentLayerColor in pairs (
          self:GetFrameColorLayers()
        ) do 
          render.rect 
          (
            self:GetStartingPosition(),
            self:GetFinalPosition(), 
            currentLayerColor
          ); 
        end;
      end; 

      Frame = function 
        (
          self, this
        ) 

        events.render:set( 
          function () 
            self:RenderObject(
              this
            )
          end 
        )
      end; 
    };

    ResizeIcon =
    {
      Colors = 
      {
        MainColor = color(255, 255, 255, 255);
      };

      Data = 
      {
        Lenght = 13;
        DifferenceFromSize = 6;
      };

      Dynamic = 
      {
        Animation = Framework.Animation.New(0.6, 3);
        ColorGroup = Framework.Color.Correspond();
      };

      GetPositions = function 
        (
          self, this 
        )

        local FramePosition = this.Frame:GetStartingPosition(); 
        local FrameSize = this.Frame:GetSize(); 

        local SizeDifference = self.Data.DifferenceFromSize;
        local Lenght = self.Data.Lenght;

        return 
        {
          FramePosition + FrameSize - SizeDifference - vector(0, Lenght);
          FramePosition + FrameSize - SizeDifference; 
          FramePosition + FrameSize - SizeDifference - vector(Lenght, 0);
        }
      end; 

      GetStartingPosition = function 
        (
          self, this 
        )
        return 
        (
          this.Frame:GetStartingPosition() + this.Frame:GetSize() - self.Data.DifferenceFromSize - self.Data.Lenght
        );
      end;

      GetFinalPosition = function  
        (
          self, this 
        ) 
        return this.Frame:GetFinalPosition();
      end; 

      HandleAnimationWhenResizing = function 
        (
          self
        )
        self.Dynamic.Animation:SetDestination(1);
      end; 

      HandleAnimationWhenNotResizing = function 
        (
          self
        )
        self.Dynamic.Animation:SetDestination(0.6);
      end; 

      HandleColorGroupAlpha = function 
        (
          self 
        ) 
        self.Dynamic.ColorGroup:ChangeParamValueByProcentage("a", self.Dynamic.Animation:Get());
      end; 

      RenderObject = function 
        (
          self, this 
        ) 

        render.poly_line(
          self.Colors.MainColor,
        
          table.unpack(
            self:GetPositions(this)
          )
        ); 
      end; 

      ResizeIcon = function 
        (
          self, this 
        )

        self.Dynamic.ColorGroup:New(self.Colors.MainColor);
        
        events.render:set(
          function (...) 
            self:RenderObject(
              this, ...
            )
          end 
        )

        this.Object:GetOpenedCallback():Add(
          function (...) 
            self:HandleColorGroupAlpha();
          end 
        )

        this.Object:GetStartedResizingCallback():Add(
          function () 
            self:HandleAnimationWhenResizing();
          end 
        )

        this.Object:GetStoppedResizingCallback():Add(
          function () 
            self:HandleAnimationWhenNotResizing();
          end 
        )

        
      end
    };

    CloseIcon = 
    {
      Colors = 
      {
        InBoundsColor = color(255, 0, 0, 255);
        CurrentColor = color(255, 255, 255, 255);
      };  

      Data = 
      {
        IconFactor = 0.4;
      };

      Dynamic = 
      {
        InBoundsAnim = Framework.Animation.New(0, 4.6);
        ColorGroup = Framework.Color.Correspond();
      };

      GetIconFactor = function 
        (
          self
        ) 
        return self.Data.IconFactor; 
      end; 

      GetIconDefaultSize = function 
        (
          self, this 
        )
        return vector(
          this.Bar:GetSizeY(), this.Bar:GetSizeY()
        );
      end; 

      GetIconFactoredSize = function 
        (
          self, this 
        ) 
        return self:GetIconDefaultSize(this) * self:GetIconFactor(); 
      end; 

      GetIconFactoredSpace = function 
        (
          self, this 
        ) 
        return (self:GetIconDefaultSize(this).x - self:GetIconFactoredSize(this).x)/2;
      end; 

      GetStartingPosition = function 
        (
          self, this 
        ) 
        local IconDefaultSize = self:GetIconDefaultSize(this);

        return (
          this.Frame:GetStartingPosition() + vector(this.Frame:GetSize().x - IconDefaultSize.x, 0)  
        )
      end; 

      GetFinalPosition = function 
        (
          self, this 
        ) 
        return (
          this.Frame:GetStartingPosition() + vector(this.Frame:GetSize().x, self:GetIconDefaultSize(this).y)
        )
      end; 

      RenderHighlightWhenInBounds = function 
        (
          self, this 
        ) 

        render.rect
        (
          self:GetStartingPosition(this),
          self:GetFinalPosition(this),
          self.Colors.InBoundsColor
        )
      end;
      
      HandleInBoundsAnim = function 
        (
          self, this 
        ) 

        self.Dynamic.ColorGroup:ChangeParamValueByProcentage("a", self.Dynamic.InBoundsAnim:Get());
        
        if (
          not Framework.Input.Mouse().IsInBounds(self:GetStartingPosition(this), self:GetFinalPosition(this))
        ) then 
          self.Dynamic.InBoundsAnim:SetDestination(0); return end 

        self.Dynamic.InBoundsAnim:SetDestination(1);
      end; 

      RenderIcon = function 
        (
          self, this 
        ) 

        local IconStartingPosition = self:GetStartingPosition(this); 
        local IconFinalPosition = self:GetFinalPosition(this);

        local IconFactoredSize = self:GetIconFactoredSize(this);
        local IconFactoredSpace = self:GetIconFactoredSpace(this);

        local Positions = 
        {
          IconStartingPosition + IconFactoredSpace, 
          IconStartingPosition + IconFactoredSpace + IconFactoredSize,
          IconStartingPosition + IconFactoredSpace + vector(IconFactoredSize.x, 0),
          IconFinalPosition - IconFactoredSpace - vector(IconFactoredSize.x, 0)
        }

        render.line
        (
          Positions[1],
          Positions[2], 
          self.Colors.CurrentColor
        )
        
        render.line(
          Positions[3],
          Positions[4],
          self.Colors.CurrentColor
        )
      end; 
      
      CloseIcon = function 
        (
          self, this 
        ) 

        self.Dynamic.ColorGroup:New(self.Colors.InBoundsColor);

        this.Object:GetOpenedCallback():Add(
          function () 
            self:HandleInBoundsAnim(this);
          end 
        )

        events.render:set( 
          function () 
            self:RenderHighlightWhenInBounds(this);
            self:RenderIcon(this);
          end 
        )
      end; 
    };

    Watermark = 
    {
      Data = 
      {
        Font = render.load_font("IMPACT", 20, "aod");
        WatermarkText = "Vtrmnl";
        SpacingX = 5;
      };  

      Colors = 
      {
        Main = color(255, 255, 255, 255);
      };

      GetSize = function 
        (
          self
        ) 
        return render.measure_text
        (
          self.Data.Font, nil, self:GetWatermarkText()
        );
      end; 

      GetSpacingX = function 
        (
          self, this  
        )
        return this.Bar:GetSizeY() - self:GetSize().y*0.85; 
      end;

      GetStartingPosition = function 
        (
          self, this 
        ) 
        
        local Size = self:GetSize(); 
        local BarYSize = this.Bar:GetSizeY(); 
        local SpacingX = self:GetSpacingX(this); 

        local FramePosition = this.Frame:GetStartingPosition(); 

        return 
        (
          FramePosition + vector(SpacingX, BarYSize/2 - Size.y/2)
        );
      end; 

      GetWatermarkTextFont = function 
        (
          self 
        ) 
        return self.Data.Font; 
      end; 

      GetWatermarkText = function 
        (
          self 
        )
        return self.Data.WatermarkText;
      end; 

      RenderObject = function 
        (
          self, this 
        )

        render.text 
        (
          self:GetWatermarkTextFont(), 
          self:GetStartingPosition(this),
          self.Colors.Main, 
          nil,
          self:GetWatermarkText()
        )
      end; 

      Watermark = function 
        (
          self, this 
        ) 
        
        events.render:set(
          function () 
            self:RenderObject(this);
          end 
        )
      end; 
    };

    CommandLine = 
    {
      Data = 
      {
        List = {
          
        }; 

        FormatedList = {
        }; 

        TextFont = render.load_font("Hack", 17, "aod");
        RegularTextLine = "Regular TextLine";

        SpacingFromTop = vector(4, 0); 
        SpacingFromBottom = vector(10, 10);

        TextScroll = 0;

        MaximalLenght = 500; 
      };

      
      Colors = 
      {
        TextColor = color(255, 255, 255, 255)
      };

      Dynamic = 
      {
        TextScrollAnim = Framework.Animation.New(0, 100);
        BeforeFormatCallback = Framework.Callback.New();
        FormatedCallback = Framework.Callback.New();
      };

      SetMaximalLenght = function 
        (
          self, val
        ) 
        self.Data.MaximalLenght = val; 
      end;

      GetList = function 
        (
          self 
        )
        return self.Data.List; 
      end; 

      GetFormatedList = function 
        (
          self 
        )
        return self.Data.FormatedList; 
      end; 

      ClearLists = function 
        (
          self
        )
        self.Data.FormatedList = {}; self.Data.List = {}; 
        
        self:SetTextScroll(0);
      end; 

      GetTextFont = function 
        (
          self 
        )
        return self.Data.TextFont; 
      end;

      SetTextColor = function 
        (
          self, col
        )
        self.Colors.TextColor = col;
      end; 

      GetRegularTextLine = function 
        (
          self 
        )
        return self.Data.RegularTextLine; 
      end;

      GetRegularTextSize = function 
        (
          self
        )
        return render.measure_text
        (
          self:GetTextFont(), nil, self:GetRegularTextLine()
        );
      end; 

      GetRegularCharSize = function 
        (
          self
        )
        return render.measure_text(
          self:GetTextFont(), nil, "G"
        );
      end;

      GetSpacingFromTop = function 
        (
          self
        )
        return self.Data.SpacingFromTop; 
      end; 

      GetSpacingFromBottom = function 
        (
          self 
        )
        return self.Data.SpacingFromBottom;
      end;

      GetStartingPosition = function 
        (
          self, this 
        )
        local FramePosition = this.Frame:GetStartingPosition(); 
        local BarSizeY = this.Bar:GetSizeY(); 

        local SpacingFromTop = self:GetSpacingFromTop(); 
        
        return (
          FramePosition + vector(0, BarSizeY) + SpacingFromTop 
        );
      end;
      
      GetFinalPosition = function 
        (
          self, this 
        ) 

        local FrameEndPos = this.Frame:GetFinalPosition(); 
        local SpacingFromBottom = self:GetSpacingFromBottom();

        return (
          FrameEndPos - SpacingFromBottom
        );
      end;
      
      GetSize = function 
        (
          self, this 
        )
        return (
          self:GetFinalPosition(this) - self:GetStartingPosition(this)
        );
      end;

      GetTextColor = function 
        (
          self 
        )
        return self.Colors.TextColor; 
      end;
      
      GetTextScroll = function 
        (
          self
        )
        return self.Data.TextScroll; 
      end; 

      SetTextScroll = function 
        (
          self, val  
        ) 

        self.Dynamic.TextScrollAnim.Speed = 300 + math.abs
        (
          val - self:GetTextScroll() 
        )*3

        self.Dynamic.TextScrollAnim:SetDestination(
          math.max(0, val));
      end; 

      ClipRect = function 
        (
          self, this 
        ) 

        return 
        {
          Push = function () 
            render.push_clip_rect(
              self:GetStartingPosition(this),
              self:GetFinalPosition(this)
            );
          end;
          
          Pop = function ()
            render.pop_clip_rect();
          end
        };
      end; 

      RenderObject = function 
        (
          self, this  
        )

        local ClipRect = self:ClipRect(this);
        ClipRect.Push();

        --[[
        for _, Text in pairs(
          self:GetFormatedList() 
        ) do 
          local CurrentTextPosition = 
          (
            self:GetStartingPosition(this) + vector(0, (_ - 1) * self:GetRegularTextSize().y - self:GetTextScroll())
          );

          if (
            CurrentTextPosition.y + 15 > self:GetStartingPosition(this).y and CurrentTextPosition.y - 15 - self:GetFinalPosition(this).y 
          ) then 
            
            render.text
            (
              self:GetTextFont(), 
              CurrentTextPosition, 
              self:GetTextColor(),
              nil,
              Text
            );
          
          end;
        end;
        --]]

        local StartingTextLoop = tonumber(
          string.format("%.0f", (self:GetTextScroll() / self:GetRegularTextSize().y))
        );
        
        local FinalTextLoop = tonumber(string.format("%.0f",
          StartingTextLoop + self:GetSize(this).y / self:GetRegularTextSize().y)
        );

        for _ = StartingTextLoop, FinalTextLoop do 
          local CurrentTextPosition = 
          (
            self:GetStartingPosition(this) + vector(0, (_ - 1) * self:GetRegularTextSize().y - self:GetTextScroll())
          );

          render.text
            (
              self:GetTextFont(), 
              CurrentTextPosition, 
              self:GetTextColor(),
              nil,
              self:GetFormatedList()[_]
            );
        end; 

        ClipRect.Pop();
      end;  

      ReFormatList = function 
        (
          self, this
        ) 
        self:GetBeforeFormatCallback():Call();

        local ExitCache = self:GetFormatedList();
        
        while (
          true 
        ) do 
          local MadeChanges = false; 
          local Rehashed = {}; 

          for _, TextLine in pairs(
            ExitCache 
          ) do 
            if (
              string.find(TextLine, "\n")
            ) then 
              MadeChanges = true; 

              local FoundAt = string.find(
                TextLine, "\n"
              )

              local FirstTextLine = string.sub(
                TextLine, 1, FoundAt - 1
              ); 

              local SecondTextLine = string.sub(
                TextLine, FoundAt + 1
              ); 

              Rehashed[
                #Rehashed + 1
              ] = FirstTextLine; 

              Rehashed[
                #Rehashed + 1
              ] = SecondTextLine; 
            else 
              Rehashed[
                #Rehashed + 1 
              ] = TextLine; end
          end; 

          if (
            not MadeChanges
          ) then 
            break; end 

          ExitCache = Rehashed;
        end; 

        while (
          true 
        ) do 
          local MadeChanges = false; 
          local Rehashed = {}; 

          for _, TextLine in pairs(
            ExitCache
          ) do 
            local TextLineSize = render.measure_text(
              self:GetTextFont(), nil, TextLine 
            ).x;  
            
            local TextRectSize = self:GetSize(this).x; 

            if (
              TextLineSize > TextRectSize
            ) then 
              MadeChanges = true; 

              for char = 1, #TextLine do 
                local CurrentTextLineSize = render.measure_text(
                  self:GetTextFont(), nil, string.sub(TextLine, 1, char)
                ).x; 

                if (
                  CurrentTextLineSize > TextRectSize
                ) then 
                  local FirstTextLine = string.sub(TextLine, 1, char - 1); 

                  local ColorsFound = Framework.String(
                    TextLine
                  ).GetColors();

                  local FurthestColorAt = 0; local FurthestColor = nil;

                  for _, Color in pairs(
                    ColorsFound
                  ) do 
                    if (
                      Color.At <= #FirstTextLine and FurthestColorAt < Color.At
                    ) then 
                      FurthestColorAt = Color.At; 
                      FurthestColor = Color.Value(); 
                    end; end 

                  local SecondTextLine = string.sub(
                    TextLine, char 
                  );

                  if (
                    FurthestColor ~= nil 
                  ) then 
                    SecondTextLine = string.format(
                      "\a%s%s", FurthestColor, SecondTextLine
                    ); 
                  end;

                  Rehashed[
                    #Rehashed + 1
                  ] = FirstTextLine;

                  Rehashed[
                    #Rehashed + 1 
                  ] = SecondTextLine;
                  

                  break; 
                end
              end; 
            else Rehashed[
              #Rehashed + 1 
            ] = TextLine; end 
          end;  

          ExitCache = Rehashed;

          if (
            MadeChanges == false 
          ) then 
            break; end
        end; 

        local MaximalScrollBefore = self:GetMaximalTextScroll(this);

        self.Data.FormatedList = ExitCache;

        self:HandleScrollAfterTextFormating(
          this, MaximalScrollBefore, self:GetMaximalTextScroll(this)
        );

        self.Dynamic.FormatedCallback:Call();
      end; 

      FormatList = function 
        (
          self, this
        ) 
        
        self:GetBeforeFormatCallback():Call();
        local ExitCache = self:GetList(); 
        
        while (
          true 
        ) do 
          local MadeChanges = false; 
          local Rehashed = {}; 

          for _, TextLine in pairs(
            ExitCache 
          ) do 
            if (
              string.find(TextLine, "\n")
            ) then 
              MadeChanges = true; 

              local FoundAt = string.find(
                TextLine, "\n"
              )

              local FirstTextLine = string.sub(
                TextLine, 1, FoundAt - 1
              ); 

              local SecondTextLine = string.sub(
                TextLine, FoundAt + 1
              ); 

              Rehashed[
                #Rehashed + 1
              ] = FirstTextLine; 

              Rehashed[
                #Rehashed + 1
              ] = SecondTextLine; 
            else 
              Rehashed[
                #Rehashed + 1 
              ] = TextLine; end
          end; 

          if (
            not MadeChanges
          ) then 
            break; end 

          ExitCache = Rehashed;
        end; 

        while (
          true 
        ) do 
          local MadeChanges = false; 
          local Rehashed = {}; 

          for _, TextLine in pairs(
            ExitCache
          ) do 
            local TextLineSize = render.measure_text(
              self:GetTextFont(), nil, TextLine 
            ).x;  
            
            local TextRectSize = self:GetSize(this).x; 

            if (
              TextLineSize > TextRectSize
            ) then 
              MadeChanges = true; 

              for char = 1, #TextLine do 
                local CurrentTextLineSize = render.measure_text(
                  self:GetTextFont(), nil, string.sub(TextLine, 1, char)
                ).x; 

                if (
                  CurrentTextLineSize > TextRectSize
                ) then 
                  local FirstTextLine = string.sub(TextLine, 1, char - 1); 

                  local ColorsFound = Framework.String(
                    TextLine
                  ).GetColors();

                  local FurthestColorAt = 0; local FurthestColor = nil;

                  for _, Color in pairs(
                    ColorsFound
                  ) do 
                    if (
                      Color.At <= #FirstTextLine and FurthestColorAt < Color.At
                    ) then 
                      FurthestColorAt = Color.At; 
                      FurthestColor = Color.Value(); 
                    end; end 

                  local SecondTextLine = string.sub(
                    TextLine, char 
                  );

                  if (
                    FurthestColor ~= nil 
                  ) then 
                    SecondTextLine = string.format(
                      "\a%s%s", FurthestColor, SecondTextLine
                    ); 
                  end;

                  Rehashed[
                    #Rehashed + 1
                  ] = FirstTextLine;

                  Rehashed[
                    #Rehashed + 1 
                  ] = SecondTextLine;
                  

                  break; 
                end
              end; 
            else Rehashed[
              #Rehashed + 1 
            ] = TextLine; end 
          end;  

          ExitCache = Rehashed;

          if (
            MadeChanges == false 
          ) then 
            break; end
        end; 

        local MaximalScrollBefore = self:GetMaximalTextScroll(this);

        self.Data.FormatedList = ExitCache;

        self:HandleScrollAfterTextFormating(
          this, MaximalScrollBefore, self:GetMaximalTextScroll(this)
        );

        self.Dynamic.FormatedCallback:Call();
      end; 

      NewTextLine = function 
        (
          self, this, TextLine 
        ) 
        
        self.Data.List[
          #self.Data.List + 1 
        ] = tostring(TextLine); 

        self.Data.FormatedList[
          #self.Data.FormatedList + 1 
        ] = tostring(TextLine); 

        utils.execute_after(
          0.05, function () self:ReFormatList(this); self:FullScroll(this); end
        );
      end; 

      GetSpaceOccupiedByTextY = function 
        (
          self, this 
        ) 
        return (
          #self:GetFormatedList()*(
            self:GetRegularTextSize().y 
          )
        );
      end;

      GetFormatedCallback = function 
        (
          self 
        )
        return self.Dynamic.FormatedCallback;
      end;

      GetBeforeFormatCallback = function 
        (
          self
        ) 
        return self.Dynamic.BeforeFormatCallback; 
      end;

      GetPositionOfGivenTextLine = function 
        (
          self, this, TextLineIndex, TextCharIndex
        ) 
        
        local TextLineSizeX = render.measure_text(
          self:GetTextFont(), nil, string.sub(Framework.String(self:GetFormatedList()[TextLineIndex]):Raw(), 0, TextCharIndex)
        ).x;

        return 
        (
          vector(TextLineSizeX, (self:GetRegularTextSize().y*TextLineIndex) - self:GetTextScroll())
        )
      end; 

      GetPositionOfGivenTextLineWithoutScroll = function 
        (
          self, this, TextLineIndex, TextCharIndex
        ) 
        
        local TextLineSizeX = render.measure_text(
          self:GetTextFont(), nil, string.sub(Framework.String(self:GetFormatedList()[TextLineIndex]):Raw(), 0, TextCharIndex)
        ).x;

        return 
        (
          vector(TextLineSizeX, (self:GetRegularTextSize().y*TextLineIndex))
        )
      end; 
      
      GetMaximalTextScroll = function 
        (
          self, this 
        )
        return math.max(0,
          self:GetSpaceOccupiedByTextY(this) - self:GetSize(this).y
        )
      end; 

      FullScroll = function 
        (
          self, this 
        )

        self:SetTextScroll(
          self:GetMaximalTextScroll(this)
        );
      end; 

      HandleScrollAfterTextFormating = function 
        (
          self, this, MaximalScrollBefore, MaximalScrollAfter
        )
        
        local CurrentScroll = self:GetTextScroll(); 

        if (
          CurrentScroll == MaximalScrollBefore
        ) then 
          self:FullScroll(this); return; end 

        local NewScrollFactor = 
        (
          MaximalScrollAfter/MaximalScrollBefore
        );

        if (
          MaximalScrollAfter == MaximalScrollBefore
        ) then 
          return; end 

        self:SetTextScroll(
          math.max(0, CurrentScroll*NewScrollFactor)
        );
      end; 

      UpdateTextScroll = function 
        (
          self, this 
        )
        
        self.Data.TextScroll = self.Dynamic.TextScrollAnim:Get();
      end; 

      GetMaximalLenght = function 
        (
          self
        )
        return self.Data.MaximalLenght
      end;

      TextLinesGC = function 
        (
          self
        )
        if (
          #self:GetFormatedList() <= self.Data.MaximalLenght 
        ) then 
          return; end 

        self:ClearLists();
      end;

      CommandLine = function 
        (
          self, this 
        ) 

        this.Object:GetOpenedCallback():Add(
          function () 
            --self:FormatList(this);
            self:UpdateTextScroll(this);
            
          end 
        )

        this.Object:GetStoppedResizingCallback():Add(
          function () 
            self:FormatList(this); 
          end 
        )

        events.render:set( 
          function () 
            self:RenderObject(this);
            self:TextLinesGC();
          end 
        )

        self:NewTextLine(
          this, string.format("\a%s[Vtrmnl \a%s3.0\a%s | 20.10.23 | \a%sLua\a%s]", 
            self:GetTextColor():to_hex(),
            color(0, 180, 255, 255):to_hex(),
            self:GetTextColor():to_hex(),
            color(0, 180, 255, 255):to_hex(),
            self:GetTextColor():to_hex()
          )
        );

        self:FormatList(this);
      end;
    };

    CommandLineCursor = 
    {
      Data = 
      {
        AtLine = 1;
        AtChar = 1;
      };

      Dynamic = 
      {
        CursorAnimX = Framework.Animation.New(0, 100); 
        CursorAnimY = Framework.Animation.New(0, 100);

        UpwardsLast = 0;
        DownwardsLast = 0;

        LeftLast = 0; 
        RightLast = 0;

        ColorGroup = Framework.Color.Correspond();

        ScrollOnFormat = false; 
      };

      Colors = 
      {
        CursorColor = color(255, 255, 255, 255);
      };


      GetSize = function 
        (
          self, this 
        ) 
        return this.CommandLine:GetRegularCharSize();
      end; 

      GetCursorColor = function 
        (
          self 
        )
        return self.Colors.CursorColor; 
      end;

      SetAtLine = function 
        (
          self, this, val 
        )
        self.Data.AtLine = math.max(1, 
          math.min(#this.CommandLine:GetFormatedList(), val)
        );
      end; 

      SetAtChar = function 
        (
          self, this, val 
        )
        self.Data.AtChar = math.max(0,
          math.min(#Framework.String(this.CommandLine:GetFormatedList()[
            self:GetAtLine()
          ]):Raw() - 1, val)
        );
      end;

      GetAtLine = function 
        (
          self, this 
        )
        return self.Data.AtLine; 
      end; 

      GetAtChar = function 
        (
          self, this 
        )
        return self.Data.AtChar; 
      end;

      GetStartingPosition = function 
        (
          self, this 
        )
        return
        (
          this.CommandLine:GetStartingPosition(this) + vector(self.Dynamic.CursorAnimX:Get(), self.Dynamic.CursorAnimY:Get())
        ) 
      end; 

      GetFinalPosition = function 
        (
          self, this 
        ) 
        return self:GetStartingPosition(this) + self:GetSize(this);
      end; 

      RenderObject = function 
        (
          self, this 
        )

        local ClipRect = this.CommandLine:ClipRect(this);
        ClipRect.Push();  

        render.rect
        ( 
          self:GetStartingPosition(this),
          self:GetFinalPosition(this),
          self:GetCursorColor()
        );

        ClipRect.Pop();
      end; 

      SetCursorOnLast = function 
        (
          self, this
        )
        local FormatedList = this.CommandLine:GetFormatedList();

        if (
          #FormatedList == 0
        ) then 
          return; end 

        self.Data.AtChar = #FormatedList[#FormatedList];
        self.Data.AtLine = #FormatedList
      end;

      HandleCursorOnFormatBegin = function 
        (
          self, this 
        ) 
        
        if (
          self:GetAtLine() == #this.CommandLine:GetFormatedList() 
        ) then 
          self.Dynamic.ScrollOnFormat = true; return; end 

        self.Dynamic.ScrollOnFormat = false; 
      end; 

      HandleCursorOnFormat = function 
        (
          self, this 
        )
        
        if (
          not self.Dynamic.ScrollOnFormat
        ) then
          return; end 

        self:SetCursorOnLast(this);
      end;

      HandleScrollOnCursorMoveWithKeyboard = function 
        (
          self, this, direction
        )

        local CurrentLinePosition = this.CommandLine:GetPositionOfGivenTextLineWithoutScroll(
          this, self:GetAtLine(), self:GetAtChar()
        ).y;

        local MaximalScroll = this.CommandLine:GetMaximalTextScroll(this);

        local WantedScroll = 
        (
          CurrentLinePosition - (this.CommandLine:GetSize(this).y)
        );
        local CurrentScroll = this.CommandLine:GetTextScroll();

        if (
          MaximalScroll == 0 
        ) then 
          return; end 

        if (
          CurrentLinePosition + this.CommandLine:GetRegularTextSize(this).y*2 > this.CommandLine:GetStartingPosition(this).y + CurrentScroll and CurrentLinePosition + this.CommandLine:GetRegularTextSize(this).y*2 < this.CommandLine:GetFinalPosition(this).y + CurrentScroll
        ) then 
          return; end    

        if (
          direction == -1 
        ) then 
          WantedScroll = WantedScroll + this.CommandLine:GetSize(this).y - this.CommandLine:GetRegularTextSize(this).y; end

        this.CommandLine:SetTextScroll(
          WantedScroll
        );
      end;

      HandleCursorMoveWithKeyboard = function 
        (
          self, this 
        )

        if (
          Framework.Input.Keyboard:IsToggled(38)
        ) then 
          self.Dynamic.UpwardsLast = globals.realtime + 0.5;

          self:SetAtLine(
            this, self:GetAtLine() - 1
          );

          self:HandleScrollOnCursorMoveWithKeyboard(this, -1);
        end; 

        if (
          Framework.Input.Keyboard.IsDown(38)
        ) then 

          if (  
            self.Dynamic.UpwardsLast + 0.03 <= globals.realtime
          ) then 
            self:SetAtLine(
              this, self:GetAtLine() - 1
            ); 
            self.Dynamic.UpwardsLast = globals.realtime; self:HandleScrollOnCursorMoveWithKeyboard(this, -1);
          end;

        end;

        if (
          Framework.Input.Keyboard:IsToggled(40)
        ) then 
          self.Dynamic.DownwardsLast = globals.realtime + 0.5;

          self:SetAtLine(
            this, self:GetAtLine() + 1
          );

          self:HandleScrollOnCursorMoveWithKeyboard(this, 1);
        end; 

        if (
          Framework.Input.Keyboard.IsDown(40)
        ) then 

          if (  
            self.Dynamic.DownwardsLast + 0.03 <= globals.realtime
          ) then 
            self:SetAtLine(
              this, self:GetAtLine() + 1
            ); 
            self.Dynamic.DownwardsLast = globals.realtime; self:HandleScrollOnCursorMoveWithKeyboard(this, 1);
          end;

        end;

        if (
          Framework.Input.Keyboard:IsToggled(37)
        ) then 
          self.Dynamic.LeftLast = globals.realtime + 0.5;
          
          self:SetAtChar(
            this, self:GetAtChar() - 1
          ); end; 
          
        if (
          Framework.Input.Keyboard.IsDown(37)
        ) then 
          if (
            self.Dynamic.LeftLast + 0.03 <= globals.realtime
          ) then 
            self:SetAtChar(
              this, self:GetAtChar() - 1
            ); 
            self.Dynamic.LeftLast = globals.realtime; 
          end; end; 

        if (
          Framework.Input.Keyboard:IsToggled(39)
        ) then 
          self.Dynamic.RightLast = globals.realtime + 0.5;
          
          self:SetAtChar(
            this, self:GetAtChar() + 1
          ); end; 
          
        if (
          Framework.Input.Keyboard.IsDown(39)
        ) then 
          if (
            self.Dynamic.RightLast + 0.03 <= globals.realtime
          ) then 
            self:SetAtChar(
              this, self:GetAtChar() + 1
            ); 
            self.Dynamic.RightLast = globals.realtime; 
          end; end; 
      end;

      HandleCursorAnim = function 
        (
          self, this 
        ) 

        local CursorDestPosition = this.CommandLine:GetPositionOfGivenTextLine(this, self:GetAtLine(), self:GetAtChar()) - vector(0, this.CommandLine:GetRegularTextSize().y)

        local AnimX, AnimY = self.Dynamic.CursorAnimX, self.Dynamic.CursorAnimY;

        if (
          AnimX:GetDestination() ~= CursorDestPosition.x 
        ) then 
          AnimX:SetSpeed(
            100 + math.abs(CursorDestPosition.x - AnimX:Get())*10
          ); 
        end;

        if (
          AnimY:GetDestination() ~= CursorDestPosition.y
        ) then 
          AnimY:SetSpeed(
            100 + math.abs(CursorDestPosition.y - AnimY:Get())*10
          ); 
        end;

        AnimX:SetDestination(CursorDestPosition.x);
        AnimY:SetDestination(CursorDestPosition.y);
      end; 

      CursorPulse = function 
        (
          self, this 
        )
        
        self.Dynamic.ColorGroup:ChangeParamValueByProcentage("a", 
          1.1 * math.abs(((globals.realtime*2) % 1 - globals.realtime % 1)*2.5)
        );
      end; 

      CommandLineCursor = function 
        (
          self, this 
        ) 

        self:SetCursorOnLast(this);

        events.render:set(
          function () 
            self:RenderObject(this);
          end 
        )

        
        self.Dynamic.ColorGroup:New(self.Colors.CursorColor);

        this.Object:GetOpenedCallback():Add(function () self:HandleCursorAnim(this); self:HandleCursorMoveWithKeyboard(this); self:CursorPulse(this); end);

        this.Object:GetUserInputCallback():Add(function () self:SetCursorOnLast(this) end);
        this.Object:GetUserEnterCallback():Add(function () self:SetCursorOnLast(this) end);
        
        this.Object:GetStoppedResizingCallback():Add(function ()
          utils.execute_after(0.1, function () self:SetCursorOnLast(this); end);
        end)

        this.CommandLine:GetBeforeFormatCallback():Add(function () 
          self:HandleCursorOnFormatBegin(this);
        end)

        this.CommandLine:GetFormatedCallback():Add(function ()
          self:HandleCursorOnFormat(this);
        end)
      end; 
    };

    CommandLineUserTextCopy = 
    {
      Data = 
      {

      };

      Dynamic = 
      {
        CopiedLines = {};
      }; 

      CommandLineUserTextCopy = function 
        (
          self, this 
        )


      end; 
    };
    
    InputLock = 
    {
      LockMouseInputWhenOpened = function 
        (
          this 
        )
        
        return not this.Object:IsOpened();
      end; 

      InputLock = function 
        (
          self, this   
        ) 

        events.mouse_input:set(
          function () 
            return self.LockMouseInputWhenOpened(this);
          end 
        )
      end; 
    }; 

    Bar = 
    {
      Data = 
      {
        SizeY = 25; 
      };

      Colors = 
      {
        BarLayers = 
        {
          color(0, 0, 0, 255)
        }
      };

      GetBarColorLayers = function 
        ( 
          self 
        )
        return self.Colors.BarLayers;
      end;

      GetSizeY = function 
        (
          self 
        )
        return self.Data.SizeY;
      end; 

      GetStartingPosition = function 
        (
          self, this 
        ) 
        return this.Frame:GetStartingPosition(); 
      end;  

      GetFinalPosition = function 
        (
          self, this 
        )
        return this.Frame:GetStartingPosition() + vector(
          this.Frame:GetSize().x, self:GetSizeY()
        );
      end;

      RenderBar = function 
        (
          self, this
        )
        
        for _, col in pairs(
          self:GetBarColorLayers()
        ) do 
          render.rect
          (
            self:GetStartingPosition(this),
            self:GetFinalPosition(this),
            col 
          ); 
        end; 
      end;

      SetSizeY = function 
        (
          self, size 
        )
        self.Data.SizeY = size; 
      end;

      Bar = function 
        ( 
          self, this 
        )

        events.render:set(
          function (...) 
            self:RenderBar(this, ...);
          end 
        )
      end
    };  

    Colors = 
    {
      Dynamic = 
      {
        Animation = Framework.Animation.New(1, 15);
      };

      Frame = function 
        (
          this 
        ) 
        
        this.Data.Colors:InsertTable(
          this.Frame:GetFrameColorLayers()
        );
      end; 

      ResizeIcon = function 
        (
          this
        )

        this.Data.Colors:InsertTable(
          this.ResizeIcon.Colors 
        ); 
      end; 

      CloseIcon = function 
        (
          this 
        )
        this.Data.Colors:InsertTable(
          this.CloseIcon.Colors 
        ); 
      end; 

      Bar = function 
        (
          this 
        )

        this.Data.Colors:InsertTable(
          this.Bar:GetBarColorLayers()
        );
      end; 

      Watermark = function 
        (
          this 
        ) 

        this.Data.Colors:InsertTable(
          this.Watermark.Colors
        );
      end;  

      CommandLine = function 
        (
          this 
        ) 

        this.Data.Colors:InsertTable(
          this.CommandLine.Colors
        );
      end; 

      CommandLineCursor = function 
        (
          this 
        )

        this.Data.Colors:InsertTable(
          this.CommandLineCursor.Colors
        );
      end; 

      Animate = function 
        (
          this, value
        )
        
        this.Data.Colors:ChangeParamValueByProcentage(
          "a", value
        );
      end;  

      OpenAndClose = function 
        (
          self, this, opened
        )

        self.Dynamic.Animation:SetDestination(
          opened and 1 or 0
        );
      end; 

      Colors = function 
        (
          self, this 
        )

        this.Data.Colors = Framework.Color.Correspond();

        self.Frame(this);
        self.Bar(this);
        self.ResizeIcon(this);
        self.CloseIcon(this);
        self.Watermark(this);
        self.CommandLine(this);
        self.CommandLineCursor(this);

        this.Object:GetSwitchCallback():Add(
          function (...) 
            self:OpenAndClose(this, ...); 
          end
        )

        self.Dynamic.Animation:SetCallback(
          function (...)
            self.Animate(
              this, ...
            );
          end 
        )

      end; 
    };

    ModifyHelpers = 
    {
      SetCallback = function (callback, func) 
        callback:Add(func);
      end; 
    };

    OnStartupCommands = 
    {
      Data = 
      {
        StartupFile = nil;
      };

      SetStartupFile = function 
        (
          self, file
        )
        self.Data.StartupFile = file; 
      end;

      LoadCommands = function 
        (
          self, this 
        ) 

        if (
          self.Data.StartupFile == nil 
        ) then
          return; end 
        
        local FileBuffer = files.read(self.Data.StartupFile); 
        local BufferVector = {};

        for x = 1, 100 do 
          local FoundAt = string.find(FileBuffer, "\n"); 

          if (
            not FoundAt
          ) then 
            if (#FileBuffer == 0) then 
              break; end 
            
            BufferVector[
              #BufferVector + 1
            ] = FileBuffer;

            break; end 

          BufferVector[
            #BufferVector + 1
          ] = string.sub(FileBuffer, 1, FoundAt - 1);

          FileBuffer = string.sub(FileBuffer, FoundAt + 1);
        end;

        this.CommandLine:NewTextLine(this, string.format("[ %s ]", self.Data.StartupFile));

        for _, command in pairs(
          BufferVector
        ) do 
          this.Object:AwakeUserInputCommand(this, command);
        end;

        if (
          #BufferVector == 0
        ) then 
          return; end 

        utils.execute_after(0.05, function () this.Object:GetUserEnterCallback():Call(); end);
        this.CommandLine:NewTextLine(this, "\n")
      end; 
      
    };

    InsertCorrespondingProgram = function 
      (
        self, programname, program
      ) 
      
      self[programname] = program;
    end; 

    _init_ = function 
      (
        self
      )

      self.Frame:Frame(self);
      self.Bar:Bar(self);
      self.ResizeIcon:ResizeIcon(self);
      self.CloseIcon:CloseIcon(self);
      self.Watermark:Watermark(self);
      self.CommandLineCursor:CommandLineCursor(self);
      self.CommandLineUserTextCopy:CommandLineUserTextCopy(self);
      self.CommandLine:CommandLine(self);
      self.InputLock:InputLock(self);

      self.Object:Object(self);

      self.OnStartupCommands:SetStartupFile(
        "nl/vtrmnl2/startup.txt"
      );

      self.OnStartupCommands:LoadCommands(self);
      
      self.Colors:Colors(self);
    end;
  }

  Engine:_init_(); 
  return Engine;
end;  

--#endregion 

--[[
  Script
]]

--#region script 

local console = Program(); 

Framework.Entity = function () 
  local Data = {}; 

  events.createmove:set(
    function () 
      for _, ptr in pairs(
        entity.get_players(false, true)
      ) do 
        if (
          Data[
            ptr:get_index()
          ] == nil 
        ) then 
          Data[
            ptr:get_index()
          ] = {}; 
        end;

        Data[
          ptr:get_index()
          ][
          #Data[
            ptr:get_index()
          ] + 1
        ] = ptr:get_origin(); 
      end; 

      for _, ptr in pairs(
        Data
      ) do 
        if (
          #Data[_] > 5 
        ) then 
          
          table.remove(Data[_], 1);
        end; end 
    end 
  )

  return {
    GetAllEnemies = function () 
      return entity.get_players(true, true);
    end; 


    Object = function 
      (
        entPointer
      ) 
      return 
      {
        PredictedPositionChangeInNextTicks = function 
          (
            self
          ) 
          
          local PositionInLastAvailableTrackedTick = Data[entPointer:get_index()][1];

          local PositionInLastTrackedTick = Data[entPointer:get_index()][
            #Data[entPointer:get_index()]
          ];

          return 
          {
            Default = function () 
              return PositionInLastTrackedTick - PositionInLastAvailableTrackedTick;
            end; 

            Flat = function () 
              return 
              (
                vector(PositionInLastTrackedTick.x, PositionInLastTrackedTick.y, 0) - vector(PositionInLastAvailableTrackedTick.x, PositionInLastAvailableTrackedTick.y, 0)
              );
            end; 

            DefaultLimited = function (self, ratio) 
              local MovementTrace = utils.trace_line(
                entPointer:get_origin(), entPointer:get_origin() + self:Default()*ratio, entPointer, 1
              );

              return MovementTrace.end_pos - entPointer:get_origin();
            end; 
          }
        end; 

        CanDoHarm = function 
          (
            self 
          ) 

          if (
            entPointer == nil 
          ) then 
            return false; end 

          if (
            not entPointer:is_alive()
          ) then 
            return false; end 

          if (
            not entPointer:is_enemy()
          ) then 
            return false; end 

          if (
            not entPointer:is_player()
          ) then 
            return false; end 

          if (
            entPointer:get_player_weapon() == nil  
          ) then 
            return false; end 

          if (
            entPointer:get_player_weapon():get_weapon_reload() ~= -1
          ) then 
            return false; end 

          local LocalPlayer = Framework.Player().Get();

          if (
            LocalPlayer == nil 
          ) then 
            return false; end 

          if (
            not LocalPlayer:is_alive()
          ) then
            return false; end 
            
          local LocalPlayerEyes = LocalPlayer:get_eye_position(); 
          local EntEyes = entPointer:get_eye_position();

          local SingularTrace = utils.trace_bullet(
            entPointer, EntEyes, LocalPlayerEyes
          ); 

          if (
            SingularTrace > 0
          ) then 
            return true; end 

          local LocalPlayerPredictedPosition = LocalPlayer:get_eye_position() + Framework.Entity.Object(
            LocalPlayer
          ):PredictedPositionChangeInNextTicks():DefaultLimited(20);
          
          local EntPointerPredictedPosition = entPointer:get_eye_position() + Framework.Entity.Object(
            entPointer
          ):PredictedPositionChangeInNextTicks():DefaultLimited(20);

          local SingularTracePredicted = utils.trace_bullet(
            entPointer, EntPointerPredictedPosition, LocalPlayerPredictedPosition
          );

          if (
            SingularTracePredicted > 0
          ) then 
            return true; end 

          return false; 
        end; 
      }
    end; 
  }
end;

Framework.Entity = Framework.Entity();

Framework.Player = function ()
  return {
    Get = function () 
      return entity.get_local_player(); 
    end; 

    GetVelocity = function 
      (
        self
      )
      return self.Get().m_vecVelocity:length();
    end;

    IsSafe = function 
      (
        self
      ) 
      local Enemies = Framework.Entity.GetAllEnemies();
      local LocalPlayer = self:Get();

      for _, entPointer in pairs(
        Enemies
      ) do 
        if (
          Framework.Entity.Object(entPointer):CanDoHarm()
        ) then 
          return false; 
        end; end 
        

      return true; 
    end; 
  }
end;  

local Script = 
{

  AntiAims =
  {
    

    AntiAims = function 
      (
        self, this 
      ) 

      events.createmove:set(
        function () 
          if (
            Framework.Player():IsSafe()
          ) then 
            ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override("Disabled");
            ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override({});
            return;
          end;

          ui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier"):override("Center");
          ui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", "Options"):override({"Jitter"});
        end 
      )
    end; 
  };

  _init_ = function 
    (
      self 
    ) 

    self.AntiAims:AntiAims(self);
  end; 
};

Script:_init_();

console:InsertCorrespondingProgram("Script", Script);

--#endregion script











