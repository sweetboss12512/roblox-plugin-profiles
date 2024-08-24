local a a={cache={}, load=function(b)if not a.cache[b]then a.cache[b]={c=a[b]()}end return a.cache[b].c end}do function a.a()

local b=require"@lune/stdio"

local c={
Reset=b.color"reset"..b.style"reset",

Red=b.color"red",
Yellow=b.color"yellow",

Bold=b.style"bold",
}

local d={}

function d.Info(e:string,f:string?)
f=f or"\n"
b.write(`∙ {e}{f}`)
end

function d.Error(e:string,f:string?)
f=f or"\n"
b.ewrite(`{c.Bold..c.Red}∙ {e}{c.Reset}{f}`)
end

function d.Warn(e:string,f:string?)
f=f or"\n"
b.write(`{c.Bold..c.Yellow}∙ {e}{c.Reset}{f}`)
end

function d.InternalError(e:string,f:string?)
d.Error("[INTERNAL ERROR] "..e,f)
end

return d end function a.b()

export type PrefixEnum=
{type:'Verbatim',value:string}
|{type:'VerbatimUNC',hostName:string,shareName:string}
|{type:'VerbatimDisk',value:string}
|{type:'DeviceNS',value:string}
|{type:'UNC',hostName:string,shareName:string}
|{type:'Disk',value:string}

export type Prefix=PrefixEnum&{
len:(self:Prefix)->number,
isVerbatim:(self:Prefix)->boolean,
isDrive:(self:Prefix)->boolean,
hasImplicitRoot:(self:Prefix)->boolean,

clone:(self:Prefix)->Prefix,
equal:(self:Prefix,other:Prefix)->boolean
}

type PrefixStatic=Prefix&{
Verbatim:(value:string)->Prefix,
VerbatimUNC:(hostName:string,shareName:string)->Prefix,
VerbatimDisk:(value:string)->Prefix,
DeviceNS:(value:string)->Prefix,
UNC:(hostName:string,shareName:string)->Prefix,
Disk:(value:string)->Prefix
}

return nil end function a.c()

local b=a.load'b'

type Prefix=Prefix.Prefix

export type PrefixComponent={
type:"prefix",
raw:string,
parsed:Prefix
}

type NormalComponent={type:"normal",value:string}

type ComponentEnum=NormalComponent|{type:"rootDir"}|{type:"curDir"}|{type:"parentDir"}|PrefixComponent

type ComponentCommon={
toString:(self:Component)->string,
equal:(self:Component,other:Component)->boolean
}

export type Component=ComponentEnum&ComponentCommon

type ComponentStatic=Component&{
normal:(value:string)->Component,
rootDir:()->Component,
curDir:()->Component,
parentDir:()->Component,
prefix:(raw:string,prefix:Prefix)->Component
}

return nil end function a.d()

export type Rev<T> ={
next:(self:Rev<T>)->T?,
collect:(self:Rev<T>)->{T},
rev:(self:Rev<T>)->Rev<T>,

nextBack:(self:Rev<T>)->T?,

clone:(self:Rev<T>)->Rev<T>
}

type DoubleEndedIterator<T> ={
next:(self:DoubleEndedIterator<T>)->T?,
nextBack:(self:DoubleEndedIterator<T>)->T?,

clone:(self:DoubleEndedIterator<T>)->DoubleEndedIterator<T>
}

type Private<T> ={
_iter:DoubleEndedIterator<T>
}
type PrivateRev<T> =Rev<T>&Private<T>

type RevStatic={
new:<T>(iter:DoubleEndedIterator<T>)->Rev<T>,

next:<T>(self:Rev<T>)->T?,
collect:<T>(self:Rev<T>)->{T},
rev:<T>(self:Rev<T>)->Rev<T>,

nextBack:<T>(self:Rev<T>)->T?,

clone:<T>(self:Rev<T>)->Rev<T>
}

return nil end function a.e()

local b=a.load'c'
local c=a.load'b'
local d=a.load'd'

type Component=Component.Component
type Prefix=Prefix.Prefix
type Rev<T> =Rev.Rev<T>

type char=string

export type Components={

prefix:Prefix?,

prefixLen:(self:Components)->number,
prefixVerbatim:(self:Components)->boolean,

prefixRemaining:(self:Components)->number,

lenBeforeBody:(self:Components)->number,

finished:(self:Components)->boolean,
isSepByte:(self:Components,b:char)->boolean,

asPathString:(self:Components)->string,
hasRoot:(self:Components)->boolean,
includeCurDir:(self:Components)->boolean,
parseSingleComponent:(self:Components,comp:string)->Component?,
parseNextComponent:(self:Components)->(number,Component?),
parseNextComponentBack:(self:Components)->(number,Component?),
trimLeft:(self:Components)->(),
trimRight:(self:Components)->(),


next:(self:Components)->Component?,
collect:(self:Components)->{Component},
rev:(self:Components)->Rev<Component>,

nextBack:(self:Components)->Component?,


clone:(self:Components)->Components,
equal:(self:Components,other:Components)->boolean
}

type IterComponents=(items:{Component},index:number?)->(number?,Component)

type State="Prefix"|"StartDir"|"Body"|"Done"

return nil end function a.f()

local b=a.load'c'
local c=a.load'e'
local d=a.load'b'

type Component=Component.Component
type Components=Components.Components
type Prefix=Prefix.Prefix

export type Ancestors={

next:(self:Ancestors)->Path?,
collect:(self:Ancestors)->{Path}
}

export type AsPath=string|Path|Components

export type Path={
toString:(self:Path)->string,

toPathBuf:(self:Path)->Path,
isAbsolute:(self:Path)->boolean,
isRelative:(self:Path)->boolean,
hasRoot:(self:Path)->boolean,
parent:(self:Path)->Path?,
ancestors:(self:Path)->Ancestors,
fileName:(self:Path)->string?,
stripPrefix:(self:Path,base:AsPath)->Path?,
startsWith:(self:Path,base:AsPath)->boolean,
endsWith:(self:Path,child:AsPath)->boolean,

fileStem:(self:Path)->string?,
filePrefix:(self:Path)->string?,
extension:(self:Path)->string?,
join:(self:Path,path:AsPath)->Path,

withFileName:(self:Path,fileName:string)->Path,
withExtension:(self:Path,extension:string)->Path,
components:(self:Path)->Components,

equal:(self:Path,other:Path)->boolean,


push:(self:Path,path:AsPath)->(),
pop:(self:Path)->boolean,
setFileName:(self:Path,fileName:string)->(),
setExtension:(self:Path,extension:string)->boolean,
clear:(self:Path)->()
}

return nil end function a.g()

local b=a.load'f'

export type Path=Path.Path
export type AsPath=Path.AsPath

return nil end function a.h()

local b b={cache={},load=function(c)if not b.cache[c]then b.cache[c]={c=b[c]()}end return b.cache[c].c end}do function b.a()

return nil end function b.b()

local function all(c,d)
for e,f in c do
if not d(f,e)then
return false
end
end
return true
end

return all end function b.c()

local function reduce(
c,
d,
e
)
if e==nil then
for f,g in c do
if f==1 then
e=g
else
e=d(e,g,f)
end
end
else
for f,g in c do
e=d(e,g,f)
end
end
return e
end











return(reduce)end function b.d()

local c=b.load'c'

local function alternate(d,...)
local e={...}

if#e==0 then
return d
end

local f=c(e,function(f,g)
return math.min(f,#g)
end,#d)

if f==0 then
return{}
end

local g={}

for h=1,f do
table.insert(g,d[h])
for i,j in e do
table.insert(g,(j[h]))
end
end

return g
end






return(alternate)end function b.e()

local function any(c,d)
for e,f in c do
if d(f,e)then
return true
end
end
return false
end

return any end function b.f()

local function average(c)
local d=#c
if d==0 then
return nil
end

local e=0

for f,g in c do
e+=g
end

return e/d
end

return average end function b.g()

local function averageBy(c,d)
local e=#c
if e==0 then
return nil
end

local f=0

for g,h in c do
f+=d(h)
end

return f/e
end

return averageBy end function b.h()

local function concat(c,...)
local d

for e=1,select('#',...)do
local f=select(e,...)

if f~=nil and#f>0 then
d=d or table.clone(c)

for g,h in f do
table.insert(d,h)
end
end
end

return d or c
end

return concat end function b.i()

local function contains(c,d)
for e,f in c do
if f==d then
return true
end
end
return false
end

return contains end function b.j()

return table.clone end function b.k()

local function deduplicate(c)
if#c==0 then
return c
end

local d={}

local e={}

for f,g in c do
if e[g]==nil then
e[g]=true
else
table.insert(d,f)
end
end

local h=#d
if h==0 then
return c
else
local i=table.clone(c)
for j=h,1,-1 do
table.remove(i,d[j])
end
return i
end
end

return deduplicate end function b.l()

local function deduplicateByKey(c,d)
local e={}

local f={}

for g,h in c do
local i=d(h)
if f[i]==nil then
f[i]=true
else
table.insert(e,g)
end
end

local i=#e
if i==0 then
return c
else
local j=table.clone(c)
for k=i,1,-1 do
table.remove(j,e[k])
end
return j
end
end

return deduplicateByKey end function b.m()

local function filter(c,d)
local e={}
for f,g in c do
if d(g,f)then
table.insert(e,g)
end
end
return e
end

return filter end function b.n()

local function find(
c,
d,
e
)
if e==nil or e==1 then
for f,g in c do
if d(g,f)then
return g
end
end
else
local f=#c
for g=e,f do
local h=c[g]
if d(h,g)then
return h
end
end
end

return nil
end

return find end function b.o()

local function findIndex(
c,
d,
e
)
if e==nil or e==1 then
for f,g in c do
if d(g,f)then
return f
end
end
else
local f=#c
for g=e,f do
local h=c[g]
if d(h,g)then
return g
end
end
end

return nil
end

return findIndex end function b.p()

local function findIndexByValue(c,d,e)
return table.find(c,d,e)
end

return findIndexByValue end function b.q()

local function findMap(c,d,e)
if e==nil or e==1 then
for f,g in c do
local h=d(g,f)
if h~=nil then
return h
end
end
else
local f=#c
for g=e,f do
local h=c[g]
local i=d(h,g)
if i~=nil then
return i
end
end
end

return nil
end

return findMap end function b.r()

local function isArray(c)
if type(c)~='table'then
return false
end

local d=c

if next(d)==nil then

return true
end

local e=#d

if e==0 then
return false
end

local f=0

for g in d do
f+=1
if type(g)~='number'or g~=f then
return false
end
end

return e==f
end

return isArray end function b.s()

local c=b.load'r'

local function flatMap(d,e)
local f={}
for g,h in d do
local i=e(h,g)
if i~=nil then
if c(i)then
for j,k in i do
table.insert(f,k)
end
else
table.insert(f,i)
end
end
end
return f
end

return flatMap end function b.t()

local c=b.load'r'

local function flatten(d,e)
local f=if e==nil then math.huge else e
if f==0 then
return d
end

local g={}

for h,i in d do
if c(i)then
local j=if f>1
then flatten(i)
else i
for k,l in j do
table.insert(g,l)
end
else
table.insert(g,i)
end
end

return g
end

return flatten end function b.u()

local function fromFn(c)
local d={}

local e=1
while true do
local f=c(e)
if f==nil then
break
else
e+=1
table.insert(d,f)
end
end

return d
end

return fromFn end function b.v()

local function fromTryFn(c)
local d={}

local e=1
while true do
local f,g=pcall(c,e)
if f==false or g==nil then
break
else
e+=1
table.insert(d,g)
end
end

return d
end

return fromTryFn end function b.w()

local function isEmpty(c)
return next(c)==nil
end

return isEmpty end function b.x()

local function map(c,d)
local e={}
for f,g in c do
local h=d(g,f)
if h~=nil then
table.insert(e,h)
end
end
return e
end

return map end function b.y()

local function maximum(c,d)
if d==nil then
if#c==0 then
error'initial value must be provided to Array.maximum when the array is empty'
end
d=c[1]
end

local e=d
for f,g in c do
e=math.max(e,g)
end
return e
end

return maximum end function b.z()

local function maximumBy(c,d,e)
if e==nil then
if#c==0 then
error'initial value must be provided to Array.maximumBy when the array is empty'
end
e=d(c[1])
end

local f=e
for g,h in c do
f=math.max(f,d(h))
end
return f
end

return maximumBy end function b.A()

local function minimum(c,d)
if d==nil then
if#c==0 then
error'initial value must be provided to Array.minimum when the array is empty'
end
d=c[1]
end

local e=d
for f,g in c do
e=math.min(e,g)
end
return e
end

return minimum end function b.B()

local function minimumBy(c,d,e)
if e==nil then
if#c==0 then
error'initial value must be provided to Array.minimumBy when the array is empty'
end
e=d(c[1])
end

local f=e
for g,h in c do
f=math.min(f,d(h))
end
return f
end

return minimumBy end function b.C()

local function partition(c,d)
local e={}
local f={}
for g,h in c do
if d(h,g)then
table.insert(e,h)
else
table.insert(f,h)
end
end
return e,f
end

return partition end function b.D()

local function pop(c,d)
local e=d or 1

if e==1 then
local f=table.clone(c)
table.remove(f)
return f
elseif e==0 then
return c
else
local f=#c

local g=f-e

if g<=0 then
return{}
elseif g>e then
local h=table.clone(c)

for i=1,e do
table.remove(h)
end

return h
else
local h={}

for i=1,g do
h[i]=c[i]
end
return h
end
end
end

return pop end function b.E()

local function popFirst(c,d)
local e=d or 1

if e==1 then
local f=table.clone(c)
table.remove(f,1)
return f
elseif e==0 then
return c
else
local f=#c

local g=f-e

if g<=0 then
return{}
elseif g>e then
local h=table.clone(c)

for i=1,e do
table.remove(h,1)
end

return h
else
local h={}

for i=1+e,f do
table.insert(h,c[i])
end

return h
end
end
end

return popFirst end function b.F()

local function product(c,d)
local e=if d==nil then 1 else d

for f,g in c do
e*=g
end

return e
end

return product end function b.G()

local function productBy(c,d,e)
local f=if e==nil then 1 else e

for g,h in c do
f*=d(h)
end

return f
end

return productBy end function b.H()

local function push(c,...)
local d=table.clone(c)

for e=1,select('#',...)do
local f=select(e,...)
if f~=nil then
table.insert(d,f)
end
end

return d
end

return push end function b.I()

local function range(c,d,e)
local f=#c
if f==0 then
return c
end
local g=if e==nil then f else e

local h=if d<0 then 1+(d+f)else d
local i=if g<0 then 1+(g+f)else g

local j={}

if i>=h then
for k=math.max(h,1),math.min(i,f)do
table.insert(j,c[k])
end
else
for k=math.min(h,f),math.max(i,1),-1 do
table.insert(j,c[k])
end
end

return j
end

return range end function b.J()

local function removeSortedIndexes(c,d)
local e=#d
local f=#c

if e==0 or f==0 then
return c
end

local g
for h=e,1,-1 do
local i=d[h]
if i<=f then
g=i
break
end
end

if g==nil then
return c
else
local h=table.clone(c)
local i=f

local j
for k=g,1,-1 do
local l=d[k]
if l~=j and l<=i then
i-=1
table.remove(h,l)
j=l
end
end

return h
end
end

return removeSortedIndexes end function b.K()

local function sort(c,d)
if#c<=1 then
return c
end
local e=table.clone(c)
table.sort(e,d)
return e
end

return sort end function b.L()

local c=b.load'J'
local d=b.load'K'

local function removeIndexes(e,f)
local g=#f
local h=#e

if g==0 or h==0 then
return e
end

local i=d(f)

return c(e,i)
end

return removeIndexes end function b.M()

local function removeValues(c,...)
local d=select('#',...)
local e=#c

if d==0 or e==0 then
return c
end

local f={}
for g,h in c do
for i=1,d do
local j=select(i,...)

if j~=nil and h==j then
table.insert(f,g)
end
end
end

local i=#f

if i==0 then
return c
elseif i==e then
return{}
else
local j=table.clone(c)

for k=i,1,-1 do
table.remove(j,f[k])
end

return j
end
end

return removeValues end function b.N()

local function reverse(c)
local d=#c

if d<2 then
return c
end

local e=table.clone(c)

for f=1,math.floor(d/2)do
local g=d-f+1

e[f],e[g]=e[g],e[f]
end

return e
end

return reverse end function b.O()

local c=b.load'x'



local function sortByKey(d,e)
if#d<=1 then
return d
end
local f=c(d,function(f)
return{
key=e(f),
element=f,
}
end)

table.sort(f,function(g,h)
return g.key<h.key
end)

for g,h in f do
f[g]=(h.element)
end

return f
end

return sortByKey end function b.P()

local function stepBy(c,d)
local e=#c

if d==1 then
return c
elseif d==-1 then
local f=table.clone(c)

for g=1,math.floor(e/2)do
local h=e-g+1

f[g],f[h]=f[h],f[g]
end

return f
elseif d>1 then
local f={}

for g=1,e,d do
table.insert(f,c[g])
end

return f
elseif d<-1 then
local f={}

for g=e,1,d do
table.insert(f,c[g])
end

return f
else
error(`invalid step value '{d}' passed to Array.stepBy`)
end
end

return stepBy end function b.Q()

local function sum(c,d)
local e=if d==nil then 0 else d

for f,g in c do
e+=g
end

return e
end

return sum end function b.R()

local function sumBy(c,d,e)
local f=if e==nil then 0 else e

for g,h in c do
f+=d(h)
end

return f
end

return sumBy end function b.S()

local function takeWhile(
c,
d,
e
)
local f=#c

if f==0 then
return c
end

local g=f+1
local h=if e==nil then 1 else e
if h==1 then
for i,j in c do
if not d(j,i)then
g=i
break
end
end
else
local i=#c
for j=h,i do
local k=c[j]
if not d(k,j)then
g=j
break
end
end
end

if h==g then
return{}
elseif h==1 and g>f then
return c
end

local i=g-h

if h==1 and i<f/2 then
local j=table.clone(c)

for k=1,f-g do
table.remove(j)
end

return j
else
local j={}

for k=h,g-1 do
table.insert(j,c[k])
end

return j
end
end

return takeWhile end function b.T()

local c=b.load'c'

local function zip(d,...)
local e={...}

local f=c(e,function(f,g)
return math.min(f,#g)
end,#d)

if f==0 then
return{}
end

local g={}

for h=1,f do
local i={d[h]}
for j,k in e do
table.insert(i,k[h])
end
table.insert(g,i)
end

return g
end






return(zip)end function b.U()

return table.clone end function b.V()

local function count(c)
local d=0
for e in c do
d+=1
end
return d
end

return count end function b.W()

local function entries(c,d,e)
local f=if d==nil then 1 else d
local g=if e==nil then f+1 else e

local h={}

for i,j in c do
table.insert(h,{
[f]=i,
[g]=j,
})
end

return h
end





return entries end function b.X()

local function invert(c)
if next(c)==nil then
return c
end

local d={}
for e,f in c do
d[f]=e
end
return d
end

return invert end function b.Y()

local function isEmpty(c)
return next(c)==nil
end

return isEmpty end function b.Z()

local function keys(c)
local d={}
for e in c do
table.insert(d,e)
end
return d
end

return keys end function b._()

local function mapEntries(c,d)
local e={}

for f,g in c do
local h,i=d(f,g)
if h~=nil and i~=nil then
e[h]=i
end
end

return e
end

return mapEntries end function b.aa()

local c=table.freeze(setmetatable({},{
__index=function()
error'attempt to index on None symbol'
end,
__tostring=function()
return'<None>'
end,
}))

return c end function b.ab()

local c=b.load'aa'

local function mapValues(d,e)
local f={}

for g,h in d do
local i=e(h,g)
if i~=nil and i~=(c)then
f[g]=i
end
end

return f
end

return mapValues end function b.ac()

local c=b.load'aa'

local function merge(...)
local d
local e
local f=select('#',...)

for g=1,f do
local h=select(g,...)

if h~=nil then
e=g
d=h
break
end
end

if d==nil then
error'attempt to merge only nil values'
end

if e==f then
return d
end

local g

for h=e+1,f do
local i=select(h,...)

if i~=nil then
if g==nil then
g=table.clone(d)
setmetatable(g,nil)
end

local j=getmetatable(i)

if j~=nil and type(j.__call)=='function'then
for k,l in pairs(i)do
if l==c then
g[k]=nil
else
g[k]=l
end
end
else
for k,l in i do
if l==c then
g[k]=nil
else
g[k]=l
end
end
end
end
end

return g or d
end








return(merge)end function b.ad()

local c=b.load'Y'

local function remove(d,...)
local e=select('#',...)

if e==0 or c(d)then
return d
else
local f

for g=1,e do
local h=select(g,...)

if h~=nil and d[h]~=nil then
f=f or table.clone(d)
f[h]=nil
end
end

return f or d
end
end

return remove end function b.ae()

local function values(c)
local d={}
for e,f in c do
table.insert(d,f)
end
return d
end

return values end function b.af()

b.load'a'



local function fromArray(c)
local d={}
for e,f in c do
d[f]=true
end
return d
end

return fromArray end function b.ag()

local c={__mode='k'}

local function WeakMap(d)
local e=d or{}
return(setmetatable(e,c))
end

return WeakMap end function b.ah()

b.load'a'



local c={
Array={
all=b.load'b',
alternate=b.load'd',
any=b.load'e',
average=b.load'f',
averageBy=b.load'g',
concat=b.load'h',
contains=b.load'i',
copy=b.load'j',
deduplicate=b.load'k',
deduplicateByKey=b.load'l',
filter=b.load'm',
find=b.load'n',
findIndex=b.load'o',
findIndexByValue=b.load'p',
findMap=b.load'q',
flatMap=b.load's',
flatten=b.load't',
fromFn=b.load'u',
fromTryFn=b.load'v',
isArray=b.load'r',
isEmpty=b.load'w',
map=b.load'x',
maximum=b.load'y',
maximumBy=b.load'z',
minimum=b.load'A',
minimumBy=b.load'B',
partition=b.load'C',
pop=b.load'D',
popFirst=b.load'E',
product=b.load'F',
productBy=b.load'G',
push=b.load'H',
range=b.load'I',
reduce=b.load'c',
removeIndexes=b.load'L',
removeSortedIndexes=b.load'J',
removeValues=b.load'M',
reverse=b.load'N',
reversed=b.load'N',
sort=b.load'K',
sortByKey=b.load'O',
stepBy=b.load'P',
sum=b.load'Q',
sumBy=b.load'R',
takeWhile=b.load'S',
zip=b.load'T',
},
Map={
copy=b.load'U',
count=b.load'V',
entries=b.load'W',
invert=b.load'X',
isEmpty=b.load'Y',
keys=b.load'Z',
mapEntries=b.load'_',
mapValues=b.load'ab',
merge=b.load'ac',
remove=b.load'ad',
values=b.load'ae',
},
Set={
fromArray=b.load'af',
},
None=b.load'aa',
WeakMap=b.load'ag',
}

return c end function b.ai()

local c=b.load'ah'

return c end function b.aj()




























local c={}
local d={
__index=c,
__eq=function(d,e)
return d:equal(e)
end,
}

local function new(e)
return(setmetatable(e,d))
end

function c.Verbatim(e)
return new{type='Verbatim',value=e}
end

function c.VerbatimUNC(e,f)
return new{type='VerbatimUNC',hostName=e,shareName=f}
end

function c.VerbatimDisk(e)
return new{type='VerbatimDisk',value=e}
end

function c.DeviceNS(e)
return new{type='DeviceNS',value=e}
end

function c.UNC(e,f)
return new{type='UNC',hostName=e,shareName=f}
end

function c.Disk(e)
return new{type='Disk',value=e}
end

function c.len(e)
local f=e.type
if f=='Verbatim'then
return 4+string.len((e).value)
elseif f=='VerbatimUNC'then
local g=e
local h=string.len(g.shareName)
return 8+string.len(g.hostName)+if h>0 then 1+h else 0
elseif f=='VerbatimDisk'then
return 6
elseif f=='UNC'then
local g=e
local h=string.len(g.shareName)
return 2+string.len(g.hostName)+if h>0 then 1+h else 0
elseif f=='DeviceNS'then
return 4+string.len((e).value)
elseif f=='Disk'then
return 2


end
return 0
end

function c.isVerbatim(e)
local f=e.type
return f=='Verbatim'or f=='VerbatimDisk'or f=='VerbatimUNC'
end

function c.isDrive(e)
return e.type=='Disk'
end

function c.hasImplicitRoot(e)
return e.type~='Disk'
end

function c.clone(e)
local f=table.clone(e)

return(setmetatable(f,d))
end

function c.equal(e,f)
local g=e.type

if g~=f.type then
return false
end

if g=='Verbatim'then
return(e).value==(f).value
end
if g=='VerbatimUNC'then
return(e).hostName==(f).hostName
and(e).shareName==(f).shareName
end
if g=='VerbatimDisk'then
return(e).value==(f).value
end
if g=='DeviceNS'then
return(e).value==(f).value
end
if g=='UNC'then
return(e).hostName==(f).hostName
and(e).shareName==(f).shareName
end
if g=='Disk'then
return(e).value==(f).value
end

return true
end

return c end function b.ak()


















local c={}
local d={
__index=c,
}

function c.new(e,f)
local g={
_path=e,
_prefix=f,
_index=1,
}

return(setmetatable(g,d))
end

function c.stripPrefix(e,f)
local g=e

local h=#f
if string.sub(g._prefix,g._index,g._index+h-1)==f then
local i={
_path=g._path,
_prefix=g._prefix,
_index=g._index+h,
}

return(setmetatable(i,d))
end
return nil
end

function c.prefixBytes(e)
local f=e

return string.sub(f._path,1,f._index)
end

function c.finish(e)
local f=e

return string.sub(f._path,f._index)
end

return c end function b.al()

local c=b.load'ak'



















local d={}
local e={
__index=d,
}

function d.new(f,g)
local h={
_path=f,
_prefix=d.getPrefix(f,g),
_length=g,
}

return(setmetatable(h,e))
end

function d.getPrefix(f,g)
local h=string.gsub(string.sub(f,1,g),'/','\\')
return h
end

function d.asSlice(f)
local g=f

return c.new(g._path,string.sub(g._prefix,1,math.min(#g._path,8)))
end

return d end function b.am()



local c=b.load'aj'
local d=b.load'al'




local function isValidDriveLetter(e)
local f=string.byte(e)
return(f>=65 and f<=90)or(f>=97 and f<=122)
end

local function parseDrive(e)
local f=string.sub(e,1,1)

if f~=''and isValidDriveLetter(f)and string.sub(e,2,2)==':'then
return string.upper(f)
end

return nil
end

local function parseDriveExact(e)
local f=string.sub(e,3,3)
if f=='/'or f=='\\'then
return parseDrive(e)
else
return nil
end
end

local function findSepByte(e)
local f=string.find(e,'/',1,true)
local g=string.find(e,'\\',1,true)

if f and g then
return math.min(f,g)
end

return f or g
end

local function findVerbatimSep(e)
local f=string.find(e,'\\',1,true)
return f
end

local function parseNextComponent(e,f)

local g=if f then findVerbatimSep else findSepByte

local h=g(e)

if h then
local i=h+1

local j=string.sub(e,1,h-1)



local k=string.sub(e,i)





return j,k
else
return e,''
end
end

local function parsePrefix(e)
local f=d.new(e,8)
local g=f:asSlice()

local h=g:stripPrefix[[\\]]

if h then




local i=h:stripPrefix[[?\]]

if i and string.find(i:prefixBytes(),'/',1,true)==nil then

local j=i:stripPrefix[[UNC\]]
if j then


local k=j:finish()
local l,m=parseNextComponent(k,true)local
n, o=parseNextComponent(m,true)

return c.VerbatimUNC(l,n)
else
local l=i:finish()


local m=parseDriveExact(l)
if m then

return c.VerbatimDisk(m)
else

local n=parseNextComponent(l,true)
return c.Verbatim(n)
end
end
end

local j=h:stripPrefix[[.\]]

if j then

local l=j:finish()local
m, n=parseNextComponent(l,false)
return c.DeviceNS(m)
end

local l=h:finish()
local m,n=parseNextComponent(l,false)local
o, p=parseNextComponent(n,false)

if m~=''and o~=''then
return c.UNC(m,o)
else

return nil
end
else


local j=parseDrive(e)
return j and c.Disk(j)
end
end

return parsePrefix end function b.an()

b.load'aj'
local c=b.load'am'



local d=if _G.SYS_PATH_SEPARATOR=='\\'
or _G.SYS_PATH_SEPARATOR=='/'
then _G.SYS_PATH_SEPARATOR

else'/'

local e=d=='\\'

local function isSepByteUnix(h)
return h=='/'
end

local function isSepByteWindows(h)
return h=='/'or h=='\\'
end

local function isVerbatimSepUnix(h)
return h=='/'
end

local function isVerbatimSepWindows(h)
return h=='\\'
end

local h=if e then isSepByteWindows else isSepByteUnix
local j=if e
then isVerbatimSepWindows
else isVerbatimSepUnix

local function parsePrefixUnix(m)
return nil
end

local m=if e
then c
else parsePrefixUnix

return{
MAIN_SEPARATOR_STR=d,
isSepByte=h,
isVerbatimSep=j,
parsePrefix=m,
}end function b.ao()

b.load'aj'
local c=b.load'an'

local d=c.MAIN_SEPARATOR_STR
































local e={}
local h={
__index=e,
__tostring=function(h)
return h:toString()
end,
__eq=function(h,j)
return h:equal(j)
end,
}

function e.normal(j)
local m={type='normal',value=j}

return(setmetatable(m,h))
end

function e.rootDir()
local j={type='rootDir'}

return(setmetatable(j,h))
end

function e.curDir()
local j={type='curDir'}

return(setmetatable(j,h))
end

function e.parentDir()
local j={type='parentDir'}

return(setmetatable(j,h))
end

function e.prefix(j,m)
local n={type='prefix',raw=j,parsed=m}

return(setmetatable(n,h))
end

function e.toString(j)
local m=j.type
return if m=='normal'
then(j).value
elseif m=='curDir'then'.'
elseif m=='parentDir'then'..'
elseif m=='rootDir'then d
else(j).raw
end

function e.equal(j,m)
local n=j.type

if n~=m.type then
return false
end

if n=='normal'then
return(j).value
==(m).value
elseif n=='prefix'then
return(j).parsed:equal(
(m).parsed
)
end

return true
end

return e end function b.ap()

local c=b.load'ai'

local d=c.Array



































local e={}
local h={
__index=e,
__iter=function(h)
local j=h:collect()
return next,j
end,
}

function e.new(j)
local m={
_iter=j,
}

return(setmetatable(m,h))
end

function e.next(j)
local m=j

return m._iter:nextBack()
end

function e.collect(j)
local m=j

return d.fromFn(function()
return m:next()
end)
end

function e.nextBack(j)
local m=j

return m._iter:next()
end

function e.clone(j)
local m=j

return e.new(m._iter:clone())
end

return e end function b.aq()

local c=b.load'ai'

local d=b.load'ao'
b.load'aj'
local e=b.load'ap'
local h=b.load'an'

local j=h.isSepByte
local m=h.isVerbatimSep





local n=c.Array










































local function getStateValue(o)
if o=='Done'then
return 3
elseif o=='StartDir'then
return 1
elseif o=='Prefix'then
return 0
else
return 2
end
end






















local o={}
local p={
__index=o,
__iter=function(p)
local q=p:collect()
return next,q
end,
}

function o.new(q,r,s)
local t={
_path=q,
prefix=r,
_hasPhysicalRoot=s,
_front='Prefix',
_back='Body',
}

return(setmetatable(t,p))
end

function o.is(q)
return type(q)=='table'and getmetatable(q)==p
end

function o.prefixLen(q)
local r=q

local s=r.prefix
return if s then s:len()else 0
end

function o.prefixVerbatim(q)
local r=q

local s=r.prefix
return if s then s:isVerbatim()else false
end


function o.prefixRemaining(q)
local r=q

local s=r._front
return if s=='Prefix'then r:prefixLen()else 0
end


function o.lenBeforeBody(q)
local r=q

local s=r._front
local t=getStateValue(s)<=getStateValue'StartDir'
local u=if t and r._hasPhysicalRoot then 1 else 0
local v=if t and r:includeCurDir()then 1 else 0

return r:prefixRemaining()+u+v
end


function o.finished(q)
local r=q

local s=r._front
local t=r._back
return s=='Done'or t=='Done'or getStateValue(s)>getStateValue(t)
end

function o.isSepByte(q,r)
local s=q

return if s:prefixVerbatim()then m(r)else j(r)
end

function o.asPathString(q)
local r=q

local s=(r:clone())
if s._front=='Body'then
s:trimLeft()
end
if s._back=='Body'then
s:trimRight()
end
return s._path
end


function o.hasRoot(q)
local r=q

if r._hasPhysicalRoot then
return true
end
local s=r.prefix
if s and s:hasImplicitRoot()then
return true
end
return false
end


function o.includeCurDir(q)
local r=q

if r:hasRoot()then
return false
end

local s=r:prefixRemaining()+1
local t=string.sub(r._path,s,s)
local u=string.sub(r._path,s+1,s+1)

local v=t=='.'


return if v and u==''
then true
elseif v and u~=''then r:isSepByte(u)
else false
end



function o.parseSingleComponent(q,r)
local s=q

if r=='.'then
if s:prefixVerbatim()then
return d.curDir()
else



return nil
end
elseif r=='..'then
return d.parentDir()
elseif r==''then
return nil
else
return d.normal(r)
end
end



function o.parseNextComponent(q)
local r=q

local s=r._path
local t=0
local u=s

for v=1,#s do
if r:isSepByte(string.sub(s,v,v))then
t=1
u=string.sub(s,1,v-1)
break
end
end

return#u+t,r:parseSingleComponent(u)
end



function o.parseNextComponentBack(q)
local r=q

local s=r:lenBeforeBody()+1
local t=r._path

local u=0
local v=string.sub(t,s)

for w=#t,s,-1 do
if r:isSepByte(string.sub(t,w,w))then
u=1
v=string.sub(t,w+1)
break
end
end

return#v+u,r:parseSingleComponent(v)
end


function o.trimLeft(q)
local r=q

while r._path~=''do
local s,t=r:parseNextComponent()
if t~=nil then
return
else
r._path=string.sub(r._path,s+1)
end
end
end


function o.trimRight(q)
local r=q

while#r._path>r:lenBeforeBody()do
local s,t=r:parseNextComponentBack()
if t~=nil then
return
else
r._path=string.sub(r._path,1,#r._path-s)
end
end
end

function o.next(q)
local r=q

while not r:finished()do
local s=r._front

if s=='Prefix'then
r._front='StartDir'
local t=r:prefixLen()
if t>0 then
local u=string.sub(r._path,1,t)
r._path=string.sub(r._path,t+1)

return d.prefix(u,(r.prefix))
end
elseif s=='StartDir'then
r._front='Body'

if r._hasPhysicalRoot then
r._path=string.sub(r._path,2)
return d.rootDir()
elseif r.prefix~=nil then
if r.prefix:hasImplicitRoot()and not r.prefix:isVerbatim()then
return d.rootDir()
end
elseif r:includeCurDir()then
r._path=string.sub(r._path,2)
return d.curDir()
end
elseif s=='Body'then
if r._path~=''then
local t,u=r:parseNextComponent()
r._path=string.sub(r._path,t+1)

if u~=nil then
return u
end
else
r._front='Done'
end
else
error'unreachable'
end
end

return nil
end

function o.collect(q)
local r=q

return n.fromFn(function()
return r:next()
end)
end

function o.rev(q)
local r=q

return e.new(r:clone())
end

function o.nextBack(q)
local r=q

while not r:finished()do
local s=r._back

if s=='Body'then
if#r._path>r:lenBeforeBody()then
local t,u=r:parseNextComponentBack()
r._path=string.sub(r._path,1,#r._path-t)

if u~=nil then
return u
end
else
r._back='StartDir'
end
elseif s=='StartDir'then
r._back='Prefix'
if r._hasPhysicalRoot then
r._path=string.sub(r._path,1,#r._path-1)
return d.rootDir()
elseif r.prefix~=nil then
local t=r.prefix
if t:hasImplicitRoot()and not t:isVerbatim()then
return d.rootDir()
end
elseif r:includeCurDir()then
r._path=string.sub(r._path,1,#r._path-1)
return d.curDir()
end
elseif s=='Prefix'then
r._back='Done'

if r:prefixLen()>0 then
return d.prefix(r._path,(r.prefix))
end
else
error'unreachable'
end
end

return nil
end

function o.clone(q)
local r=q

local s=(table.clone(r))

if s.prefix then
s.prefix=s.prefix:clone()
end

return(setmetatable(s,p))
end

function o.equal(q,r)
local s=q
local t=r




if
#s._path==#t._path
and s._front==t._front
and s._back=='Body'
and t._back=='Body'
and s:prefixVerbatim()==t:prefixVerbatim()
then


if s._path==t._path then
return true
end
end


local u=s:clone()
local v=t:clone()

local w=u:nextBack()
local x=v:nextBack()

while w and x do
if not w:equal(x)then
return false
end
w=u:nextBack()
x=v:nextBack()
end

return w==nil and x==nil
end

return o end function b.ar()

b.load'ao'






local function iterAfter(
c,
d
)

while true do

local e=c:clone()
local h=e:next()
local j=d:next()




if h~=nil and j~=nil then
if not h:equal(j)then
return nil
end
elseif j==nil then
return c
else
return nil
end
c=e
end
end

return iterAfter end function b.as()



local c=b.load'ai'

b.load'ao'
local d=b.load'aq'
b.load'aj'
local e=b.load'ar'
local h=b.load'an'

local j=c.Array

local m=h.isSepByte
local n=h.parsePrefix
local o=h.MAIN_SEPARATOR_STR

local p=o=='\\'





local function hasRedoxScheme(q)
return false
end
















local q={}
local r={
__index=q,
}

local function newAncestors(s)
local t={
_next=s,
}

return(setmetatable(t,r))
end

function q.next(s)
local t=s

local u=t._next
t._next=u and u:parent()

return u
end

function q.collect(s)
local t=s

return j.fromFn(function()
return t:next()
end)
end

















































local s={}
local t={
__index=s,
__tostring=function(t)
return t:toString()
end,
}


local function rsplitFileAtDot(u)
if u=='..'then
return u,nil
end






local v=string.reverse(u)
local w=#u
local x=string.find(v,'.',1,true)

local y=x and(1+w-x)

if y==nil then
return u,nil
end

local z=y and string.sub(u,y+1)
local A=y and string.sub(u,1,y-1)

if A==''then
return u,nil
else
return A,z
end
end

local function splitFileAtDot(u)
if u=='..'then
return u,nil
end





local v=string.find(u,'.',2,true)
if v==nil then
return u,nil
else
local w=string.sub(u,1,v-1)
local x=string.sub(u,v+1)

return w,x
end
end


local function hasPhysicalRoot(u,v)
local w=if v~=nil then string.sub(u,v:len()+1)else u
return w~=''and m(string.sub(w,1,1))
end

function s.new(u)
local v={
_inner=u,

_prefix=nil,
}

return(setmetatable(v,t))
end

function s.from(u)
local v=type(u)
if v=='string'then
return s.new(u)
elseif s.is(u)then
return u
elseif d.is(u)then
return s.new(u:asPathString())
end

error'unable to create path from value'
end

function s.is(u)
return type(u)=='table'and getmetatable(u)==t
end

function s.toString(u)
local v=u

return v._inner
end

function s.toPathBuf(u)
local v=u

return(setmetatable(table.clone(v),t))
end

function s.isAbsolute(u)
local v=u






return v:hasRoot()and((not p)or v:_prefix()~=nil)

end

function s.isRelative(u)
return not u:isAbsolute()
end

function s.hasRoot(u)
local v=u
return v:components():hasRoot()
end

function s.parent(u)
local v=u
local w=v:components()
local x=w:nextBack()

if x then
local y=x.type

if y=='normal'or y=='curDir'or y=='parentDir'then
return s.new(w:asPathString())
end
end
return nil
end

function s.ancestors(u)
local v=u

return newAncestors(v)
end

function s.fileName(u)
local v=u:components()
local w=v:nextBack()

return if w and w.type=='normal'then(w).value else nil
end

function s.stripPrefix(u,v)
local w=e(u:components(),s.from(v):components())

return w and s.from(w:asPathString())
end

function s.startsWith(u,v)
return e(u:components(),s.from(v):components())~=nil
end

function s.endsWith(u,v)
return e(u:components():rev(),s.from(v):components():rev())~=nil
end

function s.fileStem(u)
local v=u:fileName()

if v then
local w,x=rsplitFileAtDot(v)

return w or x
end

return nil
end

function s.filePrefix(u)
local v=u:fileName()

if v then
local w,x=splitFileAtDot(v)

return w or x
end

return nil
end

function s.extension(u)
local v=u:fileName()

if v then
local w,x=rsplitFileAtDot(v)

return w and x
end

return nil
end

function s.join(u,v)
local w=u

local x=w:toPathBuf()
x:push(v)
return x
end

function s.withFileName(u,v)
local w=u

local x=w:toPathBuf()
x:setFileName(v)
return x
end

function s.withExtension(u,v)
local w=u

local x=w:toPathBuf()
x:setExtension(v)
return x
end

function s.components(u)
local v=u
local w=n(v._inner)
return d.new(
v._inner,
w,
hasPhysicalRoot(v._inner,w)or hasRedoxScheme(v._inner)
)
end

function s.equal(u,v)
local w=u
return w:components():equal(v:components())
end

function s.push(u,v)
local w=u

local x=(s.from(v))


local y=if w._inner==''
then false
else not m(string.sub(w._inner,-1,-1))


local z=w:components()

if
z:prefixLen()>0
and z:prefixLen()==#(z)._path
and((z.prefix)):isDrive()
then
y=false
end


if x:isAbsolute()or x:_prefix()~=nil then
w._inner=''


elseif z:prefixVerbatim()and x._inner~=''then
local A=z:collect()
for B,C in x:components():collect()do
if C.type=='rootDir'then
A={A[1],C}
elseif C.type=='curDir'then

elseif C.type=='parentDir'then
local D=#A
if D>0 and A[D].type=='normal'then
table.remove(A)
end
else
table.insert(A,C)
end
end

local D={}
local E=false

for F,G in A do
if E and G.type~='rootDir'then
table.insert(D,o)
end
table.insert(D,G:toString())

local H=(G).parsed
E=if G.type=='rootDir'
then false
elseif H then not H:isDrive()and H:len()>0
else true
end

w._inner=table.concat(D,'')
return


elseif x:hasRoot()then
local A=w:components():prefixRemaining()

w._inner=string.sub(w._inner,1,A)


elseif y then
w._inner..=o
end

w._inner..=x._inner
end

function s.pop(u)
local v=u
local w=(v:parent())
if w~=nil then
v._inner=w._inner
return true
else
return false
end
end

function s.setFileName(u,v)
local w=u

if w:fileName()~=nil then
w:pop()
end
w:push(v)
end

function s.setExtension(u,v)
local w=u

local x=w:fileStem()

if x==nil then
return false
end

local y=x

w._inner=string.sub(w._inner,1,#y)

if v~=''then
w._inner..='.'..v
end

return true
end

function s.clear(u)
local v=u
v._inner=''
end

function s._prefix(u)
local v=u
return v:components().prefix
end

return s end end

local c=b.load'as'




return{
Path=c,
}end function a.i()


local b=require"@lune/fs"
local c=require"@lune/process"
local d=a.load'g'
local e={}

export type Path=types.Path
export type AsPath=types.AsPath
export type Metadata=fs.Metadata
export type MetadataKind=fs.MetadataKind
export type MetadataPermissions=fs.MetadataPermissions
export type WriteOptions=fs.WriteOptions
export type Contents=buffer|string

local function asPathToString(h:types.AsPath):string
if type(h)=="string"then
return h
end
return e.Path.from(h):toString()
end

function e.copy(h:types.AsPath,j:types.AsPath,m:(fs.WriteOptions|boolean)?)
return b.copy(asPathToString(h),asPathToString(j),m)
end

function e.isDir(h:types.AsPath)
return b.isDir(asPathToString(h))
end

function e.isFile(h:types.AsPath)
return b.isFile(asPathToString(h))
end

function e.metadata(h:types.AsPath)
return b.metadata(asPathToString(h))
end

function e.move(h:types.AsPath,j:types.AsPath,m:(fs.WriteOptions|boolean)?)
return b.move(asPathToString(h),asPathToString(j),m)
end

function e.readDir(h:types.AsPath)
return b.readDir(asPathToString(h))
end

function e.readFile(h:types.AsPath)
return b.readFile(asPathToString(h))
end

function e.removeDir(h:types.AsPath)
return b.removeDir(asPathToString(h))
end

function e.removeFile(h:types.AsPath)
return b.removeFile(asPathToString(h))
end

function e.writeFile(h:types.AsPath,j:Contents)
return b.writeFile(asPathToString(h),j)
end

function e.writeDir(h:types.AsPath)
return b.writeDir(asPathToString(h))
end

function e.getScriptPath():types.Path
local h=string.match(debug.info(2,"s"),'%[string "([^"]*)"%]')
local j=h..".luau"
local m=h..".lua"
if b.isFile(j)then
return e.Path.from(j)
elseif b.isFile(m)then
return e.Path.from(m)
elseif b.isFile(h)then
return e.Path.from(h)
else
error"Failed to get script path"
end
end

function e.normalizePath(h:pathfs.Path):types.Path
return e.Path.from(h:components())
end

function e.getAbsolutePathOf(h:pathfs.Path):types.Path
return e.normalizePath(e.cwd:join(h))
end

function e.getNoCurDirPathOf(h:pathfs.Path):types.Path
local j=h:components()
local m=j:next()
if m.type=="curDir"then
return e.Path.from(j)
end
return h
end

e.pathSeparator=c.os=="windows"and"\\"or"/"


_G.SYS_PATH_SEPARATOR=e.pathSeparator

e.Path=a.load'h'.Path::{
new:()->types.Path,
from:(path:types.AsPath)->types.Path,
is:(value:unknown)->boolean
}

e.cwd=e.normalizePath(e.Path.from(c.cwd))

return e end function a.j()

local b=require"@lune/serde"
local c=require"@lune/process"

local d=a.load'i'

local e:pathfs.Path
local h:pathfs.Path
local j="rbx-profile"
local m=d.cwd

if c.env.XDG_CONFIG_HOME then
e=d.Path.from(`{c.env.XDG_CONFIG_HOME}/.config/{j}`)
else
e=d.Path.from(`{c.env.HOME}/.config/{j}`)
end

if c.env.XDG_DATA_HOME then
h=d.Path.from(`{c.env.XDG_DATA_HOME}/.config/{j}`)
else
h=d.Path.from(`{c.env.HOME}/.local/share/{j}`)
end

local n="profiles.toml"
local o=h:join"disabled-plugins"
local p=m:join(n)
local q=e:join(n)
local r=d.Path.from(`{c.env.HOME}/AppData/Local/Roblox/Plugins`)

type ProfileData={
plugins:{[string]:string|number},
profiles:{
[string]:{
enabled:{string},
description:string?
}
}
}

local s:ProfileData
local t:pathfs.Path

if d.isFile(p)then
s=b.decode("toml",d.readFile(p))
t=p
else
s=b.decode("toml",d.readFile(q))
t=q
end

d.writeDir(o)
d.writeDir(h)
d.writeDir(e)

local u={
directories={
config=e,
disabledPlugins=o,
enabledPlugins=r,
},
profileData=s,
configFile=t,
}

return table.freeze(u)end function a.k()

local b=a.load'i'
local c=a.load'j'

local function attemptMove(d:pathfs.Path|string,e:pathfs.Path|string)
if tostring(d)~=tostring(e)then
b.move(d,e)
end
end




local function getPluginFileName(d:string):pathfs.Path
local e=c.profileData.plugins[d]
local h:pathfs.Path

if typeof(e)=="string"then
h=b.Path.from(e)
else
h=b.Path.from(d)
end

if not h:extension()then
h=h:withExtension"rbxm"
end

return h
end

local function getPluginFilePath(d:string):pathfs.Path?
local e=getPluginFileName(d)

if not e:extension()then
e=e:withExtension"rbxm"
end

local h=c.directories.enabledPlugins:join(e)

if not b.isFile(h)then
h=c.directories.disabledPlugins:join(e)
end

if b.isFile(h)then
return h
end

return
end

local function setPluginEnabled(d:string,e:boolean):(boolean,string?)
local h=getPluginFileName(d)
local j=getPluginFilePath(d)

if not j then
return false,`Failed to find file for '{d}'`
end

if e then
attemptMove(j,c.directories.enabledPlugins:join(h))
else
attemptMove(j,c.directories.disabledPlugins:join(h))
end

return true
end

return{
setPluginEnabled=setPluginEnabled,
getPluginFilePath=getPluginFilePath,
}end function a.l()

local b=require"@lune/net"
local c=require"@lune/stdio"

local d=a.load'a'
local e=a.load'j'
local h=a.load'k'
local j=a.load'i'

return function()
for m,n in e.profileData.plugins do
if typeof(n)=="string"then
continue
end

if h.getPluginFilePath(m)then
print(`'{m}' is already installed, skipping`)
continue
end

local o=j.Path.from(`{e.directories.disabledPlugins}/{m}.rbxm`)
local p=b.request{
url=`https://assetdelivery.roblox.com/v1/asset/?id={n}`,
method="GET",
}

if not p.ok then
d.Error(`Failed to install plugin '{m}', GOT {p.statusCode}, {p.statusMessage}`)
continue
end

j.writeFile(o,p.body)
c.write(`Installed plugin {m}.rbxm\n`)

c.write(c.color"green")
c.write"Finished installing plugins\n"
c.write(c.color"reset")
end
end end function a.m()

local b=require"@lune/stdio"
local c=a.load'j'

return function()
print"Profiles:"

for d,e in c.profileData.profiles do
b.write(`{d} `)

if e.description then
b.write(b.style"bold")
b.write(`# {e.description}`)
end

b.write"\n"
b.write(b.style"reset")
end
end end function a.n()

local b=require"@lune/stdio"

local c=a.load'a'
local d=a.load'j'
local e=a.load'k'

return function(h)
local j=d.profileData.profiles[h]

if not j then
c.Error(`Invalid profile '{h}'`)
end

local m={}
local n={}

for o in d.profileData.plugins do
local p=table.find(j.enabled,o)~=nil
local q,r=e.setPluginEnabled(o,p)

if not q then
c.Error(r::any)
continue
end

if p then

table.insert(m,o)
else

table.insert(n,o)
end
end

print"\nEnabled Plugins:"
b.write(b.color"green")
for p,q in m do
b.write(`- {q}\n`)
end
b.write(b.color"reset")

print"\nDisabled Plugins:"
b.write(b.color"red")
for r,s in n do
b.write(`- {s}\n`)
end
b.write(b.color"reset")
end end end

local b=require"@lune/process"

local c="v1.2.0"

local d={
install=a.load'l',
list=a.load'm',
use=a.load'n',
version=function()
print(`rbx-profile {c}`)
end,
}

local e=b.args[1]

if d[e]then
return d[e](unpack(b.args,2))
else
print(`Invalid command '{e}'`)
end