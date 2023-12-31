﻿uses GraphABC;
var
  kw, ka, ks, kd, obiect : boolean;
  px, py, width, heigh, score, oy, ran, ranx1, ranx2, ranx3, ranx4, scene : integer;
procedure MouseDown(x, y, mousebutton : integer);
begin
  if mousebutton = 1 then
  begin
    if (547 < x) and (x < 710) and (199 < y) and (y < 238) then scene := 2;
    if (545 < x) and (x < 610) and (244 < y) and (y < 283) then CloseWindow;
  end;
end;
procedure KeyDown(k : integer);
begin
  if k = VK_W then kw := True;
  if k = VK_A then ka := True;
  if k = VK_S then ks := True;
  if k = VK_D then kd := True;
end;
procedure KeyUp(k : integer);
begin
  if k = VK_W then kw := False;
  if k = VK_A then ka := False;
  if k = VK_S then ks := False;
  if k = VK_D then kd := False;
end;
begin
  width := 800;
  heigh := 600;
  px := 245;
  py := 535;
  oy := 11;
  obiect := True;
  score := 0;
  randomize();
  ran := random(60, 430);
  ranx1 := random(1, 2);
  ranx2 := random(15, 20);
  ranx3 := 1;
  ranx4 := 1;
  scene := 1;
  lockDrawing();
  SetWindowTitle('Touhou');
  SetWindowSize(width, heigh);
  CenterWindow;
  SetWindowIsFixedSize(True);
  while True do
  begin
    ClearWindow(RGB(168, 127, 64));
    if scene = 1 then
    begin
      OnMouseDown := MouseDown;
      SetBrushColor(RGB(168, 127, 64));
      SetFontSize(34);
      TextOut(30, 30,'Touhou');
      SetFontSize(24);
      Rectangle(545, 199, 710, 238);
      TextOut(550, 200, 'New game');
      Rectangle(545, 244, 610, 283);
      TextOut(550, 245, 'Exit');
      SetFOntSize(12);
      TextOut(5, 580, 'by Blanari Laurentiu');
    end;
    if scene = 2 then
    begin
      //Logic
      if (kw and not(py <= 0)) then py := py - 2;
      if (ka and not(px <= 60)) then px := px - 2;
      if (ks and not(py >= (heigh - 10))) then py := py + 2;
      if (kd and not(px >= 430)) then px := px + 2;
      if ((oy > 0) and (oy < heigh - 10)) then oy := oy + 1;
      if (ran < px + 10) and (px < ran + 10) and (oy < py + 10) and (py < oy + 10) then
      begin
        score := score + 1;
        oy := 11;
        ran := random(60, 430);
      end;
      if ranx1 = 1 then
      begin
        if ranx2 >= ranx3 then
        begin
          if ran >= 60 then
          begin
            if ranx4 < 4 then
            begin
              ranx4 := ranx4 + 1;
            end;
            if ranx4 = 4 then
            begin
              if oy < 590 then ran := ran - 1;
              ranx4 := 1;
            end;
            ranx3 := ranx3 + 1;
          end;
          if ran < 60 then
          begin
            ranx3 := ranx3 + 1;
          end;
        end;
        if ranx2 < ranx3 then
        begin
          ranx1 := random(1, 2);
          ranx3 := 1;
        end;
      end;
      if ranx1 = 2 then
      begin
        if ranx2 >= ranx3 then
        begin
          if ran <= 430 then
          begin
            if ranx4 < 4 then
            begin
              ranx4 := ranx4 + 1;
            end;
            if ranx4 = 4 then
            begin
              if oy < 590 then ran := ran + 1;
              ranx4 := 1;
            end;
            ranx3 := ranx3 + 1;
          end;
          if ran > 430 then
          begin
            ranx3 := ranx3 + 1;
          end;
        end;
        if ranx2 < ranx3 then
        begin
          ranx1 := random(1, 2);
          ranx3 := 1;
        end;
      end;
      OnKeyDown := KeyDown;
      OnKeyUp := KeyUp;
      //Interface
      SetBrushColor(RGB(102, 63, 38));
      FillRectangle(0, 0, 60, heigh);
      FillRectangle(440, 0, width, heigh);
      SetFontSize(24);
      TextOut(472, 32,'Score: ' + score);
      SetBrushColor(clYellow);
      if obiect then FillRectangle(ran, oy, ran + 10, oy + 10);
      SetBrushColor(clBlue);
      FillRectangle(px, py, px + 10, py + 10);
    end;
    redraw();
  end;
end.