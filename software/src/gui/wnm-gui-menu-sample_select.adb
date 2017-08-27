-------------------------------------------------------------------------------
--                                                                           --
--                              Wee Noise Maker                              --
--                                                                           --
--                  Copyright (C) 2016-2017 Fabien Chouteau                  --
--                                                                           --
--    Wee Noise Maker is free software: you can redistribute it and/or       --
--    modify it under the terms of the GNU General Public License as         --
--    published by the Free Software Foundation, either version 3 of the     --
--    License, or (at your option) any later version.                        --
--                                                                           --
--    Wee Noise Maker is distributed in the hope that it will be useful,     --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU       --
--    General Public License for more details.                               --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with We Noise Maker. If not, see <http://www.gnu.org/licenses/>. --
--                                                                           --
-------------------------------------------------------------------------------

with HAL.Bitmap;           use HAL.Bitmap;
with WNM.GUI.Menu.Drawing; use WNM.GUI.Menu.Drawing;

package body WNM.GUI.Menu.Sample_Select is

   Folder_Select : aliased Folder_Select_Window;
   Sample_Select : aliased Sample_Select_Window;

   ------------------------------------
   -- Folder_Select_Window_Singleton --
   ------------------------------------

   function Folder_Select_Window_Singleton return not null Any_Menu_Window
   is (Folder_Select'Access);

   ------------------------------------
   -- Sample_Select_Window_Singleton --
   ------------------------------------

   function Sample_Select_Window_Singleton return not null Any_Menu_Window
   is (Sample_Select'Access);

   ----------
   -- Draw --
   ----------

   overriding procedure Draw
     (This   : in out Folder_Select_Window;
      Screen : not null HAL.Bitmap.Any_Bitmap_Buffer)
   is
   begin
      Draw_Menu_Box (Screen => Screen,
                     Text   => Folder_Path (This.Current_Folder),
                     Top    => This.Current_Folder /= Sample_Folders'First,
                     Bottom => This.Current_Folder /= Sample_Folders'Last);
   end Draw;

   --------------
   -- On_Event --
   --------------

   overriding procedure On_Event
     (This  : in out Folder_Select_Window;
      Event : Menu_Event)
   is
   begin
      case Event.Kind is
         when Left_Press =>
            Menu.Push (new Sample_Select_Window'
                         (Folder => This.Current_Folder,
                          Index  => 1,
                          Rang   => (0, 0)));
            null;
         when Right_Press =>
            Menu.Pop;
         when Encoder_Right =>
            null;
         when Encoder_Left =>
            if Event.Value > 0 then
               if This.Current_Folder /= Sample_Folders'Last then
                  This.Current_Folder := Sample_Folders'Succ (This.Current_Folder);
               end if;
            elsif Event.Value < 0 then
               if This.Current_Folder /= Sample_Folders'First then
                  This.Current_Folder := Sample_Folders'Pred (This.Current_Folder);
               end if;
            end if;
      end case;
   end On_Event;

   ---------------
   -- On_Pushed --
   ---------------

   overriding procedure On_Pushed
     (This  : in out Folder_Select_Window)
   is
   begin
      This.Current_Folder := Sample_Folders'First;
   end On_Pushed;

   --------------
   -- On_Focus --
   --------------

   overriding procedure On_Focus
     (This  : in out Folder_Select_Window)
   is
   begin
      null;
   end On_Focus;

   ----------
   -- Draw --
   ----------

   overriding procedure Draw
     (This   : in out Sample_Select_Window;
      Screen : not null HAL.Bitmap.Any_Bitmap_Buffer)
   is
   begin


      if This.Rang.From = 0
        or else
          This.Rang.To = 0
        or else
          This.Rang.From > This.Rang.To
      then
         Draw_Menu_Box (Screen => Screen,
                        Text   => "No samples...",
                        Top    => False,
                        Bottom => False);
         return;
      end if;

      Draw_Menu_Box (Screen => Screen,
                     Text   => Entry_Name (This.Index),
                     Top    => This.Index /= This.Rang.From,
                     Bottom => This.Index /= This.Rang.To);
   end Draw;

   --------------
   -- On_Event --
   --------------

   overriding procedure On_Event
     (This  : in out Sample_Select_Window;
      Event : Menu_Event)
   is
   begin
      case Event.Kind is
         when Left_Press =>
            null;
         when Right_Press =>
            Menu.Pop;
         when Encoder_Right =>
            null;
         when Encoder_Left =>
            if Event.Value > 0 then
               if This.Index /= This.Rang.To then
                  This.Index := This.Index + 1;
               end if;
            elsif Event.Value < 0 then
               if This.Index /= This.Rang.From then
                  This.Index := This.Index - 1;
               end if;
            end if;
      end case;
   end On_Event;

   ---------------
   -- On_Pushed --
   ---------------

   overriding procedure On_Pushed
     (This  : in out Sample_Select_Window)
   is
   begin
      This.Rang := Sample_Library.Folder_Range (This.Folder);
      if This.Rang.From /= 0 then
         This.Index := This.Rang.From;
      else
         This.Index := Sample_Entry_Index'First;
      end if;
   end On_Pushed;

   --------------
   -- On_Focus --
   --------------

   overriding procedure On_Focus
     (This  : in out Sample_Select_Window)
   is
   begin
      null;
   end On_Focus;

end WNM.GUI.Menu.Sample_Select;