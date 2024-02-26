require("model2");	-- Import model2 machine globals
require("demulshooter");

function Init()
	P1_ChangeCrosshair_KeyState = 0
	P2_ChangeCrosshair_KeyState = 0
	CrosshairVisibility_KeyState = 0
	CrosshairList = lines_from( "./artwork/crosshairs/crosshairs.lst")
	RomConfig = lines_from("./artwork/crosshairs/vcop2.cfg")
	P1_CrosshairIndex = tonumber(RomConfig[1])
	P2_CrosshairIndex = tonumber(RomConfig[2])
	CrosshairVisibility = tonumber(RomConfig[3])
	
	if not CrosshairList[P1_CrosshairIndex] then P1_CrosshairIndex = 1 end
	if not CrosshairList[P2_CrosshairIndex] then P2_CrosshairIndex = 1 end

	P1_Crosshair = Video_CreateSurfaceFromFile("./artwork/crosshairs/"..CrosshairList[P1_CrosshairIndex].."1.png")
	P2_Crosshair = Video_CreateSurfaceFromFile("./artwork/crosshairs/"..CrosshairList[P2_CrosshairIndex].."2.png")

end

function PostDraw()
	KeyCheck()	
		
	if CrosshairVisibility == 1 then		
		--min val 149 max val 644-- 
		P1AX = (I960_ReadWord(0x507214))
		--min val 38 max val 421--
		P1AY = (I960_ReadWord(0x507218))
		P2AX = (I960_ReadWord(0x50721c))
		P2AY = (I960_ReadWord(0x507220))

		
		P1P=P1AX..P1AY
		P2P=P2AX..P2AY

		width,height = Video_GetScreenSize();	

		XPOS = (P1AX - 149) / 495;
		XPOS = XPOS * width;

		YPOS = ((P1AY - 38) / 383);
		YPOS = (YPOS * height);


		XPOS2 = (P2AX - 149) / 495;
		XPOS2 = XPOS2 * width;

		YPOS2 = ((P2AY - 38) / 383);
		YPOS2 = (YPOS2 * height);
	
		Video_DrawSurface(P1_Crosshair, XPOS-32, YPOS-32)
		Video_DrawSurface(P2_Crosshair, XPOS2-32, YPOS2-32)
	end

end

function KeyCheck()
	if Input_IsKeyPressed(P1_ChangeCrosshairKey) == 1 then
		if P1_ChangeCrosshair_KeyState == 0 then
			P1_ChangeCrosshair_KeyState = 1	
			if CrosshairVisibility == 1 then
				if P1_CrosshairIndex < #CrosshairList then 
					P1_CrosshairIndex = P1_CrosshairIndex + 1 
				else 
					P1_CrosshairIndex = 1 
				end  
				Video_ReleaseSurface(P1_Crosshair)
				P1_Crosshair = Video_CreateSurfaceFromFile("./artwork/crosshairs/"..CrosshairList[P1_CrosshairIndex].."1.png")
			end
		end
	else
		P1_ChangeCrosshair_KeyState = 0
	end
	
	if Input_IsKeyPressed(P2_ChangeCrosshairKey) == 1 then
		if P2_ChangeCrosshair_KeyState == 0 then
			P2_ChangeCrosshair_KeyState = 1	
			if CrosshairVisibility == 1 then
				if P2_CrosshairIndex < #CrosshairList then 
					P2_CrosshairIndex = P2_CrosshairIndex + 1 
				else 
					P2_CrosshairIndex = 1 
				end  
				Video_ReleaseSurface(P2_Crosshair)
				P2_Crosshair = Video_CreateSurfaceFromFile("./artwork/crosshairs/"..CrosshairList[P2_CrosshairIndex].."2.png")
			end
		end
	else
		P2_ChangeCrosshair_KeyState = 0
	end
	
	if Input_IsKeyPressed(CrosshairVisibilityKey) == 1 then
		if CrosshairVisibility_KeyState == 0 then	
			CrosshairVisibility_KeyState = 1
			if CrosshairVisibility == 1 then 
				CrosshairVisibility = 0 
			else 
				CrosshairVisibility = 1
			end
		end
	else
		CrosshairVisibility_KeyState = 0
	end

end


function End()
	--Save our Settings
	local file = io.open("./artwork/crosshairs/vcop2.cfg", "w")
	file:write(P1_CrosshairIndex.."\n"..P2_CrosshairIndex.."\n"..CrosshairVisibility)
	file:close()

end









