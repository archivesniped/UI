if not memorystats then memorystats={}memorystats.cache=function(a)end memorystats.restore=function(a)end end
for a,b in pairs(({"Internal","HttpCache","Instances","Signals","Script","PhysicsCollision","PhysicsParts","GraphicsSolidModels","GraphicsMeshParts","GraphicsParticles","GraphicsParts","GraphicsSpatialHash","GraphicsTerrain","GraphicsTexture","GraphicsTextureCharacter","Sounds","StreamingSounds","TerrainVoxels","Gui","Animation","Navigation","GeometryCSG"}))do
memorystats.cache(b)
end
local c,
d,
e,
f,
g,
h,
i=cloneref(game:GetService('UserInputService')),cloneref(game:GetService('TextService')),cloneref(game:GetService('CoreGui')),cloneref(game:GetService('Teams')),cloneref(game:GetService('Players')),cloneref(game:GetService('RunService')),cloneref(game:GetService('TweenService'))

local j,
k=h.RenderStepped,g.LocalPlayer
local l,

m=k:GetMouse(),Instance.new('ScreenGui')

m.ZIndexBehavior=Enum.ZIndexBehavior.Global
m.Parent=e

local n,
o={},{}

getgenv().Toggles=n
getgenv().Options=o

local p,






















q,
r={Registry={};RegistryMap={};HudRegistry={};FontColor=Color3.fromRGB(255,255,255);MainColor=Color3.fromRGB(28,28,28);BackgroundColor=Color3.fromRGB(20,20,20);AccentColor=Color3.fromRGB(106,90,205);OutlineColor=Color3.fromRGB(50,50,50);RiskColor=Color3.fromRGB(255,50,50),Black=Color3.new(0,0,0);Font=Enum.Font.RobotoMono;OpenedFrames={};DependencyBoxes={};Signals={};ScreenGui=m;},0,0

table.insert(p.Signals,j:Connect(function(s)
q=q+s

if q>=(1/60)then
q=0

r=r+(1/400)

if r>1 then
r=0
end

p.CurrentRainbowHue=r
p.CurrentRainbowColor=Color3.fromHSV(r,0.8,1)
end
end))local GetPlayersString=function()


local s=g:GetPlayers()

for t=1,#s do
s[t]=s[t].Name
end

table.sort(s,function(t,u)return t<u end)

return s end local GetTeamsString=function()



local s=f:GetTeams()

for t=1,#s do
s[t]=s[t].Name
end

table.sort(s,function(t,u)return t<u end)

return s end


function p:SafeCallback(s,...)
if(not s)then
return
end

if not p.NotifyOnError then
return s(...)
end

local t,u=pcall(s,...)

if not t then local
v, w=u:find(":%d+: ")

if not w then
return p:Notify(u)
end

return p:Notify(u:sub(w+1),3)
end
end

function p:AttemptSave()
if p.SaveManager then
p.SaveManager:Save()
end
end

function p:Create(s,t)
local u=s

if type(s)=='string'then
u=Instance.new(s)
end

for v,w in next,t do
u[v]=w
end

return u
end

function p:ApplyTextStroke(s)
s.TextStrokeTransparency=1

p:Create('UIStroke',{
Color=Color3.new(0,0,0);
Thickness=1;
LineJoinMode=Enum.LineJoinMode.Miter;
Parent=s;
})
end

function p:CreateLabel(s,t)
local u=p:Create('TextLabel',{
BackgroundTransparency=1;
Font=p.Font;
TextColor3=p.FontColor;
TextSize=16;
TextStrokeTransparency=0;
})

p:ApplyTextStroke(u)

p:AddToRegistry(u,{
TextColor3='FontColor';
},t)

return p:Create(u,s)
end

function p:MakeDraggable(s,t)
s.Active=true

s.InputBegan:Connect(function(u)
if u.UserInputType==Enum.UserInputType.MouseButton1 then
local v=Vector2.new(
l.X-s.AbsolutePosition.X,
l.Y-s.AbsolutePosition.Y
)

if v.Y>(t or 40)then
return
end

while c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
s.Position=UDim2.new(
0,
l.X-v.X+(s.Size.X.Offset*s.AnchorPoint.X),
0,
l.Y-v.Y+(s.Size.Y.Offset*s.AnchorPoint.Y)
)

j:Wait()
end
end
end)
end

function p:AddToolTip(s,t)
local u,v=p:GetTextBounds(s,p.Font,14)
local w=p:Create('Frame',{
BackgroundColor3=p.MainColor,
BorderColor3=p.OutlineColor,

Size=UDim2.fromOffset(u+5,v+4),
ZIndex=100,
Parent=p.ScreenGui,

Visible=false,
})

local x=p:CreateLabel({
Position=UDim2.fromOffset(3,1),
Size=UDim2.fromOffset(u,v);
TextSize=14;
Text=s,
TextColor3=p.FontColor,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=w.ZIndex+1,

Parent=w;
})

p:AddToRegistry(w,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

p:AddToRegistry(x,{
TextColor3='FontColor',
})

local y=false

t.MouseEnter:Connect(function()
if p:MouseIsOverOpenedFrame()then
return
end

y=true

w.Position=UDim2.fromOffset(l.X+15,l.Y+12)
w.Visible=true

while y do
h.Heartbeat:Wait()
w.Position=UDim2.fromOffset(l.X+15,l.Y+12)
end
end)

t.MouseLeave:Connect(function()
y=false
w.Visible=false
end)
end

function p:OnHighlight(s,t,u,v)
s.MouseEnter:Connect(function()
local w=p.RegistryMap[t]

for x,y in next,u do
t[x]=p[y]or y

if w and w.Properties[x]then
w.Properties[x]=y
end
end
end)

s.MouseLeave:Connect(function()
local w=p.RegistryMap[t]

for x,y in next,v do
t[x]=p[y]or y

if w and w.Properties[x]then
w.Properties[x]=y
end
end
end)
end

function p:MouseIsOverOpenedFrame()
for s,t in next,p.OpenedFrames do
local u,v=s.AbsolutePosition,s.AbsoluteSize

if l.X>=u.X and l.X<=u.X+v.X
and l.Y>=u.Y and l.Y<=u.Y+v.Y then

return true
end
end
end

function p:IsMouseOverFrame(s)
local t,u=s.AbsolutePosition,s.AbsoluteSize

if l.X>=t.X and l.X<=t.X+u.X
and l.Y>=t.Y and l.Y<=t.Y+u.Y then

return true
end
end

function p:UpdateDependencyBoxes()
for s,t in next,p.DependencyBoxes do
t:Update()
end
end

function p:MapValue(s,t,u,v,w)
return(1-((s-t)/(u-t)))*v+((s-t)/(u-t))*w
end

function p:GetTextBounds(s,t,u,v)
local w=d:GetTextSize(s,u,t,v or Vector2.new(1920,1080))
return w.X,w.Y
end

function p:GetDarkerColor(s)
local t,u,v=Color3.toHSV(s)
return Color3.fromHSV(t,u,v/1.5)
end
p.AccentColorDark=p:GetDarkerColor(p.AccentColor)

function p:AddToRegistry(s,t,u)
local v=#p.Registry+1
local w={
Instance=s;
Properties=t;
Idx=v;
}

table.insert(p.Registry,w)
p.RegistryMap[s]=w

if u then
table.insert(p.HudRegistry,w)
end
end

function p:RemoveFromRegistry(s)
local t=p.RegistryMap[s]

if t then
for u=#p.Registry,1,-1 do
if p.Registry[u]==t then
table.remove(p.Registry,u)
end
end

for u=#p.HudRegistry,1,-1 do
if p.HudRegistry[u]==t then
table.remove(p.HudRegistry,u)
end
end

p.RegistryMap[s]=nil
end
end

function p:UpdateColorsUsingRegistry()











for s,t in next,p.Registry do
for u,v in next,t.Properties do
if type(v)=='string'then
t.Instance[u]=p[v]
elseif type(v)=='function'then
t.Instance[u]=v()
end
end
end
end

function p:GiveSignal(s)

table.insert(p.Signals,s)
end

function p:Unload()

for s=#p.Signals,1,-1 do
local t=table.remove(p.Signals,s)
t:Disconnect()
end


if p.OnUnload then
p.OnUnload()
end

m:Destroy()
end

function p:OnUnload(s)
p.OnUnload=s
end

p:GiveSignal(m.DescendantRemoving:Connect(function(s)
if p.RegistryMap[s]then
p:RemoveFromRegistry(s)
end
end))

local s={}

do
local t={}

function t:AddColorPicker(u,v)
local w,_,




x=self.TextLabel,v.Default,{
Value=v.Default;
Transparency=v.Transparency or 0;
Type='ColorPicker';
Title=type(v.Title)=='string'and v.Title or'Color picker',
Callback=v.Callback or function(x)end;
}

function x:SetHSVFromRGB(y)
local z,A,B=Color3.toHSV(y)

x.Hue=z
x.Sat=A
x.Vib=B
end

x:SetHSVFromRGB(x.Value)

local y=p:Create('Frame',{
BackgroundColor3=x.Value;
BorderColor3=p:GetDarkerColor(x.Value);
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(0,28,0,14);
ZIndex=6;
Parent=w;
})


p:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(0,27,0,13);
ZIndex=5;
Image='http://www.roblox.com/asset/?id=12977615774';
Visible=not not v.Transparency;
Parent=y;
})






local A=p:Create('Frame',{
Name='Color';
BackgroundColor3=Color3.new(1,1,1);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(y.AbsolutePosition.X,y.AbsolutePosition.Y+18),
Size=UDim2.fromOffset(230,v.Transparency and 271 or 253);
Visible=false;
ZIndex=15;
Parent=m,
})

y:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
A.Position=UDim2.fromOffset(y.AbsolutePosition.X,y.AbsolutePosition.Y+18)
end)

local B=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=16;
Parent=A;
})

local C,







D=p:Create('Frame',{BackgroundColor3=p.AccentColor;BorderSizePixel=0;Size=UDim2.new(1,0,0,2);ZIndex=17;Parent=B;}),p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,4,0,25);
Size=UDim2.new(0,200,0,200);
ZIndex=17;
Parent=B;
})

local E=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=D;
})

local F=p:Create('ImageLabel',{
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Image='rbxassetid://4155801252';
Parent=E;
})

local G=p:Create('ImageLabel',{
AnchorPoint=Vector2.new(0.5,0.5);
Size=UDim2.new(0,6,0,6);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ImageColor3=Color3.new(0,0,0);
ZIndex=19;
Parent=F;
})

p:Create('ImageLabel',{
Size=UDim2.new(0,G.Size.X.Offset-2,0,G.Size.Y.Offset-2);
Position=UDim2.new(0,1,0,1);
BackgroundTransparency=1;
Image='http://www.roblox.com/asset/?id=9619665977';
ZIndex=20;
Parent=G;
})

local I=p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,208,0,25);
Size=UDim2.new(0,15,0,200);
ZIndex=17;
Parent=B;
})

local J=p:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=18;
Parent=I;
})

local K,








L=p:Create('Frame',{BackgroundColor3=Color3.new(1,1,1);AnchorPoint=Vector2.new(0,0.5);BorderColor3=Color3.new(0,0,0);Size=UDim2.new(1,0,0,1);ZIndex=18;Parent=J;}),p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,228),
Size=UDim2.new(0.5,-6,0,20),
ZIndex=18,
Parent=B;
})

local M=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=18,
Parent=L;
})

p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=M;
})

local N=p:Create('TextBox',{
BackgroundTransparency=1;
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
Font=p.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText='Hex color',
Text='#FFFFFF',
TextColor3=p.FontColor;
TextSize=14;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=20,
Parent=M;
})

p:ApplyTextStroke(N)

local O=p:Create(L:Clone(),{
Position=UDim2.new(0.5,2,0,228),
Size=UDim2.new(0.5,-6,0,20),
Parent=B
})

local P,





Q,R,S=p:Create(O.Frame:FindFirstChild('TextBox'),{Text='255, 255, 255',PlaceholderText='RGB color',TextColor3=p.FontColor}),nil,nil,nil

if v.Transparency then
Q=p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(4,251);
Size=UDim2.new(1,-8,0,15);
ZIndex=19;
Parent=B;
})

R=p:Create('Frame',{
BackgroundColor3=x.Value;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=19;
Parent=Q;
})

p:AddToRegistry(R,{BorderColor3='OutlineColor'})

p:Create('ImageLabel',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Image='http://www.roblox.com/asset/?id=12978095818';
ZIndex=20;
Parent=R;
})

S=p:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
AnchorPoint=Vector2.new(0.5,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=21;
Parent=R;
})
end

p:CreateLabel({
Size=UDim2.new(1,0,0,14);
Position=UDim2.fromOffset(5,5);
TextXAlignment=Enum.TextXAlignment.Left;
TextSize=14;
Text=x.Title,
TextWrapped=false;
ZIndex=16;
Parent=B;
})


local U={}
do
U.Options={}
U.Container=p:Create('Frame',{
BorderColor3=Color3.new(),
ZIndex=14,

Visible=false,
Parent=m
})

U.Inner=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.fromScale(1,1);
ZIndex=15;
Parent=U.Container;
})

p:Create('UIListLayout',{
Name='Layout',
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=U.Inner;
})

p:Create('UIPadding',{
Name='Padding',
PaddingLeft=UDim.new(0,4),
Parent=U.Inner,
})local updateMenuPosition=function()


U.Container.Position=UDim2.fromOffset(
(y.AbsolutePosition.X+y.AbsoluteSize.X)+4,
y.AbsolutePosition.Y+1
)end local updateMenuSize=function()



local V=60
for W,X in next,U.Inner:GetChildren()do
if X:IsA('TextLabel')then
V=math.max(V,X.TextBounds.X)
end
end

U.Container.Size=UDim2.fromOffset(
V+8,
U.Inner.Layout.AbsoluteContentSize.Y+4
)end


y:GetPropertyChangedSignal('AbsolutePosition'):Connect(updateMenuPosition)
U.Inner.Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateMenuSize)

task.spawn(updateMenuPosition)
task.spawn(updateMenuSize)

p:AddToRegistry(U.Inner,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

function U:Show()
self.Container.Visible=true
end

function U:Hide()
self.Container.Visible=false
end

function U:AddOption(V,W)
if type(W)~='function'then
W=function()end
end

local X=p:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=13;
Text=V;
ZIndex=16;
Parent=self.Inner;
TextXAlignment=Enum.TextXAlignment.Left,
})

p:OnHighlight(X,X,
{TextColor3='AccentColor'},
{TextColor3='FontColor'}
)

X.InputBegan:Connect(function(Y)
if Y.UserInputType~=Enum.UserInputType.MouseButton1 then
return
end

W()
end)
end

U:AddOption('Copy color',function()
p.ColorClipboard=x.Value
p:Notify('Copied color!',2)
end)

U:AddOption('Paste color',function()
if not p.ColorClipboard then
return p:Notify('You have not copied a color!',2)
end
x:SetValueRGB(p.ColorClipboard)
end)


U:AddOption('Copy HEX',function()
pcall(setclipboard,x.Value:ToHex())
p:Notify('Copied hex code to clipboard!',2)
end)

U:AddOption('Copy RGB',function()
pcall(setclipboard,table.concat({math.floor(x.Value.R*255),math.floor(x.Value.G*255),math.floor(x.Value.B*255)},', '))
p:Notify('Copied RGB values to clipboard!',2)
end)

end

p:AddToRegistry(B,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';})
p:AddToRegistry(C,{BackgroundColor3='AccentColor';})
p:AddToRegistry(E,{BackgroundColor3='BackgroundColor';BorderColor3='OutlineColor';})

p:AddToRegistry(M,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';})
p:AddToRegistry(O.Frame,{BackgroundColor3='MainColor';BorderColor3='OutlineColor';})
p:AddToRegistry(P,{TextColor3='FontColor',})
p:AddToRegistry(N,{TextColor3='FontColor',})

local V={}

for W=0,1,0.1 do
table.insert(V,ColorSequenceKeypoint.new(W,Color3.fromHSV(W,1,1)))
end

p:Create('UIGradient',{
Color=ColorSequence.new(V);
Rotation=90;
Parent=J;
})

N.FocusLost:Connect(function(X)
if X then
local Y,Z=pcall(Color3.fromHex,N.Text)
if Y and typeof(Z)=='Color3'then
x.Hue,x.Sat,x.Vib=Color3.toHSV(Z)
end
end

x:Display()
end)

P.FocusLost:Connect(function(X)
if X then
local Y,Z,_=P.Text:match('(%d+),%s*(%d+),%s*(%d+)')
if Y and Z and _ then
x.Hue,x.Sat,x.Vib=Color3.toHSV(Color3.fromRGB(Y,Z,_))
end
end

x:Display()
end)

function x:Display()
x.Value=Color3.fromHSV(x.Hue,x.Sat,x.Vib)
F.BackgroundColor3=Color3.fromHSV(x.Hue,1,1)

p:Create(y,{
BackgroundColor3=x.Value;
BackgroundTransparency=x.Transparency;
BorderColor3=p:GetDarkerColor(x.Value);
})

if R then
R.BackgroundColor3=x.Value
S.Position=UDim2.new(1-x.Transparency,0,0,0)
end

G.Position=UDim2.new(x.Sat,0,1-x.Vib,0)
K.Position=UDim2.new(0,0,x.Hue,0)

N.Text='#'..x.Value:ToHex()
P.Text=table.concat({math.floor(x.Value.R*255),math.floor(x.Value.G*255),math.floor(x.Value.B*255)},', ')

p:SafeCallback(x.Callback,x.Value)
p:SafeCallback(x.Changed,x.Value)
end

function x:OnChanged(X)
x.Changed=X
X(x.Value)
end

function x:Show()
for X,Y in next,p.OpenedFrames do
if X.Name=='Color'then
X.Visible=false
p.OpenedFrames[X]=nil
end
end

A.Visible=true
p.OpenedFrames[A]=true
end

function x:Hide()
A.Visible=false
p.OpenedFrames[A]=nil
end

function x:SetValue(X,Y)
local Z=Color3.fromHSV(X[1],X[2],X[3])

x.Transparency=Y or 0
x:SetHSVFromRGB(Z)
x:Display()
end

function x:SetValueRGB(X,Y)
x.Transparency=Y or 0
x:SetHSVFromRGB(X)
x:Display()
end

F.InputBegan:Connect(function(X)
if X.UserInputType==Enum.UserInputType.MouseButton1 then
while c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local Y=F.AbsolutePosition.X
local Z=Y+F.AbsoluteSize.X
local _,

aa=math.clamp(l.X,Y,Z),F.AbsolutePosition.Y
local ab=aa+F.AbsoluteSize.Y
local ac=math.clamp(l.Y,aa,ab)

x.Sat=(_-Y)/(Z-Y)
x.Vib=1-((ac-aa)/(ab-aa))
x:Display()

j:Wait()
end

p:AttemptSave()
end
end)

J.InputBegan:Connect(function(aa)
if aa.UserInputType==Enum.UserInputType.MouseButton1 then
while c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local ab=J.AbsolutePosition.Y
local ac=ab+J.AbsoluteSize.Y
local X=math.clamp(l.Y,ab,ac)

x.Hue=((X-ab)/(ac-ab))
x:Display()

j:Wait()
end

p:AttemptSave()
end
end)

y.InputBegan:Connect(function(aa)
if aa.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
if A.Visible then
x:Hide()
else
U:Hide()
x:Show()
end
elseif aa.UserInputType==Enum.UserInputType.MouseButton2 and not p:MouseIsOverOpenedFrame()then
U:Show()
x:Hide()
end
end)

if R then
R.InputBegan:Connect(function(aa)
if aa.UserInputType==Enum.UserInputType.MouseButton1 then
while c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local ab=R.AbsolutePosition.X
local ac=ab+R.AbsoluteSize.X
local X=math.clamp(l.X,ab,ac)

x.Transparency=1-((X-ab)/(ac-ab))

x:Display()

j:Wait()
end

p:AttemptSave()
end
end)
end

p:GiveSignal(c.InputBegan:Connect(function(aa)
if aa.UserInputType==Enum.UserInputType.MouseButton1 then
local ab,ac=A.AbsolutePosition,A.AbsoluteSize

if l.X<ab.X or l.X>ab.X+ac.X
or l.Y<(ab.Y-20-1)or l.Y>ab.Y+ac.Y then

x:Hide()
end

if not p:IsMouseOverFrame(U.Container)then
U:Hide()
end
end

if aa.UserInputType==Enum.UserInputType.MouseButton2 and U.Container.Visible then
if not p:IsMouseOverFrame(U.Container)and not p:IsMouseOverFrame(y)then
U:Hide()
end
end
end))

x:Display()
x.DisplayFrame=y

o[u]=x

return self
end

function t:AddKeyPicker(aa,ab)
local ac,
u,_,_,




w=self,self.TextLabel,self.Container,ab.Default,{
Value=ab.Default;
Toggled=false;
Mode=ab.Mode or'Toggle';
Type='KeyPicker';
Callback=ab.Callback or function(w)end;
ChangedCallback=ab.ChangedCallback or function(w)end;

SyncToggleState=ab.SyncToggleState or false;
}

if w.SyncToggleState then
ab.Modes={'Toggle'}
ab.Mode='Toggle'
end

local x=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,28,0,15);
ZIndex=6;
Parent=u;
})

local y=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=7;
Parent=x;
})

p:AddToRegistry(y,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

local z,








A=p:CreateLabel({Size=UDim2.new(1,0,1,0);TextSize=13;Text=ab.Default;TextWrapped=true;ZIndex=8;Parent=y;}),p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.fromOffset(u.AbsolutePosition.X+u.AbsoluteSize.X+4,u.AbsolutePosition.Y+1);
Size=UDim2.new(0,60,0,45+2);
Visible=false;
ZIndex=14;
Parent=m;
})

u:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
A.Position=UDim2.fromOffset(u.AbsolutePosition.X+u.AbsoluteSize.X+4,u.AbsolutePosition.Y+1)
end)

local B=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=15;
Parent=A;
})

p:AddToRegistry(B,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=B;
})

local C,








D,
E=p:CreateLabel({TextXAlignment=Enum.TextXAlignment.Left;Size=UDim2.new(1,0,0,18);TextSize=13;Visible=false;ZIndex=110;Parent=p.KeybindContainer;},true),ab.Modes or{'Always','Toggle','Hold'},{}

for F,G in next,D do
local H,

I={},p:CreateLabel({
Active=false;
Size=UDim2.new(1,0,0,15);
TextSize=13;
Text=G;
ZIndex=16;
Parent=B;
})

function H:Select()
for J,K in next,E do
K:Deselect()
end

w.Mode=G

I.TextColor3=p.AccentColor
p.RegistryMap[I].Properties.TextColor3='AccentColor'

A.Visible=false
end

function H:Deselect()
w.Mode=nil

I.TextColor3=p.FontColor
p.RegistryMap[I].Properties.TextColor3='FontColor'
end

I.InputBegan:Connect(function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 then
H:Select()
p:AttemptSave()
end
end)

if G==w.Mode then
H:Select()
end

E[G]=H
end

function w:Update()
if ab.NoUI then
return
end

local H=w:GetState()

C.Text=string.format('[%s] %s (%s)',w.Value,ab.Text,w.Mode)

C.Visible=true
C.TextColor3=H and p.AccentColor or p.FontColor

p.RegistryMap[C].Properties.TextColor3=H and'AccentColor'or'FontColor'

local I,
J=0,0

for K,L in next,p.KeybindContainer:GetChildren()do
if L:IsA('TextLabel')and L.Visible then
I=I+18
if(L.TextBounds.X>J)then
J=L.TextBounds.X
end
end
end

p.KeybindFrame.Size=UDim2.new(0,math.max(J+10,210),0,I+23)
end

function w:GetState()
if w.Mode=='Always'then
return true
elseif w.Mode=='Hold'then
if w.Value=='None'then
return false
end

local H=w.Value

if H=='MB1'or H=='MB2'then
return H=='MB1'and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
or H=='MB2'and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
else
return c:IsKeyDown(Enum.KeyCode[w.Value])
end
else
return w.Toggled
end
end

function w:SetValue(H)
local I,J=H[1],H[2]
z.Text=I
w.Value=I
E[J]:Select()
w:Update()
end

function w:OnClick(H)
w.Clicked=H
end

function w:OnChanged(H)
w.Changed=H
H(w.Value)
end

if ac.Addons then
table.insert(ac.Addons,w)
end

function w:DoClick()
if ac.Type=='Toggle'and w.SyncToggleState then
ac:SetValue(not ac.Value)
end

p:SafeCallback(w.Callback,w.Toggled)
p:SafeCallback(w.Clicked,w.Toggled)
end

local H=false

x.InputBegan:Connect(function(I)
if I.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
H=true

z.Text=''

local J,
K=nil,''

task.spawn(function()
while(not J)do
if K=='...'then
K=''
end

K=K..'.'
z.Text=K

wait(0.4)
end
end)

wait(0.2)

local L
L=c.InputBegan:Connect(function(M)
local N

if M.UserInputType==Enum.UserInputType.Keyboard then
N=M.KeyCode.Name
elseif M.UserInputType==Enum.UserInputType.MouseButton1 then
N='MB1'
elseif M.UserInputType==Enum.UserInputType.MouseButton2 then
N='MB2'
end

J=true
H=false

z.Text=N
w.Value=N

p:SafeCallback(w.ChangedCallback,M.KeyCode or M.UserInputType)
p:SafeCallback(w.Changed,M.KeyCode or M.UserInputType)

p:AttemptSave()

L:Disconnect()
end)
elseif I.UserInputType==Enum.UserInputType.MouseButton2 and not p:MouseIsOverOpenedFrame()then
A.Visible=true
end
end)

p:GiveSignal(c.InputBegan:Connect(function(I)
if(not H)then
if w.Mode=='Toggle'then
local J=w.Value

if J=='MB1'or J=='MB2'then
if J=='MB1'and I.UserInputType==Enum.UserInputType.MouseButton1
or J=='MB2'and I.UserInputType==Enum.UserInputType.MouseButton2 then
w.Toggled=not w.Toggled
w:DoClick()
end
elseif I.UserInputType==Enum.UserInputType.Keyboard then
if I.KeyCode.Name==J then
w.Toggled=not w.Toggled
w:DoClick()
end
end
end

w:Update()
end

if I.UserInputType==Enum.UserInputType.MouseButton1 then
local J,K=A.AbsolutePosition,A.AbsoluteSize

if l.X<J.X or l.X>J.X+K.X
or l.Y<(J.Y-20-1)or l.Y>J.Y+K.Y then

A.Visible=false
end
end
end))

p:GiveSignal(c.InputEnded:Connect(function(I)
if(not H)then
w:Update()
end
end))

w:Update()

o[F]=w

return self
end

s.__index=t
s.__namecall=function(aa,ab,...)
return t[ab](...)
end
end

local aa={}

do
local ab={}

function ab:AddBlank(ac)
local t=self
local u=t.Container

p:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,0,ac);
ZIndex=1;
Parent=u;
})
end

function ab:AddLabel(ac,t)
local u,

v={},self
local w=v.Container

local x=p:CreateLabel({
Size=UDim2.new(1,-4,0,15);
TextSize=14;
Text=ac;
TextWrapped=t or false,
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=w;
})

if t then
local y=select(2,p:GetTextBounds(ac,p.Font,14,Vector2.new(x.AbsoluteSize.X,math.huge)))
x.Size=UDim2.new(1,-4,0,y)
else
p:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Right;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=x;
})
end

u.TextLabel=x
u.Container=w

function u:SetText(y)
x.Text=y

if t then
local z=select(2,p:GetTextBounds(y,p.Font,14,Vector2.new(x.AbsoluteSize.X,math.huge)))
x.Size=UDim2.new(1,-4,0,z)
end

v:Resize()
end

if(not t)then
setmetatable(u,s)
end

v:AddBlank(5)
v:Resize()

return u
end

function ab:AddSpacer(ac)
local t,

u={},self
local v=u.Container

local w=p:Create('Frame',{
Size=UDim2.new(1,-4,0,ac or 10);
BackgroundTransparency=1;
Parent=v;
ZIndex=5;
})

t.Frame=w
t.Container=v

function t:SetHeight(x)
w.Size=UDim2.new(1,-4,0,x)
u:Resize()
end

u:AddBlank(5)
u:Resize()

return t
end



function ab:AddButton(...)

local ac={}local ProcessButtonParams=function(
t, u, ...)
local v=select(1,...)
if type(v)=='table'then
u.Text=v.Text
u.Func=v.Func
u.DoubleClick=v.DoubleClick
u.Tooltip=v.Tooltip
else
u.Text=select(1,...)
u.Func=select(2,...)
end local _=

type(u.Func)=='function'end


ProcessButtonParams('Button',ac,...)

local t=self
local u=t.Container local CreateBaseButton=function(

v)
local w=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
})

local x=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=w;
})

local y=p:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=14;
Text=v.Text;
ZIndex=6;
Parent=x;
})

p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=x;
})

p:AddToRegistry(w,{
BorderColor3='Black';
})

p:AddToRegistry(x,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

p:OnHighlight(w,w,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
)

return w,x,y end local InitEvents=function(


v)local WaitForEvent=function(
w, x, y)
local z=Instance.new('BindableEvent')
local A=w:Once(function(...)

if type(y)=='function'and y(...)then
z:Fire(true)
else
z:Fire(false)
end
end)
task.delay(x,function()
A:disconnect()
z:Fire(false)
end)
return z.Event:Wait()end local ValidateClick=function(


w)
if p:MouseIsOverOpenedFrame()then
return false
end

if w.UserInputType~=Enum.UserInputType.MouseButton1 then
return false
end

return true end


v.Outer.InputBegan:Connect(function(w)
if not ValidateClick(w)then return end
if v.Locked then return end

if v.DoubleClick then
p:RemoveFromRegistry(v.Label)
p:AddToRegistry(v.Label,{TextColor3='AccentColor'})

v.Label.TextColor3=p.AccentColor
v.Label.Text='Are you sure?'
v.Locked=true

local x=WaitForEvent(v.Outer.InputBegan,0.5,ValidateClick)

p:RemoveFromRegistry(v.Label)
p:AddToRegistry(v.Label,{TextColor3='FontColor'})

v.Label.TextColor3=p.FontColor
v.Label.Text=v.Text
task.defer(rawset,v,'Locked',false)

if x then
p:SafeCallback(v.Func)
end

return
end

p:SafeCallback(v.Func)
end)end


ac.Outer,ac.Inner,ac.Label=CreateBaseButton(ac)
ac.Outer.Parent=u

InitEvents(ac)

function ac:AddTooltip(v)
if type(v)=='string'then
p:AddToolTip(v,self.Outer)
end
return self
end


function ac:AddButton(...)
local v={}

ProcessButtonParams('SubButton',v,...)

self.Outer.Size=UDim2.new(0.5,-2,0,20)

v.Outer,v.Inner,v.Label=CreateBaseButton(v)

v.Outer.Position=UDim2.new(1,3,0,0)
v.Outer.Size=UDim2.fromOffset(self.Outer.AbsoluteSize.X-2,self.Outer.AbsoluteSize.Y)
v.Outer.Parent=self.Outer

function v:AddTooltip(w)
if type(w)=='string'then
p:AddToolTip(w,self.Outer)
end
return v
end

if type(v.Tooltip)=='string'then
v:AddTooltip(v.Tooltip)
end

InitEvents(v)
return v
end

if type(ac.Tooltip)=='string'then
ac:AddTooltip(ac.Tooltip)
end

t:AddBlank(5)
t:Resize()

return ac
end

function ab:AddDivider()
local ac,
t=self,self.Container





ac:AddBlank(2)
local v=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,5);
ZIndex=5;
Parent=t;
})

local w=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=v;
})

p:AddToRegistry(v,{
BorderColor3='Black';
})

p:AddToRegistry(w,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

ac:AddBlank(9)
ac:Resize()
end

function ab:AddInput(ac,t)local _, 


u, 







v=t.Text, {Value=t.Default or'';Numeric=t.Numeric or false;Finished=t.Finished or false;Type='Input';Callback=t.Callback or function(u)end;}, self
local w=v.Container

p:CreateLabel({
Size=UDim2.new(1,0,0,15);
TextSize=14;
Text=t.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=5;
Parent=w;
})

v:AddBlank(1)

local y=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=w;
})

local z=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=y;
})

p:AddToRegistry(z,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

p:OnHighlight(y,y,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
)

if type(t.Tooltip)=='string'then
p:AddToolTip(t.Tooltip,y)
end

p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=z;
})

local A=p:Create('Frame',{
BackgroundTransparency=1;
ClipsDescendants=true;

Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);

ZIndex=7;
Parent=z;
})

local B=p:Create('TextBox',{
BackgroundTransparency=1;

Position=UDim2.fromOffset(0,0),
Size=UDim2.fromScale(5,1),

Font=p.Font;
PlaceholderColor3=Color3.fromRGB(190,190,190);
PlaceholderText=t.Placeholder or'';

Text=t.Default or'';
TextColor3=p.FontColor;
TextSize=14;
TextStrokeTransparency=0;
TextXAlignment=Enum.TextXAlignment.Left;

ZIndex=7;
Parent=A;
})

p:ApplyTextStroke(B)

function u:SetValue(C)
if t.MaxLength and#C>t.MaxLength then
C=C:sub(1,t.MaxLength)
end

if u.Numeric then
if(not tonumber(C))and C:len()>0 then
C=u.Value
end
end

u.Value=C
B.Text=C

p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)
end

if u.Finished then
B.FocusLost:Connect(function(C)
if not C then return end

u:SetValue(B.Text)
p:AttemptSave()
end)
else
B:GetPropertyChangedSignal('Text'):Connect(function()
u:SetValue(B.Text)
p:AttemptSave()
end)
end local Update=function()





local C,
D=2,A.AbsoluteSize.X

if not B:IsFocused()or B.TextBounds.X<=D-2*C then

B.Position=UDim2.new(0,C,0,0)
else

local E=B.CursorPosition
if E~=-1 then

local F=string.sub(B.Text,1,E-1)
local G=d:GetTextSize(F,B.TextSize,B.Font,Vector2.new(math.huge,math.huge)).X


local H=B.Position.X.Offset+G


if H<C then
B.Position=UDim2.fromOffset(C-G,0)
elseif H>D-C-1 then
B.Position=UDim2.fromOffset(D-G-C-1,0)
end
end
end end


task.spawn(Update)

B:GetPropertyChangedSignal('Text'):Connect(Update)
B:GetPropertyChangedSignal('CursorPosition'):Connect(Update)
B.FocusLost:Connect(Update)
B.Focused:Connect(Update)

p:AddToRegistry(B,{
TextColor3='FontColor';
})

function u:OnChanged(C)
u.Changed=C
C(u.Value)
end

v:AddBlank(5)
v:Resize()

o[ac]=u

return u
end

function ab:AddToggle(ac,t)local _, 


u, 








v=t.Text, {Value=t.Default or false;Type='Toggle';Callback=t.Callback or function(u)end;Addons={},Risky=t.Risky,}, self
local x=v.Container

local y=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0,13,0,13);
ZIndex=5;
Parent=x;
})

p:AddToRegistry(y,{
BorderColor3='Black';
})

local z=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=y;
})

p:AddToRegistry(z,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

local A=p:CreateLabel({
Size=UDim2.new(0,216,1,0);
Position=UDim2.new(1,6,0,0);
TextSize=14;
Text=t.Text;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=6;
Parent=z;
})

p:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Right;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=A;
})

local B=p:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(0,170,1,0);
ZIndex=8;
Parent=y;
})

p:OnHighlight(B,y,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
)

function u:UpdateColors()
u:Display()
end

if type(t.Tooltip)=='string'then
p:AddToolTip(t.Tooltip,B)
end

function u:Display()
z.BackgroundColor3=u.Value and p.AccentColor or p.MainColor
z.BorderColor3=u.Value and p.AccentColorDark or p.OutlineColor

p.RegistryMap[z].Properties.BackgroundColor3=u.Value and'AccentColor'or'MainColor'
p.RegistryMap[z].Properties.BorderColor3=u.Value and'AccentColorDark'or'OutlineColor'
end

function u:OnChanged(C)
u.Changed=C
C(u.Value)
end

function u:SetValue(C)
C=(not not C)

u.Value=C
u:Display()

for D,E in next,u.Addons do
if E.Type=='KeyPicker'and E.SyncToggleState then
E.Toggled=C
E:Update()
end
end

p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)
p:UpdateDependencyBoxes()
end

B.InputBegan:Connect(function(C)
if C.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
u:SetValue(not u.Value)
p:AttemptSave()
end
end)

if u.Risky then
p:RemoveFromRegistry(A)
A.TextColor3=p.RiskColor
p:AddToRegistry(A,{TextColor3='RiskColor'})
end

u:Display()
v:AddBlank(t.BlankSize or 5+2)
v:Resize()

u.TextLabel=A
u.Container=x
setmetatable(u,s)

n[ac]=u

p:UpdateDependencyBoxes()

return u
end

function ab:AddSlider(ac,t)local _, _, _, _, _, 






u, 









v=t.Default, t.Text, t.Min, t.Max, t.Rounding, {Value=t.Default;Min=t.Min;Max=t.Max;Rounding=t.Rounding;MaxSize=232;Type='Slider';Callback=t.Callback or function(u)end;}, self
local x=v.Container

if not t.Compact then
p:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=14;
Text=t.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=x;
})

v:AddBlank(3)
end

local y=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,13);
ZIndex=5;
Parent=x;
})

p:AddToRegistry(y,{
BorderColor3='Black';
})

local z=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=y;
})

p:AddToRegistry(z,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

local A=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderColor3=p.AccentColorDark;
Size=UDim2.new(0,0,1,0);
ZIndex=7;
Parent=z;
})

p:AddToRegistry(A,{
BackgroundColor3='AccentColor';
BorderColor3='AccentColorDark';
})

local B=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(1,0,0,0);
Size=UDim2.new(0,1,1,0);
ZIndex=8;
Parent=A;
})

p:AddToRegistry(B,{
BackgroundColor3='AccentColor';
})

local C=p:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=14;
Text='Infinite';
ZIndex=9;
Parent=z;
})

p:OnHighlight(y,y,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
)

if type(t.Tooltip)=='string'then
p:AddToolTip(t.Tooltip,y)
end

function u:UpdateColors()
A.BackgroundColor3=p.AccentColor
A.BorderColor3=p.AccentColorDark
end

function u:Display()
local D=t.Suffix or''

if t.Compact then
C.Text=t.Text..': '..u.Value..D
elseif t.HideMax then
C.Text=string.format('%s',u.Value..D)
else
C.Text=string.format('%s/%s',u.Value..D,u.Max..D)
end

local E=math.ceil(p:MapValue(u.Value,u.Min,u.Max,0,u.MaxSize))
A.Size=UDim2.new(0,E,1,0)

B.Visible=not(E==u.MaxSize or E==0)
end

function u:OnChanged(D)
u.Changed=D
D(u.Value)
end local Round=function(

D)
if u.Rounding==0 then
return math.floor(D)
end


return tonumber(string.format('%.'..u.Rounding..'f',D))end


function u:GetValueFromXOffset(D)
return Round(p:MapValue(D,0,u.MaxSize,u.Min,u.Max))
end

function u:SetValue(D)
local E=tonumber(D)

if(not E)then
return
end

E=math.clamp(E,u.Min,u.Max)

u.Value=E
u:Display()

p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)
end

z.InputBegan:Connect(function(D)
if D.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
local E,
F=l.X,A.Size.X.Offset
local G=E-(A.AbsolutePosition.X+F)

while c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local H=l.X
local I=math.clamp(F+(H-E)+G,0,u.MaxSize)

local J,
K=u:GetValueFromXOffset(I),u.Value
u.Value=J

u:Display()

if J~=K then
p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)
end

j:Wait()
end

p:AttemptSave()
end
end)

u:Display()
v:AddBlank(t.BlankSize or 6)
v:Resize()

o[ac]=u

return u
end

function ab:AddDropdown(ac,t)
if t.SpecialType=='Player'then
t.Values=GetPlayersString()
t.AllowNull=true
elseif t.SpecialType=='Team'then
t.Values=GetTeamsString()
t.AllowNull=true
end local _, _=

t.Values, 
t.AllowNull or t.Default

if(not t.Text)then
t.Compact=true
end

local u,








v={Values=t.Values;Value=t.Multi and{};Multi=t.Multi;Type='Dropdown';SpecialType=t.SpecialType;Callback=t.Callback or function(u)end;},self
local x,

y=v.Container,0

if not t.Compact then
p:CreateLabel({
Size=UDim2.new(1,0,0,10);
TextSize=14;
Text=t.Text;
TextXAlignment=Enum.TextXAlignment.Left;
TextYAlignment=Enum.TextYAlignment.Bottom;
ZIndex=5;
Parent=x;
})

v:AddBlank(3)
end

for z,A in next,x:GetChildren()do
if not A:IsA('UIListLayout')then
y=y+A.Size.Y.Offset
end
end

local B=p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-4,0,20);
ZIndex=5;
Parent=x;
})

p:AddToRegistry(B,{
BorderColor3='Black';
})

local C=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=6;
Parent=B;
})

p:AddToRegistry(C,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(212,212,212))
});
Rotation=90;
Parent=C;
})

local D,









E=p:Create('ImageLabel',{AnchorPoint=Vector2.new(0,0.5);BackgroundTransparency=1;Position=UDim2.new(1,-16,0.5,0);Size=UDim2.new(0,12,0,12);Image='http://www.roblox.com/asset/?id=6282522798';ZIndex=8;Parent=C;}),p:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-5,1,0);
TextSize=14;
Text='--';
TextXAlignment=Enum.TextXAlignment.Left;
TextWrapped=true;
ZIndex=7;
Parent=C;
})

p:OnHighlight(B,B,
{BorderColor3='AccentColor'},
{BorderColor3='Black'}
)

if type(t.Tooltip)=='string'then
p:AddToolTip(t.Tooltip,B)
end

local F,

G=8,p:Create('Frame',{
BackgroundColor3=Color3.new(0,0,0);
BorderColor3=Color3.new(0,0,0);
ZIndex=20;
Visible=false;
Parent=m;
})local RecalculateListPosition=function()


G.Position=UDim2.fromOffset(B.AbsolutePosition.X,B.AbsolutePosition.Y+B.Size.Y.Offset+1)end local RecalculateListSize=function(


H)
G.Size=UDim2.fromOffset(B.AbsoluteSize.X,H or(F*20+2))end


RecalculateListPosition()
RecalculateListSize()

B:GetPropertyChangedSignal('AbsolutePosition'):Connect(RecalculateListPosition)

local H=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
BorderSizePixel=0;
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=G;
})

p:AddToRegistry(H,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

local I=p:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
CanvasSize=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=21;
Parent=H;

TopImage='rbxasset://textures/ui/Scroll/scroll-middle.png',
BottomImage='rbxasset://textures/ui/Scroll/scroll-middle.png',

ScrollBarThickness=3,
ScrollBarImageColor3=p.AccentColor,
})

p:AddToRegistry(I,{
ScrollBarImageColor3='AccentColor'
})

p:Create('UIListLayout',{
Padding=UDim.new(0,0);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=I;
})

function u:Display()
local J,
K=u.Values,''

if t.Multi then
for L,M in next,J do
if u.Value[M]then
K=K..M..', '
end
end

K=K:sub(1,#K-2)
else
K=u.Value or''
end

E.Text=(K==''and'--'or K)
end

function u:GetActiveValues()
if t.Multi then
local J={}

for K,L in next,u.Value do
table.insert(J,K)
end

return J
else
return u.Value and 1 or 0
end
end

function u:BuildDropdownList()
local J,
K=u.Values,{}

for L,M in next,I:GetChildren()do
if not M:IsA('UIListLayout')then
M:Destroy()
end
end

local N=0

for O,P in next,J do
local Q={}

N=N+1

local R=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Middle;
Size=UDim2.new(1,-1,0,20);
ZIndex=23;
Active=true,
Parent=I;
})

p:AddToRegistry(R,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})

local S=p:CreateLabel({
Active=false;
Size=UDim2.new(1,-6,1,0);
Position=UDim2.new(0,6,0,0);
TextSize=14;
Text=P;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=25;
Parent=R;
})

p:OnHighlight(R,R,
{BorderColor3='AccentColor',ZIndex=24},
{BorderColor3='OutlineColor',ZIndex=23}
)

local T

if t.Multi then
T=u.Value[P]
else
T=u.Value==P
end

function Q:UpdateButton()
if t.Multi then
T=u.Value[P]
else
T=u.Value==P
end

S.TextColor3=T and p.AccentColor or p.FontColor
p.RegistryMap[S].Properties.TextColor3=T and'AccentColor'or'FontColor'
end

S.InputBegan:Connect(function(U)
if U.UserInputType==Enum.UserInputType.MouseButton1 then
local V=not T

if u:GetActiveValues()==1 and(not V)and(not t.AllowNull)then
else
if t.Multi then
T=V

if T then
u.Value[P]=true
else
u.Value[P]=nil
end
else
T=V

if T then
u.Value=P
else
u.Value=nil
end

for W,X in next,K do
X:UpdateButton()
end
end

Q:UpdateButton()
u:Display()

p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)

p:AttemptSave()
end
end
end)

Q:UpdateButton()
u:Display()

K[R]=Q
end

I.CanvasSize=UDim2.fromOffset(0,(N*20)+1)

local Q=math.clamp(N*20,0,F*20)+1
RecalculateListSize(Q)
end

function u:SetValues(J)
if J then
u.Values=J
end

u:BuildDropdownList()
end

function u:OpenDropdown()
G.Visible=true
p.OpenedFrames[G]=true
D.Rotation=180
end

function u:CloseDropdown()
G.Visible=false
p.OpenedFrames[G]=nil
D.Rotation=0
end

function u:OnChanged(J)
u.Changed=J
J(u.Value)
end

function u:SetValue(J)
if u.Multi then
local K={}

for L,M in next,J do
if table.find(u.Values,L)then
K[L]=true
end
end

u.Value=K
else
if(not J)then
u.Value=nil
elseif table.find(u.Values,J)then
u.Value=J
end
end

u:BuildDropdownList()

p:SafeCallback(u.Callback,u.Value)
p:SafeCallback(u.Changed,u.Value)
end

B.InputBegan:Connect(function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
if G.Visible then
u:CloseDropdown()
else
u:OpenDropdown()
end
end
end)

c.InputBegan:Connect(function(J)
if J.UserInputType==Enum.UserInputType.MouseButton1 then
local K,L=G.AbsolutePosition,G.AbsoluteSize

if l.X<K.X or l.X>K.X+L.X
or l.Y<(K.Y-20-1)or l.Y>K.Y+L.Y then

u:CloseDropdown()
end
end
end)

u:BuildDropdownList()
u:Display()

local J={}

if type(t.Default)=='string'then
local K=table.find(u.Values,t.Default)
if K then
table.insert(J,K)
end
elseif type(t.Default)=='table'then
for K,L in next,t.Default do
local M=table.find(u.Values,L)
if M then
table.insert(J,M)
end
end
elseif type(t.Default)=='number'and u.Values[t.Default]~=nil then
table.insert(J,t.Default)
end

if next(J)then
for K=1,#J do
local L=J[K]
if t.Multi then
u.Value[u.Values[L] ]=true
else
u.Value=u.Values[L]
end

if(not t.Multi)then break end
end

u:BuildDropdownList()
u:Display()
end

v:AddBlank(t.BlankSize or 5)
v:Resize()

o[ac]=u

return u
end

function ab:AddDependencyBox()
local ac,



t={Dependencies={};},self
local u=t.Container

local v=p:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,0,0);
Visible=false;
Parent=u;
})

local x=p:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,0);
Visible=true;
Parent=v;
})

local y=p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=x;
})

function ac:Resize()
v.Size=UDim2.new(1,0,0,y.AbsoluteContentSize.Y)
t:Resize()
end

y:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
ac:Resize()
end)

v:GetPropertyChangedSignal('Visible'):Connect(function()
ac:Resize()
end)

function ac:Update()
for z,A in next,ac.Dependencies do
local B,
C=A[1],A[2]

if B.Type=='Toggle'and B.Value~=C then
v.Visible=false
ac:Resize()
return
end
end

v.Visible=true
ac:Resize()
end

function ac:SetupDependencies(z)
for A,B in next,z do local _, _, _=
type(B)=='table', 
B[1], 
B[2]~=nil
end

ac.Dependencies=z
ac:Update()
end

ac.Container=x

setmetatable(ac,aa)

table.insert(p.DependencyBoxes,ac)

return ac
end

aa.__index=ab
aa.__namecall=function(ac,t,...)
return ab[t](...)
end
end


do
p.NotificationArea=p:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,40);
Size=UDim2.new(0,300,0,200);
ZIndex=100;
Parent=m;
})

p:Create('UIListLayout',{
Padding=UDim.new(0,4);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=p.NotificationArea;
})

local ab=p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,100,0,-25);
Size=UDim2.new(0,213,0,20);
ZIndex=200;
Visible=false;
Parent=m;
})

local ac=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.AccentColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=201;
Parent=ab;
})

p:AddToRegistry(ac,{
BorderColor3='AccentColor';
})

local t=p:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=202;
Parent=ac;
})

local u=p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,p:GetDarkerColor(p.MainColor)),
ColorSequenceKeypoint.new(1,p.MainColor),
});
Rotation=-90;
Parent=t;
})

p:AddToRegistry(u,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,p:GetDarkerColor(p.MainColor)),
ColorSequenceKeypoint.new(1,p.MainColor),
})
end
})

local v=p:CreateLabel({
Position=UDim2.new(0,5,0,0);
Size=UDim2.new(1,-4,1,0);
TextSize=14;
TextXAlignment=Enum.TextXAlignment.Left;
ZIndex=203;
Parent=t;
})

p.Watermark=ab
p.WatermarkText=v
p:MakeDraggable(p.Watermark)



local x=p:Create('Frame',{
AnchorPoint=Vector2.new(0,0.5);
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,10,0.5,0);
Size=UDim2.new(0,210,0,20);
Visible=false;
ZIndex=100;
Parent=m;
})

local y=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=x;
})

p:AddToRegistry(y,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true)

local z=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=102;
Parent=y;
})

p:AddToRegistry(z,{
BackgroundColor3='AccentColor';
},true)

p:CreateLabel({
Size=UDim2.new(1,0,0,20);
Position=UDim2.fromOffset(5,2),
TextXAlignment=Enum.TextXAlignment.Left,

Text='Keybinds';
ZIndex=104;
Parent=y;
})

local B=p:Create('Frame',{
BackgroundTransparency=1;
Size=UDim2.new(1,0,1,-20);
Position=UDim2.new(0,0,0,20);
ZIndex=1;
Parent=y;
})

p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=B;
})

p:Create('UIPadding',{
PaddingLeft=UDim.new(0,5),
Parent=B,
})

p.KeybindFrame=x
p.KeybindContainer=B
p:MakeDraggable(x)
end

function p:SetWatermarkVisibility(ab)
p.Watermark.Visible=ab
end

function p:SetWatermark(ab)
local ac,t=p:GetTextBounds(ab,p.Font,14)
p.Watermark.Size=UDim2.new(0,ac+15,0,(t*1.5)+3)
p:SetWatermarkVisibility(true)

p.WatermarkText.Text=ab
end









function p:Notify(ab,ac)
local t,u=p:GetTextBounds(ab,p.Font,14)

u=u+7

local v=p:Create('Frame',{
BorderColor3=Color3.new(0,0,0);
Position=UDim2.new(0,100,0,10);
Size=UDim2.new(0,0,0,u);
ClipsDescendants=true;
ZIndex=100;
Parent=p.NotificationArea;
})

local x=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,1,0);
ZIndex=101;
Parent=v;
})

p:AddToRegistry(x,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
},true)

local y=p:Create('Frame',{
BackgroundColor3=Color3.new(1,1,1);
BorderSizePixel=0;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=102;
Parent=x;
})

local z=p:Create('UIGradient',{
Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,p:GetDarkerColor(p.MainColor)),
ColorSequenceKeypoint.new(1,p.MainColor),
});
Rotation=-90;
Parent=y;
})

p:AddToRegistry(z,{
Color=function()
return ColorSequence.new({
ColorSequenceKeypoint.new(0,p:GetDarkerColor(p.MainColor)),
ColorSequenceKeypoint.new(1,p.MainColor),
})
end
})

p:CreateLabel({
Position=UDim2.new(0,4,0,0);
Size=UDim2.new(1,-4,1,0);
Text=ab;
TextXAlignment=Enum.TextXAlignment.Left;
TextSize=14;
ZIndex=103;
Parent=y;
})

local B=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderSizePixel=0;
Position=UDim2.new(0,-1,0,-1);
Size=UDim2.new(0,3,1,2);
ZIndex=104;
Parent=v;
})

p:AddToRegistry(B,{
BackgroundColor3='AccentColor';
},true)

pcall(v.TweenSize,v,UDim2.new(0,t+8+4,0,u),'Out','Quad',0.4,true)

task.spawn(function()
wait(ac or 5)

pcall(v.TweenSize,v,UDim2.new(0,0,0,u),'Out','Quad',0.4,true)

wait(0.4)

v:Destroy()
end)
end

function p:CreateWindow(...)
local ab,
ac={...},{AnchorPoint=Vector2.zero}

if type(...)=='table'then
ac=...
else
ac.Title=ab[1]
ac.Version=ab[2]
ac.AutoShow=ab[3]or false
end

if type(ac.Title)~='string'then ac.Title='No title'end
if type(ac.Version)~='string'then ac.Version=''end
if type(ac.MenuFadeTime)~='number'then ac.MenuFadeTime=0.2 end

if typeof(ac.Position)~='UDim2'then ac.Position=UDim2.fromOffset(175,50)end
if type(ac.Size)~='UDim2'then ac.Size=UDim2.fromOffset(550,570)end

if ac.Center then
ac.AnchorPoint=Vector2.new(0.5,0.5)
ac.Position=UDim2.fromScale(0.5,0.5)
end

local t,



u,










v={Tabs={};},p:Create('Frame',{AnchorPoint=ac.AnchorPoint,BackgroundColor3=Color3.new(0,0,0);BorderSizePixel=0;Position=ac.Position,Size=ac.Size,Visible=false;ZIndex=1;Parent=m;}),UDim2.new(
ac.Size.X.Scale,
ac.Size.X.Offset+57,
ac.Size.Y.Scale,
ac.Size.Y.Offset+57
)
local x=p:Create('ImageLabel',{
AnchorPoint=ac.AnchorPoint,
BackgroundTransparency=1,
Position=ac.Position,
Size=v,
Image='rbxassetid://6015897843',
ImageColor3=p.AccentColor,
ImageTransparency=0,
ZIndex=1,
Parent=u,
BackgroundColor3=Color3.fromRGB(255,255,255),
BorderColor3=Color3.fromRGB(0,0,0),
BorderSizePixel=0,
})

p:MakeDraggable(u,25)

local y=p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.AccentColor;
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,1,0,1);
Size=UDim2.new(1,-2,1,-2);
ZIndex=1;
Parent=u;
})

p:AddToRegistry(y,{
BackgroundColor3='MainColor';
BorderColor3='AccentColor';
})

p:AddToRegistry(x,{
ImageColor3='AccentColor';
})

local z,










A=p:CreateLabel({Position=UDim2.new(0,0,0,0);Size=UDim2.new(1,0,0,25);Text=if ac.Version and ac.Version~=""then ac.Title.." | v"..ac.Version else ac.Title;TextXAlignment=Enum.TextXAlignment.Center;ZIndex=1;Parent=y;RichText=true;}),p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
Position=UDim2.new(0,8,0,25);
Size=UDim2.new(1,-16,1,-33);
ZIndex=1;
Parent=y;
})

p:AddToRegistry(A,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

local B=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
BorderMode=Enum.BorderMode.Inset;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
ZIndex=1;
Parent=A;
})

p:AddToRegistry(B,{
BackgroundColor3='BackgroundColor';
})

local C=p:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,8,0,8);
Size=UDim2.new(1,-16,0,40);
ZIndex=1;
Parent=B;
})

local D,







E=p:Create('UIListLayout',{Padding=UDim.new(0,0);FillDirection=Enum.FillDirection.Horizontal;HorizontalAlignment=Enum.HorizontalAlignment.Center;SortOrder=Enum.SortOrder.LayoutOrder;Parent=C;}),p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=p.OutlineColor;
Position=UDim2.new(0,8,0,54);
Size=UDim2.new(1,-16,1,-60);
ZIndex=2;
Parent=B;
})


p:AddToRegistry(E,{
BackgroundColor3='MainColor';
BorderColor3='OutlineColor';
})


function t:SetWindowTitle(F)
z.Text=F
end local UpdateTabButtonSizes=function()


local F=#t.Tabs
if F==0 then return end

local G,
H=C.AbsoluteSize.X,0*(F-1)
local I=(G-H)/F

for J,K in ipairs(t.Tabs)do
K.Button.Size=UDim2.new(0,I,1,0)
end end


function t:AddTab(F)
local G,




H={Groupboxes={};Tabboxes={};},p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
Size=UDim2.new(0,100,1,0);
LayoutOrder=#t.Tabs+1;
ZIndex=1;
Parent=C;
})

G.Button=H

p:AddToRegistry(H,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

p:CreateLabel({
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
Text=F;
ZIndex=1;
Parent=H;
})

local J=p:Create('Frame',{
Name='TabFrame',
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,0);
Size=UDim2.new(1,0,1,0);
Visible=false;
ZIndex=2;
Parent=E;
})

local K,












L=p:Create('ScrollingFrame',{BackgroundTransparency=1;BorderSizePixel=0;Position=UDim2.new(0,8-1,0,8-1);Size=UDim2.new(0.5,-12+2,1,-8+1);CanvasSize=UDim2.new(0,0,0,0);BottomImage='';TopImage='';ScrollBarThickness=0;ZIndex=2;Parent=J;}),p:Create('ScrollingFrame',{
BackgroundTransparency=1;
BorderSizePixel=0;
Position=UDim2.new(0.5,4+1,0,8-1);
Size=UDim2.new(0.5,-12+2,1,-8+1);
CanvasSize=UDim2.new(0,0,0,0);
BottomImage='';
TopImage='';
ScrollBarThickness=0;
ZIndex=2;
Parent=J;
})

p:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=K;
})

p:Create('UIListLayout',{
Padding=UDim.new(0,8);
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
HorizontalAlignment=Enum.HorizontalAlignment.Center;
Parent=L;
})

for M,N in next,{K,L}do
N:WaitForChild('UIListLayout'):GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
N.CanvasSize=UDim2.fromOffset(0,N.UIListLayout.AbsoluteContentSize.Y)
end)
end






function G:ShowTab()
for O,P in next,t.Tabs do
P:HideTab()
end
H.BackgroundColor3=p.MainColor
p.RegistryMap[H].Properties.BackgroundColor3='MainColor'
J.Visible=true
end

function G:HideTab()
H.BackgroundColor3=p.BackgroundColor
p.RegistryMap[H].Properties.BackgroundColor3='BackgroundColor'
J.Visible=false
end

function G:SetLayoutOrder(O)
H.LayoutOrder=O
D:ApplyLayout()
UpdateTabButtonSizes()
end

table.insert(t.Tabs,G)
UpdateTabButtonSizes()


function G:AddGroupbox(O)
local P,

Q={},p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,507+2);
ZIndex=2;
Parent=O.Side==1 and K or L;
})

p:AddToRegistry(Q,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

local R=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=Q;
})

p:AddToRegistry(R,{
BackgroundColor3='BackgroundColor';
})

local S=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=5;
Parent=R;
})

p:AddToRegistry(S,{
BackgroundColor3='AccentColor';
})

p:CreateLabel({
Size=UDim2.new(1,0,0,18);
Position=UDim2.new(0,4,0,2);
TextSize=14;
Text=O.Name;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=5;
Parent=R;
})

local U=p:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Parent=R;
})

p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=U;
})

function P:Resize()
local V=0

for W,X in next,P.Container:GetChildren()do
if(not X:IsA('UIListLayout'))and X.Visible then
V=V+X.Size.Y.Offset
end
end

Q.Size=UDim2.new(1,0,0,20+V+2+2)
end

P.Container=U
setmetatable(P,aa)

P:AddBlank(3)
P:Resize()

G.Groupboxes[O.Name]=P

return P
end

function G:AddLeftGroupbox(O)
return G:AddGroupbox({Side=1;Name=O;})
end

function G:AddRightGroupbox(O)
return G:AddGroupbox({Side=2;Name=O;})
end

function G:AddTabbox(O)
local P,



Q={Tabs={};},p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=p.OutlineColor;
BorderMode=Enum.BorderMode.Inset;
Size=UDim2.new(1,0,0,0);
ZIndex=2;
Parent=O.Side==1 and K or L;
})

p:AddToRegistry(Q,{
BackgroundColor3='BackgroundColor';
BorderColor3='OutlineColor';
})

local R=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(1,-2,1,-2);
Position=UDim2.new(0,1,0,1);
ZIndex=4;
Parent=Q;
})

p:AddToRegistry(R,{
BackgroundColor3='BackgroundColor';
})

local S=p:Create('Frame',{
BackgroundColor3=p.AccentColor;
BorderSizePixel=0;
Size=UDim2.new(1,0,0,2);
ZIndex=10;
Parent=R;
})

p:AddToRegistry(S,{
BackgroundColor3='AccentColor';
})

local T=p:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,0,0,1);
Size=UDim2.new(1,0,0,18);
ZIndex=5;
Parent=R;
})

p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Horizontal;
HorizontalAlignment=Enum.HorizontalAlignment.Left;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=T;
})

function P:AddTab(U)
local V,

W={},p:Create('Frame',{
BackgroundColor3=p.MainColor;
BorderColor3=Color3.new(0,0,0);
Size=UDim2.new(0.5,0,1,0);
ZIndex=6;
Parent=T;
})

p:AddToRegistry(W,{
BackgroundColor3='MainColor';
})

p:CreateLabel({
Size=UDim2.new(1,0,1,0);
TextSize=14;
Text=U;
TextXAlignment=Enum.TextXAlignment.Center;
ZIndex=7;
Parent=W;
})

local Y=p:Create('Frame',{
BackgroundColor3=p.BackgroundColor;
BorderSizePixel=0;
Position=UDim2.new(0,0,1,0);
Size=UDim2.new(1,0,0,1);
Visible=false;
ZIndex=9;
Parent=W;
})

p:AddToRegistry(Y,{
BackgroundColor3='BackgroundColor';
})

local Z=p:Create('Frame',{
BackgroundTransparency=1;
Position=UDim2.new(0,4,0,20);
Size=UDim2.new(1,-4,1,-20);
ZIndex=1;
Visible=false;
Parent=R;
})

p:Create('UIListLayout',{
FillDirection=Enum.FillDirection.Vertical;
SortOrder=Enum.SortOrder.LayoutOrder;
Parent=Z;
})

function V:Show()
for _,ad in next,P.Tabs do
ad:Hide()
end

Z.Visible=true
Y.Visible=true

W.BackgroundColor3=p.BackgroundColor
p.RegistryMap[W].Properties.BackgroundColor3='BackgroundColor'

ad:Resize()
end

function V:Hide()
Z.Visible=false
Y.Visible=false

W.BackgroundColor3=p.MainColor
p.RegistryMap[W].Properties.BackgroundColor3='MainColor'
end

function V:Resize()
local ad=0

for _,ae in next,P.Tabs do
ad=ad+1
end

for af,ag in next,T:GetChildren()do
if not ag:IsA('UIListLayout')then
ag.Size=UDim2.new(1/ad,0,1,0)
end
end

if(not Z.Visible)then
return
end

local ah=0

for ai,aj in next,ae.Container:GetChildren()do
if(not aj:IsA('UIListLayout'))and aj.Visible then
ah=ah+aj.Size.Y.Offset
end
end

Q.Size=UDim2.new(1,0,0,20+ah+2+2)
end

W.InputBegan:Connect(function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 and not p:MouseIsOverOpenedFrame()then
V:Show()
V:Resize()
end
end)






V.Container=Z
P.Tabs[U]=V

setmetatable(V,aa)

V:AddBlank(3)
V:Resize()

if#T:GetChildren()==2 then
V:Show()
end

return V
end

G.Tabboxes[O.Name or'']=P

return P
end

function G:AddLeftTabbox(ad)
return G:AddTabbox({Name=ad,Side=1;})
end

function G:AddRightTabbox(ad)
return G:AddTabbox({Name=ad,Side=2;})
end

H.InputBegan:Connect(function(ad)
if ad.UserInputType==Enum.UserInputType.MouseButton1 then
G:ShowTab()
end
end)

if#E:GetChildren()==1 then
G:ShowTab()
end

t.Tabs[F]=G
return G
end

local ad,








ae,
ag,
ah=p:Create('TextButton',{BackgroundTransparency=1;Size=UDim2.new(0,0,0,0);Visible=true;Text='';Modal=false;Parent=m;}),{},false,false

function p:Toggle()
if ah then
return
end

local ai=ac.MenuFadeTime
ah=true
ag=(not ag)
ad.Modal=ag

if ag then
u.Visible=true

task.spawn(function()

local aj,

F=c.MouseIconEnabled,Drawing.new('Triangle')
F.Thickness=1
F.Filled=true
F.Visible=true

local G=Drawing.new('Triangle')
G.Thickness=1
G.Filled=false
G.Color=Color3.new(1,1,1)
G.Visible=true

while ag and m.Parent do
c.MouseIconEnabled=false

local H=c:GetMouseLocation()

F.Color=p.AccentColor

F.PointA=Vector2.new(H.X,H.Y)
F.PointB=Vector2.new(H.X+16,H.Y+6)
F.PointC=Vector2.new(H.X+6,H.Y+16)

G.PointA=F.PointA
G.PointB=F.PointB
G.PointC=F.PointC

j:Wait()
end

c.MouseIconEnabled=aj

F:Remove()
G:Remove()
end)
end

for aj,F in next,u:GetDescendants()do
local G={}

if F:IsA('ImageLabel')then
table.insert(G,'ImageTransparency')
table.insert(G,'BackgroundTransparency')
elseif F:IsA('TextLabel')or F:IsA('TextBox')then
table.insert(G,'TextTransparency')
elseif F:IsA('Frame')or F:IsA('ScrollingFrame')then
table.insert(G,'BackgroundTransparency')
elseif F:IsA('UIStroke')then
table.insert(G,'Transparency')
end

local H=ae[F]

if(not H)then
H={}
ae[F]=H
end

for I,J in next,G do
if not H[J]then
H[J]=F[J]
end

if H[J]==1 then
continue
end

i:Create(F,TweenInfo.new(ai,Enum.EasingStyle.Linear),{[J]=ag and H[J]or 1}):Play()
end
end

task.wait(ai)

u.Visible=ag

ah=false
end

p:GiveSignal(c.InputBegan:Connect(function(ai,aj)
if type(p.ToggleKeybind)=='table'and p.ToggleKeybind.Type=='KeyPicker'then
if ai.UserInputType==Enum.UserInputType.Keyboard and ai.KeyCode.Name==p.ToggleKeybind.Value then
task.spawn(p.Toggle)
end
elseif ai.KeyCode==Enum.KeyCode.LeftControl or(ai.KeyCode==Enum.KeyCode.LeftAlt and(not aj))then
task.spawn(p.Toggle)
end
end))

if ac.AutoShow then task.spawn(p.Toggle)end

t.Holder=u

return t
end local OnPlayerChange=function()


local ab=GetPlayersString()

for ac,ad in next,o do
if ad.Type=='Dropdown'and ad.SpecialType=='Player'then
ad:SetValues(ab)
end
end end


g.PlayerAdded:Connect(OnPlayerChange)
g.PlayerRemoving:Connect(OnPlayerChange)

getgenv().Library=p

for ab,ac in pairs(({"Internal","HttpCache","Instances","Signals","Script","PhysicsCollision","PhysicsParts","GraphicsSolidModels","GraphicsMeshParts","GraphicsParticles","GraphicsParts","GraphicsSpatialHash","GraphicsTerrain","GraphicsTexture","GraphicsTextureCharacter","Sounds","StreamingSounds","TerrainVoxels","Gui","Animation","Navigation","GeometryCSG"}))do
memorystats.restore(ac)
end
return p,n,o
