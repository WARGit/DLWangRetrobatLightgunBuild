/*

   Copyright (C) 2007 guest(r) - guest.r@gmail.com

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License
   as published by the Free Software Foundation; either version 2
   of the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

/*

   The AmiGT shader is well used to scale a gfx. surface to a custom size.

*/


#include "shader.code"

float scaling   : SCALING = 0.5;



string name : NAME = "AmiGT";

string preprocessTechique : PREPROCESSTECHNIQUE = "AmiGT";
string combineTechique : COMBINETECHNIQUE =  "Ls";



VERTEX_STUFF1 _VERTEX (float3 p : POSITION, float2 tc : TEXCOORD0)
{
  VERTEX_STUFF1 OUT = (VERTEX_STUFF1)0;
  
  float dx = ps.x;
  float dy = ps.y;

  OUT.coord = mul(float4(p,1),WorldViewProjection);
  OUT.CT = tc;
  OUT.UL = tc + float2(-dx,-dy);
  OUT.UR = tc + float2( dx,-dy);
  OUT.DL = tc + float2(-dx, dy);
  OUT.DR = tc + float2( dx, dy);
  return OUT;
}


float4 _FRAGMENT ( in VERTEX_STUFF1 VAR ) : COLOR

{
  half3 c11 = tex2D(s_p, VAR.CT).xyz;
  half3 c00 = tex2D(s_p, VAR.UL).xyz;
  half3 c20 = tex2D(s_p, VAR.UR).xyz;
  half3 c02 = tex2D(s_p, VAR.DL).xyz;
  half3 c22 = tex2D(s_p, VAR.DR).xyz;
	
  half md1=dot(abs(c00-c22),dt);
  half md2=dot(abs(c02-c20),dt);
  
  half w1=dot(abs(c22-c11),dt)*md2;
  half w2=dot(abs(c02-c11),dt)*md1;
  half w3=dot(abs(c00-c11),dt)*md2;
  half w4=dot(abs(c20-c11),dt)*md1;

  half t1 = w1+w3;
  half t2 = w2+w4;

  half ww = max(t1,t2)+0.001;

  return float4((w1*c00+w2*c20+w3*c22+w4*c02+ww*c11)/(t1+t2+ww),0);
}



VERTEX_STUFF0 _VERTEX0 (float3 p : POSITION, float2 tc : TEXCOORD0)
{
  VERTEX_STUFF0 OUT = (VERTEX_STUFF0)0;

  OUT.coord = mul(float4(p,1),WorldViewProjection);
  OUT.CT = tc;
  return OUT;
}

// **PS**

float4 _FRAGMENT0 ( in VERTEX_STUFF0 VAR ) : COLOR
{
   half3 c11 = tex2D(w_l, VAR.CT).xyz; 

   return float4 (c11,1);
}


technique AmiGT
{
   pass P0
   {
     VertexShader = compile vs_2_0 _VERTEX();
     PixelShader  = compile ps_2_0 _FRAGMENT();
     Sampler[0] = (s_p);
   }  
}


technique Ls
{
   pass P0
   {
     VertexShader = compile vs_2_0 _VERTEX0();
     PixelShader  = compile ps_2_0 _FRAGMENT0();
     Sampler[0] = (w_l);
   }  
}