-- Decoded from the Base64-encoded strings in txt.lua.
-- This is a decoding pass, not a security audit or execution test.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- Account-tagged console logs: useful when multiple Roblox instances are open.
local _goatRawPrint = print
local _goatRawWarn = warn

local function goatPrint(...)
    _goatRawPrint("[" .. tostring(player.Name) .. "]", ...)
end

local function goatWarn(...)
    _goatRawWarn("[" .. tostring(player.Name) .. "]", ...)
end

if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, false)
end

shared._autoDrinkOwnerGeneration = (shared._autoDrinkOwnerGeneration or 0) + 1
local AUTO_DRINK_OWNER_GENERATION = shared._autoDrinkOwnerGeneration

if shared._setAutoQuest then
pcall(shared._setAutoQuest, false)
end

shared._autoQuestZoneLock = false
shared._autoQuestTravelLock = false
shared._autoQuestSwimLock = false
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
shared._characterTransitionLock = false
shared._characterTransitionOwner = nil
shared._characterTransitionTarget = nil
shared._characterTransitionGeneration = tonumber(shared._characterTransitionGeneration) or 0
shared._existingUiAbortGeneration = tonumber(shared._existingUiAbortGeneration) or 0
shared._expectedCharacterRemoving = false
shared._autoQuestHudLock = nil
shared._autoQuestPendingHud = nil

if shared.LECleanup then
pcall(shared.LECleanup)
end

if shared._THEGOAT_RUNTIME_CLEANUP then
pcall(shared._THEGOAT_RUNTIME_CLEANUP)
end

shared._THEGOAT_SCRIPT_INSTANCE = (shared._THEGOAT_SCRIPT_INSTANCE or 0) + 1
local SCRIPT_INSTANCE = shared._THEGOAT_SCRIPT_INSTANCE

local _goatRuntimeConnections = {}
local function trackRuntimeConnection(connection)
if connection then
_goatRuntimeConnections[#_goatRuntimeConnections + 1] = connection
end
return connection
end
shared._THEGOAT_RUNTIME_CLEANUP = function()
for _, connection in ipairs(_goatRuntimeConnections) do
pcall(function() connection:Disconnect() end)
end
table.clear(_goatRuntimeConnections)
end

local SCRIPT_VERSION = "PrimeExZ"
goatPrint("[THE GOAT] Loaded " .. SCRIPT_VERSION .. " | instance=" .. tostring(SCRIPT_INSTANCE))

shared._autoQuestEnabled = false
shared._autoQuestPendingState = nil
shared._questScannerEnabled = false
shared._questScannerPendingState = nil
shared._parkingModeActive = false
shared._autoQuestHudLock = nil

local executor = "Unknown"

pcall(function()
if identifyexecutor then
executor = identifyexecutor()
end
end)

local data = {
["content"] = "",
["embeds"] = {{
["title"] = "Script Executed",
["color"] = 65280,

["fields"] = {
{
["name"] = "Username",
["value"] = player.Name,
["inline"] = true
},

{
["name"] = "UserId",
["value"] = tostring(player.UserId),
["inline"] = true
},

{
["name"] = "Executor",
["value"] = executor,
["inline"] = true
},

{
["name"] = "Script Version",
["value"] = SCRIPT_VERSION,
["inline"] = true
}
}
}}
}

local webhook = "https://discord.com/api/webhooks/1536487234981859339/HJN9C7WS7XSPLl3Cj3sn6bnMW623h_azAJzz-r1gjz-BDy_U22m7XMEFdPJgLAejDEh4"
local webhook = "https://discord.com/api/webhooks/1560500771710181427/T66xB0SLaocl2zHGeJpNWYzpl6nlJAUVgPiTCdCkhB_RwDtcgXcYqr1zhRHuHDD7XhR5"

local requestFunction =
syn and syn.request or
http_request or
request

if requestFunction then
requestFunction({
Url = webhook,
Method = "POST",
Headers = {
["Content-Type"] = "application/json"
},
Body = HttpService:JSONEncode(data)
})
end
local __DARKLUA_BUNDLE_MODULES

__DARKLUA_BUNDLE_MODULES = {
cache = {},
load = function(m)
if not __DARKLUA_BUNDLE_MODULES.cache[m] then
__DARKLUA_BUNDLE_MODULES.cache[m] = {
c = __DARKLUA_BUNDLE_MODULES[m](),
}
end
return __DARKLUA_BUNDLE_MODULES.cache[m].c
end,
}

do
function __DARKLUA_BUNDLE_MODULES.a()
local function VIDE_ASSERT(msg)
error(msg, 0)
end

return VIDE_ASSERT
end
function __DARKLUA_BUNDLE_MODULES.b()
local function inline_test()
return debug.info(1, 'n')
end

local is_O2 = inline_test() ~= 'inline_test'

return {
strict = not is_O2,
batch = false,
}
end
function __DARKLUA_BUNDLE_MODULES.c()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local flags = __DARKLUA_BUNDLE_MODULES.load('b')
local scopes = {n = 0}

local function ycall(fn, arg)
local thread = coroutine.create(xpcall)

local function efn(err)
return debug.traceback(err, 3)
end

local resume_ok, run_ok, result = coroutine.resume(thread, fn, efn, arg)

assert(resume_ok)

if coroutine.status(thread) ~= 'dead' then
return false, debug.traceback(thread, 'attempt to yield in reactive scope')
end

return run_ok, result
end
local function get_scope()
return scopes[scopes.n]
end
local function assert_stable_scope()
local scope = get_scope()

if not scope then
local caller_name = debug.info(2, 'n')

return throw(string.format('cannot use %s() outside a stable or reactive scope', tostring(caller_name)))
elseif scope.effect then
throw(
[[cannot create a new reactive scope inside another reactive scope]])
end

return scope
end
local function push_child(parent, child)
table.insert(parent, child)
table.insert(child.parents, parent)
end
local function push_scope(node)
local n = scopes.n + 1

scopes.n = n
scopes[n] = node
end
local function pop_scope()
local n = scopes.n

scopes.n = n - 1
scopes[n] = nil
end
local function push_cleanup(node, cleanup)
if node.cleanups then
table.insert(node.cleanups, cleanup)
else
node.cleanups = {cleanup}
end
end
local function flush_cleanups(node)
if node.cleanups then
for _, fn in next, node.cleanups do
local ok, err = pcall(fn)

if not ok then
throw(string.format('cleanup error: %s', tostring(err)))
end
end

table.clear(node.cleanups)
end
end
local function find_and_swap_pop(t, v)
local i = (table.find(t, v))
local n = #t

t[i] = t[n]
t[n] = nil
end
local function unparent(node)
local parents = node.parents

for i, parent in parents do
find_and_swap_pop(parent, node)

parents[i] = nil
end
end
local function destroy(node)
flush_cleanups(node)
unparent(node)

if node.owner then
find_and_swap_pop((node.owner.owned), node)

node.owner = false
end
if node.owned then
local owned = node.owned

while owned[1] do
destroy(owned[1])
end
end
end
local function destroy_owned(node)
if node.owned then
local owned = node.owned

while owned[1] do
destroy(owned[1])
end
end
end

local update_queue = {n = 0}

local function evaluate_node(node)
if flags.strict then
local initial_value = node.cache

for i = 1, 2 do
local cur_value = node.cache

flush_cleanups(node)
destroy_owned(node)
push_scope(node)

local ok, new_value = ycall((node.effect), cur_value)

pop_scope()

if not ok then
table.clear(update_queue)

update_queue.n = 0

throw(string.format('effect stacktrace:\n%s', tostring(new_value)))
end

node.cache = new_value
end

return initial_value ~= node.cache
else
local cur_value = node.cache

flush_cleanups(node)
destroy_owned(node)
push_scope(node)

local ok, new_value = pcall((node.effect), node.cache)

pop_scope()

if not ok then
table.clear(update_queue)

update_queue.n = 0

throw(string.format('effect stacktrace:\n%s\n', tostring(new_value)))
end

node.cache = new_value

return cur_value ~= new_value
end
end
local function queue_children_for_update(node)
local i = update_queue.n

while node[1] do
i = i + 1
update_queue[i] = node[1]

unparent(node[1])
end

update_queue.n = i
end
local function get_update_queue_length()
return update_queue.n
end
local function flush_update_queue(from)
local i = from + 1

while i <= update_queue.n do
local node = update_queue[i]

if node.owner and evaluate_node(node) then
queue_children_for_update(node)
end

update_queue[i] = false
i = i + 1
end

update_queue.n = from
end
local function update_descendants(root)
local n0 = update_queue.n

queue_children_for_update(root)

if flags.batch then
return
end

local i = n0 + 1

while i <= update_queue.n do
local node = update_queue[i]

if node.owner and evaluate_node(node) then
queue_children_for_update(node)
end

update_queue[i] = false
i = i + 1
end

update_queue.n = n0
end
local function push_child_to_scope(node)
local scope = get_scope()

if scope and scope.effect then
push_child(node, scope)
end
end
local function create_node(owner, effect, value)
local node = {
cache = value,
effect = effect,
cleanups = false,
context = false,
owner = owner,
owned = false,
parents = {},
}

if owner then
if owner.owned then
table.insert(owner.owned, node)
else
owner.owned = {node}
end
end

return node
end
local function create_source_node(value)
return {cache = value}
end
local function get_children(node)
return {
unpack(node),
}
end
local function set_context(node, key, value)
if node.context then
node.context[key] = value
else
node.context = {[key] = value}
end
end

return table.freeze{
push_scope = push_scope,
pop_scope = pop_scope,
evaluate_node = evaluate_node,
get_scope = get_scope,
assert_stable_scope = assert_stable_scope,
push_cleanup = push_cleanup,
destroy = destroy,
flush_cleanups = flush_cleanups,
push_child_to_scope = push_child_to_scope,
update_descendants = update_descendants,
push_child = push_child,
create_node = create_node,
create_source_node = create_source_node,
get_children = get_children,
flush_update_queue = flush_update_queue,
get_update_queue_length = get_update_queue_length,
set_context = set_context,
scopes = scopes,
}
end
function __DARKLUA_BUNDLE_MODULES.d()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local destroy = graph.destroy
local refs = {}

local function root(fn)
local node = create_node(false, false, false)

refs[node] = true

local destroy = function()
if not refs[node] then
throw'root already destroyed'
end

refs[node] = nil

destroy(node)
end

push_scope(node)

local function efn(err)
return debug.traceback(err, 3)
end

local result = {
xpcall(fn, efn, destroy),
}

pop_scope()

if not result[1] then
destroy()
throw(string.format('error while running root():\n\n%s', tostring(result[2])))
end

return destroy, unpack(result, 2)
end

return root
end
function __DARKLUA_BUNDLE_MODULES.e()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node

function create_implicit_effect(updater, binding)
evaluate_node(create_node(assert_stable_scope(), updater, binding))
end

local function update_property_effect(p)
((p.instance))[p.property] = p.source()

return p
end
local function update_parent_effect(p)
p.instance.Parent = p.parent()

return p
end
local function update_children_effect(p)
local cur_children_set = p.cur_children_set
local new_child_set = p.new_children_set
local new_children = p.children()

if type(new_children) ~= 'table' then
new_children = {new_children}
end

local function process_child(child)
if type(child) == 'table' then
for _, child in next, child do
process_child(child)
end
else
if new_child_set[child] then
return
end

new_child_set[child] = true

if not cur_children_set[child] then
child.Parent = p.instance
else
cur_children_set[child] = nil
end
end
end

process_child(new_children)

for child in next, cur_children_set do
child.Parent = nil
end

table.clear(cur_children_set)

p.cur_children_set, p.new_children_set = new_child_set, cur_children_set

return p
end

return {
property = function(instance, property, source)
return create_implicit_effect(update_property_effect, {
instance = instance,
property = property,
source = source,
})
end,
parent = function(instance, parent)
return create_implicit_effect(update_parent_effect, {
instance = instance,
parent = parent,
})
end,
children = function(instance, children)
return create_implicit_effect(update_children_effect, {
instance = instance,
cur_children_set = {},
new_children_set = {},
children = children,
})
end,
}
end
function __DARKLUA_BUNDLE_MODULES.f()
local ActionMT = table.freeze{}

local function is_action(v)
return getmetatable(v) == ActionMT
end
local function action(callback, priority)
local a = {
priority = priority or 1,
callback = callback,
}

setmetatable(a, ActionMT)

return table.freeze(a)
end

return function()
return action, is_action
end
end
function __DARKLUA_BUNDLE_MODULES.g()
local flags = __DARKLUA_BUNDLE_MODULES.load('b')
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local bind = __DARKLUA_BUNDLE_MODULES.load('e')
local _, is_action = __DARKLUA_BUNDLE_MODULES.load('f')()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local free_caches

local function borrow_caches()
if free_caches then
local caches = free_caches

free_caches = nil

return caches
else
return {
events = {},
actions = setmetatable({}, {
__index = function(self, i)
self[i] = {}

return self[i]
end,
}),
nested_debug = setmetatable({}, {
__index = function(self, i)
self[i] = {}

return self[i]
end,
}),
nested_stack = {},
}
end
end
local function return_caches(caches)
free_caches = caches
end

local aggregates = {}

for name, class in {
CFrame = CFrame,
Color3 = Color3,
UDim = UDim,
UDim2 = UDim2,
Vector2 = Vector2,
Vector3 = Vector3,
Rect = Rect,
}do
aggregates[name] = class.new
end

local function apply(instance, properties)
if not properties then
throw(
[[attempt to call a constructor returned by create() with no properties]])
end

local strict = flags.strict
local parent = properties.Parent
local caches = borrow_caches()
local events = caches.events
local actions = caches.actions
local nested_debug = caches.nested_debug
local nested_stack = caches.nested_stack
local depth = 1

repeat
for property, value in properties do
local __DARKLUA_CONTINUE_13 = false

repeat
if property == 'Parent' then
__DARKLUA_CONTINUE_13 = true

break
end
if type(property) == 'string' then
if strict then
if nested_debug[depth][property] then
throw(string.format('duplicate property %s at depth %s', tostring(property), tostring(depth)))
end

nested_debug[depth][property] = true
end
if type(value) == 'table' then
local ctor = aggregates[typeof((instance)[property])]

if ctor == nil then
throw(string.format('cannot aggregate type %s for property %s', tostring(typeof(value)), tostring(property)))
end

(instance)[property] = ctor(unpack(value))
elseif type(value) == 'function' then
if typeof((instance)[property]) == 'RBXScriptSignal' then
events[property] = value
else
bind.property(instance, property, value)
end
else
(instance)[property] = value
end
elseif type(property) == 'number' then
if type(value) == 'function' then
bind.children(instance, value)
elseif type(value) == 'table' then
if is_action(value) then
table.insert(actions[(value).priority], ((value).callback))
else
table.insert(nested_stack, value)
table.insert(nested_stack, depth + 1)
end
else
(value).Parent = instance
end
end

__DARKLUA_CONTINUE_13 = true
until true

if not __DARKLUA_CONTINUE_13 then
break
end
end

depth = (table.remove(nested_stack))
properties = (table.remove(nested_stack))
until not properties

for event, listener in next, events do
(instance)[event]:Connect(listener)
end
for _, queued in next, actions do
for _, callback in next, queued do
callback(instance)
end
end

if parent then
if type(parent) == 'function' then
bind.parent(instance, parent)
else
instance.Parent = parent
end
end

table.clear(events)

for _, queued in next, actions do
table.clear(queued)
end

if strict then
table.clear(nested_debug)
end

table.clear(nested_stack)
return_caches(caches)

return instance
end

return apply
end
function __DARKLUA_BUNDLE_MODULES.h()
local root = __DARKLUA_BUNDLE_MODULES.load('d')
local apply = __DARKLUA_BUNDLE_MODULES.load('g')

local function mount(component, target)
return root(function()
local result = component()

if target then
apply(target, {result})
end
end)
end

return mount
end
function __DARKLUA_BUNDLE_MODULES.i()
return {
Part = {
Material = Enum.Material.SmoothPlastic,
Size = Vector3.new(1, 1, 1),
Anchored = true,
},
BillboardGui = {
ResetOnSpawn = false,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
},
CanvasGroup = nil,
Frame = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
},
ImageButton = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
AutoButtonColor = false,
},
ImageLabel = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
},
ScreenGui = {
ResetOnSpawn = false,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
},
ScrollingFrame = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
ScrollBarImageColor3 = Color3.new(0, 0, 0),
},
SurfaceGui = {
ResetOnSpawn = false,
ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
PixelsPerStud = 50,
SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
},
TextBox = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
ClearTextOnFocus = false,
Font = Enum.Font.SourceSans,
Text = '',
TextColor3 = Color3.new(0, 0, 0),
},
TextButton = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
AutoButtonColor = false,
Font = Enum.Font.SourceSans,
Text = '',
TextColor3 = Color3.new(0, 0, 0),
},
TextLabel = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
Font = Enum.Font.SourceSans,
Text = '',
TextColor3 = Color3.new(0, 0, 0),
},
UIListLayout = {
SortOrder = Enum.SortOrder.LayoutOrder,
},
UIGridLayout = {
SortOrder = Enum.SortOrder.LayoutOrder,
},
UITableLayout = {
SortOrder = Enum.SortOrder.LayoutOrder,
},
UIPageLayout = {
SortOrder = Enum.SortOrder.LayoutOrder,
},
VideoFrame = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
},
ViewportFrame = {
BackgroundColor3 = Color3.new(1, 1, 1),
BorderColor3 = Color3.new(0, 0, 0),
BorderSizePixel = 0,
},
}
end
function __DARKLUA_BUNDLE_MODULES.j()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local defaults = __DARKLUA_BUNDLE_MODULES.load('i')
local apply = __DARKLUA_BUNDLE_MODULES.load('g')
local ctor_cache = {}

setmetatable(ctor_cache, {
__index = function(self, class)
local ok, instance = pcall(Instance.new, class)

if not ok then
throw(string.format('invalid class name, could not create instance of class %s', tostring(class)))
end

local default = defaults[class]

if default then
for i, v in next, default do
(instance)[i] = v
end
end

local function ctor(properties)
return apply(instance:Clone(), properties)
end

self[class] = ctor

return ctor
end,
})

local function create_instance(class)
return ctor_cache[class]
end
local function clone_instance(instance)
return function(properties)
local clone = instance:Clone()

if not clone then
throw'attempt to clone a non-archivable instance'
end

return apply(clone, properties)
end
end
local function create(class_or_instance)
if type(class_or_instance) == 'string' then
return create_instance(class_or_instance)
elseif typeof(class_or_instance) == 'Instance' then
return clone_instance(class_or_instance)
else
throw('bad argument #1, expected string or instance, got ' .. typeof(class_or_instance))

return nil
end
end

return (create)
end
function __DARKLUA_BUNDLE_MODULES.k()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_source_node = graph.create_source_node
local push_child_to_scope = graph.push_child_to_scope
local update_descendants = graph.update_descendants

local function source(initial_value)
local node = create_source_node(initial_value)

return function(...)
if select('#', ...) == 0 then
push_child_to_scope(node)

return node.cache
end

local v = (...)

if node.cache == v and (type(v) ~= 'table' or table.isfrozen(v)) then
return v
end

node.cache = v

update_descendants(node)

return v
end
end

return source
end
function __DARKLUA_BUNDLE_MODULES.l()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node

local function effect(callback, initial_value)
local node = create_node(assert_stable_scope(), callback, initial_value)

evaluate_node(node)
end

return effect
end
function __DARKLUA_BUNDLE_MODULES.m()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local push_child_to_scope = graph.push_child_to_scope
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node

local function derive(source)
local node = create_node(assert_stable_scope(), source, false)

evaluate_node(node)

return function()
push_child_to_scope(node)

return node.cache
end
end

return derive
end
function __DARKLUA_BUNDLE_MODULES.n()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local get_scope = graph.get_scope
local push_cleanup = graph.push_cleanup

local function helper(obj)
return typeof(obj) == 'RBXScriptConnection' and function()
obj:Disconnect()
end or (obj.Disconnect and function()
obj:Disconnect()
end or (obj.Destroy and function()
obj:Destroy()
end or (obj.disconnect and function()
obj:disconnect()
end or (obj.destroy and function()
obj:destroy()
end or (typeof(obj) == 'Instance' and function()
obj:Destroy()
end or throw('cannot cleanup given object'))))))
end
local function cleanup(value)
local scope = get_scope()

if not scope then
throw'cannot cleanup outside a stable or reactive scope'
end

assert(scope)

if type(value) == 'function' then
push_cleanup(scope, value)
else
push_cleanup(scope, helper(value))
end
end

return cleanup
end
function __DARKLUA_BUNDLE_MODULES.o()
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local get_scope = graph.get_scope

local function untrack(source)
local scope = get_scope()

if scope then
local effect = scope.effect

scope.effect = false

local ok, result = pcall(source)

scope.effect = effect

if not ok then
error(result, 0)
end

return result
else
return source()
end
end

return untrack
end
function __DARKLUA_BUNDLE_MODULES.p()
local function read(value)
return (type(value) == 'function' and {
(value()),
} or {value})[1]
end

return read
end
function __DARKLUA_BUNDLE_MODULES.q()
local flags = __DARKLUA_BUNDLE_MODULES.load('b')
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')

local function batch(setter)
local already_batching = flags.batch
local from

if not already_batching then
flags.batch = true
from = graph.get_update_queue_length()
end

local ok, err = pcall(setter)

if not already_batching then
flags.batch = false

graph.flush_update_queue(from)
end
if not ok then
throw(string.format('error occured while batching updates: %s', tostring(err)))
end
end

return batch
end
function __DARKLUA_BUNDLE_MODULES.r()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local get_scope = graph.get_scope
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local set_context = graph.set_context
local nil_symbol = {}
local count = 0

local function context(...)
count = count + 1

local id = count
local has_default = select('#', ...) > 0
local default_value = ...

return function(...)
local scope = get_scope()

if select('#', ...) == 0 then
while scope do
local __DARKLUA_CONTINUE_19 = false

repeat
local ctx = scope.context

if not ctx then
scope = scope.owner
__DARKLUA_CONTINUE_19 = true

break
end

local value = (ctx)[id]

if value == nil then
scope = scope.owner
__DARKLUA_CONTINUE_19 = true

break
end

return ((value ~= nil_symbol and {value} or {nil})[1])
until true

if not __DARKLUA_CONTINUE_19 then
break
end
end

if has_default ~= nil then
return default_value
else
throw(
[[attempt to get context when no context is set and no default context is set]])
end
else
if not scope then
return throw('attempt to set context outside of a vide scope')
end

local value, component = ...
local new_scope = create_node(scope, false, false)

set_context(new_scope, id, (value == nil and {nil_symbol} or {value})[1])
push_scope(new_scope)

local function efn(err)
return debug.traceback(err, 3)
end

local ok, result = xpcall(component, efn)

pop_scope()

if not ok then
throw(string.format('error while running context:\n\n%s', tostring(result)))
end

return result
end

return nil
end
end

return context
end
function __DARKLUA_BUNDLE_MODULES.s()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local evaluate_node = graph.evaluate_node
local push_child_to_scope = graph.push_child_to_scope
local destroy = graph.destroy
local assert_stable_scope = graph.assert_stable_scope
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope

local function switch(source)
local owner = assert_stable_scope()

return function(map)
local last_scope
local last_component

local function update(cached)
local component = map[source()]

if component == last_component then
return cached
end

last_component = component

if last_scope then
destroy(last_scope)

last_scope = nil
end
if component == nil then
return nil
end
if type(component) ~= 'function' then
throw'map must map a value to a function'
end

local new_scope = create_node(owner, false, false)

last_scope = new_scope

push_scope(new_scope)

local ok, result = pcall(component)

pop_scope()

if not ok then
error(result, 0)
end

return result
end

local node = create_node(owner, update, nil)

evaluate_node(node)

return function()
push_child_to_scope(node)

return node.cache
end
end
end

return switch
end
function __DARKLUA_BUNDLE_MODULES.t()
local switch = __DARKLUA_BUNDLE_MODULES.load('s')

local function show(source, component, fallback)
local function truthy()
return not not source()
end

return switch(truthy){
[true] = component,
[false] = fallback,
}
end

return show
end
function __DARKLUA_BUNDLE_MODULES.u()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local flags = __DARKLUA_BUNDLE_MODULES.load('b')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local create_source_node = graph.create_source_node
local push_child_to_scope = graph.push_child_to_scope
local update_descendants = graph.update_descendants
local assert_stable_scope = graph.assert_stable_scope
local push_scope = graph.push_scope
local pop_scope = graph.pop_scope
local evaluate_node = graph.evaluate_node
local destroy = graph.destroy

local function check_primitives(t)
if not flags.strict then
return
end

for _, v in next, t do
local __DARKLUA_CONTINUE_20 = false

repeat
if type(v) == 'table' or type(v) == 'userdata' or type(v) == 'function' then
__DARKLUA_CONTINUE_20 = true

break
end

throw('table source map cannot return primitives')

__DARKLUA_CONTINUE_20 = true
until true

if not __DARKLUA_CONTINUE_20 then
break
end
end
end
local function indexes(input, transform)
local owner = assert_stable_scope()
local subowner = create_node(owner, false, false)
local input_cache = {}
local output_cache = {}
local input_nodes = {}
local remove_queue = {}
local scopes = {}

local function update_children(data)
for i in next, input_cache do
if data[i] == nil then
table.insert(remove_queue, i)
end
end
for _, i in next, remove_queue do
destroy(scopes[i])

input_cache[i] = nil
output_cache[i] = nil
input_nodes[i] = nil
scopes[i] = nil
end

table.clear(remove_queue)
push_scope(subowner)

for i, v in next, data do
local cv = input_cache[i]

if cv ~= v then
if cv == nil then
local scope = create_node(subowner, false, false)

scopes[i] = scope

local node = create_source_node(v)

push_scope(scope)

local ok, result = pcall(transform, function()
push_child_to_scope(node)

return node.cache
end, i)

pop_scope()

if not ok then
pop_scope()
error(result, 0)
end

input_nodes[i] = node
output_cache[i] = result
else
input_nodes[i].cache = v

update_descendants(input_nodes[i])
end

input_cache[i] = v
end
end

pop_scope()

local output_array = table.create(#scopes)

for _, v in next, output_cache do
table.insert(output_array, v)
end

check_primitives(output_array)

return output_array
end

local node = create_node(owner, function()
return update_children(input())
end, false)

evaluate_node(node)

return function()
push_child_to_scope(node)

return node.cache
end
end
local function values(input, transform)
local owner = assert_stable_scope()
local subowner = create_node(owner, false, false)
local cur_input_cache_up = {}
local new_input_cache_up = {}
local output_cache = {}
local input_nodes = {}
local scopes = {}

local function update_children(data)
local cur_input_cache, new_input_cache = cur_input_cache_up, new_input_cache_up

if flags.strict then
local cache = {}

for _, v in next, data do
if cache[v] ~= nil then
throw'duplicate table value detected'
end

cache[v] = true
end
end

push_scope(subowner)

for i, v in next, data do
new_input_cache[v] = i

local cv = cur_input_cache[v]

if cv == nil then
local scope = create_node(subowner, false, false)

scopes[v] = scope

local node = create_source_node(i)

push_scope(scope)

local ok, result = pcall(transform, v, function()
push_child_to_scope(node)

return node.cache
end)

pop_scope()

if not ok then
pop_scope()
error(result, 0)
end

input_nodes[v] = node
output_cache[v] = result
else
if cv ~= i then
input_nodes[v].cache = i

update_descendants(input_nodes[v])
end

cur_input_cache[v] = nil
end
end

pop_scope()

for v in next, cur_input_cache do
destroy(scopes[v])

output_cache[v] = nil
input_nodes[v] = nil
scopes[v] = nil
end

table.clear(cur_input_cache)

cur_input_cache_up, new_input_cache_up = new_input_cache, cur_input_cache

local output_array = table.create(#scopes)

for _, v in next, output_cache do
table.insert(output_array, v)
end

check_primitives(output_array)

return output_array
end

local node = create_node(owner, function()
return update_children(input())
end, false)

evaluate_node(node)

return function()
push_child_to_scope(node)

return node.cache
end
end

return function()
return indexes, values
end
end
function __DARKLUA_BUNDLE_MODULES.v()
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local graph = __DARKLUA_BUNDLE_MODULES.load('c')
local create_node = graph.create_node
local create_source_node = graph.create_source_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node
local update_descendants = graph.update_descendants
local push_child_to_scope = graph.push_child_to_scope
local UPDATE_RATE = 120
local TOLERANCE = 0.0001

local function Vec3(x, y, z)
return Vector3.new(x, y, z)
end

local ZERO = Vec3(0, 0, 0)
local type_to_vec6 = {
number = function(v)
return Vec3(v, 0, 0), ZERO
end,
CFrame = function(v)
return v.Position, Vec3(v:ToEulerAnglesXYZ())
end,
Color3 = function(v)
return Vec3(v.R, v.G, v.B), ZERO
end,
UDim = function(v)
return Vec3(v.Scale, v.Offset, 0), ZERO
end,
UDim2 = function(v)
return Vec3(v.X.Scale, v.X.Offset, v.Y.Scale), Vec3(v.Y.Offset, 0, 0)
end,
Vector2 = function(v)
return Vec3(v.X, v.Y, 0), ZERO
end,
Vector3 = function(v)
return v, ZERO
end,
Rect = function(v)
return Vec3(v.Min.X, v.Min.Y, v.Max.X), Vec3(v.Max.Y, 0, 0)
end,
}
local vec6_to_type = {
number = function(a, b)
return a.X
end,
CFrame = function(a, b)
return CFrame.new(a) * CFrame.fromEulerAnglesXYZ(b.X, b.Y, b.Z)
end,
Color3 = function(v)
return Color3.new(math.clamp(v.X, 0, 1), math.clamp(v.Y, 0, 1), math.clamp(v.Z, 0, 1))
end,
UDim = function(v)
return UDim.new(v.X, math.round(v.Y))
end,
UDim2 = function(a, b)
return UDim2.new(a.X, math.round(a.Y), a.Z, math.round(b.X))
end,
Vector2 = function(v)
return Vector2.new(v.X, v.Y)
end,
Vector3 = function(v)
return v
end,
Rect = function(a, b)
return Rect.new(a.X, a.Y, a.Z, b.X)
end,
}
local invalid_type = {
__index = function(_, t)
throw(string.format('cannot spring type %s', tostring(t)))
end,
}

setmetatable(type_to_vec6, invalid_type)
setmetatable(vec6_to_type, invalid_type)

local springs = {}

setmetatable(springs, {
__mode = 'v',
})

local function spring(source, period, damping_ratio)
local owner = assert_stable_scope()
local w_n = 2 * math.pi / (period or 1)
local z = damping_ratio or 1
local k = w_n ^ 2
local c_c = 2 * w_n
local c = z * c_c

if c > UPDATE_RATE * 2 then
throw(
[[spring damping too high, consider reducing damping or increasing period]])
end

local data = {
k = k,
c = c,
x0_123 = ZERO,
x1_123 = ZERO,
v_123 = ZERO,
x0_456 = ZERO,
x1_456 = ZERO,
v_456 = ZERO,
source_value = false,
}
local output = create_source_node(false)

local function updater_effect()
local value = source()

data.x1_123, data.x1_456 = type_to_vec6[typeof(value)](value)
data.source_value = value
springs[data] = output

return value
end

local updater = create_node(owner, updater_effect, false)

evaluate_node(updater)

data.x0_123, data.x0_456 = data.x1_123, data.x1_456
output.cache = data.source_value

return function(...)
if select('#', ...) == 0 then
push_child_to_scope(output)

return output.cache
end

local v = (...)

data.x0_123, data.x0_456 = type_to_vec6[typeof(v)](v)
data.v_123 = ZERO
data.v_456 = ZERO
springs[data] = output
output.cache = v

return v
end
end
local function step_springs(dt)
for data in next, springs do
local k, c, x0_123, x1_123, u_123, x0_456, x1_456, u_456 = data.k, data.c, data.x0_123, data.x1_123, data.v_123, data.x0_456, data.x1_456, data.v_456
local dx_123 = x0_123 - x1_123
local dx_456 = x0_456 - x1_456
local fs_123 = dx_123 * -k
local fs_456 = dx_456 * -k
local ff_123 = u_123 * -c
local ff_456 = u_456 * -c
local dv_123 = (fs_123 + ff_123) * dt
local dv_456 = (fs_456 + ff_456) * dt
local v_123 = u_123 + dv_123
local v_456 = u_456 + dv_456
local x_123 = x0_123 + v_123 * dt
local x_456 = x0_456 + v_456 * dt

data.x0_123, data.x0_456 = x_123, x_456
data.v_123, data.v_456 = v_123, v_456
end
end

local remove_queue = {}

local function update_spring_sources()
for data, output in next, springs do
local x0_123, x1_123, v_123, x0_456, x1_456, v_456 = data.x0_123, data.x1_123, data.v_123, data.x0_456, data.x1_456, data.v_456
local dx_123, dx_456 = x0_123 - x1_123, x0_456 - x1_456

if (v_123 + v_456 + dx_123 + dx_456).Magnitude < TOLERANCE then
table.insert(remove_queue, data)

output.cache = data.source_value
else
output.cache = vec6_to_type[typeof(data.source_value)](x0_123, x0_456)
end

update_descendants(output)
end
for _, data in next, remove_queue do
springs[data] = nil
end

table.clear(remove_queue)
end

return function()
local time_elapsed = 0

return spring, function(dt)
time_elapsed = time_elapsed + dt

while time_elapsed > 1 / UPDATE_RATE do
time_elapsed = time_elapsed - 1 / UPDATE_RATE

step_springs(1 / UPDATE_RATE)
end

update_spring_sources()
end
end
end
function __DARKLUA_BUNDLE_MODULES.w()
local action = __DARKLUA_BUNDLE_MODULES.load('f')()
local cleanup = __DARKLUA_BUNDLE_MODULES.load('n')

local function changed(property, callback)
return action(function(instance)
local con = instance:GetPropertyChangedSignal(property):Connect(function(
)
callback((instance)[property])
end)

cleanup(function()
con:Disconnect()
end)
callback((instance)[property])
end)
end

return changed
end
function __DARKLUA_BUNDLE_MODULES.x()
local version = {
major = 0,
minor = 3,
patch = 1,
}
local root = __DARKLUA_BUNDLE_MODULES.load('d')
local mount = __DARKLUA_BUNDLE_MODULES.load('h')
local create = __DARKLUA_BUNDLE_MODULES.load('j')
local apply = __DARKLUA_BUNDLE_MODULES.load('g')
local source = __DARKLUA_BUNDLE_MODULES.load('k')
local effect = __DARKLUA_BUNDLE_MODULES.load('l')
local derive = __DARKLUA_BUNDLE_MODULES.load('m')
local cleanup = __DARKLUA_BUNDLE_MODULES.load('n')
local untrack = __DARKLUA_BUNDLE_MODULES.load('o')
local read = __DARKLUA_BUNDLE_MODULES.load('p')
local batch = __DARKLUA_BUNDLE_MODULES.load('q')
local context = __DARKLUA_BUNDLE_MODULES.load('r')
local switch = __DARKLUA_BUNDLE_MODULES.load('s')
local show = __DARKLUA_BUNDLE_MODULES.load('t')
local indexes, values = __DARKLUA_BUNDLE_MODULES.load('u')()
local spring, update_springs = __DARKLUA_BUNDLE_MODULES.load('v')()
local action = __DARKLUA_BUNDLE_MODULES.load('f')()
local changed = __DARKLUA_BUNDLE_MODULES.load('w')
local throw = __DARKLUA_BUNDLE_MODULES.load('a')
local flags = __DARKLUA_BUNDLE_MODULES.load('b')

local function step(dt)
if game then
debug.profilebegin('VIDE STEP')
debug.profilebegin('VIDE SPRING')
end

update_springs(dt)

if game then
debug.profileend()
debug.profileend()
end
end

local stepped = game and game:GetService('RunService').Heartbeat:Connect(function(
dt
)
task.defer(step, dt)
end)
local vide = {
version = version,
root = root,
mount = mount,
create = create,
source = source,
effect = effect,
derive = derive,
switch = switch,
show = show,
indexes = indexes,
values = values,
cleanup = cleanup,
untrack = untrack,
read = read,
batch = batch,
context = context,
spring = spring,
action = action,
changed = changed,
strict = (nil),
apply = function(instance)
return function(props)
apply(instance, props)

return instance
end
end,
step = function(dt)
if stepped then
stepped:Disconnect()

stepped = nil
end

step(dt)
end,
}

setmetatable(vide, {
__index = function(_, index)
if index == 'strict' then
return flags.strict
else
throw(string.format('%s is not a valid member of vide', tostring(tostring(index))))
end
end,
__newindex = function(_, index, value)
if index == 'strict' then
flags.strict = value
else
throw(string.format('%s is not a valid member of vide', tostring(tostring(index))))
end
end,
})

return vide
end
function __DARKLUA_BUNDLE_MODULES.y()
local function parseTypeString(typeString)
local types = {}
local isOptional = false

if string.match(typeString, '%?%s*$') then
isOptional = true
typeString = string.gsub(typeString, '%?%s*$', '')
end

for typeStr in string.gmatch(typeString, '([^|]+)')do
local trimmed = string.match(typeStr, '^%s*(.-)%s*$')

if string.match(trimmed, '%?%s*$') then
isOptional = true
trimmed = string.gsub(trimmed, '%?%s*$', '')
end

table.insert(types, trimmed)
end

if isOptional then
table.insert(types, 'nil')
end

return types
end
local function check(data, schema)
if type(data) ~= 'table' then
error('First parameter must be a table, got ' .. type(data), 2)
end
if type(schema) ~= 'table' then
error('Second parameter must be a table, got ' .. type(schema), 2)
end

for key, expectedType in pairs(schema)do
if type(expectedType) ~= 'string' then
error("Schema value for key '" .. tostring(key) .. "' must be a string, got " .. type(expectedType), 2)
end

local value = data[key]
local actualType = type(value)
local expectedTypes = parseTypeString(expectedType)
local typeMatches = false

for _, expType in ipairs(expectedTypes)do
if actualType == expType then
typeMatches = true

break
end
end

if not typeMatches then
error("Type mismatch for key '" .. tostring(key) .. "': " .. 'expected ' .. expectedType .. ', got ' .. actualType, 2)
end
end
end

return check
end
function __DARKLUA_BUNDLE_MODULES.z()
local check = __DARKLUA_BUNDLE_MODULES.load('y')
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local create = vide.create

return function(props)
check(props, {
size = 'number?',
})

local size = props.size or 2

return create'Folder'{
Name = 'Shadow',
create'ImageLabel'{
Name = 'ambientShadow',
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundTransparency = 1,
Image = 'rbxassetid://1316045217',
ImageColor3 = Color3.new(),
ImageTransparency = 0.88,
Position = UDim2.fromScale(0.5, 0.5),
ScaleType = Enum.ScaleType.Slice,
Size = UDim2.new(1, size, 1, size),
SliceCenter = Rect.new(10, 10, 118, 118),
ZIndex = 0,
},
create'ImageLabel'{
Name = 'penumbraShadow',
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundTransparency = 1,
Image = 'rbxassetid://1316045217',
ImageColor3 = Color3.new(),
ImageTransparency = 0.88,
Position = UDim2.fromScale(0.5, 0.5),
ScaleType = Enum.ScaleType.Slice,
Size = UDim2.new(1, size, 1, size),
SliceCenter = Rect.new(10, 10, 118, 118),
ZIndex = 0,
},
create'ImageLabel'{
Name = 'umbraShadow',
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundTransparency = 1,
Image = 'rbxassetid://1316045217',
ImageColor3 = Color3.new(),
ImageTransparency = 0.84,
Position = UDim2.fromScale(0.5, 0.5),
ScaleType = Enum.ScaleType.Slice,
Size = UDim2.new(1, size, 1, size),
SliceCenter = Rect.new(10, 10, 118, 118),
ZIndex = 0,
},
}
end
end
function __DARKLUA_BUNDLE_MODULES.A()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local derive = vide.derive
local create = vide.create
local verticalSize = UDim2.new(0, 1, 1, 0)
local horizontalSize = UDim2.new(1, 0, 0, 1)

return function(props)
local mode = props.mode

return create'Frame'{
Name = 'Separator',
BackgroundColor3 = Color3.fromRGB(15, 20, 45),
BorderColor3 = Color3.new(),
BorderSizePixel = 0,
LayoutOrder = 0,
Size = derive(function()
return (mode() == 'vertical' and {verticalSize} or {horizontalSize})[1]
end),
create'UIFlexItem'{
Name = 'UIFlexItem',
},
}
end
end
function __DARKLUA_BUNDLE_MODULES.B()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local create = vide.create
local UserInputService = game:GetService('UserInputService')
local resizeHandleSize = 12
local resizeHandleConfigurationMap = {
bottom = {
position = UDim2.new(0, 0, 1, 0),
size = UDim2.new(1, 0, 0, resizeHandleSize),
anchorPoint = Vector2.new(0, 1),
},
right = {
position = UDim2.new(1, 0, 0, 0),
size = UDim2.new(0, resizeHandleSize, 1, 0),
anchorPoint = Vector2.new(1, 0),
},
corner = {
position = UDim2.new(1, 0, 1, 0),
size = UDim2.new(0, resizeHandleSize, 0, resizeHandleSize),
anchorPoint = Vector2.new(1, 1),
},
}
local MouseMovement = Enum.UserInputType.MouseMovement

return function(props)
local handleMode = props.handleMode
local resizeMode = props.resizeMode
local resizeStart = props.resizeStart
local startSize = props.startSize
local isResizing = props.isResizing
local frame
local startMousePosition

UserInputService.InputChanged:Connect(function(input)
if input.UserInputType ~= MouseMovement then
return
end
if input.UserInputState == Enum.UserInputState.Change then
if isResizing() then
local position = input.Position

if handleMode == 'corner' then
frame.Size = UDim2.fromOffset(startSize().X + position.X - startMousePosition.X, startSize().Y + position.Y - startMousePosition.Y)
elseif handleMode == 'right' then
frame.Size = UDim2.fromOffset(startSize().X + position.X - startMousePosition.X, 0)
elseif handleMode == 'bottom' then
frame.Size = UDim2.fromOffset(0, startSize().Y + position.Y - startMousePosition.Y)
end
end
elseif input.UserInputState == Enum.UserInputState.End then
isResizing(false)
end
end)

local configuration = resizeHandleConfigurationMap[handleMode]

return create'Frame'{
BackgroundTransparency = 1,
Position = configuration.position,
Size = configuration.size,
AnchorPoint = configuration.anchorPoint,
ZIndex = 10,
vide.changed('Parent', function(parent)
frame = parent
end),
create'UIFlexItem'{},
InputBegan = function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
isResizing(true)
startSize(frame.AbsoluteSize)
resizeMode(handleMode)
resizeStart(input.Position)

startMousePosition = input.Position
end
end,
InputEnded = function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
isResizing(false)
end
end,
MouseEnter = function()
resizeMode(handleMode)
end,
}
end
end
function __DARKLUA_BUNDLE_MODULES.C()
local UserInputService = game:GetService('UserInputService')
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local cleanup = vide.cleanup
local effect = vide.effect
local create = vide.create
local source = vide.source
local viewportSize = workspace.CurrentCamera.ViewportSize
local viewportSizeX = viewportSize.X
local viewportSizeY = viewportSize.Y - 58

local function ClampPositionToScreen(position, absoluteSize)
local width = absoluteSize and absoluteSize.X or 300
local height = absoluteSize and absoluteSize.Y or 492
local x = math.clamp(position.X.Offset, 0, math.max(0, viewportSizeX - width))
local y = math.clamp(position.Y.Offset, 0, math.max(0, viewportSizeY - height))
return UDim2.fromOffset(x, y)
end

local MouseMovement = Enum.UserInputType.MouseMovement

local function Window(props)
local size = source(props.size or UDim2.fromOffset(300, 492))
local isOpenedSources = props.isOpenedSources

for i, _ in props.categories do
effect(function()
local state = isOpenedSources[i]()
if not state then return end
for e, k in isOpenedSources do
if e ~= i then k(false) end
end
end)
end

local dragging = source(false)
local dragStart, startPos
local Window

cleanup(UserInputService.InputEnded:Connect(function(input)
if dragging() and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
dragging(false)
end
end))

cleanup(UserInputService.InputChanged:Connect(function(input)
if dragging() and (input.UserInputType == MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
local wanted = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)
Window.Position = ClampPositionToScreen(wanted, Window.AbsoluteSize)
end
end))

Window = create'Frame'{
Name = 'TheGoatHUD',
BackgroundColor3 = Color3.fromRGB(8, 12, 20),
BackgroundTransparency = 0.08,
BorderSizePixel = 0,
ClipsDescendants = true,
Position = UDim2.fromOffset(10, 8),
Size = size,
create'UICorner'{
CornerRadius = UDim.new(0, 8),
},
create'UIStroke'{
Name = 'HUDStroke',
Color = Color3.fromRGB(0, 165, 225),
Thickness = 1,
Transparency = 0.62,
},
create'Frame'{
Name = 'Header',
BackgroundColor3 = Color3.fromRGB(9, 14, 23),
BackgroundTransparency = 0.18,
BorderSizePixel = 0,
Size = UDim2.new(1, 0, 0, 28),
InputBegan = function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
startPos = Window.Position
dragStart = input.Position
dragging(true)
end
end,
create'UIPadding'{
PaddingLeft = UDim.new(0, 7),
PaddingRight = UDim.new(0, 7),
},
create'UIListLayout'{
FillDirection = Enum.FillDirection.Horizontal,
VerticalAlignment = Enum.VerticalAlignment.Center,
Padding = UDim.new(0, 4),
},
create'TextLabel'{
Name = 'Logo',
BackgroundTransparency = 1,
Size = UDim2.fromOffset(14, 14),
Font = Enum.Font.GothamBlack,
Text = '🐐',
TextColor3 = Color3.fromRGB(90, 215, 255),
TextSize = 11,
},
create'TextLabel'{
Name = 'Title',
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.X,
Size = UDim2.new(0, 0, 0, 16),
Font = Enum.Font.GothamBold,
Text = 'THE GOAT',
TextColor3 = Color3.fromRGB(228, 240, 250),
TextSize = 10,
TextXAlignment = Enum.TextXAlignment.Left,
},
create'TextLabel'{
Name = 'GameTag',
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.X,
Size = UDim2.new(0, 0, 0, 14),
Font = Enum.Font.GothamMedium,
Text = (shared._growthGameName == 'JungleLife' and 'JL' or 'SL'),
TextColor3 = Color3.fromRGB(100, 135, 165),
TextSize = 7,
},
create'Frame'{
Name = 'HeaderSpacer',
BackgroundTransparency = 1,
Size = UDim2.new(1, 0, 0, 0),
LayoutOrder = 98,
create'UIFlexItem'{ FlexMode = Enum.UIFlexMode.Fill },
},
create'Frame'{
Name = 'StatusDot',
BackgroundColor3 = Color3.fromRGB(65, 255, 160),
BorderSizePixel = 0,
Size = UDim2.fromOffset(5, 5),
LayoutOrder = 99,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
},
},
create'Frame'{
Name = 'HeaderLine',
BackgroundColor3 = Color3.fromRGB(0, 170, 230),
BackgroundTransparency = 0.62,
BorderSizePixel = 0,
Position = UDim2.new(0, 6, 0, 28),
Size = UDim2.new(1, -12, 0, 1),
},
create'Frame'{
Name = 'Content',
BackgroundTransparency = 1,
Position = UDim2.new(0, 0, 0, 29),
Size = UDim2.new(1, 0, 1, -125),
props.containers,
create'UIListLayout'{
FillDirection = Enum.FillDirection.Horizontal,
HorizontalFlex = Enum.UIFlexAlignment.Fill,
SortOrder = Enum.SortOrder.LayoutOrder,
},
},
}

return Window, nil
end

return Window
end
function __DARKLUA_BUNDLE_MODULES.D()
return {
size = 24,
image = 137475077473068,
columns = 35,
icons = {
['activity'] = Vector2.zero,
['activity-heart'] = Vector2.zero,
['airplay'] = Vector2.zero,
['airpods'] = Vector2.zero,
['alarm-clock'] = Vector2.zero,
['alarm-clock-check'] = Vector2.zero,
['alarm-clock-minus'] = Vector2.zero,
['alarm-clock-off'] = Vector2.zero,
['alarm-clock-plus'] = Vector2.zero,
['alert-circle'] = Vector2.zero,
['alert-hexagon'] = Vector2.zero,
['alert-octagon'] = Vector2.zero,
['alert-square'] = Vector2.zero,
['alert-triangle'] = Vector2.zero,
['align-bottom'] = Vector2.zero,
['align-bottom-02'] = Vector2.zero,
['align-center'] = Vector2.zero,
['align-horizontal-centre'] = Vector2.zero,
['align-horizontal-centre-02'] = Vector2.zero,
['align-justify'] = Vector2.zero,
['align-left'] = Vector2.zero,
['align-left-02'] = Vector2.zero,
['align-right'] = Vector2.zero,
['align-right-02'] = Vector2.zero,
['align-top'] = Vector2.zero,
['align-top-02'] = Vector2.zero,
['align-vertical-center'] = Vector2.zero,
['align-vertical-center-02'] = Vector2.zero,
['anchor'] = Vector2.zero,
['annotation'] = Vector2.zero,
['annotation-alert'] = Vector2.zero,
['annotation-check'] = Vector2.zero,
['annotation-dots'] = Vector2.zero,
['annotation-heart'] = Vector2.zero,
['annotation-info'] = Vector2.zero,
['annotation-plus'] = Vector2.zero,
['annotation-question'] = Vector2.zero,
['annotation-x'] = Vector2.zero,
['announcement'] = Vector2.zero,
['announcement-02'] = Vector2.zero,
['announcement-03'] = Vector2.zero,
['archive'] = Vector2.zero,
['arrow-block-down'] = Vector2.zero,
['arrow-block-left'] = Vector2.zero,
['arrow-block-right'] = Vector2.zero,
['arrow-block-up'] = Vector2.zero,
['arrow-circle-broken-down'] = Vector2.zero,
['arrow-circle-broken-down-left'] = Vector2.zero,
['arrow-circle-broken-down-right'] = Vector2.zero,
['arrow-circle-broken-left'] = Vector2.zero,
['arrow-circle-broken-right'] = Vector2.zero,
['arrow-circle-broken-up'] = Vector2.zero,
['arrow-circle-broken-up-left'] = Vector2.zero,
['arrow-circle-broken-up-right'] = Vector2.zero,
['arrow-circle-down'] = Vector2.zero,
['arrow-circle-down-left'] = Vector2.zero,
['arrow-circle-down-right'] = Vector2.zero,
['arrow-circle-left'] = Vector2.zero,
['arrow-circle-right'] = Vector2.zero,
['arrow-circle-up'] = Vector2.zero,
['arrow-circle-up-left'] = Vector2.zero,
['arrow-circle-up-right'] = Vector2.zero,
['arrow-down'] = Vector2.zero,
['arrow-down-left'] = Vector2.zero,
['arrow-down-right'] = Vector2.zero,
['arrow-left'] = Vector2.zero,
['arrow-narrow-down'] = Vector2.zero,
['arrow-narrow-down-left'] = Vector2.zero,
['arrow-narrow-down-right'] = Vector2.zero,
['arrow-narrow-left'] = Vector2.zero,
['arrow-narrow-right'] = Vector2.zero,
['arrow-narrow-up'] = Vector2.zero,
['arrow-narrow-up-left'] = Vector2.zero,
['arrow-narrow-up-right'] = Vector2.zero,
['arrow-right'] = Vector2.zero,
['arrow-square-down'] = Vector2.zero,
['arrow-square-down-left'] = Vector2.zero,
['arrow-square-down-right'] = Vector2.zero,
['arrow-square-left'] = Vector2.zero,
['arrow-square-right'] = Vector2.zero,
['arrow-square-up'] = Vector2.zero,
['arrow-square-up-left'] = Vector2.zero,
['arrow-square-up-right'] = Vector2.zero,
['arrow-up'] = Vector2.zero,
['arrow-up-left'] = Vector2.zero,
['arrow-up-right'] = Vector2.zero,
['arrows-down'] = Vector2.zero,
['arrows-left'] = Vector2.zero,
['arrows-right'] = Vector2.zero,
['arrows-triangle'] = Vector2.zero,
['arrows-up'] = Vector2.zero,
['asterisk-01'] = Vector2.zero,
['asterisk-02'] = Vector2.zero,
['at-sign'] = Vector2.zero,
['atom'] = Vector2.zero,
['atom-02'] = Vector2.zero,
['attachment'] = Vector2.zero,
['attachment-02'] = Vector2.zero,
['award'] = Vector2.zero,
['award-02'] = Vector2.zero,
['award-03'] = Vector2.zero,
['award-04'] = Vector2.zero,
['award-05'] = Vector2.zero,
['backpack'] = Vector2.zero,
['bank'] = Vector2.zero,
['bank-note'] = Vector2.zero,
['bank-note-02'] = Vector2.zero,
['bank-note-03'] = Vector2.zero,
['bar-chart'] = Vector2.zero,
['bar-chart-02'] = Vector2.zero,
['bar-chart-03'] = Vector2.zero,
['bar-chart-04'] = Vector2.zero,
['bar-chart-05'] = Vector2.zero,
['bar-chart-06'] = Vector2.zero,
['bar-chart-07'] = Vector2.zero,
['bar-chart-08'] = Vector2.zero,
['bar-chart-09'] = Vector2.zero,
['bar-chart-10'] = Vector2.zero,
['bar-chart-11'] = Vector2.zero,
['bar-chart-12'] = Vector2.zero,
['bar-chart-circle'] = Vector2.zero,
['bar-chart-circle-02'] = Vector2.zero,
['bar-chart-circle-03'] = Vector2.zero,
['bar-chart-growdown'] = Vector2.zero,
['bar-chart-growup'] = Vector2.zero,
['bar-chart-square'] = Vector2.zero,
['bar-chart-square-02'] = Vector2.zero,
['bar-chart-square-03'] = Vector2.zero,
['bar-chart-square-down'] = Vector2.zero,
['bar-chart-square-minus'] = Vector2.zero,
['bar-chart-square-plus'] = Vector2.zero,
['bar-chart-square-up'] = Vector2.zero,
['bar-line-chart'] = Vector2.zero,
['battery-charging'] = Vector2.zero,
['battery-charging-02'] = Vector2.zero,
['battery-empty'] = Vector2.zero,
['battery-full'] = Vector2.zero,
['battery-low'] = Vector2.zero,
['battery-mid'] = Vector2.zero,
['beaker'] = Vector2.zero,
['beaker-02'] = Vector2.zero,
['bell'] = Vector2.zero,
['bell-02'] = Vector2.zero,
['bell-03'] = Vector2.zero,
['bell-04'] = Vector2.zero,
['bell-minus'] = Vector2.zero,
['bell-off'] = Vector2.zero,
['bell-off-02'] = Vector2.zero,
['bell-off-03'] = Vector2.zero,
['bell-plus'] = Vector2.zero,
['bell-ringing'] = Vector2.zero,
['bell-ringing-02'] = Vector2.zero,
['bell-ringing-03'] = Vector2.zero,
['bell-ringing-04'] = Vector2.zero,
['bezier-curve'] = Vector2.zero,
['bezier-curve-02'] = Vector2.zero,
['bezier-curve-03'] = Vector2.zero,
['bluetooth-connect'] = Vector2.zero,
['bluetooth-off'] = Vector2.zero,
['bluetooth-on'] = Vector2.zero,
['bluetooth-signal'] = Vector2.zero,
['bold'] = Vector2.zero,
['bold-02'] = Vector2.zero,
['bold-square'] = Vector2.zero,
['book-closed'] = Vector2.zero,
['book-open'] = Vector2.zero,
['book-open-02'] = Vector2.zero,
['bookmark'] = Vector2.zero,
['bookmark-add'] = Vector2.zero,
['bookmark-check'] = Vector2.zero,
['bookmark-minus'] = Vector2.zero,
['bookmark-x'] = Vector2.zero,
['box'] = Vector2.zero,
['brackets'] = Vector2.zero,
['brackets-check'] = Vector2.zero,
['brackets-ellipses'] = Vector2.zero,
['brackets-minus'] = Vector2.zero,
['brackets-plus'] = Vector2.zero,
['brackets-slash'] = Vector2.zero,
['brackets-x'] = Vector2.zero,
['briefcase'] = Vector2.zero,
['briefcase-02'] = Vector2.zero,
['browser'] = Vector2.zero,
['brush'] = Vector2.zero,
['brush-02'] = Vector2.zero,
['brush-03'] = Vector2.zero,
['building'] = Vector2.zero,
['building-02'] = Vector2.zero,
['building-03'] = Vector2.zero,
['building-04'] = Vector2.zero,
['building-05'] = Vector2.zero,
['building-06'] = Vector2.zero,
['building-07'] = Vector2.zero,
['building-08'] = Vector2.zero,
['bus'] = Vector2.zero,
['calculator'] = Vector2.zero,
['calendar'] = Vector2.zero,
['calendar-check'] = Vector2.zero,
['calendar-check-02'] = Vector2.zero,
['calendar-date'] = Vector2.zero,
['calendar-heart'] = Vector2.zero,
['calendar-heart-02'] = Vector2.zero,
['calendar-minus'] = Vector2.zero,
['calendar-minus-02'] = Vector2.zero,
['calendar-plus'] = Vector2.zero,
['calendar-plus-02'] = Vector2.zero,
['camera'] = Vector2.zero,
['camera-02'] = Vector2.zero,
['camera-03'] = Vector2.zero,
['camera-lens'] = Vector2.zero,
['camera-off'] = Vector2.zero,
['camera-plus'] = Vector2.zero,
['car'] = Vector2.zero,
['car-02'] = Vector2.zero,
['certificate'] = Vector2.zero,
['certificate-02'] = Vector2.zero,
['chart-breakout-circle'] = Vector2.zero,
['chart-breakout-square'] = Vector2.zero,
['check'] = Vector2.zero,
['check-circle'] = Vector2.zero,
['check-circle-broken'] = Vector2.zero,
['check-done'] = Vector2.zero,
['check-done-02'] = Vector2.zero,
['check-heart'] = Vector2.zero,
['check-square'] = Vector2.zero,
['check-square-broken'] = Vector2.zero,
['check-verified'] = Vector2.zero,
['check-verified-02'] = Vector2.zero,
['check-verified-03'] = Vector2.zero,
['chevron-down'] = Vector2.zero,
['chevron-down-double'] = Vector2.zero,
['chevron-left'] = Vector2.zero,
['chevron-left-double'] = Vector2.zero,
['chevron-right'] = Vector2.zero,
['chevron-right-double'] = Vector2.zero,
['chevron-selector-horizontal'] = Vector2.zero,
['chevron-selector-vertical'] = Vector2.zero,
['chevron-up'] = Vector2.zero,
['chevron-up-double'] = Vector2.zero,
['chrome-cast'] = Vector2.zero,
['circle'] = Vector2.zero,
['circle-cut'] = Vector2.zero,
['clapperboard'] = Vector2.zero,
['clipboard'] = Vector2.zero,
['clipboard-attachment'] = Vector2.zero,
['clipboard-check'] = Vector2.zero,
['clipboard-download'] = Vector2.zero,
['clipboard-minus'] = Vector2.zero,
['clipboard-plus'] = Vector2.zero,
['clipboard-x'] = Vector2.zero,
['clock'] = Vector2.zero,
['clock-check'] = Vector2.zero,
['clock-fast-forward'] = Vector2.zero,
['clock-plus'] = Vector2.zero,
['clock-refresh'] = Vector2.zero,
['clock-rewind'] = Vector2.zero,
['clock-snooze'] = Vector2.zero,
['clock-stopwatch'] = Vector2.zero,
['cloud'] = Vector2.zero,
['cloud-02'] = Vector2.zero,
['cloud-03'] = Vector2.zero,
['cloud-blank'] = Vector2.zero,
['cloud-blank-02'] = Vector2.zero,
['cloud-lightning'] = Vector2.zero,
['cloud-moon'] = Vector2.zero,
['cloud-off'] = Vector2.zero,
['cloud-raining'] = Vector2.zero,
['cloud-raining-02'] = Vector2.zero,
['cloud-raining-03'] = Vector2.zero,
['cloud-raining-04'] = Vector2.zero,
['cloud-raining-05'] = Vector2.zero,
['cloud-raining-06'] = Vector2.zero,
['cloud-snowing'] = Vector2.zero,
['cloud-snowing-02'] = Vector2.zero,
['cloud-sun'] = Vector2.zero,
['cloud-sun-02'] = Vector2.zero,
['cloud-sun-03'] = Vector2.zero,
['code'] = Vector2.zero,
['code-02'] = Vector2.zero,
['code-browser'] = Vector2.zero,
['code-circle'] = Vector2.zero,
['code-circle-02'] = Vector2.zero,
['code-circle-03'] = Vector2.zero,
['code-snippet'] = Vector2.zero,
['code-snippet-02'] = Vector2.zero,
['code-square'] = Vector2.zero,
['code-square-02'] = Vector2.zero,
['codepen'] = Vector2.zero,
['coins'] = Vector2.zero,
['coins-02'] = Vector2.zero,
['coins-03'] = Vector2.zero,
['coins-04'] = Vector2.zero,
['coins-hand'] = Vector2.zero,
['coins-stacked'] = Vector2.zero,
['coins-stacked-02'] = Vector2.zero,
['coins-stacked-03'] = Vector2.zero,
['coins-stacked-04'] = Vector2.zero,
['coins-swap'] = Vector2.zero,
['coins-swap-02'] = Vector2.zero,
['colors'] = Vector2.zero,
['columns'] = Vector2.zero,
['columns-02'] = Vector2.zero,
['columns-03'] = Vector2.zero,
['command'] = Vector2.zero,
['compass'] = Vector2.zero,
['compass-02'] = Vector2.zero,
['compass-03'] = Vector2.zero,
['container'] = Vector2.zero,
['contrast'] = Vector2.zero,
['contrast-02'] = Vector2.zero,
['contrast-03'] = Vector2.zero,
['copy'] = Vector2.zero,
['copy-02'] = Vector2.zero,
['copy-03'] = Vector2.zero,
['copy-04'] = Vector2.zero,
['copy-05'] = Vector2.zero,
['copy-06'] = Vector2.zero,
['copy-07'] = Vector2.zero,
['copy-dashed'] = Vector2.zero,
['corner-down-left'] = Vector2.zero,
['corner-down-right'] = Vector2.zero,
['corner-left-down'] = Vector2.zero,
['corner-left-up'] = Vector2.zero,
['corner-right-down'] = Vector2.zero,
['corner-right-up'] = Vector2.zero,
['corner-up-left'] = Vector2.zero,
['corner-up-right'] = Vector2.zero,
['cpu-chip'] = Vector2.zero,
['cpu-chip-02'] = Vector2.zero,
['credit-card'] = Vector2.zero,
['credit-card-02'] = Vector2.zero,
['credit-card-check'] = Vector2.zero,
['credit-card-down'] = Vector2.zero,
['credit-card-download'] = Vector2.zero,
['credit-card-edit'] = Vector2.zero,
['credit-card-lock'] = Vector2.zero,
['credit-card-minus'] = Vector2.zero,
['credit-card-plus'] = Vector2.zero,
['credit-card-refresh'] = Vector2.zero,
['credit-card-search'] = Vector2.zero,
['credit-card-shield'] = Vector2.zero,
['credit-card-up'] = Vector2.zero,
['credit-card-upload'] = Vector2.zero,
['credit-card-x'] = Vector2.zero,
['crop'] = Vector2.zero,
['crop-02'] = Vector2.zero,
['cryptocurrency'] = Vector2.zero,
['cryptocurrency-02'] = Vector2.zero,
['cryptocurrency-03'] = Vector2.zero,
['cryptocurrency-04'] = Vector2.zero,
['cube'] = Vector2.zero,
['cube-02'] = Vector2.zero,
['cube-03'] = Vector2.zero,
['cube-04'] = Vector2.zero,
['cube-outline'] = Vector2.zero,
['currency-bitcoin'] = Vector2.zero,
['currency-bitcoin-circle'] = Vector2.zero,
['currency-dollar'] = Vector2.zero,
['currency-dollar-circle'] = Vector2.zero,
['currency-ethereum'] = Vector2.zero,
['currency-ethereum-circle'] = Vector2.zero,
['currency-euro'] = Vector2.zero,
['currency-euro-circle'] = Vector2.zero,
['currency-pound'] = Vector2.zero,
['currency-pound-circle'] = Vector2.zero,
['currency-ruble'] = Vector2.zero,
['currency-ruble-circle'] = Vector2.zero,
['currency-rupee'] = Vector2.zero,
['currency-rupee-circle'] = Vector2.zero,
['currency-yen'] = Vector2.zero,
['currency-yen-circle'] = Vector2.zero,
['cursor'] = Vector2.zero,
['cursor-02'] = Vector2.zero,
['cursor-03'] = Vector2.zero,
['cursor-04'] = Vector2.zero,
['cursor-box'] = Vector2.zero,
['cursor-click'] = Vector2.zero,
['cursor-click-02'] = Vector2.zero,
['data'] = Vector2.zero,
['database'] = Vector2.zero,
['database-02'] = Vector2.zero,
['database-03'] = Vector2.zero,
['dataflow'] = Vector2.zero,
['dataflow-02'] = Vector2.zero,
['dataflow-03'] = Vector2.zero,
['dataflow-04'] = Vector2.zero,
['delete'] = Vector2.zero,
['diamond'] = Vector2.zero,
['diamond-02'] = Vector2.zero,
['dice'] = Vector2.zero,
['dice-2'] = Vector2.zero,
['dice-3'] = Vector2.zero,
['dice-4'] = Vector2.zero,
['dice-5'] = Vector2.zero,
['dice-6'] = Vector2.zero,
['disc'] = Vector2.zero,
['disc-02'] = Vector2.zero,
['distribute-spacing-horizontal'] = Vector2.zero,
['distribute-spacing-vertical'] = Vector2.zero,
['divide'] = Vector2.zero,
['divide-02'] = Vector2.zero,
['divide-03'] = Vector2.zero,
['divide-circle'] = Vector2.zero,
['divider'] = Vector2.zero,
['dotpoints'] = Vector2.zero,
['dotpoints-02'] = Vector2.zero,
['dots-grid'] = Vector2.zero,
['dots-horizontal'] = Vector2.zero,
['dots-vertical'] = Vector2.zero,
['download'] = Vector2.zero,
['download-02'] = Vector2.zero,
['download-03'] = Vector2.zero,
['download-04'] = Vector2.zero,
['download-circle'] = Vector2.zero,
['download-cloud-01'] = Vector2.zero,
['download-cloud-02'] = Vector2.zero,
['download-line'] = Vector2.zero,
['drop'] = Vector2.zero,
['droplets'] = Vector2.zero,
['droplets-02'] = Vector2.zero,
['droplets-03'] = Vector2.zero,
['dropper'] = Vector2.zero,
['edit-01'] = Vector2.zero,
['edit-02'] = Vector2.zero,
['edit-03'] = Vector2.zero,
['edit-04'] = Vector2.zero,
['edit-05'] = Vector2.zero,
['equal'] = Vector2.zero,
['equal-not'] = Vector2.zero,
['eraser'] = Vector2.zero,
['expand'] = Vector2.zero,
['expand-02'] = Vector2.zero,
['expand-03'] = Vector2.zero,
['expand-04'] = Vector2.zero,
['expand-05'] = Vector2.zero,
['expand-06'] = Vector2.zero,
['expand-lg'] = Vector2.zero,
['eye'] = Vector2.zero,
['eye-off'] = Vector2.zero,
['face-content'] = Vector2.zero,
['face-frown'] = Vector2.zero,
['face-happy'] = Vector2.zero,
['face-id'] = Vector2.zero,
['face-id-square'] = Vector2.zero,
['face-neutral'] = Vector2.zero,
['face-sad'] = Vector2.zero,
['face-smile'] = Vector2.zero,
['face-wink'] = Vector2.zero,
['fast-backward'] = Vector2.zero,
['fast-forward'] = Vector2.zero,
['feather'] = Vector2.zero,
['figma'] = Vector2.zero,
['file'] = Vector2.zero,
['file-02'] = Vector2.zero,
['file-03'] = Vector2.zero,
['file-04'] = Vector2.zero,
['file-05'] = Vector2.zero,
['file-06'] = Vector2.zero,
['file-07'] = Vector2.zero,
['file-attachment'] = Vector2.zero,
['file-attachment-02'] = Vector2.zero,
['file-attachment-03'] = Vector2.zero,
['file-attachment-04'] = Vector2.zero,
['file-attachment-05'] = Vector2.zero,
['file-check'] = Vector2.zero,
['file-check-02'] = Vector2.zero,
['file-check-03'] = Vector2.zero,
['file-code'] = Vector2.zero,
['file-code-02'] = Vector2.zero,
['file-download'] = Vector2.zero,
['file-download-02'] = Vector2.zero,
['file-download-03'] = Vector2.zero,
['file-heart'] = Vector2.zero,
['file-heart-02'] = Vector2.zero,
['file-heart-03'] = Vector2.zero,
['file-lock'] = Vector2.zero,
['file-lock-02'] = Vector2.zero,
['file-lock-03'] = Vector2.zero,
['file-minus'] = Vector2.zero,
['file-minus-02'] = Vector2.zero,
['file-minus-03'] = Vector2.zero,
['file-plus'] = Vector2.zero,
['file-plus-02'] = Vector2.zero,
['file-plus-03'] = Vector2.zero,
['file-question'] = Vector2.zero,
['file-question-02'] = Vector2.zero,
['file-question-03'] = Vector2.zero,
['file-search'] = Vector2.zero,
['file-search-02'] = Vector2.zero,
['file-search-03'] = Vector2.zero,
['file-shield'] = Vector2.zero,
['file-shield-02'] = Vector2.zero,
['file-shield-03'] = Vector2.zero,
['file-x'] = Vector2.zero,
['file-x-02'] = Vector2.zero,
['file-x-03'] = Vector2.zero,
['film'] = Vector2.zero,
['film-02'] = Vector2.zero,
['film-03'] = Vector2.zero,
['filter-funnel'] = Vector2.zero,
['filter-funnel-02'] = Vector2.zero,
['filter-lines'] = Vector2.zero,
['fingerprint'] = Vector2.zero,
['fingerprint-02'] = Vector2.zero,
['fingerprint-03'] = Vector2.zero,
['fingerprint-04'] = Vector2.zero,
['flag'] = Vector2.zero,
['flag-02'] = Vector2.zero,
['flag-03'] = Vector2.zero,
['flag-04'] = Vector2.zero,
['flag-05'] = Vector2.zero,
['flag-06'] = Vector2.zero,
['flash'] = Vector2.zero,
['flash-off'] = Vector2.zero,
['flex-align-bottom'] = Vector2.zero,
['flex-align-left'] = Vector2.zero,
['flex-align-right'] = Vector2.zero,
['flex-align-top'] = Vector2.zero,
['flip-backward'] = Vector2.zero,
['flip-forward'] = Vector2.zero,
['folder'] = Vector2.zero,
['folder-check'] = Vector2.zero,
['folder-closed'] = Vector2.zero,
['folder-code'] = Vector2.zero,
['folder-download'] = Vector2.zero,
['folder-lock'] = Vector2.zero,
['folder-minus'] = Vector2.zero,
['folder-plus'] = Vector2.zero,
['folder-question'] = Vector2.zero,
['folder-search'] = Vector2.zero,
['folder-shield'] = Vector2.zero,
['folder-x'] = Vector2.zero,
['framer'] = Vector2.zero,
['gaming-pad'] = Vector2.zero,
['gaming-pad-02'] = Vector2.zero,
['gift'] = Vector2.zero,
['gift-02'] = Vector2.zero,
['git-branch'] = Vector2.zero,
['git-branch-02'] = Vector2.zero,
['git-commit'] = Vector2.zero,
['git-merge'] = Vector2.zero,
['git-pull-request'] = Vector2.zero,
['glasses'] = Vector2.zero,
['glasses-02'] = Vector2.zero,
['globe'] = Vector2.zero,
['globe-02'] = Vector2.zero,
['globe-03'] = Vector2.zero,
['globe-04'] = Vector2.zero,
['globe-05'] = Vector2.zero,
['globe-06'] = Vector2.zero,
['globe-slated'] = Vector2.zero,
['globe-slated-02'] = Vector2.zero,
['google-chrome'] = Vector2.zero,
['graduation-hat'] = Vector2.zero,
['graduation-hat-02'] = Vector2.zero,
['grid'] = Vector2.zero,
['grid-02'] = Vector2.zero,
['grid-03'] = Vector2.zero,
['grid-dots-blank'] = Vector2.zero,
['grid-dots-bottom'] = Vector2.zero,
['grid-dots-horizontal-center'] = Vector2.zero,
['grid-dots-left'] = Vector2.zero,
['grid-dots-outer'] = Vector2.zero,
['grid-dots-right'] = Vector2.zero,
['grid-dots-top'] = Vector2.zero,
['grid-dots-vertical-center'] = Vector2.zero,
['hand'] = Vector2.zero,
['hard-drive'] = Vector2.zero,
['hash'] = Vector2.zero,
['hash-02'] = Vector2.zero,
['hash-italic'] = Vector2.zero,
['heading'] = Vector2.zero,
['heading-02'] = Vector2.zero,
['heading-square'] = Vector2.zero,
['headphones'] = Vector2.zero,
['headphones-02'] = Vector2.zero,
['heart'] = Vector2.zero,
['heart-circle'] = Vector2.zero,
['heart-hand'] = Vector2.zero,
['heart-hexagon'] = Vector2.zero,
['heart-octagon'] = Vector2.zero,
['heart-rounded'] = Vector2.zero,
['heart-square'] = Vector2.zero,
['hearts'] = Vector2.zero,
['help-circle'] = Vector2.zero,
['help-hexagon'] = Vector2.zero,
['help-octagon'] = Vector2.zero,
['help-square'] = Vector2.zero,
['hexagon'] = Vector2.zero,
['hexagon-02'] = Vector2.zero,
['home'] = Vector2.zero,
['home-02'] = Vector2.zero,
['home-03'] = Vector2.zero,
['home-04'] = Vector2.zero,
['home-05'] = Vector2.zero,
['home-line'] = Vector2.zero,
['home-smile'] = Vector2.zero,
['horizontal-bar-chart'] = Vector2.zero,
['horizontal-bar-chart-02'] = Vector2.zero,
['horizontal-bar-chart-03'] = Vector2.zero,
['hourglass'] = Vector2.zero,
['hourglass-02'] = Vector2.zero,
['hourglass-03'] = Vector2.zero,
['hurricane'] = Vector2.zero,
['hurricane-02'] = Vector2.zero,
['hurricane-03'] = Vector2.zero,
['image'] = Vector2.zero,
['image-02'] = Vector2.zero,
['image-03'] = Vector2.zero,
['image-04'] = Vector2.zero,
['image-05'] = Vector2.zero,
['image-check'] = Vector2.zero,
['image-circle'] = Vector2.zero,
['image-down'] = Vector2.zero,
['image-indent-left'] = Vector2.zero,
['image-indent-right'] = Vector2.zero,
['image-left'] = Vector2.zero,
['image-plus'] = Vector2.zero,
['image-right'] = Vector2.zero,
['image-up'] = Vector2.zero,
['image-user'] = Vector2.zero,
['image-user-check'] = Vector2.zero,
['image-user-down'] = Vector2.zero,
['image-user-left'] = Vector2.zero,
['image-user-plus'] = Vector2.zero,
['image-user-right'] = Vector2.zero,
['image-user-up'] = Vector2.zero,
['image-user-x'] = Vector2.zero,
['image-x'] = Vector2.zero,
['inbox'] = Vector2.zero,
['inbox-02'] = Vector2.zero,
['infinity'] = Vector2.zero,
['info-circle'] = Vector2.zero,
['info-hexagon'] = Vector2.zero,
['info-octagon'] = Vector2.zero,
['info-square'] = Vector2.zero,
['intersect-circle'] = Vector2.zero,
['intersect-square'] = Vector2.zero,
['iphone'] = Vector2.zero,
['italic'] = Vector2.zero,
['italic-02'] = Vector2.zero,
['italic-square'] = Vector2.zero,
['key'] = Vector2.zero,
['key-02'] = Vector2.zero,
['keyboard'] = Vector2.zero,
['keyboard-02'] = Vector2.zero,
['laptop'] = Vector2.zero,
['laptop-02'] = Vector2.zero,
['layer-single'] = Vector2.zero,
['layers-three'] = Vector2.zero,
['layers-three-02'] = Vector2.zero,
['layers-two'] = Vector2.zero,
['layers-two-02'] = Vector2.zero,
['layout-alt'] = Vector2.zero,
['layout-alt-02'] = Vector2.zero,
['layout-alt-03'] = Vector2.zero,
['layout-alt-04'] = Vector2.zero,
['layout-bottom'] = Vector2.zero,
['layout-grid'] = Vector2.zero,
['layout-grid-02'] = Vector2.zero,
['layout-left'] = Vector2.zero,
['layout-right'] = Vector2.zero,
['layout-top'] = Vector2.zero,
['left-indent'] = Vector2.zero,
['left-indent-02'] = Vector2.zero,
['letter-spacing'] = Vector2.zero,
['letter-spacing-02'] = Vector2.zero,
['life-buoy'] = Vector2.zero,
['life-buoy-02'] = Vector2.zero,
['lightbulb'] = Vector2.zero,
['lightbulb-02'] = Vector2.zero,
['lightbulb-03'] = Vector2.zero,
['lightbulb-04'] = Vector2.zero,
['lightbulb-05'] = Vector2.zero,
['lightning'] = Vector2.zero,
['lightning-02'] = Vector2.zero,
['line-chart-down'] = Vector2.zero,
['line-chart-down-02'] = Vector2.zero,
['line-chart-down-03'] = Vector2.zero,
['line-chart-down-04'] = Vector2.zero,
['line-chart-down-05'] = Vector2.zero,
['line-chart-up'] = Vector2.zero,
['line-chart-up-02'] = Vector2.zero,
['line-chart-up-03'] = Vector2.zero,
['line-chart-up-04'] = Vector2.zero,
['line-chart-up-05'] = Vector2.zero,
['line-height'] = Vector2.zero,
['link'] = Vector2.zero,
['link-02'] = Vector2.zero,
['link-03'] = Vector2.zero,
['link-04'] = Vector2.zero,
['link-05'] = Vector2.zero,
['link-broken'] = Vector2.zero,
['link-broken-02'] = Vector2.zero,
['link-external-01'] = Vector2.zero,
['link-external-02'] = Vector2.zero,
['list'] = Vector2.zero,
['loading-01'] = Vector2.zero,
['loading-02'] = Vector2.zero,
['loading-03'] = Vector2.zero,
['lock'] = Vector2.zero,
['lock-02'] = Vector2.zero,
['lock-03'] = Vector2.zero,
['lock-04'] = Vector2.zero,
['lock-keyhole-circle'] = Vector2.zero,
['lock-keyhole-square'] = Vector2.zero,
['lock-unlocked'] = Vector2.zero,
['lock-unlocked-02'] = Vector2.zero,
['lock-unlocked-03'] = Vector2.zero,
['lock-unlocked-04'] = Vector2.zero,
['log-in'] = Vector2.zero,
['log-in-02'] = Vector2.zero,
['log-in-03'] = Vector2.zero,
['log-in-04'] = Vector2.zero,
['log-out'] = Vector2.zero,
['log-out-02'] = Vector2.zero,
['log-out-03'] = Vector2.zero,
['log-out-04'] = Vector2.zero,
['log-out-rounded'] = Vector2.zero,
['luggage'] = Vector2.zero,
['luggage-02'] = Vector2.zero,
['luggage-03'] = Vector2.zero,
['magic-wand'] = Vector2.zero,
['magic-wand-02'] = Vector2.zero,
['mail'] = Vector2.zero,
['mail-02'] = Vector2.zero,
['mail-03'] = Vector2.zero,
['mail-04'] = Vector2.zero,
['mail-05'] = Vector2.zero,
['mail-open'] = Vector2.zero,
['mail-open-02'] = Vector2.zero,
['map'] = Vector2.zero,
['map-02'] = Vector2.zero,
['mark'] = Vector2.zero,
['marker-pin'] = Vector2.zero,
['marker-pin-02'] = Vector2.zero,
['marker-pin-03'] = Vector2.zero,
['marker-pin-04'] = Vector2.zero,
['marker-pin-05'] = Vector2.zero,
['marker-pin-06'] = Vector2.zero,
['marker-pin-flag'] = Vector2.zero,
['maximize'] = Vector2.zero,
['maximize-02'] = Vector2.zero,
['medical-circle'] = Vector2.zero,
['medical-cross'] = Vector2.zero,
['medical-square'] = Vector2.zero,
['menu'] = Vector2.zero,
['menu-02'] = Vector2.zero,
['menu-03'] = Vector2.zero,
['menu-04'] = Vector2.zero,
['menu-05'] = Vector2.zero,
['message-alert-circle'] = Vector2.zero,
['message-alert-square'] = Vector2.zero,
['message-chat-circle'] = Vector2.zero,
['message-chat-square'] = Vector2.zero,
['message-check-circle'] = Vector2.zero,
['message-check-square'] = Vector2.zero,
['message-circle'] = Vector2.zero,
['message-circle-02'] = Vector2.zero,
['message-dots-circle'] = Vector2.zero,
['message-dots-square'] = Vector2.zero,
['message-heart-circle'] = Vector2.zero,
['message-heart-square'] = Vector2.zero,
['message-notification-circle'] = Vector2.zero,
['message-notification-square'] = Vector2.zero,
['message-plus-circle'] = Vector2.zero,
['message-plus-square'] = Vector2.zero,
['message-question-circle'] = Vector2.zero,
['message-question-square'] = Vector2.zero,
['message-smile-circle'] = Vector2.zero,
['message-smile-square'] = Vector2.zero,
['message-square'] = Vector2.zero,
['message-square-02'] = Vector2.zero,
['message-text-circle'] = Vector2.zero,
['message-text-circle-02'] = Vector2.zero,
['message-text-square'] = Vector2.zero,
['message-text-square-02'] = Vector2.zero,
['message-x-circle'] = Vector2.zero,
['message-x-square'] = Vector2.zero,
['microphone'] = Vector2.zero,
['microphone-02'] = Vector2.zero,
['microphone-off'] = Vector2.zero,
['microphone-off-02'] = Vector2.zero,
['microscope'] = Vector2.zero,
['minimize'] = Vector2.zero,
['minimize-02'] = Vector2.zero,
['minus'] = Vector2.zero,
['minus-circle'] = Vector2.zero,
['minus-square'] = Vector2.zero,
['mobile'] = Vector2.zero,
['modem'] = Vector2.zero,
['modem-02'] = Vector2.zero,
['monitor'] = Vector2.zero,
['monitor-02'] = Vector2.zero,
['monitor-03'] = Vector2.zero,
['monitor-04'] = Vector2.zero,
['monitor-05'] = Vector2.zero,
['moon'] = Vector2.zero,
['moon-02'] = Vector2.zero,
['moon-eclipse'] = Vector2.zero,
['moon-star'] = Vector2.zero,
['mouse'] = Vector2.zero,
['move'] = Vector2.zero,
['music-note'] = Vector2.zero,
['music-note-02'] = Vector2.zero,
['music-note-plus'] = Vector2.zero,
['navigation-pointer'] = Vector2.zero,
['navigation-pointer-02'] = Vector2.zero,
['navigation-pointer-off'] = Vector2.zero,
['navigation-pointer-off-02'] = Vector2.zero,
['notification-box'] = Vector2.zero,
['notification-message'] = Vector2.zero,
['notification-text'] = Vector2.zero,
['octagon'] = Vector2.zero,
['package'] = Vector2.zero,
['package-check'] = Vector2.zero,
['package-minus'] = Vector2.zero,
['package-plus'] = Vector2.zero,
['package-search'] = Vector2.zero,
['package-x'] = Vector2.zero,
['paint'] = Vector2.zero,
['paint-pour'] = Vector2.zero,
['palette'] = Vector2.zero,
['paperclip'] = Vector2.zero,
['paragraph-spacing'] = Vector2.zero,
['paragraph-wrap'] = Vector2.zero,
['passcode'] = Vector2.zero,
['passcode-lock'] = Vector2.zero,
['passport'] = Vector2.zero,
['pause-circle'] = Vector2.zero,
['pause-square'] = Vector2.zero,
['pen-tool'] = Vector2.zero,
['pen-tool-02'] = Vector2.zero,
['pen-tool-minus'] = Vector2.zero,
['pen-tool-plus'] = Vector2.zero,
['pencil'] = Vector2.zero,
['pencil-02'] = Vector2.zero,
['pencil-line'] = Vector2.zero,
['pentagon'] = Vector2.zero,
['percent'] = Vector2.zero,
['percent-02'] = Vector2.zero,
['percent-03'] = Vector2.zero,
['percent-circle'] = Vector2.zero,
['perspective'] = Vector2.zero,
['perspective-02'] = Vector2.zero,
['phone'] = Vector2.zero,
['phone-02'] = Vector2.zero,
['phone-call'] = Vector2.zero,
['phone-call-02'] = Vector2.zero,
['phone-hang-up'] = Vector2.zero,
['phone-incoming'] = Vector2.zero,
['phone-incoming-02'] = Vector2.zero,
['phone-outgoing'] = Vector2.zero,
['phone-outgoing-02'] = Vector2.zero,
['phone-pause'] = Vector2.zero,
['phone-plus'] = Vector2.zero,
['phone-x'] = Vector2.zero,
['pie-chart'] = Vector2.zero,
['pie-chart-02'] = Vector2.zero,
['pie-chart-03'] = Vector2.zero,
['pie-chart-04'] = Vector2.zero,
['piggy-bank'] = Vector2.zero,
['piggy-bank-02'] = Vector2.zero,
['pilcrow'] = Vector2.zero,
['pilcrow-02'] = Vector2.zero,
['pilcrow-square'] = Vector2.zero,
['pin'] = Vector2.zero,
['pin-02'] = Vector2.zero,
['pin-italic'] = Vector2.zero,
['placeholder'] = Vector2.zero,
['plane'] = Vector2.zero,
['play'] = Vector2.zero,
['play-circle'] = Vector2.zero,
['play-square'] = Vector2.zero,
['plus'] = Vector2.zero,
['plus-circle'] = Vector2.zero,
['plus-square'] = Vector2.zero,
['podcast'] = Vector2.zero,
['power'] = Vector2.zero,
['power-02'] = Vector2.zero,
['power-03'] = Vector2.zero,
['presentation-chart'] = Vector2.zero,
['presentation-chart-02'] = Vector2.zero,
['presentation-chart-03'] = Vector2.zero,
['printer'] = Vector2.zero,
['puzzle-piece'] = Vector2.zero,
['puzzle-piece-02'] = Vector2.zero,
['qr-code'] = Vector2.zero,
['qr-code-02'] = Vector2.zero,
['receipt'] = Vector2.zero,
['receipt-check'] = Vector2.zero,
['recording'] = Vector2.zero,
['recording-02'] = Vector2.zero,
['recording-03'] = Vector2.zero,
['reflect'] = Vector2.zero,
['reflect-02'] = Vector2.zero,
['refresh-ccw'] = Vector2.zero,
['refresh-ccw-02'] = Vector2.zero,
['refresh-ccw-03'] = Vector2.zero,
['refresh-ccw-04'] = Vector2.zero,
['refresh-ccw-05'] = Vector2.zero,
['refresh-ccw-double'] = Vector2.zero,
['refresh-ccw-vertical'] = Vector2.zero,
['refresh-ccw-vertical-md'] = Vector2.zero,
['refresh-ccw-vertical-sm'] = Vector2.zero,
['refresh-cw-02'] = Vector2.zero,
['refresh-cw-03'] = Vector2.zero,
['refresh-cw-04'] = Vector2.zero,
['refresh-cw-05'] = Vector2.zero,
['refresh-cw-right'] = Vector2.zero,
['repeat'] = Vector2.zero,
['repeat-02'] = Vector2.zero,
['repeat-03'] = Vector2.zero,
['repeat-04'] = Vector2.zero,
['reverse-left'] = Vector2.zero,
['reverse-right'] = Vector2.zero,
['right-indent'] = Vector2.zero,
['right-indent-02'] = Vector2.zero,
['rocket'] = Vector2.zero,
['rocket-02'] = Vector2.zero,
['roller-brush'] = Vector2.zero,
['route'] = Vector2.zero,
['rows'] = Vector2.zero,
['rows-02'] = Vector2.zero,
['rows-03'] = Vector2.zero,
['rss'] = Vector2.zero,
['rss-02'] = Vector2.zero,
['ruler'] = Vector2.zero,
['safe'] = Vector2.zero,
['sale'] = Vector2.zero,
['sale-02'] = Vector2.zero,
['sale-03'] = Vector2.zero,
['sale-04'] = Vector2.zero,
['save'] = Vector2.zero,
['save-02'] = Vector2.zero,
['save-03'] = Vector2.zero,
['save-double'] = Vector2.zero,
['scale'] = Vector2.zero,
['scale-02'] = Vector2.zero,
['scale-03'] = Vector2.zero,
['scales'] = Vector2.zero,
['scales-02'] = Vector2.zero,
['scan'] = Vector2.zero,
['school-compass'] = Vector2.zero,
['scissors'] = Vector2.zero,
['scissors-02'] = Vector2.zero,
['scissors-cut'] = Vector2.zero,
['scissors-cut-02'] = Vector2.zero,
['search-lg'] = Vector2.zero,
['search-md'] = Vector2.zero,
['search-refraction'] = Vector2.zero,
['search-sm'] = Vector2.zero,
['send'] = Vector2.zero,
['send-02'] = Vector2.zero,
['send-03'] = Vector2.zero,
['send-horizontal'] = Vector2.zero,
['send-vertical'] = Vector2.zero,
['server'] = Vector2.zero,
['server-02'] = Vector2.zero,
['server-03'] = Vector2.zero,
['server-04'] = Vector2.zero,
['server-05'] = Vector2.zero,
['server-06'] = Vector2.zero,
['settings'] = Vector2.zero,
['settings-02'] = Vector2.zero,
['settings-03'] = Vector2.zero,
['settings-04'] = Vector2.zero,
['settings-toggle'] = Vector2.zero,
['settings-toggle-line'] = Vector2.zero,
['share'] = Vector2.zero,
['share-02'] = Vector2.zero,
['share-03'] = Vector2.zero,
['share-04'] = Vector2.zero,
['share-05'] = Vector2.zero,
['share-06'] = Vector2.zero,
['share-07'] = Vector2.zero,
['shield'] = Vector2.zero,
['shield-02'] = Vector2.zero,
['shield-03'] = Vector2.zero,
['shield-dollar'] = Vector2.zero,
['shield-off'] = Vector2.zero,
['shield-plus'] = Vector2.zero,
['shield-separator'] = Vector2.zero,
['shield-tick'] = Vector2.zero,
['shield-zap'] = Vector2.zero,
['shop'] = Vector2.zero,
['shopping-bag'] = Vector2.zero,
['shopping-bag-02'] = Vector2.zero,
['shopping-bag-03'] = Vector2.zero,
['shopping-cart'] = Vector2.zero,
['shopping-cart-02'] = Vector2.zero,
['shopping-cart-03'] = Vector2.zero,
['shuffle'] = Vector2.zero,
['shuffle-02'] = Vector2.zero,
['signal'] = Vector2.zero,
['signal-02'] = Vector2.zero,
['signal-03'] = Vector2.zero,
['simcard'] = Vector2.zero,
['skew'] = Vector2.zero,
['skip-back'] = Vector2.zero,
['skip-forward'] = Vector2.zero,
['slash-circle-01'] = Vector2.zero,
['slash-circle-02'] = Vector2.zero,
['slash-divider'] = Vector2.zero,
['slash-octagon'] = Vector2.zero,
['sliders'] = Vector2.zero,
['sliders-02'] = Vector2.zero,
['sliders-03'] = Vector2.zero,
['sliders-04'] = Vector2.zero,
['snowflake'] = Vector2.zero,
['snowflake-02'] = Vector2.zero,
['spacing-height'] = Vector2.zero,
['spacing-height-02'] = Vector2.zero,
['spacing-width'] = Vector2.zero,
['spacing-width-02'] = Vector2.zero,
['speaker'] = Vector2.zero,
['speaker-02'] = Vector2.zero,
['speaker-03'] = Vector2.zero,
['speedometer'] = Vector2.zero,
['speedometer-02'] = Vector2.zero,
['speedometer-03'] = Vector2.zero,
['speedometer-04'] = Vector2.zero,
['square'] = Vector2.zero,
['stand'] = Vector2.zero,
['star'] = Vector2.zero,
['star-02'] = Vector2.zero,
['star-03'] = Vector2.zero,
['star-04'] = Vector2.zero,
['star-05'] = Vector2.zero,
['star-06'] = Vector2.zero,
['star-07'] = Vector2.zero,
['stars'] = Vector2.zero,
['stars-02'] = Vector2.zero,
['stars-03'] = Vector2.zero,
['sticker-circle'] = Vector2.zero,
['sticker-square'] = Vector2.zero,
['stop'] = Vector2.zero,
['stop-circle'] = Vector2.zero,
['stop-square'] = Vector2.zero,
['strikethrough'] = Vector2.zero,
['strikethrough-02'] = Vector2.zero,
['strikethrough-square'] = Vector2.zero,
['subscript'] = Vector2.zero,
['sun'] = Vector2.zero,
['sun-setting'] = Vector2.zero,
['sun-setting-02'] = Vector2.zero,
['sun-setting-03'] = Vector2.zero,
['sunrise'] = Vector2.zero,
['sunset'] = Vector2.zero,
['switch-horizontal'] = Vector2.zero,
['switch-horizontal-02'] = Vector2.zero,
['switch-horizontal-sm'] = Vector2.zero,
['switch-vertical'] = Vector2.zero,
['switch-vertical-02'] = Vector2.zero,
['switch-vertical-sm'] = Vector2.zero,
['table'] = Vector2.zero,
['tablet'] = Vector2.zero,
['tablet-02'] = Vector2.zero,
['tag'] = Vector2.zero,
['tag-02'] = Vector2.zero,
['tag-03'] = Vector2.zero,
['target'] = Vector2.zero,
['target-02'] = Vector2.zero,
['target-03'] = Vector2.zero,
['target-04'] = Vector2.zero,
['target-05'] = Vector2.zero,
['target-arrow'] = Vector2.zero,
['telescope'] = Vector2.zero,
['terminal'] = Vector2.zero,
['terminal-browser'] = Vector2.zero,
['terminal-circle'] = Vector2.zero,
['terminal-square'] = Vector2.zero,
['text-align-left'] = Vector2.zero,
['text-align-right'] = Vector2.zero,
['text-input'] = Vector2.zero,
['thermometer'] = Vector2.zero,
['thermometer-02'] = Vector2.zero,
['thermometer-03'] = Vector2.zero,
['thermometer-cold'] = Vector2.zero,
['thermometer-warm'] = Vector2.zero,
['thumbs-down'] = Vector2.zero,
['thumbs-up'] = Vector2.zero,
['ticket'] = Vector2.zero,
['ticket-02'] = Vector2.zero,
['toggle-01-left'] = Vector2.zero,
['toggle-01-right'] = Vector2.zero,
['toggle-02-left'] = Vector2.zero,
['toggle-02-right'] = Vector2.zero,
['toggle-03-left'] = Vector2.zero,
['toggle-03-right'] = Vector2.zero,
['toggle-left'] = Vector2.zero,
['toggle-right'] = Vector2.zero,
['toggle-rounded-left'] = Vector2.zero,
['toggle-rounded-right'] = Vector2.zero,
['tool'] = Vector2.zero,
['tool-02'] = Vector2.zero,
['train'] = Vector2.zero,
['tram'] = Vector2.zero,
['transform'] = Vector2.zero,
['translate'] = Vector2.zero,
['translate-02'] = Vector2.zero,
['trash'] = Vector2.zero,
['trash-02'] = Vector2.zero,
['trash-03'] = Vector2.zero,
['trash-04'] = Vector2.zero,
['trend-down'] = Vector2.zero,
['trend-down-02'] = Vector2.zero,
['trend-up'] = Vector2.zero,
['trend-up-02'] = Vector2.zero,
['triangle'] = Vector2.zero,
['trophy'] = Vector2.zero,
['trophy-02'] = Vector2.zero,
['truck'] = Vector2.zero,
['truck-02'] = Vector2.zero,
['tv'] = Vector2.zero,
['tv-02'] = Vector2.zero,
['tv-03'] = Vector2.zero,
['type'] = Vector2.zero,
['type-02'] = Vector2.zero,
['type-square'] = Vector2.zero,
['type-strikethrough'] = Vector2.zero,
['type-strikethrough-02'] = Vector2.zero,
['umbrella'] = Vector2.zero,
['umbrella-02'] = Vector2.zero,
['umbrella-03'] = Vector2.zero,
['underline'] = Vector2.zero,
['underline-02'] = Vector2.zero,
['underline-square'] = Vector2.zero,
['upload'] = Vector2.zero,
['upload-02'] = Vector2.zero,
['upload-03'] = Vector2.zero,
['upload-04'] = Vector2.zero,
['upload-circle'] = Vector2.zero,
['upload-circle-broken'] = Vector2.zero,
['upload-cloud'] = Vector2.zero,
['upload-cloud-02'] = Vector2.zero,
['usb-flash-drive'] = Vector2.zero,
['user'] = Vector2.zero,
['user-02'] = Vector2.zero,
['user-03'] = Vector2.zero,
['user-check'] = Vector2.zero,
['user-check-02'] = Vector2.zero,
['user-circle'] = Vector2.zero,
['user-down'] = Vector2.zero,
['user-down-02'] = Vector2.zero,
['user-edit'] = Vector2.zero,
['user-left'] = Vector2.zero,
['user-left-02'] = Vector2.zero,
['user-minus'] = Vector2.zero,
['user-minus-02'] = Vector2.zero,
['user-plus'] = Vector2.zero,
['user-plus-02'] = Vector2.zero,
['user-right'] = Vector2.zero,
['user-right-02'] = Vector2.zero,
['user-square'] = Vector2.zero,
['user-up'] = Vector2.zero,
['user-up-02'] = Vector2.zero,
['user-x'] = Vector2.zero,
['user-x-02'] = Vector2.zero,
['users'] = Vector2.zero,
['users-02'] = Vector2.zero,
['users-03'] = Vector2.zero,
['users-check'] = Vector2.zero,
['users-down'] = Vector2.zero,
['users-edit'] = Vector2.zero,
['users-left'] = Vector2.zero,
['users-minus'] = Vector2.zero,
['users-plus'] = Vector2.zero,
['users-right'] = Vector2.zero,
['users-up'] = Vector2.zero,
['users-x'] = Vector2.zero,
['variable'] = Vector2.zero,
['video-recorder'] = Vector2.zero,
['video-recorder-off'] = Vector2.zero,
['virus'] = Vector2.zero,
['voicemail'] = Vector2.zero,
['volume-max'] = Vector2.zero,
['volume-min'] = Vector2.zero,
['volume-minus'] = Vector2.zero,
['volume-plus'] = Vector2.zero,
['volume-x'] = Vector2.zero,
['wallet'] = Vector2.zero,
['wallet-02'] = Vector2.zero,
['wallet-03'] = Vector2.zero,
['wallet-04'] = Vector2.zero,
['wallet-05'] = Vector2.zero,
['watch-circle'] = Vector2.zero,
['watch-square'] = Vector2.zero,
['waves'] = Vector2.zero,
['webcam'] = Vector2.zero,
['webcam-02'] = Vector2.zero,
['wifi-off'] = Vector2.zero,
},
}
end
function __DARKLUA_BUNDLE_MODULES.E()
local icons = {
untitled = __DARKLUA_BUNDLE_MODULES.load('D'),
}

local function ProcessIconsMap(
iconsList,
iconsMap,
image,
iconSize,
sizeOffset,
columns
)
for iconIndex, iconName in iconsList do
iconIndex = iconIndex - 1
iconsMap[iconName] = {
image = image,
size = iconSize,
position = Vector2.new((iconIndex % columns) * sizeOffset, math.floor((iconIndex / columns)) * sizeOffset),
}
end
end

for _, pack in icons do
pack.image = 'rbxassetid://' .. pack.image

local sizeOffset = pack.size
local iconsMap = pack.icons
local iconsList = {}

for i, v in iconsMap do
table.insert(iconsList, i)
end

table.sort(iconsList)

local columns = pack.columns

if not columns then
local totalIcons = 0

for i, v in iconsMap do
totalIcons = totalIcons + 1
end

columns = math.ceil(math.sqrt(totalIcons))
end

local iconSize = Vector2.new(sizeOffset, sizeOffset)

ProcessIconsMap(iconsList, iconsMap, pack.image, iconSize, sizeOffset, columns)
end

return icons
end
function __DARKLUA_BUNDLE_MODULES.F()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local create = vide.create
local fontWeightMap = {
['semi-bold'] = Enum.FontWeight.SemiBold,
['bold'] = Enum.FontWeight.Bold,
}

return function(props)
local weight = props.fontWeight

return create'TextLabel'{
Name = 'Label',
BackgroundTransparency = 1,
ClipsDescendants = false,
FontFace = Font.new('rbxasset://fonts/families/Ubuntu.json', (weight and {
(fontWeightMap[weight]),
} or {
(Enum.FontWeight.Regular),
})[1]),
AutomaticSize = Enum.AutomaticSize.Y,
Size = UDim2.new(1, 0, 0, 0),
Text = props.content,
TextColor3 = props.color or Color3.fromRGB(180, 200, 230),
TextSize = props.size or 10,
TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Left,
LayoutOrder = props.layoutOrder or 0,
create'UIPadding'{
PaddingLeft = UDim.new(0, props.paddingLeft or 0),
PaddingRight = UDim.new(0, props.paddingRight or 0),
},
}
end
end
function __DARKLUA_BUNDLE_MODULES.G()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local derive = vide.derive
local source = vide.source
local create = vide.create
local indexes = vide.indexes
local Label = __DARKLUA_BUNDLE_MODULES.load('F')

local function Category(props)
local isOpened = props.isOpened
local sections = source(props.sections)

local container = create'ScrollingFrame'{
Name = 'Container',
AutomaticCanvasSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
ClipsDescendants = true,
LayoutOrder = 2,
ScrollBarThickness = 2,
ScrollBarImageColor3 = Color3.fromRGB(45, 100, 135),
CanvasPosition = Vector2.new(0, 0),
Selectable = false,
Size = UDim2.fromScale(1, 1),
Visible = isOpened,
create'UIListLayout'{
Padding = UDim.new(0, 2),
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Vertical,
HorizontalAlignment = Enum.HorizontalAlignment.Left,
},
create'UIPadding'{
PaddingLeft = UDim.new(0, 6),
PaddingTop = UDim.new(0, 5),
PaddingRight = UDim.new(0, 6),
PaddingBottom = UDim.new(0, 5),
},
indexes(sections, function(section, i)
local expanded = source(true)
local sectionFrame = create'Frame'{
Name = 'Section',
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
Size = UDim2.new(1, 0, 0, 0),
LayoutOrder = i,
BorderSizePixel = 0,
create'UIListLayout'{
Padding = UDim.new(0, 1),
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Vertical,
},
create'TextButton'{
Name = 'SectionHeader',
BackgroundTransparency = 1,
AutoButtonColor = false,
Size = UDim2.new(1, 0, 0, 18),
Text = '',
LayoutOrder = 0,
Activated = function()
expanded(not expanded())
end,
create'Frame'{
Name = 'Accent',
BackgroundColor3 = Color3.fromRGB(0, 185, 240),
BackgroundTransparency = 0.15,
BorderSizePixel = 0,
Position = UDim2.new(0, 0, 0.5, -5),
Size = UDim2.fromOffset(2, 10),
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
},
create'TextLabel'{
Name = 'SectionTitle',
BackgroundTransparency = 1,
Position = UDim2.fromOffset(7, 0),
Size = UDim2.new(1, -23, 1, 0),
Font = Enum.Font.GothamBold,
Text = string.upper(section().name),
TextColor3 = Color3.fromRGB(125, 205, 240),
TextSize = 8,
TextXAlignment = Enum.TextXAlignment.Left,
},
create'TextLabel'{
Name = 'CollapseIndicator',
BackgroundTransparency = 1,
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, 0, 0, 0),
Size = UDim2.fromOffset(14, 18),
Font = Enum.Font.GothamBold,
Text = derive(function()
return expanded() and '−' or '+'
end),
TextColor3 = Color3.fromRGB(95, 135, 160),
TextSize = 10,
},
},
create'Frame'{
Name = 'SectionBody',
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
Size = UDim2.new(1, 0, 0, 0),
LayoutOrder = 1,
Visible = expanded,
create'UIListLayout'{
Padding = UDim.new(0, 0),
SortOrder = Enum.SortOrder.LayoutOrder,
FillDirection = Enum.FillDirection.Vertical,
},
unpack(section().content),
},
}
return {sectionFrame}
end),
}

local category = create'ImageButton'{
Name = 'Category',
BackgroundTransparency = 1,
Size = UDim2.fromOffset(0, 0),
Visible = false,
Activated = function()
isOpened(not isOpened())
end,
}

return category, container
end

return Category
end
function __DARKLUA_BUNDLE_MODULES.H()
local RunService = game:GetService('RunService')
local Lerp = {}

function Lerp:TweenPartCFrame(part, goalCFrame, duration, onComplete)
duration = math.max(duration or 1, 0.03)

assert(part and part:IsA('BasePart'), 'Expected BasePart at argument #1')
assert(goalCFrame and typeof(goalCFrame) == 'CFrame', 'Expected CFrame at argument #2')

local startCFrame = part.CFrame
local startTime = tick()
local connection

connection = RunService.PreRender:Connect(function()
if not part or not part.Parent then
connection:Disconnect()

return
end

local alpha = math.min((tick() - startTime) / duration, 1)

part.CFrame = startCFrame:lerp(goalCFrame, alpha)

if alpha >= 1 then
connection:Disconnect()

part.CFrame = goalCFrame

if onComplete then
onComplete()
end
end
end)

return connection
end

return Lerp
end
function __DARKLUA_BUNDLE_MODULES.I()
local LerpTween = __DARKLUA_BUNDLE_MODULES.load('H')
local player = game:GetService('Players').LocalPlayer
local groundDirection = Vector3.new(0, -100, 0)

local function RaycastAnimalGround()
if not player.Character then return nil end
local origin = player.Character:GetPivot().Position
local result = workspace:Raycast(origin, groundDirection)

return result
end

local Animal = {
basicAttackCooldown = 0.6,
specialAttackCooldown = 1.9,
}
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local AttackHandlerRemoteEvent = ReplicatedStorage.AttackHandlerRemoteEvent

function Animal.BasicAttack(targetHumanoid)
AttackHandlerRemoteEvent:FireServer(targetHumanoid)
if not player.Character then return end
player.Character:SetAttribute('LastBasicAttack', tick())
end

local SpecialAttackRemoteEvent_RegularAttack = ReplicatedStorage.SpecialAttackRemoteEvent_RegularAttack

function Animal.SpecialAttack(targetHumanoid)
SpecialAttackRemoteEvent_RegularAttack:FireServer(targetHumanoid)
if not player.Character then return end
player.Character:SetAttribute('LastSpecialAttack', tick())
end
function Animal.IsBasicAttackOnCooldown()
if not player.Character then return false end
local last = player.Character:GetAttribute('LastBasicAttack')

return last and tick() - last < Animal.basicAttackCooldown
end
function Animal.IsSpecialAttackOnCooldown()
if not player.Character then return false end
local last = player.Character:GetAttribute('LastSpecialAttack')

return last and tick() - last < Animal.specialAttackCooldown
end
function Animal.IsOnGrass()
local result = RaycastAnimalGround()

return result and result.Material == Enum.Material.Grass
end
function Animal.IsOnWater()
local result = RaycastAnimalGround()

return result and result.Material == Enum.Material.Water
end

local terrainCellSize = Vector3.new(4, 4, 4)

function Animal.IsInsideTerrain()
local character = player.Character

if not character then
return false
end

local root = character:FindFirstChild("HumanoidRootPart")
if not root then return false end
local position = root.Position

if position.Magnitude == 0 then return false end

local ok, result = pcall(function()
local region = Region3.new(position, position + terrainCellSize):ExpandToGrid(4)
local _, occupancies = workspace.Terrain:ReadVoxels(region, 4)
return occupancies[1][1][1] > 0
end)

if not ok then return false end
return result
end

local maxStudsPerSecond = 80
local activeTweenConnection
local activeTweenPart

local function cancelActiveTween(zeroVelocity)
if activeTweenConnection then
activeTweenConnection:Disconnect()
activeTweenConnection = nil
end

if zeroVelocity and activeTweenPart and activeTweenPart.Parent then
activeTweenPart.AssemblyLinearVelocity = Vector3.zero
activeTweenPart.AssemblyAngularVelocity = Vector3.zero
end

activeTweenPart = nil
shared._animalTweening = false
end

function Animal.CancelTween(zeroVelocity)
cancelActiveTween(zeroVelocity)
end

function Animal.IsTweening()
return activeTweenConnection ~= nil
end

function Animal.TweenTo(cframe, studsPerSecond)
local character = player.Character

if not character then
return
end

local root = character:FindFirstChild("HumanoidRootPart")
if not root then return end
local rootPosition = root.Position
local duration = (cframe.Position - rootPosition).Magnitude / (tonumber(studsPerSecond) or maxStudsPerSecond)

cancelActiveTween(true)

local connection
connection = LerpTween:TweenPartCFrame(root, cframe, duration, function()
if activeTweenConnection == connection then
activeTweenConnection = nil
activeTweenPart = nil
shared._animalTweening = false
end
end)
activeTweenConnection = connection
activeTweenPart = root
shared._animalTweening = true

return duration
end
function Animal.TweenToAsync(cframe)
local duration = Animal.TweenTo(cframe)

if duration then
task.wait(duration)
end
end

local PathfindingService = game:GetService("PathfindingService")

function Animal.WalkToAsync(goalCFrame, options)
local character = player.Character
if not character then return false end

local root = character:FindFirstChild("HumanoidRootPart")
local humanoid = character:FindFirstChild("Humanoid")
if not root or not humanoid or humanoid.Health <= 0 then return false end

cancelActiveTween(true)
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
local myWalkGeneration = shared._animalWalkGeneration

if root.Anchored then
root.Anchored = false
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end
humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

shared._animalTweening = true

-- Juvenile movement tuning is isolated to characters below 30% growth.
-- Characters at 30% or above use the original movement parameters.
local growthPercentage = tonumber(character:GetAttribute("GrowthPercentage"))
local isJuvenileMovement = growthPercentage ~= nil and growthPercentage < 0.30

local brachiSlowWaterMove =
tostring(character:GetAttribute("AnimalName") or "") == "Brachiosaurus"
and type(options) == "table"
and options.groundedRecovery == true

local walkSpeed =
brachiSlowWaterMove and 25
or (isJuvenileMovement and 24 or 45)

local animalName = (character:GetAttribute("AnimalName") or ""):lower()
local BIG_ANIMALS = { elefante = true, elefanteafricano = true, rhino = true, rinoceronte = true, girafa = true, ["hipopótamo"] = true, hipo = true, hippo = true }
local agentRadius = (BIG_ANIMALS[animalName] or animalName:find("elef") or animalName:find("rhin") or animalName:find("giraf") or animalName:find("hipo")) and 8 or 4
local agentHeight = 6

if isJuvenileMovement then
agentRadius = math.max(2, agentRadius * 0.5)
agentHeight = 3.5

if shared._juvenileMoveLogCharacter ~= character then
shared._juvenileMoveLogCharacter = character
goatPrint(string.format(
"[Animal] Juvenile movement tuning ON | growth=%.1f%% | radius=%.1f | height=%.1f",
growthPercentage * 100,
agentRadius,
agentHeight
))
end
end

local stuckDetection = true
local maxRecalculations = isJuvenileMovement and 3 or 2

local swimLeg = type(options) == "table" and options.swim == true
and shared._autoQuestSwimLock == true

-- Optional mode used only by the fixed-water recovery's long LAND leg.
-- It keeps tween fallback close to the terrain instead of cutting through it.
local groundedRecovery =
type(options) == "table" and options.groundedRecovery == true

if brachiSlowWaterMove
and shared._brachiSlowWaterMoveLogCharacter ~= character
then
shared._brachiSlowWaterMoveLogCharacter = character
goatPrint("[Animal][DL] Brachiosaurus natural water movement ON | fallbackSpeed=25 | maxStep=5")
end

local waypoints = nil
if swimLeg then
waypoints = { { Position = root.Position }, { Position = goalCFrame.Position } }
else
pcall(function()
local path = PathfindingService:CreatePath({
AgentRadius = agentRadius,
AgentHeight = agentHeight,
AgentCanJump = false,
Costs = { Water = 20 },  -- evita rota pela água
})
path:ComputeAsync(root.Position, goalCFrame.Position)
if path.Status == Enum.PathStatus.Success then
waypoints = path:GetWaypoints()
end
end)

end
if not waypoints then
waypoints = { { Position = root.Position }, { Position = goalCFrame.Position } }
end

if (groundedRecovery or isJuvenileMovement) and #waypoints >= 2 then
local dense = { { Position = waypoints[1].Position } }
local MAX_GROUND_STEP =
brachiSlowWaterMove and 5
or (isJuvenileMovement and 3.5 or 7)

for wi = 2, #waypoints do
local from = dense[#dense].Position
local to = waypoints[wi].Position
local flatDelta = Vector3.new(to.X - from.X, 0, to.Z - from.Z)
local steps = math.max(1, math.ceil(flatDelta.Magnitude / MAX_GROUND_STEP))

for si = 1, steps do
local alpha = si / steps
dense[#dense + 1] = {
Position = from:Lerp(to, alpha)
}
end
end

waypoints = dense
end

local function aborted()
local ch = player.Character
local hum = ch and ch:FindFirstChild("Humanoid")
return not ch or not hum or hum.Health <= 0
or shared._animalWalkGeneration ~= myWalkGeneration
or not shared._animalTweening
end

-- A failed MoveTo from a tiny juvenile must not poison the global adult mode.
-- Juveniles always get their own probe first.
local moveMode = swimLeg and "tween"
or (isJuvenileMovement and "probe")
or (shared._animalMoveToBroken and "tween" or "probe")
local recalculations = 0
local legStuck = false

local travelGroundParams = RaycastParams.new()
travelGroundParams.FilterType = Enum.RaycastFilterType.Exclude
travelGroundParams.FilterDescendantsInstances = {character}

-- Grounded recovery must follow the MAP TERRAIN, not the top surface of
-- trees, bushes, decorative rocks or other MeshParts. Using Terrain-only
-- raycasts prevents a canopy/rock prop from becoming a fake floor.
local groundedTerrainParams = RaycastParams.new()
groundedTerrainParams.FilterType = Enum.RaycastFilterType.Include
groundedTerrainParams.FilterDescendantsInstances = {workspace.Terrain}
groundedTerrainParams.IgnoreWater = true

local function groundedTravelWaypoint(rawTarget)
if groundedRecovery then
local currentY = root.Position.Y
local castTop = math.max(currentY, rawTarget.Y) + 80

local hit = workspace:Raycast(
Vector3.new(rawTarget.X, castTop, rawTarget.Z),
Vector3.new(0, -260, 0),
groundedTerrainParams
)

if hit and hit.Normal.Y >= 0.35 then
local minLift = isJuvenileMovement and 0.8 or 2.4
local lift = math.max(humanoid.HipHeight, minLift)
local terrainTargetY = hit.Position.Y + lift

-- Juveniles use much smaller vertical changes so a tiny rig is not lifted
-- several studs per waypoint. Adult values are unchanged.
local MAX_STEP_UP = isJuvenileMovement and 1.5 or 3.5
local MAX_STEP_DOWN = isJuvenileMovement and 2.5 or 5.0
local safeY = math.clamp(
terrainTargetY,
currentY - MAX_STEP_DOWN,
currentY + MAX_STEP_UP
)

if math.abs(terrainTargetY - safeY) > 0.25 then
goatPrint(string.format(
"[Animal] Ground waypoint height limited | terrainY=%.1f | currentY=%.1f | safeY=%.1f",
terrainTargetY,
currentY,
safeY
))
end

return Vector3.new(rawTarget.X, safeY, rawTarget.Z)
end

-- No Terrain below this mini-step: do not climb a prop or dive vertically.
-- Keep current body height and let the monitored route/stuck logic recalc.
return Vector3.new(rawTarget.X, currentY, rawTarget.Z)
end

if shared._autoQuestTravelLock ~= true then
return rawTarget
end

local currentY = root.Position.Y
local origin = Vector3.new(rawTarget.X, currentY + 120, rawTarget.Z)
local hit = workspace:Raycast(
origin,
Vector3.new(0, -420, 0),
travelGroundParams
)

local wantedY = currentY
if hit and hit.Material ~= Enum.Material.Water then
wantedY = hit.Position.Y + 3.2
end

wantedY = math.clamp(
wantedY,
currentY - 4.5,
currentY + 1.25
)

return Vector3.new(rawTarget.X, wantedY, rawTarget.Z)
end

local arrivalTolerance = isJuvenileMovement and 1.2 or 3
local probeMovementNeeded =
brachiSlowWaterMove and 0.5
or (isJuvenileMovement and 0.65 or 2)
local probeTimeout =
brachiSlowWaterMove and 3.5
or (isJuvenileMovement and 3.5 or 2)
local juvenileStuckMovement = isJuvenileMovement and 0.35 or 1
local stuckWindow = brachiSlowWaterMove and 6 or (isJuvenileMovement and 5 or 4)

while true do
for i = 2, #waypoints do
if aborted() then
shared._animalTweening = false
return nil
end

local target = groundedTravelWaypoint(waypoints[i].Position)
local flat = (target - root.Position) * Vector3.new(1, 0, 1)

if flat.Magnitude >= arrivalTolerance then
if moveMode == "probe" or moveMode == "moveto" then
local legStart = root.Position
humanoid:MoveTo(target)
local t0 = os.clock()
local moving = false
while os.clock() - t0 < probeTimeout do
if aborted() then
shared._animalTweening = false
return nil
end
if (root.Position - legStart).Magnitude > probeMovementNeeded then
moving = true
break
end
task.wait(0.1)
end

if moving then
moveMode = "moveto"
if not isJuvenileMovement then
shared._animalMoveToBroken = false
end
local naturalLegSpeed = brachiSlowWaterMove and 4 or 8
local legDeadline = os.clock() + (flat.Magnitude / naturalLegSpeed) + 15
while os.clock() < legDeadline do
if aborted() then
shared._animalTweening = false
return nil
end
local flatNow = (target - root.Position) * Vector3.new(1, 0, 1)
if flatNow.Magnitude < arrivalTolerance then break end
humanoid:MoveTo(target)
task.wait(0.5)
end
else
moveMode = "tween"
if not isJuvenileMovement then
shared._animalMoveToBroken = true
goatPrint("[Animal] MoveTo sem efeito neste rig — usando tween entre waypoints")
else
goatPrint("[Animal] Juvenile MoveTo fallback — tween curto/lento entre mini-waypoints")
end
end
end

if moveMode == "tween" then
if aborted() then
shared._animalTweening = false
return nil
end
local dirFlat = Vector3.new(flat.X, 0, flat.Z)
local legGoal = (dirFlat.Magnitude > 0.01)
and CFrame.lookAlong(target, dirFlat.Unit)
or CFrame.new(target)
local legSpeed = walkSpeed
Animal.TweenTo(legGoal, legSpeed)
local legDeadline = os.clock() + (flat.Magnitude / legSpeed) + 15
local legStartPos = root.Position
local tStuck = os.clock()
legStuck = false
while os.clock() < legDeadline do
local flatNow = (target - root.Position) * Vector3.new(1, 0, 1)
if flatNow.Magnitude < arrivalTolerance then
break
end
if aborted() then
shared._animalTweening = false
return nil
end
if stuckDetection and os.clock() - tStuck >= stuckWindow then
if (root.Position - legStartPos).Magnitude < juvenileStuckMovement then
legStuck = true
break
end
tStuck = os.clock()
legStartPos = root.Position
end
task.wait(0.05)
end
if legStuck then
break  -- sai do for para recalcular a rota
end
shared._animalTweening = true  -- reafirma posse até o fim da caminhada
end
end
end

if not legStuck then
shared._animalTweening = false
return true
end

if swimLeg then
cancelActiveTween(true)
return false
end
recalculations = recalculations + 1
if recalculations > maxRecalculations then
goatWarn("[Animal] Travado após " .. maxRecalculations .. " recálculos — desistindo desta caminhada")
shared._animalTweening = false
return false
end
goatPrint("[Animal] Possível travamento — recalculando rota (" .. recalculations .. "/" .. maxRecalculations .. ")")
cancelActiveTween(true)
shared._animalTweening = true
task.wait(0.5)
waypoints = nil
pcall(function()
local path = PathfindingService:CreatePath({
AgentRadius = agentRadius,
AgentHeight = agentHeight,
AgentCanJump = false,
Costs = { Water = 20 },
})
path:ComputeAsync(root.Position, goalCFrame.Position)
if path.Status == Enum.PathStatus.Success then
waypoints = path:GetWaypoints()
end
end)
if not waypoints then
waypoints = { { Position = root.Position }, { Position = goalCFrame.Position } }
end

if (groundedRecovery or isJuvenileMovement) and #waypoints >= 2 then
local dense = { { Position = waypoints[1].Position } }
local MAX_GROUND_STEP =
brachiSlowWaterMove and 5
or (isJuvenileMovement and 3.5 or 7)

for wi = 2, #waypoints do
local from = dense[#dense].Position
local to = waypoints[wi].Position
local flatDelta = Vector3.new(to.X - from.X, 0, to.Z - from.Z)
local steps = math.max(1, math.ceil(flatDelta.Magnitude / MAX_GROUND_STEP))

for si = 1, steps do
local alpha = si / steps
dense[#dense + 1] = {
Position = from:Lerp(to, alpha)
}
end
end

waypoints = dense
end

legStuck = false
end
end

shared._animalWalkToAsync = Animal.WalkToAsync
shared._animalCancelTween = Animal.CancelTween

return Animal
end
function __DARKLUA_BUNDLE_MODULES.J()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local create = vide.create
local icons = __DARKLUA_BUNDLE_MODULES.load('E')

return function(props)
local icon = props.icon
local size = props.size or 10

return create'ImageLabel'{
Name = 'Icon',
AnchorPoint = Vector2.new(0.5, 0.5),
BackgroundTransparency = 1,
Image = icon.image,
ImageRectOffset = icon.position,
ImageRectSize = icon.size,
Position = UDim2.fromScale(0.5, 0.5),
ScaleType = Enum.ScaleType.Fit,
Size = UDim2.fromOffset(size, size),
ImageColor3 = props.color or Color3.new(1, 1, 1),
create'UIFlexItem'{},
}
end
end
function __DARKLUA_BUNDLE_MODULES.K()
local check = __DARKLUA_BUNDLE_MODULES.load('y')
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local create = vide.create
local barBackground = Color3.fromRGB(0, 50, 100)

local function CreateTrailBar(isFinalizer, size)
return create'Frame'{
Name = 'FrameHorizontal',
AnchorPoint = Vector2.new(0, 0.5),
BackgroundColor3 = barBackground,
BorderSizePixel = 0,
Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.new(0.5, 0, 0, 1),
}, create'Frame'{
Name = 'FrameVertical',
AnchorPoint = Vector2.new(0.5, 0),
BackgroundColor3 = barBackground,
BorderSizePixel = 0,
Position = UDim2.fromScale(0.5, 0),
Size = UDim2.new(0, 1, isFinalizer and 0.5 or 1, 0),
}, create'UISizeConstraint'{
MinSize = Vector2.new(0, 0),
MaxSize = Vector2.new(size, size),
}
end
local function TreeChildTrail(props)
check(props, {
isFinalizer = 'boolean',
size = 'number?',
})

local isFinalizer = props.isFinalizer
local size = props.size or 20

return create'Frame'{
Size = UDim2.new(0, size, 0, size),
BackgroundTransparency = 1,
CreateTrailBar(isFinalizer, size),
}
end

return TreeChildTrail
end
function __DARKLUA_BUNDLE_MODULES.L()
local ControlManager = {
states = {
character = {
controlled = false,
priority = 0,
owner = nil,
},
camera = {
controlled = false,
priority = 0,
owner = nil,
},
},
timeouts = {},
events = {},
}

function ControlManager:requestControl(
owner,
controlType,
priority,
timeout
)
local state = self.states[controlType]

if not state then
return false
end
if state.controlled and priority <= state.priority then
return false
end
if state.controlled then
self:releaseControl(controlType)
end

state.controlled = true
state.priority = priority
state.owner = owner

if timeout then
self.timeouts[controlType] = task.delay(timeout, function()
if state.owner == owner then
self:releaseControl(controlType)
end
end)
end

self:emit('control_taken', {
controlType = controlType,
owner = owner,
priority = priority,
})

return true
end
function ControlManager:releaseControl(controlType, owner)
local state = self.states[controlType]

if not state or not state.controlled then
return
end
if owner and state.owner ~= owner then
return
end

local oldOwner = state.owner

state.controlled = false
state.priority = 0
state.owner = nil

if self.timeouts[controlType] then
task.cancel(self.timeouts[controlType])

self.timeouts[controlType] = nil
end

self:emit('control_released', {
controlType = controlType,
owner = oldOwner,
})
end
function ControlManager:hasControl(owner, controlType)
local state = self.states[controlType]

return state and state.controlled and state.owner == owner
end
function ControlManager:canTakeControl(controlType, priority)
local state = self.states[controlType]

return not state or not state.controlled or priority > state.priority
end
function ControlManager:emit(event, data)
local listeners = self.events[event] or {}

for _, callback in ipairs(listeners)do
task.spawn(callback, data)
end
end
function ControlManager:on(event, callback)
if not self.events[event] then
self.events[event] = {}
end

table.insert(self.events[event], callback)
end

return ControlManager
end
function __DARKLUA_BUNDLE_MODULES.M()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local cleanup = vide.cleanup
local effect = vide.effect
local source = vide.source
local create = vide.create
local Icon = __DARKLUA_BUNDLE_MODULES.load('J')
local Label = __DARKLUA_BUNDLE_MODULES.load('F')
local TreeChildTrail = __DARKLUA_BUNDLE_MODULES.load('K')
local ControlManager = __DARKLUA_BUNDLE_MODULES.load('L')

local function Checkbox(props)
local isChecked = props.isChecked

if not isChecked or type(isChecked) == 'boolean' then
isChecked = source(isChecked or false)
end

cleanup(function()
if isChecked() then
goatPrint(props.label, isChecked())
isChecked(false)
end
end)

local isDisabled = props.isDisabled or source(false)
local childs = props.childs and source(props.childs)
local ownerId = tostring({})
local accent = props.accent or Color3.fromRGB(0, 170, 255)

local function requestAllControls()
if not props.controlPriority then
return true
end

local acquired = {}

for controlType, priority in pairs(props.controlPriority)do
if ControlManager:requestControl(ownerId, controlType, priority, props.controlTimeout) then
table.insert(acquired, controlType)
else
for _, acquiredType in ipairs(acquired)do
ControlManager:releaseControl(acquiredType, ownerId)
end

return false
end
end

return true
end
local function hasRequiredControl()
if not props.controlPriority then
return true
end

for controlType, priority in pairs(props.controlPriority)do
if not ControlManager:hasControl(ownerId, controlType) then
return false
end
end

return true
end
local function releaseAllControls()
if not props.controlPriority then
return
end

for controlType, _ in pairs(props.controlPriority)do
ControlManager:releaseControl(controlType, ownerId)
end
end

local whenCheckedConnections = {}

local function addWhenCheckedConnection(connection)
table.insert(whenCheckedConnections, connection)
end
local function cleanupWhenChecked()
for _, connection in ipairs(whenCheckedConnections)do
if connection.Connected then
connection:Disconnect()
end
end

whenCheckedConnections = {}
end
local function whileCheckedLoop()
local WhileChecked = props.WhileChecked

if not WhileChecked then
return
end

while isChecked() do
local hasRequired = hasRequiredControl()

if hasRequired or requestAllControls() then
local returnValue = WhileChecked()

if returnValue == false then
releaseAllControls()
end
end

task.wait()
end
end
local function onCheckedChanged(newState)
if props.OnChanged then
task.spawn(props.OnChanged, newState)
end
if newState then
if props.WhenChecked then
task.spawn(props.WhenChecked, addWhenCheckedConnection)
end

task.spawn(whileCheckedLoop)
else
cleanupWhenChecked()
releaseAllControls()
end
end

effect(function()
onCheckedChanged(isChecked())
end)

local checkboxFrame = create'Frame'{
Name = 'Checkbox',
BackgroundTransparency = 1,
BorderSizePixel = 0,
Size = UDim2.new(1, 0, 0, 24),
create'UIPadding'{
PaddingLeft = UDim.new(0, 2),
PaddingRight = UDim.new(0, 1),
},
create'UIListLayout'{
FillDirection = Enum.FillDirection.Horizontal,
HorizontalFlex = Enum.UIFlexAlignment.Fill,
SortOrder = Enum.SortOrder.LayoutOrder,
VerticalAlignment = Enum.VerticalAlignment.Center,
},
Label({
content = props.shortLabel or props.label,
color = props.labelColor or Color3.fromRGB(205, 218, 232),
size = 8,
fontWeight = 'semi-bold',
}),
create'Frame'{
Name = 'ToggleWrapper',
BackgroundTransparency = 1,
Size = UDim2.fromOffset(28, 16),
create'Frame'{
Name = 'Glow',
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromOffset(28, 16),
BackgroundColor3 = accent,
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 0,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
},
create'ImageButton'{
Name = 'CheckButton',
BackgroundColor3 = Color3.fromRGB(18, 24, 36),
BackgroundTransparency = 0,
Size = UDim2.fromOffset(26, 14),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
AutoButtonColor = false,
BorderSizePixel = 0,
ZIndex = 2,
Activated = function()
if not isDisabled() then
local newState = not isChecked()
if props.OnUserChanged then
local ok, err = pcall(props.OnUserChanged, newState)
if not ok then
goatWarn("[Checkbox] OnUserChanged error for " .. tostring(props.label) .. ": " .. tostring(err))
end
end
isChecked(newState)
end
end,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
create'UIStroke'{
Name = 'TrackStroke',
Color = Color3.fromRGB(45, 68, 90),
Thickness = 1,
Transparency = 0.72,
},
create'Frame'{
Name = 'ThumbShadow',
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0, 7, 0.52, 0),
Size = UDim2.fromOffset(10, 10),
BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = 0.72,
BorderSizePixel = 0,
ZIndex = 2,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
},
create'Frame'{
Name = 'Thumb',
BackgroundColor3 = Color3.fromRGB(120, 135, 150),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0, 7, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
BorderSizePixel = 0,
ZIndex = 3,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
create'Frame'{
Name = 'Shine',
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.35, 0.28),
Size = UDim2.fromOffset(3, 1),
BackgroundColor3 = Color3.new(1, 1, 1),
BackgroundTransparency = 0.55,
BorderSizePixel = 0,
ZIndex = 4,
create'UICorner'{ CornerRadius = UDim.new(1, 0) },
},
},
},
},
}

effect(function()
local transparency = isDisabled() and 0.5 or 0

checkboxFrame.ToggleWrapper.CheckButton.Active = not isDisabled()
checkboxFrame.ToggleWrapper.CheckButton.BackgroundTransparency = transparency
checkboxFrame.ToggleWrapper.CheckButton.Thumb.BackgroundTransparency = transparency
checkboxFrame.ToggleWrapper.CheckButton.ThumbShadow.BackgroundTransparency = math.clamp(transparency + 0.6, 0, 1)
checkboxFrame.ToggleWrapper.CheckButton.Thumb.Shine.BackgroundTransparency = math.clamp(transparency + 0.4, 0, 1)
checkboxFrame.ToggleWrapper.Glow.BackgroundTransparency = math.clamp(transparency + 1, 0, 1)
checkboxFrame.Label.TextTransparency = transparency
end)
effect(function()
local isCheckedValue = isChecked()
local TweenService = game:GetService('TweenService')
local slowTween = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local quickTween = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local bounceTween = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)

local track = checkboxFrame.ToggleWrapper.CheckButton
local thumb = track.Thumb
local thumbShadow = track.ThumbShadow
local glow = checkboxFrame.ToggleWrapper.Glow
local stroke = track.TrackStroke

local trackColor = isCheckedValue and accent or Color3.fromRGB(18, 24, 38)
local thumbColor = isCheckedValue and Color3.fromRGB(245, 252, 255) or Color3.fromRGB(115, 130, 150)
local thumbPos = isCheckedValue and UDim2.new(1, -7, 0.5, 0) or UDim2.new(0, 7, 0.5, 0)
local shadowPos = isCheckedValue and UDim2.new(1, -7, 0.52, 0) or UDim2.new(0, 7, 0.52, 0)
local glowTransparency = isCheckedValue and 0.75 or 1
local strokeColor = isCheckedValue and accent or Color3.fromRGB(48, 78, 118)
local strokeTransparency = isCheckedValue and 0.3 or 0.7

TweenService:Create(track, quickTween, {BackgroundColor3 = trackColor}):Play()
TweenService:Create(thumb, bounceTween, {BackgroundColor3 = thumbColor, Position = thumbPos, Size = UDim2.fromOffset(12, 12)}):Play()
TweenService:Create(thumbShadow, quickTween, {Position = shadowPos}):Play()
TweenService:Create(glow, slowTween, {BackgroundColor3 = accent, BackgroundTransparency = glowTransparency}):Play()
TweenService:Create(stroke, quickTween, {Color = strokeColor, Transparency = strokeTransparency}):Play()

if isCheckedValue then
thumb.Size = UDim2.fromOffset(8, 8)
task.delay(0.05, function()
TweenService:Create(thumb, bounceTween, {Size = UDim2.fromOffset(10, 10)}):Play()
end)
end
end)

if not childs then
return checkboxFrame
end

return create'Frame'{
BackgroundTransparency = 1,
Size = UDim2.fromScale(1, 0),
AutomaticSize = Enum.AutomaticSize.Y,
create'UIListLayout'{
HorizontalAlignment = Enum.HorizontalAlignment.Left,
VerticalAlignment = Enum.VerticalAlignment.Top,
FillDirection = Enum.FillDirection.Vertical,
},
checkboxFrame,
vide.indexes(childs, function(child, i)
return create'Frame'{
Size = UDim2.fromScale(1, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
create'UIListLayout'{
Padding = UDim.new(0, 4),
HorizontalAlignment = Enum.HorizontalAlignment.Left,
VerticalAlignment = Enum.VerticalAlignment.Center,
FillDirection = Enum.FillDirection.Horizontal,
HorizontalFlex = Enum.UIFlexAlignment.Fill,
},
TreeChildTrail({
isFinalizer = i == #childs(),
}),
child(),
}
end),
}
end

return Checkbox
end
function __DARKLUA_BUNDLE_MODULES.Q()
local Segment = {}

function Segment.GenerateCirclePoints(
centerPosition,
radius,
resolution
)
local circumference = 2 * math.pi * radius
local numPoints = math.max(3, math.floor(circumference / resolution))
local angleStep = (2 * math.pi) / numPoints
local points = {}

for i = 0, numPoints - 1 do
local angle = i * angleStep
local x = centerPosition.X + radius * math.cos(angle)
local z = centerPosition.Z + radius * math.sin(angle)
local point = Vector3.new(x, centerPosition.Y, z)

table.insert(points, point)
end

return points, numPoints
end

return Segment
end
function __DARKLUA_BUNDLE_MODULES.R()
local Animal = __DARKLUA_BUNDLE_MODULES.load('I')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local AskServerToSetSubStateRemoteFunction = ReplicatedStorage:WaitForChild('AskServerToSetSubStateRemoteFunction')
local namecall
local blockChangeSubState = false

namecall = hookmetamethod(game, '__namecall', function(self, ...)
if blockChangeSubState then
local isTryingToChangeSubState = self == AskServerToSetSubStateRemoteFunction

if isTryingToChangeSubState and not checkcaller() then
if not checkcaller() then
return true
end
end
end

return namecall(self, ...)
end)

local function SetClientSubStateChangesEnabled(enabled)
blockChangeSubState = not enabled
end
local function ChangeCharacterSubState(state)
task.spawn(AskServerToSetSubStateRemoteFunction.InvokeServer, AskServerToSetSubStateRemoteFunction, state)
end

-- One-time recovery for stale Eating/Drinking/substate locks left by a prior
-- script execution. No automatic grass eating is enabled here.
task.defer(function()
task.wait(0.35)

pcall(function()
SetClientSubStateChangesEnabled(true)
end)

local ch = player.Character
if ch then
pcall(function()
ch:SetAttribute("_drinkingToFull", false)
ch:SetAttribute("_carcassFeedCycle", false)
ch:SetAttribute("_returningToLand", false)
ch:SetAttribute("_carcassInteractionLock", false)
end)

local movementState = tostring(ch:GetAttribute("MovementState") or "")
local replicatedState = tonumber(ch:GetAttribute("ReplicatedMovementState"))

if movementState ~= "Swimming" and replicatedState ~= 7 then
pcall(function()
ChangeCharacterSubState("Idling")
end)
end
end

goatPrint("[InteractionFix] Manual E/substate controls released")
end)

local function SetGoatHudStatus(actionText, detailText, accentColor)
local setter = shared._goatHudSetStatus
if type(setter) == "function" then
pcall(setter, actionText, detailText, accentColor)
end
end

local Utils = require(ReplicatedStorage:WaitForChild('AnimalGameFrameworkShared'):WaitForChild('Utils'))
local AnimalConfig = require(ReplicatedStorage.Shared.AnimalConfig)

local function CanStartEatDrink(p94, p95)
if p94 then
if p94:GetAttribute('IsCarrying') then
return
elseif p95 or not p94:GetAttribute('MovementDisabled') then
if p94:FindFirstChild('Head') then
local v96 = p94:GetAttribute('AnimalType')
local v97 = p94:GetAttribute('AnimalName')

if v96 and (v97 and p94:GetAttribute('AnimalAge')) then
local v98 = AnimalConfig[v96][v97]
local v99 = Utils.CanEatDrink.DetectMeatGrassWater(p94, v98)
local v100 = v99 == 'Drink' and 'Drinking' or 'Eating'

if v98.EnableLeavesEating and type(Utils.DetectLeaves) == "function" then
local okLeaves, leavesResult = pcall(Utils.DetectLeaves, p94)
if okLeaves and leavesResult then
return leavesResult
end
end

if v98.EnableInsectEating and type(Utils.DetectInsects) == "function" then
local okInsects, insectsResult = pcall(Utils.DetectInsects, p94)
if okInsects and insectsResult then
return insectsResult
end
end

return v99
else
goatWarn("Not spawned as animal, so we can't check eat/drink")
end
else
return
end
else
return
end
else
return
end
end

local grassResolution = 4
local grassHeightOffset = Vector3.new(0, 40, 0)
local grassRayDirection = Vector3.new(0, -80, 0)
local SegmentCircle = __DARKLUA_BUNDLE_MODULES.load('Q')
local Grass = Enum.Material.Grass
local grassRayParams = RaycastParams.new()

grassRayParams.FilterType = Enum.RaycastFilterType.Include
grassRayParams.FilterDescendantsInstances = {
workspace.Terrain,
}

local grassStartingRadius = 6
local grassMaxRadius = 384  -- same as water — prevents starvation when grass is far

local lastGrassSearchFailAt = 0
local GRASS_RETRY_DELAY = 2     -- seconds to wait before searching again after a full sweep found nothing
local GRASS_FORCE_PAUSE = 15    -- seconds to disable auto eat after 2 consecutive failed sweeps

-- AutoEat protection for tiny/awkward grass patches directly under the body.
-- If Savannah still does not allow Eating, temporarily reject only that local
-- patch and search another grass point instead of repeatedly walking in place.
local AUTOEAT_NEAR_GRASS_DEADZONE = 4.0
local AUTOEAT_REJECT_GRASS_RADIUS = 18.0
local AUTOEAT_REJECT_GRASS_TIME = 12.0
local AUTOEAT_POST_MOVE_EAT_CHECK = 0.9
local AUTOEAT_POST_MOVE_TARGET_TOLERANCE = 7.0
local AUTOEAT_MAX_REJECTED_PATCHES = 4

local autoEatRejectedGrassCharacter = nil
local autoEatRejectedGrassPatches = {}

local function grassFlatDistance(a, b)
return Vector3.new(a.X - b.X, 0, a.Z - b.Z).Magnitude
end

local function pruneAutoEatRejectedGrassPatches(now)
now = now or os.clock()
for i = #autoEatRejectedGrassPatches, 1, -1 do
local patch = autoEatRejectedGrassPatches[i]
if type(patch) ~= "table"
or typeof(patch.point) ~= "Vector3"
or (tonumber(patch.untilTime) or 0) <= now
then
table.remove(autoEatRejectedGrassPatches, i)
end
end
end

local function addAutoEatRejectedGrassPatch(point, reason)
if typeof(point) ~= "Vector3" then return end
local now = os.clock()
pruneAutoEatRejectedGrassPatches(now)
for _, patch in ipairs(autoEatRejectedGrassPatches) do
if grassFlatDistance(point, patch.point) <= AUTOEAT_REJECT_GRASS_RADIUS * 0.65 then
patch.point = point
patch.untilTime = now + AUTOEAT_REJECT_GRASS_TIME
patch.reason = reason
return
end
end
table.insert(autoEatRejectedGrassPatches, {
point = point,
untilTime = now + AUTOEAT_REJECT_GRASS_TIME,
reason = reason,
})
while #autoEatRejectedGrassPatches > AUTOEAT_MAX_REJECTED_PATCHES do
table.remove(autoEatRejectedGrassPatches, 1)
end
end

local function grassPointIsRejected(point)
if typeof(point) ~= "Vector3" then return false end
pruneAutoEatRejectedGrassPatches()
for _, patch in ipairs(autoEatRejectedGrassPatches) do
if grassFlatDistance(point, patch.point) <= AUTOEAT_REJECT_GRASS_RADIUS then
return true
end
end
return false
end

local function FindNearestGrass(at, radius)
if tick() - lastGrassSearchFailAt < GRASS_RETRY_DELAY then
return nil
end

local points = SegmentCircle.GenerateCirclePoints(at + grassHeightOffset, radius, grassResolution)

for i, v in points do
local result = workspace:Raycast(v, grassRayDirection, grassRayParams)

if result and result.Material == Grass then
lastGrassSearchFailAt = 0
return result.Position
end
end

if radius ~= grassMaxRadius then
local retry = FindNearestGrass(at, radius * 2)
if retry then
return retry
end
end

if tick() - lastGrassSearchFailAt < GRASS_FORCE_PAUSE then
lastGrassSearchFailAt = tick()
if shared._autoEatChecked then
goatPrint("[AutoEat] No grass found nearby twice — pausing auto eat for " .. GRASS_FORCE_PAUSE .. "s (anti-spin)")
shared._autoEatChecked(false)
task.delay(GRASS_FORCE_PAUSE, function()
if not shared._inGrowthReset and shared._autoEatChecked then
shared._autoEatChecked(true)
end
end)
end
else
lastGrassSearchFailAt = tick()
end

return nil
end

-- Alternate search used only after a too-close grass point was rejected.
-- It intentionally does NOT touch the normal no-grass anti-spin timers.
local function FindNearestGrassExcluding(at, excludedPoint, excludedRadius)
local radius = grassStartingRadius
pruneAutoEatRejectedGrassPatches()
while radius <= grassMaxRadius do
local points = SegmentCircle.GenerateCirclePoints(
at + grassHeightOffset,
radius,
grassResolution
)
for _, v in points do
local result = workspace:Raycast(v, grassRayDirection, grassRayParams)
if result and result.Material == Grass then
local rejectedByLegacyPoint =
excludedPoint
and grassFlatDistance(result.Position, excludedPoint)
<= (excludedRadius or AUTOEAT_REJECT_GRASS_RADIUS)
if not rejectedByLegacyPoint and not grassPointIsRejected(result.Position) then
return result.Position
end
end
end
if radius >= grassMaxRadius then break end
radius = math.min(radius * 2, grassMaxRadius)
end
return nil
end

local waterResolution = 12
local waterHeightOffset = Vector3.new(0, 80, 0)
local waterRayDirection = Vector3.new(0, -160, 0)
local Water = Enum.Material.Water
local waterRayParams = RaycastParams.new()

waterRayParams.FilterType = Enum.RaycastFilterType.Include
waterRayParams.FilterDescendantsInstances = {
workspace.Terrain,
}

local waterStartingRadius = 12
local waterMaxRadius = 384

local function FindNearestWaterShore(at, radius)
local points = SegmentCircle.GenerateCirclePoints(at + waterHeightOffset, radius, waterResolution)
local bestPosition = nil
local bestDistance = math.huge

for i, v in points do
local result = workspace:Raycast(v, waterRayDirection, waterRayParams)

if result and result.Material == Water then
local flatDirection = Vector3.new(result.Position.X - at.X, 0, result.Position.Z - at.Z)
local flatDistance = flatDirection.Magnitude
local shorePosition = result.Position

if flatDistance > 0 then
shorePosition = result.Position - flatDirection.Unit * math.min(2, flatDistance)
end

if flatDistance < bestDistance then
bestDistance = flatDistance
bestPosition = shorePosition
end
end
end

if bestPosition then
return bestPosition
end

if radius >= waterMaxRadius then
return
end

return FindNearestWaterShore(at, math.min(radius * 2, waterMaxRadius))
end

local player = game:GetService('Players').LocalPlayer
local Checkbox = __DARKLUA_BUNDLE_MODULES.load('M')
local LerpTween = __DARKLUA_BUNDLE_MODULES.load('H')
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local source = vide.source
local goToNearestSource = source(true)

local autoEatChecked = source(false)
local autoCarcassChecked = source(false)
local autoDrinkChecked = source(false)

local carcassUserAllowed = true

-- Explicitly activating Grow authorizes food automation for its slots.
-- A later manual Carcass OFF is still respected until Grow is activated again.
shared._authorizeCarcassForGrowth = function(reason)
carcassUserAllowed = true
goatPrint("[GrowthLoop] Carcass autorizado ao ativar " .. tostring(reason or "Grow"))
return true
end

shared._autoEatChecked = autoEatChecked
shared._getAutoEatInternal = function()
return autoEatChecked()
end
shared._setAutoEatInternal = function(state)
state = state == true
autoEatChecked(state)
return autoEatChecked()
end

shared._getAutoCarcassInternal = function()
return autoCarcassChecked()
end
shared._setAutoCarcassInternal = function(state)
state = state == true
if state and not carcassUserAllowed then
return false
end
autoCarcassChecked(state)
return autoCarcassChecked()
end
shared._getAutoDrinkInternal = function()
return autoDrinkChecked()
end
shared._setAutoDrinkInternal = function(state)
state = state == true
if state then
shared._autoDrinkOwnerGeneration = AUTO_DRINK_OWNER_GENERATION
end
autoDrinkChecked(state)
return autoDrinkChecked()
end

shared._autoCarcassChecked = function(...)
return false
end
shared._autoDrinkChecked = function(...)
return false
end

local CARNIVORES = {
-- Savannah / Jungle
Lion = true,
Tiger = true,
Cheetah = true,
Crocodile = true,
Croc = true,
Leopard = true,
WildDog = true,
["Wild Dog"] = true,
AfricanWildDog = true,
["African Wild Dog"] = true,

-- DinoLife carnivores
Deinosuchus = true,
Mosasaurus = true,
WaterSpinosaurus = true,
Pteranodon = true,
Carnotaurus = true,
LandSpinosaurus = true,
TRex = true,
Velociraptor = true,

-- Legacy T-Rex aliases
["Tyrannosaurus Rex"] = true,
Tyrannosaurus = true,
["T-Rex"] = true,
Rex = true,
}
shared._isCarnivoreName = function(animalName)
return CARNIVORES[animalName] == true
end

-- DinoLife species that must remain in water for survival.
-- Keep this intentionally narrow: Mosasaurus is confirmed by live testing.
shared._goatIsDLFullyAquaticName = function(animalName)
return game.GameId == 8198412649
and tostring(animalName or "") == "Mosasaurus"
end

shared._tryEatNearbyGrass = function()
local character = player.Character
if not character then return false end
local animalName = character:GetAttribute("AnimalName") or ""
if CARNIVORES[animalName] then return false end
local ingestionAvaliable = CanStartEatDrink(character)
if ingestionAvaliable == 'Eat' then
ChangeCharacterSubState('Eating')
return true
end
return false
end

local CARCASS_START_FOOD = 90
local CARCASS_STOP_FOOD = 98
local CARCASS_PATROL_MIN_DISTANCE = 45
local CARCASS_PATROL_MAX_DISTANCE = 105
local CARCASS_SCAN_INTERVAL = 0.30
local CARCASS_EAT_INTERVAL = 0.65
local CARCASS_MAX_NO_PROGRESS = 6
local CARCASS_EAT_LOST_GRACE = 1.0
local CARCASS_GROUND_RAY_UP = 110
local CARCASS_GROUND_RAY_DOWN = 240
local CARCASS_GOAL_ATTEMPTS = 14

local CARCASS_RADAR_RADIUS = 1500
local CARCASS_RADAR_INTERVAL = 0.75
local CARCASS_RADAR_MAX_PARTS = 1200

local CARCASS_FINAL_APPROACH_DISTANCE = 16
local CARCASS_STAGE_DISTANCE = 11
local CARCASS_FINAL_APPROACH_SPEED = 9
local CARCASS_FINAL_SCAN_INTERVAL = 0.05
local CARCASS_FINAL_TIMEOUT = 7
local CARCASS_FINAL_STOP_DISTANCE = 1.6 -- stop just short of the carcass body; avoids collision/rubber-band
local CARCASS_FINAL_CREEP_DISTANCE = 0.55 -- last gentle step only if the game's Eat detector has not fired yet

local WATER_CARNIVORES = {
Crocodile = true,
Croc = true, -- Savannah currently reports AnimalName as "Croc"

-- DinoLife aquatic carnivores
Deinosuchus = true,
Mosasaurus = true,
WaterSpinosaurus = true,
}
local CARCASS_DEEP_WATER_THRESHOLD = 0.15 -- any real water coverage blocks terrestrial animals
local carcassWaterRayParams = RaycastParams.new()
carcassWaterRayParams.FilterType = Enum.RaycastFilterType.Include
carcassWaterRayParams.FilterDescendantsInstances = { workspace.Terrain }
local lastSkippedWaterCarcass = nil

-- Savannah Life also uses a physical MainWaterPart. The old filter only
-- raycasted Terrain water, so a terrestrial carnivore (Lion/Tiger/etc.)
-- could still select carcasses submerged inside MainWaterPart.
local cachedMainWaterPart = nil

local function getMainWaterPartForCarcassFilter()
if cachedMainWaterPart
and cachedMainWaterPart.Parent
and cachedMainWaterPart:IsA("BasePart")
then
return cachedMainWaterPart
end

cachedMainWaterPart = nil
local direct = workspace:FindFirstChild("MainWaterPart")
if direct and direct:IsA("BasePart") then
cachedMainWaterPart = direct
return direct
end

local nested = workspace:FindFirstChild("MainWaterPart", true)
if nested and nested:IsA("BasePart") then
cachedMainWaterPart = nested
return nested
end

return nil
end

local function getMainWaterSurfaceYAt(x, z)
local waterPart = getMainWaterPartForCarcassFilter()
if not waterPart then
return nil
end

-- Test X/Z against the water part in its own local space, so this
-- remains valid even if the part is translated/rotated.
local localProbe = waterPart.CFrame:PointToObjectSpace(
Vector3.new(x, waterPart.Position.Y, z)
)
local halfX = (waterPart.Size.X * 0.5) + 0.5
local halfZ = (waterPart.Size.Z * 0.5) + 0.5

if math.abs(localProbe.X) > halfX or math.abs(localProbe.Z) > halfZ then
return nil
end

local topPoint = waterPart.CFrame:PointToWorldSpace(
Vector3.new(0, waterPart.Size.Y * 0.5, 0)
)
return topPoint.Y
end

local carcassPatrolRunning = false
local carcassPatrolToken = 0
local carcassOwnsMovement = false

local carcassGroundRayParams = RaycastParams.new()
carcassGroundRayParams.FilterType = Enum.RaycastFilterType.Include
carcassGroundRayParams.FilterDescendantsInstances = { workspace.Terrain }

local function getDrinkTrigger()
-- Keep Auto Carcass synchronized with the current AutoDrink rule.
-- Water has absolute priority only at <= 80%, so carcass must remain
-- allowed to hunt/eat while Water is still 81-100%.
return 80
end

-- Single Carcass water arbitration rule used by patrol, travel, final approach
-- and eating. During Food Emergency normal 80% water must NOT interrupt.
-- Once critical water (<=18) starts AutoDrink, _drinkingToFull keeps Carcass
-- paused until the drink-to-full cycle is completely finished.
shared._goatCarcassMustYieldToWater = function(character, water)
water = tonumber(water) or 100

-- WaterEscape / fixed land recovery owns movement exclusively.
-- Carcass must not approach/eat while these recovery systems are active.
if shared._fixedWaterLandRecoveryActive == true
or shared._SL_WATER_ESCAPE_TOKEN ~= nil
then
return true
end

if character and character:GetAttribute("_drinkingToFull") then
return true
end
if shared._autoQuestCarnivoreFoodEmergency == true then
return water <= 18
end
return water <= getDrinkTrigger()
end

local function getWaterSurfaceYAt(x, z, aroundY)
local bestSurfaceY = nil

-- Terrain water.
local origin = Vector3.new(x, (aroundY or 0) + 120, z)
local result = workspace:Raycast(
origin,
Vector3.new(0, -280, 0),
carcassWaterRayParams
)
if result and result.Material == Enum.Material.Water then
bestSurfaceY = result.Position.Y
end

-- Physical water plane used by Savannah Life.
local partSurfaceY = getMainWaterSurfaceYAt(x, z)
if partSurfaceY then
if bestSurfaceY == nil or partSurfaceY > bestSurfaceY then
bestSurfaceY = partSurfaceY
end
end

return bestSurfaceY
end

local function getCarcassWaterDepth(candidate, fallbackPosition)
if not fallbackPosition and not candidate then return 0 end

local center = fallbackPosition
local size = Vector3.new(2, 2, 2)

if candidate then
if candidate:IsA("Model") then
local ok, cf, boxSize = pcall(function()
local c, s = candidate:GetBoundingBox()
return c, s
end)
if ok and cf and boxSize then
center = cf.Position
size = boxSize
end
elseif candidate:IsA("BasePart") then
center = candidate.Position
size = candidate.Size
end
end

if not center then return 0 end

local bottomY = center.Y - (size.Y * 0.5)
local rx = math.max(0.4, size.X * 0.32)
local rz = math.max(0.4, size.Z * 0.32)

local samples = {
Vector3.new(center.X, bottomY, center.Z),
Vector3.new(center.X + rx, bottomY, center.Z),
Vector3.new(center.X - rx, bottomY, center.Z),
Vector3.new(center.X, bottomY, center.Z + rz),
Vector3.new(center.X, bottomY, center.Z - rz),
}

local maxDepth = 0
for _, p in ipairs(samples) do
local waterY = getWaterSurfaceYAt(p.X, p.Z, center.Y)
if waterY then
maxDepth = math.max(maxDepth, waterY - p.Y)
end
end

return math.max(0, maxDepth)
end

local function shouldSkipCarcassForWater(character, candidate, position)
local animalName = character and (character:GetAttribute("AnimalName") or "") or ""
local depth = getCarcassWaterDepth(candidate, position)

-- Mosasaurus is fully aquatic in DL: never choose a dry-land carcass.
if type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(animalName)
then
if depth < CARCASS_DEEP_WATER_THRESHOLD then
if candidate ~= lastSkippedWaterCarcass then
lastSkippedWaterCarcass = candidate
goatPrint(string.format(
"[CarcassRadar][DL] Mosasaurus skipped dry carcass | %s | depth=%.1f",
candidate and candidate:GetFullName() or "?",
depth
))
end
return true, depth
end
return false, depth
end

if WATER_CARNIVORES[animalName] then
return false, depth
end

if depth >= CARCASS_DEEP_WATER_THRESHOLD then
if candidate ~= lastSkippedWaterCarcass then
lastSkippedWaterCarcass = candidate
goatPrint(string.format(
"[CarcassRadar] BLOCKED underwater carcass: %s | depth=%.1f studs | animal=%s | only Croc allowed",
candidate and candidate:GetFullName() or "?",
depth,
animalName ~= "" and animalName or "?"
))
end
return true, depth
end

return false, depth
end

local function ensureMeatFoodType()
pcall(function()
local framework = ReplicatedStorage:FindFirstChild("AnimalGameFrameworkShared")
local utilsFolder = framework and framework:FindFirstChild("Utils")
local canEatDrinkFolder = utilsFolder and utilsFolder:FindFirstChild("CanEatDrink")
local remote = canEatDrinkFolder and canEatDrinkFolder:FindFirstChild("SetFoodTypeRemoteEvent")
if remote then
remote:FireServer("Meat")
end
end)
end

local function stopCarcassMovement(character)
if not carcassOwnsMovement then return end
carcassOwnsMovement = false

shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
Animal.CancelTween(true)

local humanoid = character and character:FindFirstChild("Humanoid")
local root = character and character:FindFirstChild("HumanoidRootPart")
if humanoid and root then
pcall(function()
humanoid:MoveTo(root.Position)
end)
end
end

local function findCarcassPatrolGoal(character)
local root = character and character:FindFirstChild("HumanoidRootPart")
local humanoid = character and character:FindFirstChild("Humanoid")
if not root or not humanoid then return nil end

for _ = 1, CARCASS_GOAL_ATTEMPTS do
local angle = math.random() * math.pi * 2
local distance = math.random(CARCASS_PATROL_MIN_DISTANCE, CARCASS_PATROL_MAX_DISTANCE)
local offset = Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
local probe = root.Position + offset

local rayOrigin = probe + Vector3.new(0, CARCASS_GROUND_RAY_UP, 0)
local rayDirection = Vector3.new(0, -CARCASS_GROUND_RAY_DOWN, 0)
local result = workspace:Raycast(rayOrigin, rayDirection, carcassGroundRayParams)

if result
and result.Material ~= Enum.Material.Water
and result.Normal.Y >= 0.50
then
local lift = math.max(humanoid.HipHeight, 2)
local goal = result.Position + Vector3.new(0, lift, 0)
local flatDistance = ((goal - root.Position) * Vector3.new(1, 0, 1)).Magnitude
if flatDistance >= 25 then
return goal
end
end
end

return nil
end

local lastCarcassRadarAt = 0
local cachedCarcassTarget = nil
local lastRadarLogInstance = nil

-- Short-lived rejection cache:
-- when one carcass proves unusable, skip it briefly so the radar can
-- immediately choose the next nearest valid carcass.
shared._goatCarcassRejectedTargets =
shared._goatCarcassRejectedTargets
or setmetatable({}, { __mode = "k" })

local function textHasCarcassHint(value)
local s = string.lower(tostring(value or ""))
return string.find(s, "carcass", 1, true) ~= nil
or string.find(s, "corpse", 1, true) ~= nil
or string.find(s, "meat", 1, true) ~= nil
or string.find(s, "remains", 1, true) ~= nil
or string.find(s, "deadbody", 1, true) ~= nil
or string.find(s, "dead_body", 1, true) ~= nil
end

local function getCarcassHintScore(instance, character)
if not instance or instance == workspace or instance == character then
return 0
end
if character and instance:IsDescendantOf(character) then
return 0
end

local score = 0
local lowerName = string.lower(instance.Name or "")
if string.find(lowerName, "carcass", 1, true) then score = score + 12 end
if string.find(lowerName, "corpse", 1, true) then score = score + 11 end
if string.find(lowerName, "meat", 1, true) then score = score + 9 end
if string.find(lowerName, "remains", 1, true) then score = score + 8 end
if string.find(lowerName, "deadbody", 1, true) or string.find(lowerName, "dead_body", 1, true) then
score = score + 9
end

for _, attrName in ipairs({
"IsCarcass", "Carcass", "IsCorpse", "Corpse",
"IsDead", "Dead", "Edible", "CanEat"
}) do
local value = instance:GetAttribute(attrName)
if value == true then
score = score + 10
elseif textHasCarcassHint(value) then
score = score + 8
end
end

for _, attrName in ipairs({"FoodType", "Food", "Type", "ItemType", "ResourceType"}) do
local value = instance:GetAttribute(attrName)
if textHasCarcassHint(value) then
score = score + 10
end
end

if instance:IsA("Model") then
local hum = instance:FindFirstChildOfClass("Humanoid")
if hum and hum.Health <= 0 then
score = score + 7
end
end

return score
end

local function getCarcassStorageRoot()
return workspace:FindFirstChild("CarcassesStorageModel")
end

local storageCacheRoot = nil
local storageCachedParts = {}
local storagePartSet = {}
local storageCacheConnections = {}
local lastStorageCompactAt = 0

local function disconnectStorageCache()
for _, connection in ipairs(storageCacheConnections) do
pcall(function() connection:Disconnect() end)
end
table.clear(storageCacheConnections)
end

local function rebuildStorageCache(storage)
disconnectStorageCache()
storageCacheRoot = storage
table.clear(storageCachedParts)
table.clear(storagePartSet)

if not storage then return end

for _, descendant in ipairs(storage:GetDescendants()) do
if descendant:IsA("BasePart") then
storagePartSet[descendant] = true
table.insert(storageCachedParts, descendant)
end
end

table.insert(storageCacheConnections, storage.DescendantAdded:Connect(function(descendant)
if SCRIPT_INSTANCE ~= shared._THEGOAT_SCRIPT_INSTANCE then return end
if descendant:IsA("BasePart") and not storagePartSet[descendant] then
storagePartSet[descendant] = true
table.insert(storageCachedParts, descendant)
end
end))

table.insert(storageCacheConnections, storage.DescendantRemoving:Connect(function(descendant)
if descendant:IsA("BasePart") then
storagePartSet[descendant] = nil
end
end))
end

local function getCachedStorageParts()
local storage = getCarcassStorageRoot()
if storage ~= storageCacheRoot then
rebuildStorageCache(storage)
end
if not storage then return nil, storageCachedParts end

local now = os.clock()
if now - lastStorageCompactAt >= 10 then
lastStorageCompactAt = now
local compact = {}
for _, part in ipairs(storageCachedParts) do
if storagePartSet[part] and part.Parent and part:IsDescendantOf(storage) then
table.insert(compact, part)
end
end
storageCachedParts = compact
end

return storage, storageCachedParts
end

local function getStorageCarcassCandidate(part, storage)
if not storage or not part or not part:IsDescendantOf(storage) then
return nil
end

local node = part.Parent
while node and node ~= storage do
if node:IsA("Model") then
return node
end
node = node.Parent
end

return part
end

local function resolveCarcassCandidate(part, character)
if not part or not part:IsA("BasePart") then return nil, 0, false end
if character and part:IsDescendantOf(character) then return nil, 0, false end

local storage = getCarcassStorageRoot()
if storage and part:IsDescendantOf(storage) then
local carcass = getStorageCarcassCandidate(part, storage)
if carcass then
return carcass, 100, true
end
end

local bestInstance = part
local bestScore = getCarcassHintScore(part, character)
local node = part.Parent
local depth = 0

while node and node ~= workspace and depth < 5 do
local lowerName = string.lower(node.Name or "")
local isContainer = lowerName == "carcassesstoragemodel"
or string.find(lowerName, "carcassstorage", 1, true) ~= nil
or string.find(lowerName, "carcassesstorage", 1, true) ~= nil

if not isContainer then
local score = getCarcassHintScore(node, character)
if score > bestScore then
bestScore = score
bestInstance = node
end
end

node = node.Parent
depth = depth + 1
end

return bestInstance, bestScore, false
end

local function getCandidatePosition(instance, fallbackPart, preferFallbackPart)
if preferFallbackPart and fallbackPart and fallbackPart:IsA("BasePart") then
return fallbackPart.Position
end

if instance then
if instance:IsA("BasePart") then
return instance.Position
elseif instance:IsA("Model") then
local ok, pivot = pcall(instance.GetPivot, instance)
if ok and pivot then return pivot.Position end
local pp = instance.PrimaryPart or instance:FindFirstChildWhichIsA("BasePart", true)
if pp then return pp.Position end
elseif instance:IsA("Attachment") then
return instance.WorldPosition
end
end
return fallbackPart and fallbackPart.Position or nil
end

local function findDirectStorageCarcassTarget(character)
local root = character and character:FindFirstChild("HumanoidRootPart")
local storage, cachedParts = getCachedStorageParts()
if not root or not storage then return nil end

local nearestPartByCarcass = {}

for _, descendant in ipairs(cachedParts) do
if storagePartSet[descendant]
and descendant.Parent
and descendant:IsDescendantOf(storage)
and not (character and descendant:IsDescendantOf(character))
then
local pos = descendant.Position
local flat = Vector3.new(pos.X - root.Position.X, 0, pos.Z - root.Position.Z)
local dist = flat.Magnitude

if dist <= (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS) then
local candidate = getStorageCarcassCandidate(descendant, storage) or descendant

local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(character and character:GetAttribute("AnimalName"))

local usablePart = true
local partDepth = nil

if fullyAquaticDL then
partDepth = getCarcassWaterDepth(candidate, pos)
usablePart = partDepth >= CARCASS_DEEP_WATER_THRESHOLD
end

if usablePart then
local previous = nearestPartByCarcass[candidate]
if not previous or dist < previous.distance then
nearestPartByCarcass[candidate] = {
instance = candidate,
physicalPart = descendant,
position = pos,
distance = dist,
score = 100,
storageConfirmed = true,
aquaticDepth = partDepth,
}
end
end
end
end
end

local best = nil
local bestDistance = math.huge
for candidate, info in pairs(nearestPartByCarcass) do
local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(character and character:GetAttribute("AnimalName"))

-- For Mosasaurus, keep the exact submerged body-part position. The model
-- bounding-box center may sit above/dry and makes pursuit aim at the bank.
if candidate and candidate:IsA("Model") and not fullyAquaticDL then
local okBox, boxCFrame = pcall(function()
local cf = candidate:GetBoundingBox()
return cf
end)
if okBox and boxCFrame then
info.position = boxCFrame.Position
end
end

local skipForWater = shouldSkipCarcassForWater(character, candidate, info.position)
local rejectUntil =
tonumber(shared._goatCarcassRejectedTargets[candidate])
or 0

if not skipForWater
and rejectUntil <= os.clock()
and info.distance < bestDistance
then
best = info
bestDistance = info.distance
end
end

return best
end

local function findWideCarcassTarget(character, forceScan)
local root = character and character:FindFirstChild("HumanoidRootPart")
if not root then return nil end

if shared._goatCarcassForceFreshScan == true then
forceScan = true
shared._goatCarcassForceFreshScan = false
end

local now = os.clock()

-- Keep following the current carcass while it is still a valid target.
-- This avoids wasting scans and prevents target hopping.
if not forceScan
and cachedCarcassTarget
and cachedCarcassTarget.instance
and cachedCarcassTarget.instance.Parent
and cachedCarcassTarget.position
then
local rejectUntil =
tonumber(shared._goatCarcassRejectedTargets[cachedCarcassTarget.instance])
or 0

local cachedDistance = Vector3.new(
cachedCarcassTarget.position.X - root.Position.X,
0,
cachedCarcassTarget.position.Z - root.Position.Z
).Magnitude

local cachedWaterBlocked = false
if rejectUntil <= now and cachedDistance <= (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS) + 2 then
cachedWaterBlocked = shouldSkipCarcassForWater(
character,
cachedCarcassTarget.instance,
cachedCarcassTarget.position
)
end

if rejectUntil <= now
and cachedDistance <= (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS) + 2
and not cachedWaterBlocked
then
cachedCarcassTarget.distance = cachedDistance
return cachedCarcassTarget
end

cachedCarcassTarget = nil
end

local activeRadarInterval =
shared._autoQuestCarnivoreFoodEmergency == true
and 0.20
or CARCASS_RADAR_INTERVAL

if not forceScan and now - lastCarcassRadarAt < activeRadarInterval then
return cachedCarcassTarget
end
lastCarcassRadarAt = now
cachedCarcassTarget = nil

local directStorageTarget = findDirectStorageCarcassTarget(character)
if directStorageTarget then
cachedCarcassTarget = directStorageTarget
if directStorageTarget.instance ~= lastRadarLogInstance then
lastRadarLogInstance = directStorageTarget.instance
goatPrint(string.format(
"[CarcassRadar] STORAGE DIRECT: %s | %.1f studs | physical=%s | radius=%d",
directStorageTarget.instance:GetFullName(),
directStorageTarget.distance,
directStorageTarget.physicalPart and directStorageTarget.physicalPart.Name or "?",
(shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS)
))
SetGoatHudStatus(
"Carcass encontrada",
string.format("%.0f studs de distância", directStorageTarget.distance),
Color3.fromRGB(255, 90, 105)
)
end
return directStorageTarget
end

if getCarcassStorageRoot() then
cachedCarcassTarget = nil
lastRadarLogInstance = nil
return nil
end

local overlap = OverlapParams.new()
overlap.FilterType = Enum.RaycastFilterType.Exclude
overlap.FilterDescendantsInstances = {character}
overlap.MaxParts = CARCASS_RADAR_MAX_PARTS

local ok, parts = pcall(function()
return workspace:GetPartBoundsInRadius(root.Position, (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS), overlap)
end)
if not ok or not parts then
lastRadarLogInstance = nil
return nil
end

local best = nil
local bestScore = 0
local bestDistance = math.huge

for _, part in ipairs(parts) do
local candidate, score, preferPartPosition = resolveCarcassCandidate(part, character)
if candidate
and score >= 7
and (tonumber(shared._goatCarcassRejectedTargets[candidate]) or 0) <= now
then
local storage = getCarcassStorageRoot()
if candidate ~= storage then
local pos = getCandidatePosition(candidate, part, preferPartPosition)
if pos then
local flat = Vector3.new(pos.X - root.Position.X, 0, pos.Z - root.Position.Z)
local dist = flat.Magnitude
if dist <= (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS) + 2 then
local skipForWater = shouldSkipCarcassForWater(character, candidate, pos)
if not skipForWater then
local closer = dist < (bestDistance - 0.25)
local sameDistanceBetterScore = math.abs(dist - bestDistance) <= 0.25 and score > bestScore
if closer or sameDistanceBetterScore then
best = {
instance = candidate,
physicalPart = part,
position = pos,
distance = dist,
score = score,
storageConfirmed = score >= 100,
}
bestScore = score
bestDistance = dist
end
end
end
end
end
end
end

cachedCarcassTarget = best
if best and best.instance ~= lastRadarLogInstance then
lastRadarLogInstance = best.instance
goatPrint(string.format(
"[CarcassRadar] FALLBACK: %s | %.1f studs | score=%d | radius=%d",
best.instance:GetFullName(), best.distance, best.score, (shared._autoQuestCarnivoreFoodEmergency == true and 2000 or CARCASS_RADAR_RADIUS)
))
SetGoatHudStatus(
"Carcass encontrada",
string.format("%.0f studs de distância", best.distance),
Color3.fromRGB(255, 90, 105)
)
elseif not best then
lastRadarLogInstance = nil
end

return best
end

local function projectCarcassGroundGoal(character, probePosition)
local humanoid = character and character:FindFirstChild("Humanoid")
if not humanoid or not probePosition then return nil end

if type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(character:GetAttribute("AnimalName"))
then
return Vector3.new(probePosition.X, probePosition.Y, probePosition.Z)
end

local rayOrigin = probePosition + Vector3.new(0, CARCASS_GROUND_RAY_UP, 0)
local result = workspace:Raycast(
rayOrigin,
Vector3.new(0, -CARCASS_GROUND_RAY_DOWN, 0),
carcassGroundRayParams
)
if result and result.Material ~= Enum.Material.Water then
return result.Position + Vector3.new(0, math.max(humanoid.HipHeight, 2), 0)
end

return Vector3.new(probePosition.X, probePosition.Y, probePosition.Z)
end

local function getCarcassTravelGoal(character, carcassPosition)
local root = character and character:FindFirstChild("HumanoidRootPart")
if not root or not carcassPosition then return nil end

local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(character:GetAttribute("AnimalName"))

local flatDir = Vector3.new(
carcassPosition.X - root.Position.X,
0,
carcassPosition.Z - root.Position.Z
)

if fullyAquaticDL then
if flatDir.Magnitude < 0.05 then
return Vector3.new(carcassPosition.X, carcassPosition.Y, carcassPosition.Z)
end

-- Keep Mosasaurus submerged while staging toward food. Aim directly through
-- water, not at terrain under/behind the carcass.
local stageXZ = carcassPosition
if flatDir.Magnitude > CARCASS_FINAL_APPROACH_DISTANCE then
stageXZ = carcassPosition - flatDir.Unit * CARCASS_STAGE_DISTANCE
end

-- Keep current swim height until the final approach, unless the carcass
-- itself is deeper than the current root.
local swimY = math.min(root.Position.Y, carcassPosition.Y + 1.0)
return Vector3.new(stageXZ.X, swimY, stageXZ.Z)
end

if flatDir.Magnitude < 0.05 then
return projectCarcassGroundGoal(character, carcassPosition)
end

local probe = carcassPosition
if flatDir.Magnitude > CARCASS_FINAL_APPROACH_DISTANCE then
probe = carcassPosition - flatDir.Unit * CARCASS_STAGE_DISTANCE
end
return projectCarcassGroundGoal(character, probe)
end

local function carcassPatrolIsValid(token, character)
if SCRIPT_INSTANCE ~= shared._THEGOAT_SCRIPT_INSTANCE then return false end
if token ~= carcassPatrolToken then return false end
if not autoCarcassChecked() then return false end
if shared._autoQuestZoneLock or shared._autoQuestTravelLock then return false end
if character and (
character:GetAttribute("_autoQuestZoneLock")
or character:GetAttribute("_autoQuestTravelLock")
) then return false end
if shared._inGrowthReset then return false end
if shared._goatMosasaurusBreathing == true then return false end
if character and character:GetAttribute("_returningToLand") then return false end
if player.Character ~= character then return false end
if not character or not character.Parent then return false end

local animalName = character:GetAttribute("AnimalName") or ""
if not CARNIVORES[animalName] then return false end

local humanoid = character:FindFirstChild("Humanoid")
return humanoid ~= nil and humanoid.Health > 0
end

local function eatCarcassLocked(character, token)
stopCarcassMovement(character)
SetClientSubStateChangesEnabled(true)
if character then character:SetAttribute("_carcassInteractionLock", true) end

local lastFood = character:GetAttribute("Food") or 0
local noProgressSince = os.clock()
local lostEatSince = nil
local filled = false

while carcassPatrolIsValid(token, character) do
local currentFood = character:GetAttribute("Food") or 0
if currentFood >= CARCASS_STOP_FOOD then
filled = true
break
end

local currentWater = character:GetAttribute("Water") or 100
if shared._goatCarcassMustYieldToWater(character, currentWater) then
break
end

local canStillEat = CanStartEatDrink(character, true) == "Eat"
if canStillEat then
lostEatSince = nil
ChangeCharacterSubState("Eating")
else
lostEatSince = lostEatSince or os.clock()
if os.clock() - lostEatSince >= CARCASS_EAT_LOST_GRACE then
break
end
end

task.wait(CARCASS_EAT_INTERVAL)

local newFood = character:GetAttribute("Food") or currentFood
if newFood > lastFood + 0.1 then
lastFood = newFood
noProgressSince = os.clock()
elseif canStillEat and os.clock() - noProgressSince >= CARCASS_MAX_NO_PROGRESS then
break
end
end

if character and character.Parent then
character:SetAttribute("_carcassInteractionLock", false)
end
return filled
end

local function finalApproachCarcass(character, radarTarget, token)
local root = character and character:FindFirstChild("HumanoidRootPart")
if not root or not radarTarget or not radarTarget.position then return false end

local waterBlocked = shouldSkipCarcassForWater(
character,
radarTarget.instance,
radarTarget.position
)
if waterBlocked then
cachedCarcassTarget = nil
stopCarcassMovement(character)
return false
end

local flatToCarcass = Vector3.new(
radarTarget.position.X - root.Position.X,
0,
radarTarget.position.Z - root.Position.Z
)
if flatToCarcass.Magnitude > CARCASS_FINAL_APPROACH_DISTANCE + 2 then
return false
end

local carcassGround = projectCarcassGroundGoal(character, radarTarget.position)
if not carcassGround then return false end

local toGround = Vector3.new(
carcassGround.X - root.Position.X,
0,
carcassGround.Z - root.Position.Z
)
local goal = carcassGround
local finalStopDistance = CARCASS_FINAL_STOP_DISTANCE

-- DinoLife carcass interaction is tighter than SL/JL. Move every DL
-- carnivore a little closer to the carcass before deciding it has arrived.
if game.GameId == 8198412649 then
finalStopDistance = 0.65

-- TRex remains slightly tighter because its Eat detector is especially small.
if tostring(character:GetAttribute("AnimalName") or "") == "TRex" then
finalStopDistance = 0.45
end
end

if toGround.Magnitude > finalStopDistance then
goal = carcassGround - toGround.Unit * finalStopDistance
end

if character then character:SetAttribute("_carcassInteractionLock", true) end
carcassOwnsMovement = true

local function releaseCloseLock()
if character and character.Parent then
character:SetAttribute("_carcassInteractionLock", false)
end
end

local dirFlat = Vector3.new(goal.X - root.Position.X, 0, goal.Z - root.Position.Z)
local goalCFrame = (dirFlat.Magnitude > 0.01)
and CFrame.lookAlong(goal, dirFlat.Unit)
or CFrame.new(goal)

Animal.TweenTo(goalCFrame, CARCASS_FINAL_APPROACH_SPEED)
local deadline = os.clock() + CARCASS_FINAL_TIMEOUT

while carcassPatrolIsValid(token, character) and os.clock() < deadline do
local currentWater = character:GetAttribute("Water") or 100
if shared._goatCarcassMustYieldToWater(character, currentWater) then
stopCarcassMovement(character)
releaseCloseLock()
return false
end

if radarTarget.instance and not radarTarget.instance.Parent then
stopCarcassMovement(character)
releaseCloseLock()
return false
end

local blockedByWater = shouldSkipCarcassForWater(
character,
radarTarget.instance,
radarTarget.position
)
if blockedByWater then
cachedCarcassTarget = nil
stopCarcassMovement(character)
releaseCloseLock()
goatPrint("[CarcassRadar] Target entered water — terrestrial pursuit cancelled")
return false
end

if CanStartEatDrink(character, true) == "Eat" then
local acceptEatRange = true

if game.GameId == 18214855317
and tostring(character:GetAttribute("AnimalName") or "") == "Lion"
then
local lionRoot = character:FindFirstChild("HumanoidRootPart")
if lionRoot then
local lionCarcassDistance = Vector3.new(
carcassGround.X - lionRoot.Position.X,
0,
carcassGround.Z - lionRoot.Position.Z
).Magnitude

if lionCarcassDistance > 6.0 then
acceptEatRange = false
goatPrint(string.format(
"[Carcass] Lion Eat detector early • %.1f studs • continuing final approach",
lionCarcassDistance
))
end
end
end

if acceptEatRange then
stopCarcassMovement(character)
goatPrint("[Carcass] Eat range reached — movement locked; eating")
return eatCarcassLocked(character, token)
end
end

root = character:FindFirstChild("HumanoidRootPart")
if not root then
releaseCloseLock()
return false
end
local remaining = Vector3.new(goal.X - root.Position.X, 0, goal.Z - root.Position.Z).Magnitude

if remaining <= 0.55 then
Animal.CancelTween(true)
carcassOwnsMovement = false

local graceDeadline = os.clock() + 1.15
while carcassPatrolIsValid(token, character) and os.clock() < graceDeadline do
if CanStartEatDrink(character, true) == "Eat" then
goatPrint("[Carcass] Eat range confirmed after final hold")
return eatCarcassLocked(character, token)
end
task.wait(CARCASS_FINAL_SCAN_INTERVAL)
end

root = character:FindFirstChild("HumanoidRootPart")
if root then
local creepDir = Vector3.new(
carcassGround.X - root.Position.X,
0,
carcassGround.Z - root.Position.Z
)
local precisionCreepDistance =
(game.GameId == 8198412649 and 0.25)
or CARCASS_FINAL_CREEP_DISTANCE

if creepDir.Magnitude > precisionCreepDistance then
local creepGoal = carcassGround - creepDir.Unit * precisionCreepDistance
local creepCFrame = CFrame.lookAlong(creepGoal, creepDir.Unit)
carcassOwnsMovement = true
Animal.TweenTo(creepCFrame, 5)

local creepDeadline = os.clock() + 1.6
while carcassPatrolIsValid(token, character) and os.clock() < creepDeadline do
if CanStartEatDrink(character, true) == "Eat" then
stopCarcassMovement(character)
goatPrint("[Carcass] Eat range reached after precision creep")
return eatCarcassLocked(character, token)
end
task.wait(CARCASS_FINAL_SCAN_INTERVAL)
end
end
end

-- DinoLife carcass meshes can expose the Eat detector slightly off-center.
-- If the normal final approach is still a little short, reproduce a small
-- player-like forward nudge before rejecting the carcass.
local animalName = tostring(character:GetAttribute("AnimalName") or "")
if game.GameId == 8198412649 and CARNIVORES[animalName] then
root = character:FindFirstChild("HumanoidRootPart")
if root then
local toward = Vector3.new(
carcassGround.X - root.Position.X,
0,
carcassGround.Z - root.Position.Z
)

if toward.Magnitude > 0.01 then
toward = toward.Unit
local side = Vector3.new(-toward.Z, 0, toward.X)

local probes
if animalName == "TRex" then
probes = {
{ forward = 0.30, side = 0.00 },
{ forward = 0.55, side = 0.00 },
{ forward = 0.80, side = 0.00 },
{ forward = 1.05, side = 0.00 },
{ forward = 0.75, side = 0.35 },
{ forward = 0.75, side = -0.35 },
{ forward = 1.10, side = 0.45 },
{ forward = 1.10, side = -0.45 },
{ forward = 1.30, side = 0.00 },
}
else
probes = {
{ forward = 0.20, side = 0.00 },
{ forward = 0.40, side = 0.00 },
{ forward = 0.60, side = 0.00 },
{ forward = 0.80, side = 0.00 },
{ forward = 0.65, side = 0.25 },
{ forward = 0.65, side = -0.25 },
}
end

goatPrint(string.format(
"[Carcass] [DL] close-range Eat not unlocked — nudging closer | animal=%s | carcassDist=%.2f",
animalName,
Vector3.new(carcassGround.X - root.Position.X, 0, carcassGround.Z - root.Position.Z).Magnitude
))

for index, probe in ipairs(probes) do
if not carcassPatrolIsValid(token, character) then
break
end

local currentWater = character:GetAttribute("Water") or 100
if shared._goatCarcassMustYieldToWater(character, currentWater) then
break
end

root = character:FindFirstChild("HumanoidRootPart")
if not root then
break
end

local rawGoal =
root.Position
+ (toward * probe.forward)
+ (side * probe.side)

local projected = projectCarcassGroundGoal(character, rawGoal) or rawGoal
local flatDir = Vector3.new(
carcassGround.X - projected.X,
0,
carcassGround.Z - projected.Z
)

local cf = (flatDir.Magnitude > 0.01)
and CFrame.lookAlong(projected, flatDir.Unit)
or CFrame.new(projected)

carcassOwnsMovement = true
Animal.TweenTo(cf, 3.5)

local probeDeadline = os.clock() + 0.65
while carcassPatrolIsValid(token, character)
and os.clock() < probeDeadline
do
if CanStartEatDrink(character, true) == "Eat" then
stopCarcassMovement(character)
goatPrint(string.format(
"[Carcass] [DL] Eat unlocked by micro-nudge %d | animal=%s",
index,
animalName
))
return eatCarcassLocked(character, token)
end

task.wait(CARCASS_FINAL_SCAN_INTERVAL)
end
end
end
end
end

stopCarcassMovement(character)
releaseCloseLock()
return false
end

task.wait(CARCASS_FINAL_SCAN_INTERVAL)
end

stopCarcassMovement(character)
releaseCloseLock()
return false
end

local function startCarcassPatrol(character)
if carcassPatrolRunning then return end
if not character then return end

carcassPatrolRunning = true
shared._goatCarcassPatrolHeartbeat = os.clock()
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
local myToken = carcassPatrolToken

task.spawn(function()
ensureMeatFoodType()

while carcassPatrolIsValid(myToken, character) do
shared._goatCarcassPatrolHeartbeat = os.clock()
local food = character:GetAttribute("Food") or 100
if food >= CARCASS_STOP_FOOD then
character:SetAttribute("_carcassFeedCycle", false)
break
end

local water = character:GetAttribute("Water") or 100
if shared._goatCarcassMustYieldToWater(character, water) then
stopCarcassMovement(character)
break
end

if shared._animalTweening and not carcassOwnsMovement then
task.wait(0.10)
continue
end

if CanStartEatDrink(character, true) == "Eat" then
shared._goatCarcassPatrolHeartbeat = os.clock()
local filled = eatCarcassLocked(character, myToken)
shared._goatCarcassPatrolHeartbeat = os.clock()
if filled or (character:GetAttribute("Food") or 0) >= CARCASS_STOP_FOOD then
character:SetAttribute("_carcassFeedCycle", false)
break
end
task.wait(0.30)
continue
end

local radarTarget = findWideCarcassTarget(character, false)
local root = character:FindFirstChild("HumanoidRootPart")
local radarDistance = math.huge
if radarTarget and radarTarget.position and root then
radarDistance = Vector3.new(
radarTarget.position.X - root.Position.X,
0,
radarTarget.position.Z - root.Position.Z
).Magnitude
end

if radarTarget and radarDistance <= CARCASS_FINAL_APPROACH_DISTANCE + 2 then
shared._goatCarcassPatrolHeartbeat = os.clock()
local ate = finalApproachCarcass(character, radarTarget, myToken)
shared._goatCarcassPatrolHeartbeat = os.clock()
if ate or (character:GetAttribute("Food") or 0) >= CARCASS_STOP_FOOD then
character:SetAttribute("_carcassFeedCycle", false)
break
end

-- The selected carcass failed at close range. Do not waste another
-- full cycle on the same target: quarantine it briefly and force a
-- fresh nearest-target scan immediately.
if radarTarget.instance then
shared._goatCarcassFailureMemory = shared._goatCarcassFailureMemory or setmetatable({}, {__mode = "k"})

local failureInfo = shared._goatCarcassFailureMemory[radarTarget.instance]
local failureNow = os.clock()

if type(failureInfo) ~= "table"
or failureNow - (tonumber(failureInfo.last) or 0) > 120
then
failureInfo = {count = 0, last = failureNow}
end

failureInfo.count = math.min((tonumber(failureInfo.count) or 0) + 1, 7)
failureInfo.last = failureNow
shared._goatCarcassFailureMemory[radarTarget.instance] = failureInfo

local rejectSeconds = math.min(30, 4 + ((failureInfo.count - 1) * 4))
shared._goatCarcassRejectedTargets[radarTarget.instance] = failureNow + rejectSeconds

goatPrint(string.format(
"[CarcassRadar] Target failed — adaptive reject %.0fs | failures=%d | %s",
rejectSeconds,
failureInfo.count,
radarTarget.instance:GetFullName()
))
end

cachedCarcassTarget = nil
lastCarcassRadarAt = 0

local nextTarget = findWideCarcassTarget(character, true)
if nextTarget and nextTarget.position then
goatPrint(string.format(
"[CarcassRadar] NEXT candidate immediately | %s | %.1f studs",
nextTarget.instance and nextTarget.instance:GetFullName() or "?",
nextTarget.distance or -1
))
task.wait(0.05)
else
task.wait(0.15)
end
continue
end

local goalPosition = nil
local followingCarcass = false
if radarTarget and radarTarget.position then
goalPosition = getCarcassTravelGoal(character, radarTarget.position)
followingCarcass = goalPosition ~= nil
end

if not goalPosition then
goalPosition = findCarcassPatrolGoal(character)
end

if not goalPosition then
task.wait(shared._autoQuestCarnivoreFoodEmergency == true and 0.20 or 0.90)
continue
end

local walkDone = false
local eatReachedDuringWalk = false
carcassOwnsMovement = true

local patrolAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(patrolAnimalName)

task.spawn(function()
if fullyAquaticDL and followingCarcass then
local swimRoot = character:FindFirstChild("HumanoidRootPart")
if swimRoot then
local swimDir = Vector3.new(
goalPosition.X - swimRoot.Position.X,
0,
goalPosition.Z - swimRoot.Position.Z
)

local swimCFrame = (swimDir.Magnitude > 0.01)
and CFrame.lookAlong(goalPosition, swimDir.Unit)
or CFrame.new(goalPosition)

goatPrint(string.format(
"[Carcass][DL] Mosasaurus swimming to submerged carcass | distance=%.1f",
swimDir.Magnitude
))

Animal.TweenTo(swimCFrame, 9)
else
walkDone = true
end
else
pcall(function()
Animal.WalkToAsync(CFrame.new(goalPosition))
end)
end

if myToken == carcassPatrolToken then
carcassOwnsMovement = false
end
walkDone = true
end)

local lastRetargetAt = os.clock()
local lastWaterValidationAt = 0

while carcassPatrolIsValid(myToken, character) and not walkDone do
shared._goatCarcassPatrolHeartbeat = os.clock()
local currentWater = character:GetAttribute("Water") or 100
if shared._goatCarcassMustYieldToWater(character, currentWater) then
stopCarcassMovement(character)
break
end

if followingCarcass
and radarTarget
and os.clock() - lastWaterValidationAt >= 0.35
then
lastWaterValidationAt = os.clock()

local blockedByWater = shouldSkipCarcassForWater(
character,
radarTarget.instance,
radarTarget.position
)
if blockedByWater then
if radarTarget.instance then
shared._goatCarcassFailureMemory = shared._goatCarcassFailureMemory or setmetatable({}, {__mode = "k"})

local failureInfo = shared._goatCarcassFailureMemory[radarTarget.instance]
local failureNow = os.clock()

if type(failureInfo) ~= "table"
or failureNow - (tonumber(failureInfo.last) or 0) > 120
then
failureInfo = {count = 0, last = failureNow}
end

failureInfo.count = math.min((tonumber(failureInfo.count) or 0) + 1, 7)
failureInfo.last = failureNow
shared._goatCarcassFailureMemory[radarTarget.instance] = failureInfo

local rejectSeconds = math.min(30, 4 + ((failureInfo.count - 1) * 4))
shared._goatCarcassRejectedTargets[radarTarget.instance] = failureNow + rejectSeconds

goatPrint(string.format(
"[CarcassRadar] Water target adaptive reject %.0fs | failures=%d",
rejectSeconds,
failureInfo.count
))
end
cachedCarcassTarget = nil
lastCarcassRadarAt = 0
stopCarcassMovement(character)
goatPrint("[CarcassRadar] Water target cancelled during pursuit — next scan unlocked")
break
end
end

if CanStartEatDrink(character, true) == "Eat" then
eatReachedDuringWalk = true
stopCarcassMovement(character)
break
end

if fullyAquaticDL and followingCarcass and radarTarget and radarTarget.position then
local swimRoot = character:FindFirstChild("HumanoidRootPart")
if swimRoot then
local aquaticRemaining = Vector3.new(
radarTarget.position.X - swimRoot.Position.X,
0,
radarTarget.position.Z - swimRoot.Position.Z
).Magnitude

if aquaticRemaining <= CARCASS_FINAL_APPROACH_DISTANCE + 2 then
stopCarcassMovement(character)
break
end
end
end

if not followingCarcass and os.clock() - lastRetargetAt >= CARCASS_RADAR_INTERVAL then
lastRetargetAt = os.clock()
local newlyFound = findWideCarcassTarget(character, false)
if newlyFound and newlyFound.position then
stopCarcassMovement(character)
break
end
end

task.wait(CARCASS_SCAN_INTERVAL)
end

if not carcassPatrolIsValid(myToken, character) then
stopCarcassMovement(character)
break
end

if eatReachedDuringWalk then
local filled = eatCarcassLocked(character, myToken)
if filled or (character:GetAttribute("Food") or 0) >= CARCASS_STOP_FOOD then
character:SetAttribute("_carcassFeedCycle", false)
break
end
end

task.wait(0.30)
end

if myToken == carcassPatrolToken then
stopCarcassMovement(character)
carcassPatrolRunning = false
end
end)
end

local lastDrinkMoveAt = 0
local DRINK_MOVE_COOLDOWN = 1.5
local savedLandPosition = nil  -- save position before going to water
local savedWaterPosition = nil  -- force CFrame here while drinking (no anchor)
local returningToLand = false
local returnToLandToken = 0

-- Recovery point confirmed by the user.
-- Used for any animal that reaches land but Savannah still owns it as Swimming/7.
local FIXED_WATER_RECOVERY_POINT = Vector3.new(-6565.300, -29.467, 4619.873)
local FIXED_LAND_RECOVERY_POINT  = Vector3.new(-6570.467, -7.801, 4432.124)

shared._fixedWaterLandRecoveryGeneration =
tonumber(shared._fixedWaterLandRecoveryGeneration) or 0

-- Grow/Spawn Beach must be able to kill an old AutoDrink return worker
-- immediately. Clearing only the character attribute is not enough,
-- because the old coroutine still owns myReturnToken/savedLandPosition.
shared._cancelAutoDrinkReturnForGrowth = function(targetCharacter, reason)
returnToLandToken = returnToLandToken + 1
returningToLand = false
savedLandPosition = nil
savedWaterPosition = nil
lastDrinkMoveAt = 0

-- Invalidate any fixed-water recovery worker from the previous state too.
shared._fixedWaterLandRecoveryGeneration =
(tonumber(shared._fixedWaterLandRecoveryGeneration) or 0) + 1

shared._fixedWaterLandRecoveryActive = false
shared._fixedWaterLandRecoveryCharacter = nil
shared._fixedWaterLandRecoveryOwnerGeneration = nil

local ch = targetCharacter or player.Character

if ch then
ch:SetAttribute("_drinkingToFull", false)
ch:SetAttribute("_returningToLand", false)
ch:SetAttribute("_carcassInteractionLock", false)

local r = ch:FindFirstChild("HumanoidRootPart")
if r then
r.Anchored = false
r.AssemblyLinearVelocity = Vector3.zero
r.AssemblyAngularVelocity = Vector3.zero
end
end

-- Cancel the old movement BEFORE Spawn Beach starts its own route.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
pcall(function()
Animal.CancelTween(true)
end)
shared._animalTweening = false

goatPrint(string.format(
"[AutoDrink] Return worker CANCELLED for Growth/Beach | reason=%s | token=%d",
tostring(reason or "growth"),
returnToLandToken
))

return true
end

pcall(function()
local ch = player.Character
if ch then
ch:SetAttribute("_returningToLand", false)
ch:SetAttribute("_carcassInteractionLock", false)
end
end)

local function getSafeLandReturnGoal(character, savedPosition)
if not character or not savedPosition then return savedPosition end

local humanoid = character:FindFirstChild("Humanoid")

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.FilterDescendantsInstances = { character }
rayParams.IgnoreWater = false

-- The savedPosition is already the real HRP position from solid land
-- immediately before going to drink. Search only near that height.
-- The previous +80/-180 ray could hit tree tops or rocks high above it.
local RETURN_RAY_UP = 12
local RETURN_RAY_DOWN = 34
local MAX_GOAL_ABOVE_SAVED = 7
local MAX_GOAL_BELOW_SAVED = 10

local origin = savedPosition + Vector3.new(0, RETURN_RAY_UP, 0)

local result = workspace:Raycast(
origin,
Vector3.new(0, -RETURN_RAY_DOWN, 0),
rayParams
)

if result
and result.Material ~= Enum.Material.Water
and (not result.Normal or result.Normal.Y >= 0.35)
then
local lift = math.max((humanoid and humanoid.HipHeight or 2), 2) + 0.75
local candidate = result.Position + Vector3.new(0, lift, 0)
local deltaY = candidate.Y - savedPosition.Y

if deltaY <= MAX_GOAL_ABOVE_SAVED
and deltaY >= -MAX_GOAL_BELOW_SAVED
then
return candidate
end

goatPrint(string.format(
"[AutoDrink] Return goal rejected | savedY=%.1f | hitY=%.1f | candidateY=%.1f | deltaY=%.1f",
savedPosition.Y,
result.Position.Y,
candidate.Y,
deltaY
))
end

-- savedPosition itself was captured while the animal was safely on land,
-- so use it instead of accepting a suspicious tree/rock top.
return savedPosition + Vector3.new(0, 0.75, 0)
end

local function findNearestSafeLand(character)
if not character then return nil end
local root = character:FindFirstChild("HumanoidRootPart")
if not root then return nil end

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.FilterDescendantsInstances = {character}

local radii = {20, 35, 55, 80, 120, 170, 240, 320}
local best = nil
local bestDist = math.huge

for _, radius in ipairs(radii) do
for i = 0, 15 do
local angle = (math.pi * 2) * (i / 16)
local x = root.Position.X + math.cos(angle) * radius
local z = root.Position.Z + math.sin(angle) * radius

local hit = workspace:Raycast(
Vector3.new(x, root.Position.Y + 90, z),
Vector3.new(0, -220, 0),
rayParams
)

if hit
and hit.Material ~= Enum.Material.Water
and hit.Normal.Y >= 0.55
then
local candidate = hit.Position + Vector3.new(0, 3, 0)
local flatDist = Vector3.new(
candidate.X - root.Position.X,
0,
candidate.Z - root.Position.Z
).Magnitude

if flatDist < bestDist then
bestDist = flatDist
best = candidate
end
end
end

if best then
return best
end
end

return nil
end

local function beginReturnToLand(character)
if type(shared._goatIsDLFullyAquaticName) == "function"
and character
and shared._goatIsDLFullyAquaticName(character:GetAttribute("AnimalName"))
then
character:SetAttribute("_returningToLand", false)
character:SetAttribute("_drinkingToFull", false)
returningToLand = false
return
end

if shared._autoQuestSwimLock then return end

-- Prevent a second AutoDrink return worker from starting while the
-- fixed water -> fixed land recovery is already moving this animal.
if shared._fixedWaterLandRecoveryActive then
return
end
if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION then
return
end
if returningToLand then return end
if not character then return end

local fallbackLand = nil
if not savedLandPosition then
fallbackLand = findNearestSafeLand(character)
end

local returnPos = savedLandPosition or fallbackLand
if not returnPos then
character:SetAttribute("_returningToLand", false)
goatPrint("[AutoDrink] Return to land blocked — no safe land point found")
return
end

returningToLand = true
SetGoatHudStatus("Auto Drink", "Voltando para terra", Color3.fromRGB(0, 170, 255))
returnToLandToken = returnToLandToken + 1
local myReturnToken = returnToLandToken

character:SetAttribute("_returningToLand", true)
character:SetAttribute("_drinkingToFull", false)
character:SetAttribute("_carcassInteractionLock", false)
savedWaterPosition = nil

carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
stopCarcassMovement(character)
Animal.CancelTween(true)

task.spawn(function()
SetClientSubStateChangesEnabled(true)

local function isSwimmingNow()
if not character or player.Character ~= character then
return false
end

local movementState = character:GetAttribute("MovementState")
local replicatedState = character:GetAttribute("ReplicatedMovementState")
local onWater = Animal.IsOnWater() == true

-- Always return a real boolean. In Lua, "false or false or nil"
-- evaluates to nil, which previously produced swimming=nil in the log.
if movementState == "Swimming" or replicatedState == 7 or onWater then
return true
end

return false
end

local root = character:FindFirstChild("HumanoidRootPart")
local humanoid = character:FindFirstChild("Humanoid")

-- Save the actual nearby water position before the return route starts.
-- Used only if this same AutoDrink return remains stuck in Swimming/7.
local returnRecoveryWaterPoint = nil
if root and isSwimmingNow() then
returnRecoveryWaterPoint = root.Position
end
if root then
root.Anchored = false
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end

local safeGoal = getSafeLandReturnGoal(character, returnPos)
or findNearestSafeLand(character)

local moved = false

local returnAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local impalaReturn = string.lower(returnAnimalName) == "impala"
local impalaStableSince = nil

local function impalaHasSafeGround(liveRoot)
if not impalaReturn then
return true
end
if not liveRoot then
return false
end

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {character}
params.IgnoreWater = false

local hit = workspace:Raycast(
liveRoot.Position + Vector3.new(0, 1.5, 0),
Vector3.new(0, -12, 0),
params
)

if not hit then
return false
end
if hit.Material == Enum.Material.Water then
return false
end
if hit.Normal and hit.Normal.Y < 0.45 then
return false
end

local gap = liveRoot.Position.Y - hit.Position.Y
return gap >= 1.5 and gap <= 7.0
end

if safeGoal and root then
local startY = root.Position.Y
local startFlatDistance = Vector3.new(
root.Position.X - safeGoal.X,
0,
root.Position.Z - safeGoal.Z
).Magnitude

local startedSwimming = isSwimmingNow()
local verticalRiseToLand = safeGoal.Y - startY

-- Savannah Life can finish drinking while the character is no longer
-- reporting MovementState=Swimming even though it is still well below
-- the saved land level. Treat a clearly higher land target as a water exit.
local waterExitMode = startedSwimming or verticalRiseToLand > 2.5

-- Do not force GettingUp while exiting water/deep terrain.
if humanoid and not waterExitMode then
humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

goatPrint(string.format(
"[AutoDrink] Return start | swimming=%s | waterExit=%s | startY=%.1f | goalY=%.1f | rise=%.1f | flat=%.1f",
tostring(startedSwimming),
tostring(waterExitMode),
startY,
safeGoal.Y,
verticalRiseToLand,
startFlatDistance
))

local moveFinished = false
local moveCallOk = false

task.spawn(function()
local ok, result = pcall(function()
if waterExitMode then
-- IMPORTANT:
-- Pathfinding/WalkToAsync was sending swimming animals through bad
-- underwater waypoints after the Savannah Life update.
-- The saved return point is the land position from immediately before
-- drinking, so use a direct controlled tween only for water exit.
Animal.CancelTween(true)
Animal.TweenToAsync(CFrame.new(safeGoal))
return true
end

return Animal.WalkToAsync(CFrame.new(safeGoal))
end)

moveCallOk = ok and result ~= false
moveFinished = true
end)

local startedReturn = os.clock()
local RETURN_LAND_TIMEOUT = waterExitMode and 4.0 or 8.0
local forcedRescue = false

while (os.clock() - startedReturn) < RETURN_LAND_TIMEOUT
and shared._autoDrinkOwnerGeneration == AUTO_DRINK_OWNER_GENERATION
and myReturnToken == returnToLandToken
and player.Character == character
do
task.wait(0.10)

local liveRoot = character:FindFirstChild("HumanoidRootPart")
if not liveRoot then
break
end

local d = Vector3.new(
liveRoot.Position.X - safeGoal.X,
0,
liveRoot.Position.Z - safeGoal.Z
).Magnitude

-- Reached the saved land area and no longer in swimming state.
-- Impala needs stricter confirmation because its body can still be
-- half-submerged/inside the bank while the horizontal distance already
-- looks correct.
local heightOk = (not impalaReturn)
or liveRoot.Position.Y >= (safeGoal.Y - 0.8)

local groundOk = impalaHasSafeGround(liveRoot)

local returnReady =
d <= 9
and not isSwimmingNow()
and not Animal.IsInsideTerrain()
and heightOk
and groundOk

if returnReady then
if impalaReturn then
if not impalaStableSince then
impalaStableSince = os.clock()
end

if (os.clock() - impalaStableSince) >= 0.60 then
moved = true
break
end
else
moved = true
break
end
else
impalaStableSince = nil
end

-- New protection:
-- while RETURNING TO LAND, never allow the route to take the animal
-- progressively deeper into the water.
if waterExitMode and liveRoot.Position.Y < (startY - 1.5) then
goatPrint(string.format(
"[AutoDrink] Return path going deeper | startY=%.1f | currentY=%.1f — forcing safe land",
startY,
liveRoot.Position.Y
))
Animal.CancelTween(true)
forcedRescue = true
break
end

if moveFinished and not moveCallOk then
break
end
end

if not moved
and shared._autoDrinkOwnerGeneration == AUTO_DRINK_OWNER_GENERATION
and myReturnToken == returnToLandToken
and player.Character == character
then
if forcedRescue then
goatPrint("[AutoDrink] Return-to-land rescue — depth guard activated")
elseif waterExitMode then
goatPrint("[AutoDrink] Return-to-land watchdog — water exit timeout; forcing safe land")
else
goatPrint("[AutoDrink] Return-to-land watchdog — movement stuck; forcing safe land")
end

Animal.CancelTween(true)

local liveRoot = character:FindFirstChild("HumanoidRootPart")
local rescueGoal = getSafeLandReturnGoal(character, returnPos)
or findNearestSafeLand(character)
or safeGoal

if liveRoot and rescueGoal then
liveRoot.Anchored = false
liveRoot.CFrame = CFrame.new(rescueGoal)
liveRoot.AssemblyLinearVelocity = Vector3.zero
liveRoot.AssemblyAngularVelocity = Vector3.zero
task.wait(0.25)

local rescueDistance = Vector3.new(
liveRoot.Position.X - rescueGoal.X,
0,
liveRoot.Position.Z - rescueGoal.Z
).Magnitude

local rescueHeightOk = (not impalaReturn)
or liveRoot.Position.Y >= (rescueGoal.Y - 0.8)

local rescueGroundOk = impalaHasSafeGround(liveRoot)

moved = rescueDistance <= 10
and not isSwimmingNow()
and not Animal.IsInsideTerrain()
and rescueHeightOk
and rescueGroundOk
end
end
end

if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or myReturnToken ~= returnToLandToken
or player.Character ~= character
then
if myReturnToken == returnToLandToken then
returningToLand = false
end
return
end

root = character:FindFirstChild("HumanoidRootPart")
local unsafe = not root or isSwimmingNow() or Animal.IsInsideTerrain()

if root and safeGoal then
local flatDistance = Vector3.new(
root.Position.X - safeGoal.X,
0,
root.Position.Z - safeGoal.Z
).Magnitude

local finalHeightOk = (not impalaReturn)
or root.Position.Y >= (safeGoal.Y - 0.8)

local finalGroundOk = impalaHasSafeGround(root)

unsafe = unsafe
or flatDistance > 10
or not finalHeightOk
or not finalGroundOk
end

-- Final safety fallback only.
if unsafe and root and safeGoal then
root.Anchored = false

local finalGoal = safeGoal
if impalaReturn then
-- Small Impala-only clearance so the lower body does not remain clipped
-- into the bank after the emergency rescue.
finalGoal = safeGoal + Vector3.new(0, 1.5, 0)
end

root.CFrame = CFrame.new(finalGoal)
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
task.wait(impalaReturn and 0.35 or 0.20)
end

-- ALL-ANIMAL WATER RECOVERY: CARCASS-GROUND TRANSIT + FIXED WATER/LAND
-- No teleport/CFrame placement is used here. This copies the monitored
-- movement pattern used by Spawn Beach: WalkToAsync + stuck detection +
-- route restart + arrival confirmation.
do
local animalName = tostring(character:GetAttribute("AnimalName") or "")
local movementState = tostring(character:GetAttribute("MovementState") or "")
local replicatedState = tonumber(character:GetAttribute("ReplicatedMovementState"))

if (movementState == "Swimming" or replicatedState == 7)
and shared._autoDrinkOwnerGeneration == AUTO_DRINK_OWNER_GENERATION
and myReturnToken == returnToLandToken
and player.Character == character
then
local RECOVERY_ARRIVAL_DISTANCE = 8
local RECOVERY_SCAN_INTERVAL = 0.25
local RECOVERY_STUCK_WINDOW = 5.0
local RECOVERY_MIN_MOVEMENT = 1.5
local RECOVERY_MAX_RESTARTS = 8
local RECOVERY_TIMEOUT = 420

local recoveryCharacter = character
local recoveryGeneration =
(tonumber(shared._fixedWaterLandRecoveryGeneration) or 0) + 1

shared._fixedWaterLandRecoveryGeneration = recoveryGeneration

local function stopRecoveryMovement()
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1

if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end

shared._animalTweening = false

-- IMPORTANT: stop only the character that owns this recovery.
-- Never grab player.Character here, because Grow/Spawn can replace it.
local ch = recoveryCharacter
local r = ch and ch:FindFirstChild("HumanoidRootPart")
local h = ch and ch:FindFirstChildOfClass("Humanoid")

if h and r then
pcall(function()
h:MoveTo(r.Position)
end)
end
end

local function monitoredMoveLikeSpawnBeach(target, label, requireWater, useCarcassGround)
local startingCharacter = recoveryCharacter
local rootNow = startingCharacter and startingCharacter:FindFirstChild("HumanoidRootPart")
local humNow = startingCharacter and startingCharacter:FindFirstChildOfClass("Humanoid")

if not rootNow or not humNow or humNow.Health <= 0 then
goatWarn("[AutoDrink] " .. label .. " — invalid character")
return false
end

local function flatDistance()
local ch = startingCharacter
local r = ch and ch:FindFirstChild("HumanoidRootPart")

if player.Character ~= startingCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
or not r
then
return math.huge
end

return (
Vector3.new(target.X, 0, target.Z)
- Vector3.new(r.Position.X, 0, r.Position.Z)
).Magnitude
end

local function waterConfirmed()
if not requireWater then
return true
end

local ch = startingCharacter
local r = ch and ch:FindFirstChild("HumanoidRootPart")
if player.Character ~= startingCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
or not r
then
return false
end

local onWater = false
pcall(function()
onWater = Animal.IsOnWater() == true
end)

-- The chosen point is deep water. Accept either the game's water ray
-- or actually reaching close to the recorded water-point Y.
local nearRecordedWaterY =
math.abs(r.Position.Y - target.Y) <= 8

return onWater or nearRecordedWaterY
end

local initialDistance = flatDistance()

goatPrint(string.format(
"[AutoDrink] %s START | animal=%s | distance=%.1f | target=(%.1f, %.1f, %.1f)",
label,
animalName,
initialDistance,
target.X,
target.Y,
target.Z
))

stopRecoveryMovement()
task.wait(0.35)

local globalDeadline = os.clock() + RECOVERY_TIMEOUT
local restartCount = 0

while os.clock() < globalDeadline do
local ch = startingCharacter
local h = ch and ch:FindFirstChildOfClass("Humanoid")
rootNow = ch and ch:FindFirstChild("HumanoidRootPart")

if player.Character ~= startingCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
or not rootNow
or not h
or h.Health <= 0
or shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or myReturnToken ~= returnToLandToken
then
stopRecoveryMovement()
goatWarn("[AutoDrink] " .. label .. " — cancelled/character changed")
return false
end

local remainingBefore = flatDistance()

if remainingBefore <= RECOVERY_ARRIVAL_DISTANCE and waterConfirmed() then
stopRecoveryMovement()

goatPrint(string.format(
"[AutoDrink] %s ARRIVED | animal=%s | distance=%.1f | onWater=%s | y=%.1f",
label,
animalName,
remainingBefore,
tostring(Animal.IsOnWater() == true),
rootNow.Position.Y
))

task.wait(1.25)
return true
end

if restartCount > RECOVERY_MAX_RESTARTS then
stopRecoveryMovement()
goatWarn("[AutoDrink] " .. label .. " — max route recalculations reached")
return false
end

local walkDone = false
local walkResult = nil
local walkError = nil

task.spawn(function()
local ok, result = pcall(function()
if type(shared._animalWalkToAsync) ~= "function" then
error("shared._animalWalkToAsync unavailable")
end

-- Same movement call used by Spawn Beach.
if useCarcassGround then
return shared._animalWalkToAsync(
CFrame.new(target),
{ groundedRecovery = true }
)
end

return shared._animalWalkToAsync(CFrame.new(target))
end)

if ok then
walkResult = result
else
walkError = result
end

walkDone = true
end)

local checkpointAt = os.clock()
local checkpointPos = rootNow.Position
local restartReason = nil

while not walkDone and os.clock() < globalDeadline do
local ch2 = startingCharacter
local h2 = ch2 and ch2:FindFirstChildOfClass("Humanoid")
rootNow = ch2 and ch2:FindFirstChild("HumanoidRootPart")

if player.Character ~= startingCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
or not rootNow
or not h2
or h2.Health <= 0
then
restartReason = "character_invalid"
break
end

local remaining = flatDistance()

if remaining <= RECOVERY_ARRIVAL_DISTANCE and waterConfirmed() then
stopRecoveryMovement()

goatPrint(string.format(
"[AutoDrink] %s ARRIVED | animal=%s | distance=%.1f | onWater=%s | y=%.1f",
label,
animalName,
remaining,
tostring(Animal.IsOnWater() == true),
rootNow.Position.Y
))

task.wait(1.25)
return true
end

if os.clock() - checkpointAt >= RECOVERY_STUCK_WINDOW then
local moved = (rootNow.Position - checkpointPos).Magnitude

if moved < RECOVERY_MIN_MOVEMENT then
restartReason = "stuck"
break
end

checkpointAt = os.clock()
checkpointPos = rootNow.Position
end

task.wait(RECOVERY_SCAN_INTERVAL)
end

if os.clock() >= globalDeadline then
stopRecoveryMovement()
goatWarn("[AutoDrink] " .. label .. " — timeout")
return false
end

if restartReason == "character_invalid" then
stopRecoveryMovement()
goatWarn("[AutoDrink] " .. label .. " — character invalid")
return false
end

local remainingAfter = flatDistance()

if remainingAfter <= RECOVERY_ARRIVAL_DISTANCE and waterConfirmed() then
stopRecoveryMovement()
task.wait(1.25)
return true
end

restartCount = restartCount + 1

if walkError then
goatWarn("[AutoDrink] " .. label .. " movement error: " .. tostring(walkError))
elseif restartReason == "stuck" then
goatPrint(string.format(
"[AutoDrink] %s stuck — recalculating route (%d/%d)",
label,
restartCount,
RECOVERY_MAX_RESTARTS
))
elseif walkDone then
goatPrint(string.format(
"[AutoDrink] %s ended away from target (%.1f studs) — recalculating (%d/%d)",
label,
remainingAfter,
restartCount,
RECOVERY_MAX_RESTARTS
))
elseif walkResult == false then
goatPrint(string.format(
"[AutoDrink] %s requested route recalculation (%d/%d)",
label,
restartCount,
RECOVERY_MAX_RESTARTS
))
end

stopRecoveryMovement()

local settleDeadline = os.clock() + 1.25
while not walkDone and os.clock() < settleDeadline do
task.wait(0.05)
end

task.wait(0.30)
end

stopRecoveryMovement()
return false
end

-- Abort immediately if this return worker belongs to an old slot.
if player.Character ~= recoveryCharacter then
goatWarn(string.format(
"[AutoDrink] FIXED recovery cancelled before start | animal=%s | character changed",
animalName
))
return
end

shared._fixedWaterLandRecoveryActive = true
shared._fixedWaterLandRecoveryCharacter = recoveryCharacter
shared._fixedWaterLandRecoveryOwnerGeneration = recoveryGeneration

local function finishFixedRecovery()
if shared._fixedWaterLandRecoveryCharacter == recoveryCharacter
and shared._fixedWaterLandRecoveryOwnerGeneration == recoveryGeneration
then
shared._fixedWaterLandRecoveryActive = false
shared._fixedWaterLandRecoveryCharacter = nil
shared._fixedWaterLandRecoveryOwnerGeneration = nil
end
end

-- LOCAL-FIRST RECOVERY FOR TERRESTRIAL ANIMALS.
-- This changes only the emergency branch that previously jumped directly
-- to the distant FIXED WATER -> FIXED LAND route.
local localRecoverySucceeded = false
local lowerRecoveryAnimal = string.lower(animalName)
local localRecoveryIsCroc =
lowerRecoveryAnimal:find("croc", 1, true) ~= nil

if not localRecoveryIsCroc then
local localLandGoal =
safeGoal
or getSafeLandReturnGoal(character, returnPos)
or findNearestSafeLand(character)

if localLandGoal then
local liveRoot = recoveryCharacter
and recoveryCharacter:FindFirstChild("HumanoidRootPart")

local landDistance = math.huge
if liveRoot then
landDistance = Vector3.new(
localLandGoal.X - liveRoot.Position.X,
0,
localLandGoal.Z - liveRoot.Position.Z
).Magnitude
end

goatPrint(string.format(
"[AutoDrink] LOCAL shore recovery START | animal=%s | landDistance=%.1f",
animalName,
landDistance
))

-- Attempt 1: leave the current water state directly toward the nearby/saved shore.
local reachedLocalLand = monitoredMoveLikeSpawnBeach(
localLandGoal,
"NEARBY LAND EXIT",
false,
true
)

if reachedLocalLand then
pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)
task.wait(0.40)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()

-- EARLY SUCCESS grace:
-- Savannah can clear replicated=7 shortly AFTER the animal is already
-- physically on dry land. Wait briefly before forcing another water route.
if not localRecoverySucceeded then
task.wait(0.85)

pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()
end

if localRecoverySucceeded then
goatPrint(string.format(
"[AutoDrink] EARLY SUCCESS after nearby land | animal=%s | state=%s | replicated=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end

-- Attempt 2: if Savannah kept Swimming/7 latched, re-enter the SAME local
-- water point where this return started, then exit to the same nearby land.
if not localRecoverySucceeded
and returnRecoveryWaterPoint
and player.Character == recoveryCharacter
and shared._fixedWaterLandRecoveryGeneration == recoveryGeneration
then
goatPrint(string.format(
"[AutoDrink] Nearby shore did not clear Swimming/7 — LOCAL WATER->LAND | animal=%s",
animalName
))

local reachedLocalWater = monitoredMoveLikeSpawnBeach(
returnRecoveryWaterPoint,
"LOCAL WATER ENTRY",
true,
false
)

local reachedNearbyLand = false

if reachedLocalWater then
task.wait(1.25)

reachedNearbyLand = monitoredMoveLikeSpawnBeach(
localLandGoal,
"NEARBY LAND EXIT",
false,
true
)

if reachedNearbyLand then
pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)
task.wait(0.40)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()
end
end

goatPrint(string.format(
"[AutoDrink] LOCAL WATER->LAND recovery END | animal=%s | waterReached=%s | landReached=%s | escaped=%s | state=%s | replicated=%s",
animalName,
tostring(reachedLocalWater),
tostring(reachedNearbyLand),
tostring(localRecoverySucceeded),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
else
goatWarn(string.format(
"[AutoDrink] LOCAL shore recovery unavailable — no nearby/saved land | animal=%s",
animalName
))
end
end

-- TEST WATER LOCAL:
-- If the direct nearby-land / original-water attempt did not release
-- Swimming/7, try the SAME shallow-water transition already proven by
-- WaterEscape before ever travelling to the distant fixed pair.
if not localRecoverySucceeded
and not localRecoveryIsCroc
and player.Character == recoveryCharacter
and shared._fixedWaterLandRecoveryGeneration == recoveryGeneration
and type(shared._goatFindTestWaterShallowRecoveryRoute) == "function"
then
local testRoute = nil
pcall(function()
testRoute = shared._goatFindTestWaterShallowRecoveryRoute(recoveryCharacter)
end)

if testRoute
and testRoute.shorePoint
and testRoute.waterPoint
then
goatPrint(string.format(
"[AutoDrink][TEST WATER] SHALLOW route found | animal=%s | distance=%.1f | entry=%.1f | depth=%.1f | source=%s",
animalName,
tonumber(testRoute.routeDistance) or -1,
tonumber(testRoute.entryDistance) or -1,
tonumber(testRoute.depth) or -1,
tostring(testRoute.source)
))

local reachedTestShore = monitoredMoveLikeSpawnBeach(
testRoute.shorePoint,
"TEST WATER SHORE",
false,
true
)

if reachedTestShore then
pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)
task.wait(0.55)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()

-- If just reaching the dry TEST WATER shore already cleared the state,
-- do NOT enter water again.
if localRecoverySucceeded then
goatPrint(string.format(
"[AutoDrink][TEST WATER] EARLY SUCCESS AT SHORE | animal=%s | state=%s | replicated=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
else
local reachedTestWater = monitoredMoveLikeSpawnBeach(
testRoute.waterPoint,
"TEST WATER SHALLOW ENTRY",
true,
false
)

if reachedTestWater then
task.wait(1.10)

local reachedTestExit = monitoredMoveLikeSpawnBeach(
testRoute.shorePoint,
"TEST WATER SHORE EXIT",
false,
true
)

if reachedTestExit then
pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)
task.wait(0.55)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()
end

goatPrint(string.format(
"[AutoDrink][TEST WATER] SHALLOW WATER->LAND END | animal=%s | waterReached=%s | exitReached=%s | escaped=%s | state=%s | replicated=%s",
animalName,
tostring(reachedTestWater),
tostring(reachedTestExit),
tostring(localRecoverySucceeded),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
else
goatPrint(string.format(
"[AutoDrink][TEST WATER] SHALLOW ENTRY failed | animal=%s",
animalName
))
end
end
end
else
goatPrint(string.format(
"[AutoDrink][TEST WATER] No valid shallow route within 1200 studs | animal=%s",
animalName
))
end
end

-- FINAL EARLY SUCCESS CHECK:
-- state can normalize while a failed local movement is winding down.
if not localRecoverySucceeded
and not localRecoveryIsCroc
and player.Character == recoveryCharacter
and shared._fixedWaterLandRecoveryGeneration == recoveryGeneration
then
pcall(function()
SetClientSubStateChangesEnabled(true)
end)
pcall(function()
ChangeCharacterSubState("Idling")
end)
task.wait(0.35)

localRecoverySucceeded =
not isSwimmingNow()
and not Animal.IsInsideTerrain()

if localRecoverySucceeded then
goatPrint(string.format(
"[AutoDrink] EARLY SUCCESS before FIXED fallback | animal=%s | state=%s | replicated=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end

if localRecoverySucceeded then
goatPrint(string.format(
"[AutoDrink] LOCAL shore recovery CONFIRMED | animal=%s | fixed recovery skipped",
animalName
))
finishFixedRecovery()
else
-- DinoLife must never use Savannah Life's fixed water/land recovery pair.
-- If local AutoDrink recovery fails, release this attempt and retry locally
-- from the TRex's current position on the next cycle.
if game.GameId == 8198412649 then
goatWarn(string.format(
"[AutoDrink] [DL] Local recovery failed — fixed SL fallback BLOCKED | animal=%s",
animalName
))
finishFixedRecovery()
return
end

if not localRecoveryIsCroc then
goatWarn(string.format(
"[AutoDrink] LOCAL recovery failed — LAST RESORT FIXED WATER->LAND | animal=%s",
animalName
))
end

local recoveryRootAtStart = recoveryCharacter
and recoveryCharacter:FindFirstChild("HumanoidRootPart")

local startToWater = math.huge
if recoveryRootAtStart then
startToWater = Vector3.new(
FIXED_WATER_RECOVERY_POINT.X - recoveryRootAtStart.Position.X,
0,
FIXED_WATER_RECOVERY_POINT.Z - recoveryRootAtStart.Position.Z
).Magnitude
end

-- If the fixed water is far away, first cross the map by LAND using
-- carcass-style grounded mini-waypoints. This is the anti-clipping leg.
local approachLandReached = true

if startToWater > 260 then
goatPrint(string.format(
"[AutoDrink] CARCASS-GROUND approach START | animal=%s | waterDistance=%.1f",
animalName,
startToWater
))

approachLandReached = monitoredMoveLikeSpawnBeach(
FIXED_LAND_RECOVERY_POINT,
"CARCASS-GROUND LAND APPROACH",
false,
true
)

goatPrint(string.format(
"[AutoDrink] CARCASS-GROUND approach END | animal=%s | reached=%s",
animalName,
tostring(approachLandReached)
))
end

if player.Character ~= recoveryCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
then
finishFixedRecovery()
return
end

local reachedWater = false

if approachLandReached then
reachedWater = monitoredMoveLikeSpawnBeach(
FIXED_WATER_RECOVERY_POINT,
"FIXED WATER ENTRY",
false,
false
)
else
goatWarn(string.format(
"[AutoDrink] Ground approach failed — fixed-water entry cancelled | animal=%s",
animalName
))
end

if reachedWater then
local waterRoot = character:FindFirstChild("HumanoidRootPart")

goatPrint(string.format(
"[AutoDrink] FIXED WATER reached | animal=%s | state=%s | replicated=%s | y=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState")),
waterRoot and string.format("%.1f", waterRoot.Position.Y) or "nil"
))

-- Let Savannah process the physical arrival before leaving again.
task.wait(1.50)

if player.Character ~= recoveryCharacter
or shared._fixedWaterLandRecoveryGeneration ~= recoveryGeneration
then
goatWarn(string.format(
"[AutoDrink] FIXED recovery cancelled after water | animal=%s | character changed",
animalName
))
finishFixedRecovery()
return
end

local reachedLand = monitoredMoveLikeSpawnBeach(
FIXED_LAND_RECOVERY_POINT,
"FIXED LAND EXIT",
false,
false
)

local finalRoot = character:FindFirstChild("HumanoidRootPart")
local finalHum = character:FindFirstChildOfClass("Humanoid")

goatPrint(string.format(
"[AutoDrink] FIXED WATER->LAND recovery END | animal=%s | waterReached=%s | landReached=%s | state=%s | replicated=%s | floor=%s | y=%s",
animalName,
tostring(reachedWater),
tostring(reachedLand),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState")),
tostring(finalHum and finalHum.FloorMaterial or "nil"),
finalRoot and string.format("%.1f", finalRoot.Position.Y) or "nil"
))

finishFixedRecovery()
else
goatWarn(string.format(
"[AutoDrink] FIXED WATER recovery FAILED | animal=%s",
animalName
))
finishFixedRecovery()
end

end
end
end

if shared._autoDrinkOwnerGeneration == AUTO_DRINK_OWNER_GENERATION
and myReturnToken == returnToLandToken
and player.Character == character
then
savedLandPosition = nil
returningToLand = false
character:SetAttribute("_returningToLand", false)
shared._autoDrinkLastLandReturnAt = os.clock()
goatPrint("[AutoDrink] Return to land complete — Carcass released")
SetGoatHudStatus("Auto Drink", "Retorno para terra concluído", Color3.fromRGB(0, 170, 255))
end
end)
end

-- Normal AutoDrink route state.
-- The fixed WATER->LAND recovery above remains emergency-only.
local savedDrinkShorePoint = nil
local savedDrinkPoint = nil
local autoDrinkApproachActive = false
local autoDrinkShoreReturnActive = false
local autoDrinkRouteGeneration = 0
local lastSafeWaterSearchAt = 0

-- Track which exact character owns the current AutoDrink state.
-- Without this, a Grow/slot/animal change can leave a stale approach or
-- Drinking latch blocking the next character from searching for water.
local autoDrinkApproachCharacter = nil
local autoDrinkApproachStartedAt = 0
local autoDrinkShoreReturnCharacter = nil
local drinkCommandCharacter = nil
local lastAutoDrinkCharacter = nil

local AUTO_DRINK_APPROACH_HARD_TIMEOUT = 150

-- AutoDrink-only soft watchdog:
-- if an approach lock is active but this same character stays Idling/1
-- and barely moves for several seconds, treat only that route as stale.
local autoDrinkIdleStallCharacter = nil
local autoDrinkIdleStallSince = 0
local autoDrinkIdleStallPosition = nil
local AUTO_DRINK_IDLE_STALL_TIME = 5.0
local AUTO_DRINK_IDLE_STALL_DISTANCE = 1.25

-- Drinking substate command lock.
-- WhileChecked can run many times per second; without a latch it spams
-- ChangeCharacterSubState("Drinking") and immediately re-enables substate
-- changes on the next tick.
local drinkCommandLatched = false
local drinkCommandIssuedAt = 0
local drinkCommandWaterAtIssue = 0
local drinkCommandLastWater = 0
local drinkCommandLastProgressAt = 0

local AUTO_DRINK_COMMAND_MIN_HOLD = 1.25
local AUTO_DRINK_COMMAND_STALL_TIMEOUT = 6.0

local AUTO_DRINK_SEARCH_COOLDOWN = 4.0
local AUTO_DRINK_MAX_ENTRY = 4.0
local AUTO_DRINK_MAX_DEPTH = 6.5
local AUTO_DRINK_SHORE_SLOPE = 0.50
local AUTO_DRINK_ARRIVAL = 5.0

local drinkWaterParams = RaycastParams.new()
drinkWaterParams.FilterType = Enum.RaycastFilterType.Include
drinkWaterParams.FilterDescendantsInstances = { workspace.Terrain }
drinkWaterParams.IgnoreWater = false

local drinkGroundParams = RaycastParams.new()
drinkGroundParams.FilterType = Enum.RaycastFilterType.Include
drinkGroundParams.FilterDescendantsInstances = { workspace.Terrain }
drinkGroundParams.IgnoreWater = true

local function flatDistance(a, b)
return Vector3.new(a.X - b.X, 0, a.Z - b.Z).Magnitude
end

local function castGroundOnlyAt(x, z, referenceY)
local originY = (referenceY or 0) + 140

return workspace:Raycast(
Vector3.new(x, originY, z),
Vector3.new(0, -360, 0),
drinkGroundParams
)
end

-- Savannah Life can expose water in TWO ways:
-- 1) Terrain material Water
-- 2) a physical MainWaterPart plane
--
-- Return a normalized water sample so the rest of AutoDrink does not care
-- which representation the map is currently using.
local function getAutoDrinkWaterSampleAt(x, z, referenceY)
local originY = (referenceY or 0) + 140

local terrainHit = workspace:Raycast(
Vector3.new(x, originY, z),
Vector3.new(0, -360, 0),
drinkWaterParams
)

local terrainWaterY = nil

if terrainHit and terrainHit.Material == Enum.Material.Water then
terrainWaterY = terrainHit.Position.Y
end

local partWaterY = getMainWaterSurfaceYAt(x, z)

local waterY = terrainWaterY

if partWaterY and (waterY == nil or partWaterY > waterY) then
waterY = partWaterY
end

if waterY == nil then
return nil
end

-- MainWaterPart can extend underneath dry land, so verify that Terrain
-- ground is actually below the water surface before calling this X/Z wet.
local groundHit = castGroundOnlyAt(x, z, math.max(referenceY or waterY, waterY))
local groundY = groundHit and groundHit.Position.Y or nil

if groundY and groundY >= waterY - 0.20 then
return nil
end

return {
Position = Vector3.new(x, waterY, z),
Material = Enum.Material.Water,
WaterY = waterY,
GroundY = groundY,
Source = terrainWaterY and "TerrainWater" or "MainWaterPart",
GroundHit = groundHit,
}
end

local function castTerrainTopAt(x, z, referenceY)
return getAutoDrinkWaterSampleAt(x, z, referenceY)
end

local function getWaterDepthAt(x, z, referenceY)
local sample = getAutoDrinkWaterSampleAt(x, z, referenceY)

if not sample then
return nil, nil, nil
end

local waterY = sample.WaterY
local groundY = sample.GroundY

if groundY == nil then
local ground = castGroundOnlyAt(x, z, waterY)

if ground then
groundY = ground.Position.Y
end
end

if groundY == nil then
return nil, waterY, sample.Position
end

return waterY - groundY, waterY, sample.Position
end

local function isSubmergedForAutoDrink(character)
if not character then return true, 'no-character' end
local root = character:FindFirstChild('HumanoidRootPart')
if not root then return true, 'no-root' end

local movementState = tostring(character:GetAttribute('MovementState') or '')
local replicatedState = tonumber(character:GetAttribute('ReplicatedMovementState'))

if movementState == 'Swimming' or replicatedState == 7 then
return true, 'Swimming/7'
end

local top = castTerrainTopAt(root.Position.X, root.Position.Z, root.Position.Y)
if top and top.Material == Enum.Material.Water then
local waterSurfaceY = top.Position.Y
if root.Position.Y < waterSurfaceY - 2.5 then
return true, string.format('root-below-water %.1f<%.1f', root.Position.Y, waterSurfaceY)
end
end

return false, nil
end

local function collectNearbyWaterCandidates(origin)
local candidates = {}
-- Search progressively farther away. The previous detector stopped at
-- 384 studs, so water beyond that distance was invisible to AutoDrink.
-- 1200 matches the long-range philosophy already used by Auto Carcass.
local radii = {
12, 22, 36, 52, 74, 100, 136, 180,
235, 300, 384, 500, 650, 800, 1000, 1200
}
local directions = 16

for _, radius in ipairs(radii) do
for i = 0, directions - 1 do
local angle = (math.pi * 2) * (i / directions)
local x = origin.X + math.cos(angle) * radius
local z = origin.Z + math.sin(angle) * radius
local hit = castTerrainTopAt(x, z, origin.Y)

if hit and hit.Material == Enum.Material.Water then
candidates[#candidates + 1] = {
water = hit.Position,
distance = flatDistance(origin, hit.Position),
source = hit.Source or "UnknownWater",
}
end
end
end

table.sort(candidates, function(a, b)
return a.distance < b.distance
end)

return candidates
end

-- MainWaterPart direct fallback.
-- This does NOT replace the normal 12..1200 ring scanner.
-- It is used only when that scanner returns zero candidates.
--
-- Savannah's MainWaterPart can also exist underneath dry Terrain, so every
-- geometry-derived point is still validated by getAutoDrinkWaterSampleAt().
local MAIN_WATER_DIRECT_EDGE_INSETS = { 4, 12, 24, 48, 96 }
local MAIN_WATER_DIRECT_TANGENT_OFFSETS = {
0,
64, -64,
128, -128,
256, -256,
384, -384,
512, -512,
768, -768,
1024, -1024,
}
local MAIN_WATER_DIRECT_MAX_CANDIDATES = 18
local function collectDirectMainWaterCandidates(origin)
local waterPart = getMainWaterPartForCarcassFilter()
if not waterPart or not waterPart.Parent then
return {}
end

local halfX = math.max(1, (waterPart.Size.X * 0.5) - 2)
local halfZ = math.max(1, (waterPart.Size.Z * 0.5) - 2)

-- Work in MainWaterPart local X/Z so translated/rotated water planes
-- remain valid.
local localOrigin3 = waterPart.CFrame:PointToObjectSpace(
Vector3.new(origin.X, waterPart.Position.Y, origin.Z)
)
local lx = localOrigin3.X
local lz = localOrigin3.Z

local outsideX = math.abs(lx) > halfX
local outsideZ = math.abs(lz) > halfZ

local edgeX = math.clamp(lx, -halfX, halfX)
local edgeZ = math.clamp(lz, -halfZ, halfZ)

local inward

if outsideX and outsideZ then
-- Animal is outside a corner of MainWaterPart.
inward = Vector3.new(
lx > 0 and -1 or 1,
0,
lz > 0 and -1 or 1
).Unit
elseif outsideX then
-- Closest face is the +/-X edge.
inward = Vector3.new(lx > 0 and -1 or 1, 0, 0)
elseif outsideZ then
-- Closest face is the +/-Z edge.
inward = Vector3.new(0, 0, lz > 0 and -1 or 1)
else
-- Animal X/Z is already inside the MainWaterPart rectangle, but the
-- Terrain under it may still be dry. Use the nearest rectangle edge as
-- a deterministic starting side and probe just inside that side.
local dx = halfX - math.abs(lx)
local dz = halfZ - math.abs(lz)

if dx <= dz then
edgeX = lx >= 0 and halfX or -halfX
edgeZ = math.clamp(lz, -halfZ, halfZ)
inward = Vector3.new(lx >= 0 and -1 or 1, 0, 0)
else
edgeX = math.clamp(lx, -halfX, halfX)
edgeZ = lz >= 0 and halfZ or -halfZ
inward = Vector3.new(0, 0, lz >= 0 and -1 or 1)
end
end

local tangent = Vector3.new(-inward.Z, 0, inward.X)
local candidates = {}
local seen = {}

for _, tangentOffset in ipairs(MAIN_WATER_DIRECT_TANGENT_OFFSETS) do
for _, inset in ipairs(MAIN_WATER_DIRECT_EDGE_INSETS) do
local localPoint =
Vector3.new(edgeX, 0, edgeZ)
+ inward * inset
+ tangent * tangentOffset

localPoint = Vector3.new(
math.clamp(localPoint.X, -halfX, halfX),
waterPart.Size.Y * 0.5,
math.clamp(localPoint.Z, -halfZ, halfZ)
)

local worldPoint = waterPart.CFrame:PointToWorldSpace(localPoint)

-- A geometric MainWaterPart point is not automatically water because
-- Terrain can sit above the water plane. Validate actual exposed water.
local sample = getAutoDrinkWaterSampleAt(
worldPoint.X,
worldPoint.Z,
origin.Y
)

if sample then
local key =
tostring(math.floor(sample.Position.X * 2 + 0.5))
.. ":"
.. tostring(math.floor(sample.Position.Z * 2 + 0.5))

if not seen[key] then
seen[key] = true
candidates[#candidates + 1] = {
water = sample.Position,
distance = flatDistance(origin, sample.Position),
source = "MainWaterPartDirect",
}
end
end
end
end

table.sort(candidates, function(a, b)
return a.distance < b.distance
end)

while #candidates > MAIN_WATER_DIRECT_MAX_CANDIDATES do
table.remove(candidates)
end

return candidates
end

local function findSafeShoreFromWater(origin, waterPosition, humanoid)
local towardLand = Vector3.new(
origin.X - waterPosition.X,
0,
origin.Z - waterPosition.Z
)

if towardLand.Magnitude < 1 then
return nil
end

towardLand = towardLand.Unit

local lastWaterPoint = waterPosition

-- Walk from the detected water point toward the animal until exposed water
-- becomes dry Terrain. Props/trees/rocks are ignored because land sampling
-- is Terrain-only.
for distance = 1.5, 140, 1.5 do
local samplePos = waterPosition + towardLand * distance

local waterSample = getAutoDrinkWaterSampleAt(
samplePos.X,
samplePos.Z,
math.max(origin.Y, waterPosition.Y)
)

if waterSample then
lastWaterPoint = waterSample.Position
else
local groundHit = castGroundOnlyAt(
samplePos.X,
samplePos.Z,
math.max(origin.Y, waterPosition.Y)
)

if groundHit
and groundHit.Material ~= Enum.Material.Water
and groundHit.Normal
and groundHit.Normal.Y >= AUTO_DRINK_SHORE_SLOPE
then
local lift = math.max((humanoid and humanoid.HipHeight or 2.4), 2.4)
local shorePoint = groundHit.Position + Vector3.new(0, lift, 0)

local intoWater = Vector3.new(
lastWaterPoint.X - shorePoint.X,
0,
lastWaterPoint.Z - shorePoint.Z
)

if intoWater.Magnitude < 0.75 then
intoWater = Vector3.new(
waterPosition.X - shorePoint.X,
0,
waterPosition.Z - shorePoint.Z
)
end

if intoWater.Magnitude >= 0.75 then
local verticalDelta = math.abs(shorePoint.Y - origin.Y)

if verticalDelta <= 30.0 then
return {
shorePoint = shorePoint,
intoWater = intoWater.Unit,
waterSurface = lastWaterPoint,
distance = flatDistance(origin, shorePoint),
}
elseif distance <= 3.1 then
goatPrint(string.format(
"[AutoDrink] Shore candidate rejected | vertical delta=%.1f studs | shoreY=%.1f | currentY=%.1f",
verticalDelta,
shorePoint.Y,
origin.Y
))
end
end
end
end
end

return nil
end

local function findNearestSafeDrinkRoute(character)
local root = character and character:FindFirstChild('HumanoidRootPart')
local humanoid = character and character:FindFirstChildOfClass('Humanoid')
if not root or not humanoid then return nil end

local origin = root.Position

if shared._characterTransitionLock == true then
goatPrint(
'[AutoDrink] PAUSED • character transition owner='
.. tostring(shared._characterTransitionOwner or '?')
.. ' • target='
.. tostring(shared._characterTransitionTarget or '?')
)
return nil
end

goatPrint('[AutoDrink] Searching nearby water...')
local candidates = collectNearbyWaterCandidates(origin)

if #candidates == 0 then
goatPrint('[AutoDrink] No nearby water found (Terrain/MainWaterPart) — trying MainWaterPart direct fallback')

local directCandidates = collectDirectMainWaterCandidates(origin)

if #directCandidates > 0 then
goatPrint(string.format(
"[AutoDrink] MainWaterPart direct fallback found %d valid water candidate(s) | nearest=%.1f",
#directCandidates,
directCandidates[1].distance
))

for _, candidate in ipairs(directCandidates) do
candidates[#candidates + 1] = candidate
end
else
goatPrint('[AutoDrink] MainWaterPart fallback found no exposed water in current validated sweep')
return nil
end
end

local best = nil
local bestDistance = math.huge
local fallbackRoute = nil
local fallbackDistance = math.huge
local maxCandidates = math.min(#candidates, 24)

for i = 1, maxCandidates do
local candidate = candidates[i]
goatPrint(string.format(
"[AutoDrink] Water candidate | source=%s | distance=%.1f",
tostring(candidate.source),
candidate.distance
))
local route = findSafeShoreFromWater(origin, candidate.water, humanoid)

if route
and shared._goatAutoDrinkRejectedShorePoint
and os.clock() < (tonumber(shared._goatAutoDrinkRejectedShoreUntil) or 0)
and flatDistance(route.shorePoint, shared._goatAutoDrinkRejectedShorePoint) <= 30.0
then
goatPrint(string.format(
"[AutoDrink] Shore candidate skipped | recently rejected region | distance=%.1f",
flatDistance(route.shorePoint, shared._goatAutoDrinkRejectedShorePoint)
))
route = nil
end

if route then
shared._goatAutoDrinkShoreFailureMemory =
shared._goatAutoDrinkShoreFailureMemory or {}

local memoryNow = os.clock()

for memoryKey, memoryInfo in pairs(shared._goatAutoDrinkShoreFailureMemory) do
if type(memoryInfo) ~= "table"
or memoryNow - (tonumber(memoryInfo.last) or 0) > 300
then
shared._goatAutoDrinkShoreFailureMemory[memoryKey] = nil
elseif memoryNow < (tonumber(memoryInfo.untilTime) or 0)
and memoryInfo.point
and flatDistance(route.shorePoint, memoryInfo.point) <= 35.0
then
goatPrint(string.format(
"[AutoDrink] Shore candidate skipped | failure-memory | failures=%d | cooldown=%.0fs",
tonumber(memoryInfo.count) or 1,
math.max(0, (tonumber(memoryInfo.untilTime) or memoryNow) - memoryNow)
))
route = nil
break
end
end
end

-- PREVALIDATE SHORE:
-- Do not walk hundreds of studs to a shore that has no actual drinkable
-- water geometry within the same 1-4 stud inward window used on arrival.
-- This is geometry-only; CanStartEatDrink is still confirmed after arrival.
if route then
local prevalidatedEntry = nil
local prevalidatedDepth = nil

for entryDistance = 1.0, AUTO_DRINK_MAX_ENTRY, 1.0 do
local candidateXZ = route.shorePoint + route.intoWater * entryDistance
local depth = getWaterDepthAt(
candidateXZ.X,
candidateXZ.Z,
route.shorePoint.Y
)

if depth and depth <= AUTO_DRINK_MAX_DEPTH then
prevalidatedEntry = entryDistance
prevalidatedDepth = depth
break
end
end

if not prevalidatedEntry then
goatPrint(string.format(
"[AutoDrink] Shore candidate pre-rejected | no shallow water within 1-4 studs | distance=%.1f",
route.distance or -1
))

-- Keep the nearest otherwise-safe shore as a LAST LOCAL FALLBACK.
-- It may still be directly drinkable once the animal physically reaches it
-- because CanStartEatDrink(character, true) can succeed from the shore.
if (route.distance or math.huge) < fallbackDistance then
fallbackRoute = route
fallbackDistance = route.distance or math.huge
end

route = nil
else
route.prevalidatedEntry = prevalidatedEntry
route.prevalidatedDepth = prevalidatedDepth
end
end

if route and route.distance < bestDistance then
best = route
bestDistance = route.distance
end
end

if not best and fallbackRoute then
best = fallbackRoute
goatPrint(string.format(
"[AutoDrink] No prevalidated shore found — using nearest safe-shore fallback | distance=%.1f",
fallbackDistance
))
end

if best then
goatPrint(string.format(
'[AutoDrink] Safe shore found | distance=%.1f | shore=(%.1f, %.1f, %.1f)',
best.distance,
best.shorePoint.X,
best.shorePoint.Y,
best.shorePoint.Z
))
end

return best
end

local function shortNaturalMove(character, target, timeout)
if not character or player.Character ~= character then return false end
local root = character:FindFirstChild('HumanoidRootPart')
local humanoid = character:FindFirstChildOfClass('Humanoid')
if not root or not humanoid or humanoid.Health <= 0 then return false end

if root.Anchored then root.Anchored = false end
local start = root.Position
humanoid:MoveTo(target)

local deadline = os.clock() + (timeout or 4.0)
local probeDeadline = os.clock() + 1.15

while os.clock() < deadline do
if player.Character ~= character then return false end
root = character:FindFirstChild('HumanoidRootPart')
humanoid = character:FindFirstChildOfClass('Humanoid')
if not root or not humanoid or humanoid.Health <= 0 then return false end

if flatDistance(root.Position, target) <= 2.2 then return true end
if os.clock() >= probeDeadline and flatDistance(root.Position, start) < 1.2 then break end
task.wait(0.10)
end

local ok, result = pcall(function()
local shortMoveAnimalName = tostring(character:GetAttribute("AnimalName") or "")
if shortMoveAnimalName == "Brachiosaurus" then
return Animal.WalkToAsync(
CFrame.new(target),
{ groundedRecovery = true }
)
end
return Animal.WalkToAsync(CFrame.new(target))
end)
return ok and result ~= false
end

local function moveToDrinkShore(character, shorePoint, myGeneration)
if not character or not shorePoint then return false end
if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or autoDrinkRouteGeneration ~= myGeneration
or player.Character ~= character then
return false
end

goatPrint('[AutoDrink] Moving to shore using Carcass-ground')
local ok, result = pcall(function()
return Animal.WalkToAsync(CFrame.new(shorePoint), { groundedRecovery = true })
end)

if not ok or result == false then
goatWarn('[AutoDrink] Shore movement failed')
return false
end

local root = character:FindFirstChild('HumanoidRootPart')
if not root then return false end
local arrived = flatDistance(root.Position, shorePoint) <= AUTO_DRINK_ARRIVAL
if arrived then
goatPrint(string.format('[AutoDrink] Shore reached | distance=%.1f', flatDistance(root.Position, shorePoint)))
end
return arrived
end

local function tryEnterShallowDrinkPoint(character, route, myGeneration)
if not character or not route then return false end
local root = character:FindFirstChild('HumanoidRootPart')
if not root then return false end

local availableAtShore = CanStartEatDrink(character, true)

-- DL/TRex juvenile fix:
-- The game can report Drink as available from shore even though Water does not
-- actually increase. For young TRexes, do not trust the shore result; force a
-- real inward-water position using the normal 1-4 stud checks (and DL fallback).
local animalName = tostring(character:GetAttribute("AnimalName") or "")
local growth = tonumber(character:GetAttribute("Growth")) or tonumber(character:GetAttribute("GrowthPercentage")) or 1
local dlYoungTRex =
game.GameId == 8198412649
and animalName == "TRex"
and growth < 0.25

if availableAtShore == 'Drink' and not dlYoungTRex then
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
character:SetAttribute("_autoDrinkInvalidShoreUntil", nil)
shared._goatAutoDrinkRejectedShorePoint = nil
shared._goatAutoDrinkRejectedShoreUntil = nil
goatPrint('[AutoDrink] Drinking available directly from shore')
return true
elseif availableAtShore == 'Drink' and dlYoungTRex then
goatPrint(string.format(
"[AutoDrink] [DL] Juvenile TRex shore Drink ignored | growth=%.1f%% | forcing inward water check",
growth * 100
))
end

local entryDistances = dlYoungTRex
and { 2.0, 3.0, 4.0, 4.5, 5.0, 5.5, 6.0 }
or { 1.0, 2.0, 3.0, 4.0 }

for _, entryDistance in ipairs(entryDistances) do
if (not dlYoungTRex) and entryDistance > AUTO_DRINK_MAX_ENTRY then break end
if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or autoDrinkRouteGeneration ~= myGeneration
or player.Character ~= character then
return false
end

local candidateXZ = route.shorePoint + route.intoWater * entryDistance
local depth, waterSurfaceY = getWaterDepthAt(candidateXZ.X, candidateXZ.Z, route.shorePoint.Y)

if not depth then
goatPrint(string.format('[AutoDrink] Drink point rejected | %.1f studs inward | no water', entryDistance))
elseif depth > AUTO_DRINK_MAX_DEPTH then
goatPrint(string.format('[AutoDrink] Drink point rejected | too deep | entry=%.1f | depth=%.1f', entryDistance, depth))
else
root = character:FindFirstChild('HumanoidRootPart')
if not root then return false end

local targetY = root.Position.Y
if waterSurfaceY then targetY = math.max(targetY, waterSurfaceY - 0.5) end
local drinkPoint = Vector3.new(candidateXZ.X, targetY, candidateXZ.Z)

goatPrint(string.format('[AutoDrink] Entering shallow drink point | entry=%.1f | depth=%.1f', entryDistance, depth))
local moved = shortNaturalMove(character, drinkPoint, 3.5)

if moved then
task.wait(0.30)
local submerged, reason = isSubmergedForAutoDrink(character)
if submerged then
goatPrint(string.format('[AutoDrink] Drink point rejected | submerged | reason=%s', tostring(reason)))
shortNaturalMove(character, route.shorePoint, 4.0)
return false
end

local available = CanStartEatDrink(character, true)
if available == 'Drink' then
if dlYoungTRex then
local waterBefore = tonumber(character:GetAttribute("Water")) or 0

goatPrint(string.format(
"[AutoDrink] [DL] Baby TRex validating real drink | entry=%.1f | waterBefore=%.1f%%",
entryDistance,
waterBefore
))

ChangeCharacterSubState('Drinking')
task.wait(2.0)

if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or autoDrinkRouteGeneration ~= myGeneration
or player.Character ~= character then
return false
end

local waterAfter = tonumber(character:GetAttribute("Water")) or waterBefore
local waterGain = waterAfter - waterBefore

if waterGain > 0.10 then
root = character:FindFirstChild('HumanoidRootPart')
if root then
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
end
character:SetAttribute("_autoDrinkInvalidShoreUntil", nil)
shared._goatAutoDrinkRejectedShorePoint = nil
shared._goatAutoDrinkRejectedShoreUntil = nil

goatPrint(string.format(
"[AutoDrink] [DL] Baby TRex drink CONFIRMED | entry=%.1f | %.1f%% -> %.1f%% | gain=%.1f%%",
entryDistance,
waterBefore,
waterAfter,
waterGain
))
return true
else
goatPrint(string.format(
"[AutoDrink] [DL] Baby TRex drink FAILED | entry=%.1f | %.1f%% -> %.1f%% | moving deeper",
entryDistance,
waterBefore,
waterAfter
))

-- Movement to the next micro-step will naturally interrupt the false Drinking state.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
end
else
root = character:FindFirstChild('HumanoidRootPart')
if root then
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
end
character:SetAttribute("_autoDrinkInvalidShoreUntil", nil)
shared._goatAutoDrinkRejectedShorePoint = nil
shared._goatAutoDrinkRejectedShoreUntil = nil
goatPrint(string.format('[AutoDrink] Safe drink point ready | entry=%.1f | depth=%.1f', entryDistance, depth))
return true
end
end
end
end
end

-- Dino Life fallback:
-- Some DL dinosaurs (including TRex) need to physically step a little farther
-- into the water before the game's Drink interaction becomes available.
-- This branch is DL-only; SL/JL keep the exact original 1-4 stud behavior.
if game.GameId == 8198412649 and not dlYoungTRex then
goatPrint("[AutoDrink] [DL] Standard shallow entry failed — trying extended micro-steps")

local dlEntryDistances = { 4.5, 5.0, 5.5, 6.0 }

for _, entryDistance in ipairs(dlEntryDistances) do
if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION
or autoDrinkRouteGeneration ~= myGeneration
or player.Character ~= character then
return false
end

local candidateXZ = route.shorePoint + route.intoWater * entryDistance
local depth, waterSurfaceY = getWaterDepthAt(
candidateXZ.X,
candidateXZ.Z,
route.shorePoint.Y
)

if depth and depth <= AUTO_DRINK_MAX_DEPTH then
root = character:FindFirstChild('HumanoidRootPart')
if not root then return false end

local targetY = root.Position.Y
if waterSurfaceY then
targetY = math.max(targetY, waterSurfaceY - 0.5)
end

local drinkPoint = Vector3.new(candidateXZ.X, targetY, candidateXZ.Z)

goatPrint(string.format(
"[AutoDrink] [DL] Extended drink step | entry=%.1f | depth=%.1f",
entryDistance,
depth
))

local moved = shortNaturalMove(character, drinkPoint, 2.5)

if moved then
task.wait(0.20)

root = character:FindFirstChild('HumanoidRootPart')
if not root then return false end

local actualDistance = flatDistance(root.Position, drinkPoint)
local available = CanStartEatDrink(character, true)

goatPrint(string.format(
"[AutoDrink] [DL] Extended step result | entry=%.1f | actualDist=%.2f | interaction=%s",
entryDistance,
actualDistance,
tostring(available)
))

if available == 'Drink' then
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
character:SetAttribute("_autoDrinkInvalidShoreUntil", nil)
shared._goatAutoDrinkRejectedShorePoint = nil
shared._goatAutoDrinkRejectedShoreUntil = nil

goatPrint(string.format(
"[AutoDrink] [DL] Drink unlocked by extended step | entry=%.1f",
entryDistance
))
return true
end

local submerged, reason = isSubmergedForAutoDrink(character)
if submerged then
goatPrint(string.format(
"[AutoDrink] [DL] Extended step stopped | submerged | reason=%s",
tostring(reason)
))
shortNaturalMove(character, route.shorePoint, 4.0)
break
end
end
end
end
end

goatPrint('[AutoDrink] No valid shallow drink point on this shore')

-- This shore has just proved unusable. Do not let the generic
-- CanStartEatDrink path immediately start Drinking here.
shared._goatAutoDrinkShoreFailureMemory =
shared._goatAutoDrinkShoreFailureMemory or {}

local shoreNow = os.clock()
local shoreKey =
tostring(math.floor(route.shorePoint.X / 20))
.. ":"
.. tostring(math.floor(route.shorePoint.Z / 20))

local shoreInfo = shared._goatAutoDrinkShoreFailureMemory[shoreKey]

if type(shoreInfo) ~= "table"
or shoreNow - (tonumber(shoreInfo.last) or 0) > 180
then
shoreInfo = {count = 0}
end

shoreInfo.count = math.min((tonumber(shoreInfo.count) or 0) + 1, 6)
shoreInfo.last = shoreNow
shoreInfo.point = route.shorePoint

local shoreRejectSeconds = math.min(60, 15 + ((shoreInfo.count - 1) * 10))
shoreInfo.untilTime = shoreNow + shoreRejectSeconds
shared._goatAutoDrinkShoreFailureMemory[shoreKey] = shoreInfo

shared._goatAutoDrinkRejectedShorePoint = route.shorePoint
shared._goatAutoDrinkRejectedShoreUntil = shoreInfo.untilTime
character:SetAttribute("_autoDrinkInvalidShoreUntil", shoreNow + 6.0)

goatPrint(string.format(
"[AutoDrink] Shore failure remembered | failures=%d | rejected=%.0fs",
shoreInfo.count,
shoreRejectSeconds
))

savedDrinkPoint = nil
savedWaterPosition = nil
savedDrinkShorePoint = nil
savedLandPosition = nil

shortNaturalMove(character, route.shorePoint, 4.0)
return false
end

local function startSafeDrinkApproach(character)
if not character then return false end

-- Clear only stale ownership. A live route for the SAME character remains protected.
if autoDrinkApproachActive then
local staleCharacter = autoDrinkApproachCharacter ~= character
local staleTimeout =
autoDrinkApproachStartedAt > 0
and (os.clock() - autoDrinkApproachStartedAt) > AUTO_DRINK_APPROACH_HARD_TIMEOUT

if staleCharacter or staleTimeout then
goatPrint(string.format(
"[AutoDrink] Clearing stale approach lock | characterChanged=%s | timeout=%s",
tostring(staleCharacter),
tostring(staleTimeout)
))

autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkApproachActive = false
autoDrinkApproachCharacter = nil
autoDrinkApproachStartedAt = 0
else
return false
end
end

if autoDrinkShoreReturnActive then
if autoDrinkShoreReturnCharacter ~= character then
goatPrint("[AutoDrink] Clearing stale shore-return lock after character change")
autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil
else
return false
end
end

if os.clock() - lastSafeWaterSearchAt < AUTO_DRINK_SEARCH_COOLDOWN then
return false
end

lastSafeWaterSearchAt = os.clock()
autoDrinkApproachActive = true
autoDrinkApproachCharacter = character
autoDrinkApproachStartedAt = os.clock()

autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
local myGeneration = autoDrinkRouteGeneration

task.spawn(function()
local function finish()
if autoDrinkRouteGeneration == myGeneration
and autoDrinkApproachCharacter == character
then
autoDrinkApproachActive = false
autoDrinkApproachCharacter = nil
autoDrinkApproachStartedAt = 0
end
end

if player.Character ~= character
or shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION then
finish()
return
end

local autoDrinkAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(autoDrinkAnimalName)

-- Mosasaurus survival is the opposite of terrestrial AutoDrink:
-- water is the safe state. Never return it to shore after detecting Swimming.
if fullyAquaticDL then
local root = character:FindFirstChild("HumanoidRootPart")
if not root then
finish()
return
end

local waterHere = getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
)

local movementState = tostring(character:GetAttribute("MovementState") or "")
local replicatedState = tonumber(character:GetAttribute("ReplicatedMovementState"))
local confirmedAquaticState =
movementState == "Swimming"
or replicatedState == 7

if waterHere or confirmedAquaticState then
character:SetAttribute("_drinkingToFull", false)
character:SetAttribute("_returningToLand", false)
returningToLand = false
savedDrinkShorePoint = nil
savedLandPosition = nil
shared._goatAutoDrinkWaterLeaseCharacter = character
shared._goatAutoDrinkWaterLeaseUntil = os.clock() + 4.0

if (tonumber(shared._goatMosasaurusWaterLogAt) or 0) + 8 < os.clock() then
shared._goatMosasaurusWaterLogAt = os.clock()
goatPrint("[AutoDrink][DL] Mosasaurus already in water — staying submerged")
end

finish()
return
end

local aquaticRoute = findNearestSafeDrinkRoute(character)
if not aquaticRoute then
goatPrint("[AutoDrink][DL] Mosasaurus is on land — no water route found yet")
finish()
return
end

shared._goatAutoDrinkWaterLeaseCharacter = character
shared._goatAutoDrinkWaterLeaseUntil = os.clock() + 45

goatPrint(string.format(
"[AutoDrink][DL] Mosasaurus emergency return to water | shoreDistance=%.1f",
tonumber(aquaticRoute.distance) or -1
))

-- Mosasaurus must not use the terrestrial shore approach.
-- Build one direct destination inside the water and swim/walk straight to it.
root = character:FindFirstChild("HumanoidRootPart")
if not root then
finish()
return
end

local inwardDistance = 8.0
local inwardXZ = aquaticRoute.shorePoint + aquaticRoute.intoWater * inwardDistance
local waterDepth, waterSurfaceY = getWaterDepthAt(
inwardXZ.X,
inwardXZ.Z,
aquaticRoute.shorePoint.Y
)

-- If 8 studs is not real water, try alternative inward distances.
if not waterDepth then
for _, testDistance in ipairs({ 6.0, 10.0, 12.0, 4.0 }) do
local testXZ = aquaticRoute.shorePoint + aquaticRoute.intoWater * testDistance
local testDepth, testSurfaceY = getWaterDepthAt(
testXZ.X,
testXZ.Z,
aquaticRoute.shorePoint.Y
)
if testDepth then
inwardDistance = testDistance
inwardXZ = testXZ
waterDepth = testDepth
waterSurfaceY = testSurfaceY
break
end
end
end

local targetY = root.Position.Y
if waterSurfaceY then
targetY = waterSurfaceY - 1.25
end
local waterTarget = Vector3.new(inwardXZ.X, targetY, inwardXZ.Z)

goatPrint(string.format(
"[AutoDrink][DL] Mosasaurus direct water entry | targetDistance=%.1f | inward=%.1f",
flatDistance(root.Position, waterTarget),
inwardDistance
))

local movedIntoWater = shortNaturalMove(character, waterTarget, 12.0)

if not movedIntoWater then
local walkOk, walkResult = pcall(function()
return Animal.WalkToAsync(
CFrame.lookAlong(
waterTarget,
Vector3.new(
waterTarget.X - root.Position.X,
0,
waterTarget.Z - root.Position.Z
).Unit
)
)
end)

if not walkOk or walkResult == false then
goatPrint("[AutoDrink][DL] Mosasaurus direct water movement failed — retrying")
finish()
return
end

task.wait(0.6)
end

root = character:FindFirstChild("HumanoidRootPart")
local confirmedWater = root and getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
) ~= nil

local movementStateAfter = tostring(character:GetAttribute("MovementState") or "")
local replicatedAfter = tonumber(character:GetAttribute("ReplicatedMovementState"))
confirmedWater =
confirmedWater
or movementStateAfter == "Swimming"
or replicatedAfter == 7

if confirmedWater then
character:SetAttribute("_drinkingToFull", false)
character:SetAttribute("_returningToLand", false)
returningToLand = false
autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkApproachActive = false
autoDrinkApproachCharacter = nil
autoDrinkApproachStartedAt = 0
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
savedDrinkShorePoint = nil
savedLandPosition = nil
goatPrint(string.format(
"[AutoDrink][DL] Mosasaurus back in water | inward=%.1f | depth=%s",
inwardDistance,
waterDepth and string.format("%.1f", waterDepth) or "?"
))
else
goatPrint("[AutoDrink][DL] Mosasaurus water entry not confirmed — retrying")
end

finish()
return
end

local submerged, reason = isSubmergedForAutoDrink(character)
if submerged then
goatPrint(string.format('[AutoDrink] Already submerged before drinking | reason=%s | returning to land', tostring(reason)))
finish()
beginReturnToLand(character)
return
end

local route = findNearestSafeDrinkRoute(character)
if not route then
goatPrint('[AutoDrink] No safe shore found — retrying later')
finish()
return
end

savedDrinkShorePoint = route.shorePoint
savedLandPosition = route.shorePoint

if not moveToDrinkShore(character, route.shorePoint, myGeneration) then
goatPrint('[AutoDrink] Safe shore approach failed — retrying later')
finish()
return
end

if not tryEnterShallowDrinkPoint(character, route, myGeneration) then
finish()
return
end

finish()
end)

return true
end

local function returnToSavedDrinkShore(character)
if autoDrinkShoreReturnActive or not character then return false end

if type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(character:GetAttribute("AnimalName"))
then
character:SetAttribute("_drinkingToFull", false)
character:SetAttribute("_returningToLand", false)
returningToLand = false
savedDrinkShorePoint = nil
savedLandPosition = nil
goatPrint("[AutoDrink][DL] Mosasaurus shore-return blocked — remaining in water")
return true
end

local shorePoint = savedDrinkShorePoint or savedLandPosition
if not shorePoint then
beginReturnToLand(character)
return false
end

autoDrinkShoreReturnActive = true
autoDrinkShoreReturnCharacter = character
autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
local myGeneration = autoDrinkRouteGeneration

-- Shared lease prevents another Water Escape worker in this client from
-- taking movement ownership while AutoDrink is returning from the water.
shared._goatAutoDrinkWaterLeaseCharacter = character
shared._goatAutoDrinkWaterLeaseUntil = os.clock() + 45

-- Returning to shore does NOT necessarily mean Water is full.
-- If we were forced out because Swimming/7 was detected, keep the
-- drink-to-full ownership latched so Carcass cannot steal movement.
local returnWaterAtStart = tonumber(character:GetAttribute("Water")) or 0
local returnWasFullAtStart = returnWaterAtStart >= 99.9
character:SetAttribute('_drinkingToFull', not returnWasFullAtStart)
SetClientSubStateChangesEnabled(true)

task.spawn(function()
if returnWasFullAtStart then
goatPrint('[AutoDrink] Water full')
else
goatPrint(string.format(
'[AutoDrink] Returning to shore before full | water=%.1f%% | will retry after safe land',
returnWaterAtStart
))
end
goatPrint('[AutoDrink] Returning to saved shore')
Animal.CancelTween(true)
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
local moved = shortNaturalMove(character, shorePoint, 5.5)

if autoDrinkRouteGeneration ~= myGeneration or player.Character ~= character then
autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil
return
end

task.wait(0.65)
local state = tostring(character:GetAttribute('MovementState') or '')
local replicated = tonumber(character:GetAttribute('ReplicatedMovementState'))

goatPrint(string.format(
'[AutoDrink] Shore return complete | moved=%s | state=%s | replicated=%s',
tostring(moved), state, tostring(replicated)
))

savedDrinkPoint = nil
savedWaterPosition = nil

if state == 'Swimming' or replicated == 7 then
goatPrint('[AutoDrink] Swimming/7 detected after exit — emergency recovery')
autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil
savedLandPosition = shorePoint

shared._goatAutoDrinkWaterLeaseCharacter = character
shared._goatAutoDrinkWaterLeaseUntil = os.clock() + 180

beginReturnToLand(character)
return
end

local waterAfterReturn = tonumber(character:GetAttribute("Water")) or 0
local drinkActuallyFull = waterAfterReturn >= 99.9

savedDrinkPoint = nil
savedWaterPosition = nil
savedDrinkShorePoint = nil
savedLandPosition = nil
returningToLand = false
character:SetAttribute('_returningToLand', false)
shared._autoDrinkLastLandReturnAt = os.clock()
autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil

shared._goatAutoDrinkWaterLeaseCharacter = character
shared._goatAutoDrinkWaterLeaseUntil = os.clock() + 1.5

if drinkActuallyFull then
character:SetAttribute('_drinkingToFull', false)
goatPrint("[SurvivalLock] WATER PRIORITY OFF | Water full | AutoEat resumed")
SetGoatHudStatus('Auto Drink', 'Retorno para margem concluído', Color3.fromRGB(0, 170, 255))
else
-- We only returned because the chosen drink point became submerged/Swimming.
-- Keep water ownership and immediately allow the normal AutoDrink worker to
-- choose a different shore. Do NOT announce "Water full".
character:SetAttribute('_drinkingToFull', true)
goatPrint(string.format(
"[SurvivalLock] WATER PRIORITY CONTINUES | Water %.1f%% | safe shore reached, searching another drink point",
waterAfterReturn
))
SetGoatHudStatus(
'Auto Drink',
string.format('Água %.0f%% • procurando outro ponto seguro', waterAfterReturn),
Color3.fromRGB(0, 170, 255)
)
end
end)

return true
end

-- ============================================================
-- DL MOSASAURUS WATER RESIDENCY
-- Mosasaurus loses survival stats rapidly on land, so do not wait for
-- Water <= 80%. If it is physically outside water, immediately reuse the
-- protected AutoDrink route to return it to water.
-- ============================================================
task.spawn(function()
local lastForceAt = 0

-- Mosasaurus can remain submerged only for a limited time before it needs air.
-- Keep the breathing cycle conservative for AFK safety.
shared._goatMosasaurusSubmergedSince = nil
shared._goatMosasaurusBreathing = false
shared._goatMosasaurusLastBreathAt = 0

while shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
task.wait(0.75)

local ch = player.Character
if ch and ch.Parent
and type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(ch:GetAttribute("AnimalName"))
then
local hum = ch:FindFirstChildOfClass("Humanoid")
local root = ch:FindFirstChild("HumanoidRootPart")

if hum and root and hum.Health > 0
and shared._inGrowthReset ~= true
and not ch:GetAttribute("_returningToLand")
then
local waterHere = getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
)

local movementState = tostring(ch:GetAttribute("MovementState") or "")
local replicatedState = tonumber(ch:GetAttribute("ReplicatedMovementState"))
local alreadyAquatic =
waterHere ~= nil
or movementState == "Swimming"
or replicatedState == 7

if alreadyAquatic then
if shared._goatMosasaurusSubmergedSince == nil then
shared._goatMosasaurusSubmergedSince = os.clock()
end

local submergedFor = os.clock() - (tonumber(shared._goatMosasaurusSubmergedSince) or os.clock())

-- Surface roughly every 22 seconds. Hold close to the surface for 4 seconds,
-- then release movement so Carcass/AFK can resume naturally.
if submergedFor >= 22
and shared._goatMosasaurusBreathing ~= true
and os.clock() - (tonumber(shared._goatMosasaurusLastBreathAt) or 0) >= 8
then
shared._goatMosasaurusBreathing = true
shared._goatMosasaurusLastBreathAt = os.clock()
shared._goatMosasaurusSubmergedSince = os.clock()

stopCarcassMovement(ch)
ch:SetAttribute("_carcassInteractionLock", false)

local surfaceY = getWaterSurfaceYAt(root.Position.X, root.Position.Z, root.Position.Y)
if surfaceY then
local oldY = root.Position.Y
local breatheTarget = Vector3.new(
root.Position.X,
surfaceY - 0.45,
root.Position.Z
)

goatPrint(string.format(
"[Mosasaurus][DL] BREATHING | submerged=%.1fs | rising %.1f studs",
submergedFor,
math.max(0, breatheTarget.Y - oldY)
))
SetGoatHudStatus(
"Mosasaurus",
"Subindo para respirar • aguarde",
Color3.fromRGB(0, 170, 255)
)

local flatLook = root.CFrame.LookVector
flatLook = Vector3.new(flatLook.X, 0, flatLook.Z)
if flatLook.Magnitude < 0.01 then
flatLook = Vector3.new(0, 0, -1)
else
flatLook = flatLook.Unit
end

Animal.TweenTo(CFrame.lookAlong(breatheTarget, flatLook), 7)

local breathDeadline = os.clock() + 4.0
while os.clock() < breathDeadline
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and player.Character == ch
and ch.Parent
do
task.wait(0.20)
end

goatPrint("[Mosasaurus][DL] BREATH COMPLETE | returning control to survival workers")
SetGoatHudStatus(
"Mosasaurus",
"Respiração concluída • sobrevivência retomada",
Color3.fromRGB(0, 170, 255)
)
else
goatPrint("[Mosasaurus][DL] BREATH skipped | water surface not resolved")
end

shared._goatMosasaurusBreathing = false
shared._goatMosasaurusSubmergedSince = os.clock()
end
else
shared._goatMosasaurusSubmergedSince = nil

if os.clock() - lastForceAt >= 2.5 then
lastForceAt = os.clock()

autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil
returningToLand = false
ch:SetAttribute("_returningToLand", false)

goatPrint(string.format(
"[Mosasaurus][DL] OUT OF WATER | Water=%.1f%% | forcing immediate water return",
tonumber(ch:GetAttribute("Water")) or -1
))

startSafeDrinkApproach(ch)
end
end
end
end
end
end)

-- ============================================================
-- GLOBAL WATER ESCAPE V2
-- Independent from beginReturnToLand/AutoDrink ownership.
-- Terrestrial animals that accidentally enter Swimming/7:
--   1) confirm for 1 second
--   2) find nearest TERRAIN land around current position
--   3) controlled water-exit tween
--   4) if still Swimming/7, force final safe placement on that land
-- Crocodile is excluded.
-- ============================================================
local globalWaterEscapeActive = false
local globalWaterEscapeCharacter = nil
local globalWaterEscapeGeneration = 0
local globalWaterEscapeLastAttemptAt = 0

local GLOBAL_WATER_ESCAPE_CONFIRM_TIME = 1.0
local GLOBAL_WATER_ESCAPE_RETRY_COOLDOWN = 3.0
local GLOBAL_WATER_ESCAPE_MOVE_TIMEOUT = 9.0
local GLOBAL_WATER_ESCAPE_TWEEN_SPEED = 20

-- TEST WATER:
-- If Swimming/7 remains latched on land, first try a nearby VALID SHALLOW
-- water edge and exit through the same dry shore. This recreates the game's
-- normal water-entry -> land-exit transition without travelling to the
-- distant fixed recovery pair.
local TEST_WATER_MAX_ROUTE_DISTANCE = 1200.0
local TEST_WATER_MIN_DEPTH = 0.75
local TEST_WATER_MAX_DEPTH = 4.0
local TEST_WATER_ENTRY_DISTANCES = { 1.0, 2.0, 3.0, 4.0 }

local function isCrocodileCharacter(character)
if not character then
return false
end

local name = tostring(character:GetAttribute("AnimalName") or ""):lower()
return name:find("croc", 1, true) ~= nil
end

local function isAccidentalSwimmingState(character)
if not character then
return false
end

local state = tostring(character:GetAttribute("MovementState") or "")
local replicated = tonumber(character:GetAttribute("ReplicatedMovementState"))

return state == "Swimming" or replicated == 7
end


shared._goatIsSavannahLifeGame = function()
return game.GameId == 6174994284
or game.GameId == 18214855317
end

-- JL-specific strong detector:
-- Do not react just because the replicated state says Swimming/7.
-- Confirm that the animal is physically on dry ground at the same time.
shared._goatIsJLSwimmingOnLand = function(character)
if game.GameId ~= 9237322219 or not character or player.Character ~= character then
return false
end

if not isAccidentalSwimmingState(character) then
return false
end

local root = character:FindFirstChild("HumanoidRootPart")
local hum = character:FindFirstChildOfClass("Humanoid")
if not root or not hum or hum.Health <= 0 then
return false
end

local onWater = false
pcall(function()
onWater = Animal.IsOnWater() == true
end)

local physicalWater = getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
) ~= nil

local groundOK = shared._goatTerrainGroundConfirmed(character)

-- Savannah can leave ReplicatedMovementState=7 stale after the animal
-- is already safely on land. Ignore that stale replicated flag only when
-- the live MovementState is Idling AND physical checks confirm dry land.
if tostring(character:GetAttribute("MovementState")) == "Idling"
and tonumber(character:GetAttribute("ReplicatedMovementState")) == 7
and groundOK
and not onWater
and not physicalWater
then
return false
end

return
groundOK
and not onWater
and not physicalWater
end


-- SavannahLife strong detector: same philosophy as DL/JL.
-- Only treat Swimming/7 as a bug when the animal is physically on dry land.
shared._goatIsSLSwimmingOnLand = function(character)
if not shared._goatIsSavannahLifeGame()
or not character
or player.Character ~= character
then
return false
end

if not isAccidentalSwimmingState(character) then
return false
end

local root = character:FindFirstChild("HumanoidRootPart")
local hum = character:FindFirstChildOfClass("Humanoid")
if not root or not hum or hum.Health <= 0 then
return false
end

local onWater = false
pcall(function()
onWater = Animal.IsOnWater() == true
end)

local physicalWater = getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
) ~= nil

local groundOK = shared._goatTerrainGroundConfirmed(character)

return
groundOK
and not onWater
and not physicalWater
end

local function normalAutoDrinkOwnsWater(character)
if not character then
return false
end

local leaseActive =
shared._goatAutoDrinkWaterLeaseCharacter == character
and os.clock() < (tonumber(shared._goatAutoDrinkWaterLeaseUntil) or 0)

-- Water Escape must never compete with AutoDrink while AutoDrink is
-- approaching water, drinking, returning to the saved shore or running
-- its emergency recovery.
return
leaseActive
or character:GetAttribute("_drinkingToFull") == true
or character:GetAttribute("_returningToLand") == true
or autoDrinkApproachActive == true
or autoDrinkShoreReturnActive == true
or drinkCommandLatched == true
or returningToLand == true
or shared._fixedWaterLandRecoveryActive == true
end

local function waterEscapeStatus(brText, usText)
if shared._goatStatusLanguage == "USA" then
return usText
end
return brText
end

local function findTestWaterShallowRecoveryRoute(character)
if not character or player.Character ~= character then
return nil
end

local root = character:FindFirstChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid")
if not root or not humanoid or humanoid.Health <= 0 then
return nil
end

local origin = root.Position
local candidates = collectNearbyWaterCandidates(origin)
local best = nil
local bestScore = math.huge
local checked = 0

for _, candidate in ipairs(candidates) do
if candidate.distance > TEST_WATER_MAX_ROUTE_DISTANCE then
break
end

checked = checked + 1
if checked > 32 then
break
end

local route = findSafeShoreFromWater(origin, candidate.water, humanoid)
if route and route.distance <= TEST_WATER_MAX_ROUTE_DISTANCE then
for _, entryDistance in ipairs(TEST_WATER_ENTRY_DISTANCES) do
local candidateXZ = route.shorePoint + route.intoWater * entryDistance
local depth, waterSurfaceY = getWaterDepthAt(
candidateXZ.X,
candidateXZ.Z,
route.shorePoint.Y
)

if depth
and waterSurfaceY
and depth >= TEST_WATER_MIN_DEPTH
and depth <= TEST_WATER_MAX_DEPTH
then
-- Put the root only slightly below the real water surface. The point is
-- intentionally shallow so Savannah receives a valid water transition
-- without sending the Lion deep/submerged.
local waterPoint = Vector3.new(
candidateXZ.X,
waterSurfaceY - 0.35,
candidateXZ.Z
)

local score = route.distance + (depth * 2.0) + (entryDistance * 0.25)
if score < bestScore then
bestScore = score
best = {
shorePoint = route.shorePoint,
waterPoint = waterPoint,
depth = depth,
entryDistance = entryDistance,
routeDistance = route.distance,
source = candidate.source,
}
end

-- Prefer the first shallow point from this shore.
break
end
end
end
end

return best
end

-- Reuse the exact tested TEST WATER route finder inside AutoDrink's
-- return recovery too. The assignment happens after load, before any
-- normal AutoDrink return can call it.
shared._goatFindTestWaterShallowRecoveryRoute = findTestWaterShallowRecoveryRoute

local function findNearestTerrainLandForEscape(character, originOverride)
if not character then
return nil, nil
end

local root = character:FindFirstChild("HumanoidRootPart")
local humanoid = character:FindFirstChildOfClass("Humanoid")
if not root then
return nil, nil
end

local origin = originOverride or root.Position
local radii = {
5, 7, 9, 12, 16, 21, 28, 36, 48, 62,
80, 105, 135, 175, 220
}
local samples = 48

local bestPoint = nil
local bestDistance = math.huge

for _, radius in ipairs(radii) do
for i = 0, samples - 1 do
local angle = (math.pi * 2) * (i / samples)
local x = origin.X + math.cos(angle) * radius
local z = origin.Z + math.sin(angle) * radius

-- This is the important V4 change:
-- reject BOTH Terrain water and MainWaterPart water before accepting land.
local wetSample = getAutoDrinkWaterSampleAt(x, z, origin.Y)

if not wetSample then
local groundHit = castGroundOnlyAt(x, z, origin.Y)

if groundHit
and groundHit.Material ~= Enum.Material.Water
and groundHit.Normal
and groundHit.Normal.Y >= 0.50
then
local minLift = 0.9
local growth = tonumber(character:GetAttribute("GrowthPercentage"))

if not growth or growth >= 0.30 then
minLift = 2.4
end

local lift = math.max(
tonumber(humanoid and humanoid.HipHeight) or 0,
minLift
)

local candidate =
groundHit.Position
+ Vector3.new(0, lift + 0.65, 0)

local flatDistance = Vector3.new(
candidate.X - origin.X,
0,
candidate.Z - origin.Z
).Magnitude

local verticalDelta = candidate.Y - origin.Y

-- Reject river-bottom terrain and unreasonable cliffs.
local plausibleLand =
verticalDelta >= -4
and verticalDelta <= 40

if plausibleLand and flatDistance < bestDistance then
bestDistance = flatDistance
bestPoint = candidate
end
end
end
end

if bestPoint then
return bestPoint, bestDistance
end
end

return nil, nil
end

shared._goatTerrainGroundConfirmed = function(character)
local root = character and character:FindFirstChild("HumanoidRootPart")
if not root then
return false
end

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {workspace.Terrain}
params.IgnoreWater = false

local hit = workspace:Raycast(
root.Position + Vector3.new(0, 4, 0),
Vector3.new(0, -14, 0),
params
)

return hit
and hit.Material ~= Enum.Material.Water
and hit.Normal
and hit.Normal.Y >= 0.45
end

local function finishWaterEscapeOnLand(character, animalName)
if not character or player.Character ~= character then
return false
end

local root = character:FindFirstChild("HumanoidRootPart")
if root then
root.Anchored = false
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end

pcall(function()
SetClientSubStateChangesEnabled(true)
end)

pcall(function()
ChangeCharacterSubState("Idling")
end)

local growthNow = tonumber(character:GetAttribute("Growth"))
or tonumber(character:GetAttribute("GrowthPercentage"))
or 1

local dlBabyTRex =
game.GameId == 8198412649
and tostring(animalName) == "TRex"
and growthNow < 0.25

if dlBabyTRex then
-- DinoLife baby TRex can briefly report Idling/1 while it is still physically
-- in water. Require a full second of stable, physically dry land before success.
local stableStartedAt = nil
local stableChecks = 0

for _ = 1, 8 do
if not character or player.Character ~= character then
return false
end

root = character:FindFirstChild("HumanoidRootPart")
if not root then
return false
end

local movementState = tostring(character:GetAttribute("MovementState") or "")
local replicatedState = tonumber(character:GetAttribute("ReplicatedMovementState"))
local onWater = Animal.IsOnWater() == true
local accidental = isAccidentalSwimmingState(character)
local terrainOK = shared._goatTerrainGroundConfirmed(character)

local dryNow =
not accidental
and movementState ~= "Swimming"
and replicatedState ~= 7
and not onWater
and terrainOK

if dryNow then
stableChecks = stableChecks + 1
stableStartedAt = stableStartedAt or os.clock()

if os.clock() - stableStartedAt >= 1.0 and stableChecks >= 5 then
goatPrint(string.format(
"[WaterEscape] LAND REAL confirmed | animal=%s | onWater=false | state=%s | replicated=%s | stable=%.1fs",
animalName,
movementState,
tostring(replicatedState),
os.clock() - stableStartedAt
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
"Terra alcançada",
"Land reached"
),
Color3.fromRGB(0, 170, 255)
)
return true
end
else
stableStartedAt = nil
stableChecks = 0

goatPrint(string.format(
"[WaterEscape] [DL] Baby TRex land not stable yet | onWater=%s | state=%s | replicated=%s | terrain=%s",
tostring(onWater),
movementState,
tostring(replicatedState),
tostring(terrainOK)
))
end

task.wait(0.2)
end

return false
end

-- JungleLife: use the same "don't trust one state flip" philosophy as DL.
-- Require several consecutive physically dry checks before declaring success.
if game.GameId == 9237322219 or shared._goatIsSavannahLifeGame() then
local stableStartedAt = nil
local stableChecks = 0

for _ = 1, 7 do
if not character or player.Character ~= character then
return false
end

root = character:FindFirstChild("HumanoidRootPart")
if not root then
return false
end

local movementState = tostring(character:GetAttribute("MovementState") or "")
local replicatedState = tonumber(character:GetAttribute("ReplicatedMovementState"))

local onWater = false
pcall(function()
onWater = Animal.IsOnWater() == true
end)

local physicalWater = getAutoDrinkWaterSampleAt(
root.Position.X,
root.Position.Z,
root.Position.Y
) ~= nil

local terrainOK = shared._goatTerrainGroundConfirmed(character)

local dryNow =
movementState ~= "Swimming"
and replicatedState ~= 7
and not onWater
and not physicalWater
and terrainOK

if dryNow then
stableChecks = stableChecks + 1
stableStartedAt = stableStartedAt or os.clock()

if stableChecks >= 4 and os.clock() - stableStartedAt >= 0.6 then
goatPrint(string.format(
"[WaterEscape][%s] LAND REAL confirmed | animal=%s | state=%s | replicated=%s | terrain=%s | stable=%.1fs",
shared._goatIsSavannahLifeGame() and "SL" or "JL",
animalName,
movementState,
tostring(replicatedState),
tostring(terrainOK),
os.clock() - stableStartedAt
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
shared._goatIsSavannahLifeGame() and "Terra confirmada • SL" or "Terra confirmada • JL",
shared._goatIsSavannahLifeGame() and "Land confirmed • SL" or "Land confirmed • JL"
),
Color3.fromRGB(0, 170, 255)
)

return true
end
else
stableStartedAt = nil
stableChecks = 0
end

task.wait(0.2)
end

return false
end

task.wait(0.35)

local escaped =
not isAccidentalSwimmingState(character)
and shared._goatTerrainGroundConfirmed(character)

if escaped then
goatPrint(string.format(
"[WaterEscape] LAND confirmed | animal=%s | state=%s | replicated=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
"Terra alcançada",
"Land reached"
),
Color3.fromRGB(0, 170, 255)
)
end

return escaped
end

local function startGlobalWaterEscape(character)
-- DL only: block WaterEscape routines from older injected THE GOAT instances.
if (game.GameId == 8198412649 or game.GameId == 9237322219 or shared._goatIsSavannahLifeGame())
and shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
then
return false
end
local dlQuestBlocksWaterEscape =
game.GameId == 8198412649
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)

local jlQuestBlocksWaterEscape =
game.GameId == 9237322219
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)


local slQuestBlocksWaterEscape =
shared._goatIsSavannahLifeGame()
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)

-- Savannah keeps the legacy behavior.
-- JungleLife now allows WaterEscape during Travel/Zone so a land-swim bug
-- caused by movement can recover immediately. Intentional Swim still blocks it.
local legacyQuestBlocksWaterEscape =
game.GameId ~= 8198412649
and game.GameId ~= 9237322219
and not shared._goatIsSavannahLifeGame()
and (
shared._autoQuestSwimLock == true
or shared._autoQuestTravelLock == true
or shared._autoQuestZoneLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
or (character and character:GetAttribute("_autoQuestTravelLock") == true)
or (character and character:GetAttribute("_autoQuestZoneLock") == true)
)

local waterEscapeAnimalName =
character and tostring(character:GetAttribute("AnimalName") or "") or ""

if shared._goatMosasaurusBreathing == true then
return false
end

local dlAquaticAnimal =
game.GameId == 8198412649
and (
waterEscapeAnimalName == "Deinosuchus"
or waterEscapeAnimalName == "Mosasaurus"
or waterEscapeAnimalName == "WaterSpinosaurus"
)

if not character
or player.Character ~= character
or isCrocodileCharacter(character)
or dlAquaticAnimal
or normalAutoDrinkOwnsWater(character)
or dlQuestBlocksWaterEscape
or jlQuestBlocksWaterEscape
or slQuestBlocksWaterEscape
or legacyQuestBlocksWaterEscape
then
return false
end

if globalWaterEscapeActive then
return false
end

-- DL only: cross-injection mutex. Local globals are not enough if an older
-- injected copy still has a task alive, so all DL copies share one owner.
local dlSharedEscapeToken = nil
if game.GameId == 8198412649 then
local now = os.clock()
local oldToken = shared._DL_WATER_ESCAPE_TOKEN
local oldAt = tonumber(shared._DL_WATER_ESCAPE_STARTED_AT) or 0

-- A healthy run owns the lock for at most 90s. This also self-recovers if an
-- executor killed a coroutine without releasing its shared lock.
if oldToken ~= nil and (now - oldAt) < 90 then
return false
end

dlSharedEscapeToken =
tostring(SCRIPT_INSTANCE) .. ":" .. tostring(math.floor(now * 1000))

shared._DL_WATER_ESCAPE_TOKEN = dlSharedEscapeToken
shared._DL_WATER_ESCAPE_STARTED_AT = now
end


local slSharedEscapeToken = nil
if shared._goatIsSavannahLifeGame() then
local now = os.clock()
local oldToken = shared._SL_WATER_ESCAPE_TOKEN
local oldAt = tonumber(shared._SL_WATER_ESCAPE_STARTED_AT) or 0

if oldToken ~= nil and (now - oldAt) < 90 then
return false
end

slSharedEscapeToken =
tostring(SCRIPT_INSTANCE) .. ":" .. tostring(math.floor(now * 1000))

shared._SL_WATER_ESCAPE_TOKEN = slSharedEscapeToken
shared._SL_WATER_ESCAPE_STARTED_AT = now
end

if os.clock() - globalWaterEscapeLastAttemptAt
< GLOBAL_WATER_ESCAPE_RETRY_COOLDOWN
then
if game.GameId == 8198412649
and shared._DL_WATER_ESCAPE_TOKEN == dlSharedEscapeToken
then
shared._DL_WATER_ESCAPE_TOKEN = nil
shared._DL_WATER_ESCAPE_STARTED_AT = nil
end

if shared._goatIsSavannahLifeGame()
and shared._SL_WATER_ESCAPE_TOKEN == slSharedEscapeToken
then
shared._SL_WATER_ESCAPE_TOKEN = nil
shared._SL_WATER_ESCAPE_STARTED_AT = nil
end
return false
end

globalWaterEscapeActive = true
globalWaterEscapeCharacter = character
globalWaterEscapeLastAttemptAt = os.clock()
globalWaterEscapeGeneration = globalWaterEscapeGeneration + 1

local myGeneration = globalWaterEscapeGeneration
local animalName = tostring(character:GetAttribute("AnimalName") or "?")

-- Save where the accidental swim actually happened. If this X/Z is truly
-- wet according to Terrain/MainWaterPart, it becomes the LOCAL recovery
-- water point. This avoids travelling hundreds of studs to fixed water.
local escapeStartRoot = character:FindFirstChild("HumanoidRootPart")
local localRecoveryWaterPoint = nil

if escapeStartRoot then
local localWaterSample = getAutoDrinkWaterSampleAt(
escapeStartRoot.Position.X,
escapeStartRoot.Position.Z,
escapeStartRoot.Position.Y
)

if localWaterSample then
localRecoveryWaterPoint = escapeStartRoot.Position

goatPrint(string.format(
"[WaterEscape] LOCAL WATER saved | point=(%.1f, %.1f, %.1f) | source=%s",
localRecoveryWaterPoint.X,
localRecoveryWaterPoint.Y,
localRecoveryWaterPoint.Z,
tostring(localWaterSample.Source)
))
end
end

goatPrint(string.format(
"[WaterEscape] ACCIDENTAL SWIM detected | animal=%s | state=%s | replicated=%s | water=%.1f",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState")),
tonumber(character:GetAttribute("Water")) or -1
))

if shared._goatIsSavannahLifeGame() then
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
cachedCarcassTarget = nil
shared._goatCarcassForceFreshScan = true

pcall(function()
character:SetAttribute("_carcassInteractionLock", false)
end)

pcall(function()
stopCarcassMovement(character)
end)

goatPrint("[WaterEscape][SL] Carcass paused — recovery owns movement")
end

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
"Entrou na água • procurando terra",
"Entered water • searching for land"
),
Color3.fromRGB(0, 170, 255)
)

task.spawn(function()
local function finish()
if globalWaterEscapeGeneration == myGeneration then
globalWaterEscapeActive = false
globalWaterEscapeCharacter = nil
end

if game.GameId == 8198412649
and dlSharedEscapeToken ~= nil
and shared._DL_WATER_ESCAPE_TOKEN == dlSharedEscapeToken
then
shared._DL_WATER_ESCAPE_TOKEN = nil
shared._DL_WATER_ESCAPE_STARTED_AT = nil
end

if shared._goatIsSavannahLifeGame()
and slSharedEscapeToken ~= nil
and shared._SL_WATER_ESCAPE_TOKEN == slSharedEscapeToken
then
shared._SL_WATER_ESCAPE_TOKEN = nil
shared._SL_WATER_ESCAPE_STARTED_AT = nil
shared._goatCarcassForceFreshScan = true
lastCarcassRadarAt = 0
goatPrint("[WaterEscape][SL] Recovery ownership released — Carcass fresh scan allowed")
end
end

if (game.GameId == 8198412649 or game.GameId == 9237322219 or shared._goatIsSavannahLifeGame())
and shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
then
finish()
return
end

if player.Character ~= character
or globalWaterEscapeGeneration ~= myGeneration
then
finish()
return
end

-- Cancel the route that accidentally pushed the animal into the water.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1

pcall(function()
Animal.CancelTween(true)
end)

local root = character:FindFirstChild("HumanoidRootPart")
if not root then
finish()
return
end

root.Anchored = false
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero

local safeLand, safeDistance = findNearestTerrainLandForEscape(character)

if not safeLand then
goatWarn("[WaterEscape] No nearby TERRAIN land found — will retry")
SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
"Nenhuma terra segura próxima • tentando novamente",
"No nearby safe land • retrying"
),
Color3.fromRGB(255, 170, 0)
)
finish()
return
end

goatPrint(string.format(
"[WaterEscape] SAFE LAND found | animal=%s | distance=%.1f | goal=(%.1f, %.1f, %.1f)",
animalName,
safeDistance or -1,
safeLand.X,
safeLand.Y,
safeLand.Z
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
string.format("Terra encontrada • %.0f studs", safeDistance or 0),
string.format("Land found • %.0f studs", safeDistance or 0)
),
Color3.fromRGB(0, 170, 255)
)

-- Independent water exit: do not call beginReturnToLand().
-- Move at a moderate speed so this does not look like the old teleport bug.
local moveDone = false
task.spawn(function()
pcall(function()
Animal.TweenTo(CFrame.new(safeLand), GLOBAL_WATER_ESCAPE_TWEEN_SPEED)
end)

local expected =
(root.Position - safeLand).Magnitude
/ GLOBAL_WATER_ESCAPE_TWEEN_SPEED

task.wait(math.min(expected + 0.75, GLOBAL_WATER_ESCAPE_MOVE_TIMEOUT))
moveDone = true
end)

local deadline = os.clock() + GLOBAL_WATER_ESCAPE_MOVE_TIMEOUT
local escaped = false

while os.clock() < deadline do
if player.Character ~= character
or globalWaterEscapeGeneration ~= myGeneration
then
finish()
return
end

local liveRoot = character:FindFirstChild("HumanoidRootPart")
if not liveRoot then
break
end

local flatDistance = Vector3.new(
liveRoot.Position.X - safeLand.X,
0,
liveRoot.Position.Z - safeLand.Z
).Magnitude

if flatDistance <= 8 then
pcall(function()
Animal.CancelTween(true)
end)

escaped = finishWaterEscapeOnLand(character, animalName)
if escaped then
break
end
end

if moveDone and flatDistance <= 10 then
break
end

task.wait(0.15)
end

-- EARLY SUCCESS:
-- The movement state can clear a fraction of a second after the nearby-shore
-- move finishes. Re-check before starting any water re-entry recovery.
if not escaped
and player.Character == character
and globalWaterEscapeGeneration == myGeneration
then
escaped = finishWaterEscapeOnLand(character, animalName)

if escaped then
goatPrint(string.format(
"[WaterEscape] EARLY SUCCESS after nearby shore | state=%s | replicated=%s",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end

-- Final rescue only if the nearby-shore attempt did not clear Swimming/7.
--
-- V4 ORDER:
--   LOCAL WATER -> NEARBY LAND
--
-- The distant fixed pair is now LAST RESORT only.
if not escaped
and player.Character == character
and globalWaterEscapeGeneration == myGeneration
then
goatPrint("[WaterEscape] Nearby shore did not clear Swimming/7 — starting LOCAL WATER->LAND rescue")

-- Stop old recovery workers before taking local ownership.
shared._fixedWaterLandRecoveryGeneration =
(tonumber(shared._fixedWaterLandRecoveryGeneration) or 0) + 1

shared._fixedWaterLandRecoveryActive = false
shared._fixedWaterLandRecoveryCharacter = nil
shared._fixedWaterLandRecoveryOwnerGeneration = nil

pcall(function()
Animal.CancelTween(true)
end)

shared._animalWalkGeneration =
(tonumber(shared._animalWalkGeneration) or 0) + 1

local rescueGeneration = globalWaterEscapeGeneration

local function escapeMove(target, label, requireWater, directTween, physicalWaterOnly)
if game.GameId == 8198412649
and dlSharedEscapeToken ~= nil
and shared._DL_WATER_ESCAPE_TOKEN ~= dlSharedEscapeToken
then
return false
end

if player.Character ~= character
or globalWaterEscapeGeneration ~= rescueGeneration
then
return false
end

local liveRoot = character:FindFirstChild("HumanoidRootPart")
if not liveRoot then
return false
end

goatPrint(string.format(
"[WaterEscape] %s START | distance=%.1f | target=(%.1f, %.1f, %.1f)",
label,
Vector3.new(
target.X - liveRoot.Position.X,
0,
target.Z - liveRoot.Position.Z
).Magnitude,
target.X,
target.Y,
target.Z
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
requireWater
and "Resgate local • confirmando água"
or "Resgate local • saindo pela margem",
requireWater
and "Local rescue • confirming water"
or "Local rescue • exiting by nearby shore"
),
Color3.fromRGB(0, 170, 255)
)

pcall(function()
Animal.CancelTween(true)
end)

local movementDone = false
local movementOk = false

task.spawn(function()
local ok, result = pcall(function()
if directTween then
Animal.TweenTo(CFrame.new(target), 18)
return true
end

return Animal.WalkToAsync(
CFrame.new(target),
{ groundedRecovery = not requireWater }
)
end)

movementOk = ok and result ~= false
movementDone = true
end)

local deadline = os.clock() + 35
local lastPos = liveRoot.Position
local lastProgressAt = os.clock()

while os.clock() < deadline do
if player.Character ~= character
or globalWaterEscapeGeneration ~= rescueGeneration
then
pcall(function()
Animal.CancelTween(true)
end)
return false
end

liveRoot = character:FindFirstChild("HumanoidRootPart")
if not liveRoot then
return false
end

local flatDistance = Vector3.new(
target.X - liveRoot.Position.X,
0,
target.Z - liveRoot.Position.Z
).Magnitude

local confirmed = true

if requireWater then
local wetHere = getAutoDrinkWaterSampleAt(
liveRoot.Position.X,
liveRoot.Position.Z,
liveRoot.Position.Y
)

if physicalWaterOnly then
-- TEST WATER must physically reach real Terrain/MainWaterPart water.
-- Swimming/7 alone cannot count because it is the stuck state being repaired.
confirmed = wetHere ~= nil
else
confirmed =
wetHere ~= nil
or isAccidentalSwimmingState(character)
end
else
local wetHere = getAutoDrinkWaterSampleAt(
liveRoot.Position.X,
liveRoot.Position.Z,
liveRoot.Position.Y
)

confirmed =
wetHere == nil
and shared._goatTerrainGroundConfirmed(character)
end

if flatDistance <= 6 and confirmed then
pcall(function()
Animal.CancelTween(true)
end)

goatPrint(string.format(
"[WaterEscape] %s ARRIVED | distance=%.1f | state=%s | replicated=%s",
label,
flatDistance,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))

return true
end

if (liveRoot.Position - lastPos).Magnitude >= 0.75 then
lastPos = liveRoot.Position
lastProgressAt = os.clock()
elseif os.clock() - lastProgressAt >= 6 then
break
end

if movementDone and not movementOk then
break
end

task.wait(0.15)
end

pcall(function()
Animal.CancelTween(true)
end)

goatWarn("[WaterEscape] " .. label .. " failed/timeout")
return false
end

local localRecoverySucceeded = false

-- ============================================================
-- TEST WATER — valid shallow water -> same nearby dry shore
-- ============================================================
-- Savannah has been observed to clear a latched Swimming/7 reliably after
-- a real water entry followed by a normal land exit. Recreate that locally
-- before falling back to the previous recovery points.
local testWaterRoute = findTestWaterShallowRecoveryRoute(character)

if testWaterRoute
and player.Character == character
and globalWaterEscapeGeneration == rescueGeneration
then
goatPrint(string.format(
"[WaterEscape][TEST WATER] SHALLOW route found | distance=%.1f | entry=%.1f | depth=%.1f | source=%s",
testWaterRoute.routeDistance or -1,
testWaterRoute.entryDistance or -1,
testWaterRoute.depth or -1,
tostring(testWaterRoute.source or "?")
))

SetGoatHudStatus(
"Water Escape",
waterEscapeStatus(
string.format("TEST WATER • água rasa %.1f studs", testWaterRoute.depth or 0),
string.format("TEST WATER • shallow water %.1f studs", testWaterRoute.depth or 0)
),
Color3.fromRGB(0, 170, 255)
)

-- Stand on the exact dry shore associated with this shallow point first.
local reachedTestShore = escapeMove(
testWaterRoute.shorePoint,
"TEST WATER SHORE",
false,
true
)

if reachedTestShore then
task.wait(0.30)

-- EARLY SUCCESS:
-- In some cases simply reaching this verified dry shore is enough to make
-- Savannah release replicated=7. If so, stop here instead of entering water.
escaped = finishWaterEscapeOnLand(character, animalName)
localRecoverySucceeded = escaped

if escaped then
goatPrint(string.format(
"[WaterEscape][TEST WATER] EARLY SUCCESS AT SHORE | state=%s | replicated=%s",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
else
-- Enter only a few studs into VERIFIED shallow water. physicalWaterOnly=true
-- prevents the already-stuck Swimming/7 flag from faking a successful entry.
local reachedTestWater = escapeMove(
testWaterRoute.waterPoint,
"TEST WATER SHALLOW ENTRY",
true,
true,
true
)

if reachedTestWater then
local liveRoot = character:FindFirstChild("HumanoidRootPart")
local wetHere = liveRoot and getAutoDrinkWaterSampleAt(
liveRoot.Position.X,
liveRoot.Position.Z,
liveRoot.Position.Y
)

local liveDepth = nil
if liveRoot and wetHere then
liveDepth = select(1, getWaterDepthAt(
liveRoot.Position.X,
liveRoot.Position.Z,
liveRoot.Position.Y
))
end

goatPrint(string.format(
"[WaterEscape][TEST WATER] VALID WATER confirmed | depth=%s | state=%s | replicated=%s",
liveDepth and string.format("%.1f", liveDepth) or "?",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))

-- Give Savannah time to register a real water transition before exiting.
task.wait(1.10)

local reachedTestExit = escapeMove(
testWaterRoute.shorePoint,
"TEST WATER SHORE EXIT",
false,
true
)

if reachedTestExit then
task.wait(0.45)
escaped = finishWaterEscapeOnLand(character, animalName)
localRecoverySucceeded = escaped

goatPrint(string.format(
"[WaterEscape][TEST WATER] SHALLOW WATER->LAND END | waterReached=%s | exitReached=%s | escaped=%s | state=%s | replicated=%s",
tostring(reachedTestWater),
tostring(reachedTestExit),
tostring(escaped),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end
end
end
else
goatPrint("[WaterEscape][TEST WATER] No valid shallow water within 1200 studs")
end

-- Keep the previous local recovery only if TEST WATER did not clear Swimming/7.
if not localRecoverySucceeded and not escaped then
if localRecoveryWaterPoint then
-- Find land relative to where the animal originally entered the water,
-- not relative to the distant fixed recovery area.
local nearbyLand, nearbyDistance =
findNearestTerrainLandForEscape(
character,
localRecoveryWaterPoint
)

if nearbyLand then
goatPrint(string.format(
"[WaterEscape] LOCAL recovery pair | water=(%.1f, %.1f, %.1f) | landDistance=%.1f | land=(%.1f, %.1f, %.1f)",
localRecoveryWaterPoint.X,
localRecoveryWaterPoint.Y,
localRecoveryWaterPoint.Z,
nearbyDistance or -1,
nearbyLand.X,
nearbyLand.Y,
nearbyLand.Z
))

local reachedLocalWater = escapeMove(
localRecoveryWaterPoint,
"LOCAL WATER ENTRY",
true,
true
)

if reachedLocalWater then
goatPrint(string.format(
"[WaterEscape] LOCAL WATER confirmed | state=%s | replicated=%s",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))

task.wait(1.25)

local reachedNearbyLand = escapeMove(
nearbyLand,
"NEARBY LAND EXIT",
false,
true
)

if reachedNearbyLand then
task.wait(0.35)
escaped = finishWaterEscapeOnLand(character, animalName)
localRecoverySucceeded = escaped

goatPrint(string.format(
"[WaterEscape] LOCAL WATER->LAND rescue END | waterReached=%s | landReached=%s | escaped=%s | state=%s | replicated=%s",
tostring(reachedLocalWater),
tostring(reachedNearbyLand),
tostring(escaped),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end
else
goatWarn("[WaterEscape] No valid nearby dry shore for LOCAL recovery")
end
else
goatWarn("[WaterEscape] Original swim point was not physically verified as water")
end
end

-- EARLY SUCCESS before LAST RESORT:
-- Never send the animal to the distant fixed pair if Swimming/7 has already
-- cleared while the previous recovery attempt was winding down.
if not localRecoverySucceeded
and not escaped
and player.Character == character
and globalWaterEscapeGeneration == rescueGeneration
then
escaped = finishWaterEscapeOnLand(character, animalName)
localRecoverySucceeded = escaped

if escaped then
goatPrint(string.format(
"[WaterEscape] EARLY SUCCESS before LAST RESORT | state=%s | replicated=%s",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end

-- LAST RESORT ONLY:
-- use the old known fixed pair only when local water/shore recovery failed.
if not localRecoverySucceeded
and not escaped
and player.Character == character
and globalWaterEscapeGeneration == rescueGeneration
then
if game.GameId == 8198412649 then
-- DinoLife must never use Savannah's fixed recovery coordinates.
-- Release this attempt and let the watcher retry from the animal's CURRENT
-- local water/shore position on the next cycle.
goatWarn("[WaterEscape] [DL] Local recovery failed — fixed SL fallback BLOCKED; retrying locally")
else
goatPrint("[WaterEscape] LOCAL recovery failed — LAST RESORT FIXED WATER->LAND")

local reachedFixedWater = escapeMove(
FIXED_WATER_RECOVERY_POINT,
"LAST RESORT FIXED WATER",
true,
false
)

if reachedFixedWater then
task.wait(1.50)

local reachedFixedLand = escapeMove(
FIXED_LAND_RECOVERY_POINT,
"LAST RESORT FIXED LAND",
false,
false
)

if reachedFixedLand then
task.wait(0.35)
escaped = finishWaterEscapeOnLand(character, animalName)

goatPrint(string.format(
"[WaterEscape] LAST RESORT FIXED rescue END | escaped=%s | state=%s | replicated=%s",
tostring(escaped),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end
end
end

if not escaped then
goatWarn(string.format(
"[WaterEscape] Rescue ended but state still=%s replicated=%s",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
end

finish()
end)

return true
end

-- Global watcher. Works at any Water percentage.
task.spawn(function()
local watchedCharacter = nil
local swimmingSince = nil

while task.wait(0.20) do
-- DL only: task.spawn loops are not connections, so old injections used to
-- keep this watcher alive. Exit immediately when a newer script instance exists.
if (game.GameId == 8198412649 or game.GameId == 9237322219 or shared._goatIsSavannahLifeGame())
and shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
then
local strongTag =
shared._goatIsSavannahLifeGame() and "SL"
or (game.GameId == 9237322219 and "JL" or "DL")

goatPrint(string.format(
"[WaterEscape] [%s] Stale watcher stopped | oldInstance=%s | currentInstance=%s",
strongTag,
tostring(SCRIPT_INSTANCE),
tostring(shared._THEGOAT_SCRIPT_INSTANCE)
))
break
end

local character = player.Character

if character ~= watchedCharacter then
watchedCharacter = character
swimmingSince = nil
globalWaterEscapeGeneration = globalWaterEscapeGeneration + 1
globalWaterEscapeActive = false
globalWaterEscapeCharacter = nil
end

local dlQuestBlocksWaterEscape =
game.GameId == 8198412649
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)

local jlQuestBlocksWaterEscape =
game.GameId == 9237322219
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)


local slQuestBlocksWaterEscape =
shared._goatIsSavannahLifeGame()
and (
shared._autoQuestSwimLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
)

-- Savannah keeps the legacy behavior.
-- JungleLife now allows WaterEscape during Travel/Zone so a land-swim bug
-- caused by movement can recover immediately. Intentional Swim still blocks it.
local legacyQuestBlocksWaterEscape =
game.GameId ~= 8198412649
and game.GameId ~= 9237322219
and not shared._goatIsSavannahLifeGame()
and (
shared._autoQuestSwimLock == true
or shared._autoQuestTravelLock == true
or shared._autoQuestZoneLock == true
or (character and character:GetAttribute("_autoQuestSwimLock") == true)
or (character and character:GetAttribute("_autoQuestTravelLock") == true)
or (character and character:GetAttribute("_autoQuestZoneLock") == true)
)

if not character
or isCrocodileCharacter(character)
or shared._inGrowthReset
or dlQuestBlocksWaterEscape
or jlQuestBlocksWaterEscape
or slQuestBlocksWaterEscape
or legacyQuestBlocksWaterEscape
then
swimmingSince = nil
continue
end

if normalAutoDrinkOwnsWater(character) then
swimmingSince = nil
continue
end

local accidentalForWatcher

if game.GameId == 9237322219 then
accidentalForWatcher = shared._goatIsJLSwimmingOnLand(character)
elseif shared._goatIsSavannahLifeGame() then
accidentalForWatcher = shared._goatIsSLSwimmingOnLand(character)
else
accidentalForWatcher = isAccidentalSwimmingState(character)
end

if accidentalForWatcher then
if not swimmingSince then
swimmingSince = os.clock()

if game.GameId == 9237322219 or shared._goatIsSavannahLifeGame() then
local detectTag = shared._goatIsSavannahLifeGame() and "SL" or "JL"

goatPrint(string.format(
"[WaterEscape][%s] Swimming/7 ON LAND detected | animal=%s | state=%s | replicated=%s",
detectTag,
tostring(character:GetAttribute("AnimalName") or "?"),
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end
elseif os.clock() - swimmingSince >= GLOBAL_WATER_ESCAPE_CONFIRM_TIME then
startGlobalWaterEscape(character)
swimmingSince = nil
end
else
swimmingSince = nil
end
end
end)

return {
Checkbox({
label = 'Auto eat',
isChecked = autoEatChecked,
accent = Color3.fromRGB(0, 170, 255),
controlPriority = {character = 2},
WhileChecked = function()
local character = player.Character

if not character then
return
end

-- AutoEat / AutoDrink movement mutex.
-- There is NO Food percentage gate here. AutoEat only pauses while AutoDrink
-- already owns an active water action, preventing both systems from issuing
-- movement/substate commands at the same time.
local autoDrinkOwnsSurvival =
autoDrinkChecked()
and (
character:GetAttribute("_drinkingToFull") == true
or character:GetAttribute("_returningToLand") == true
or autoDrinkApproachActive
or autoDrinkShoreReturnActive
or drinkCommandLatched
or returningToLand
)

if autoDrinkOwnsSurvival then
return false
end

SetClientSubStateChangesEnabled(true)
if shared._inGrowthReset or shared._autoQuestSwimLock then return false end

-- VISIT_ZONES owns movement. Do not let normal AutoEat drag the animal
-- away from the current zone route. Critical food is still allowed through;
-- AutoQuest survival priority will then pause Visit Zones cleanly.
if shared._autoQuestVisitZonesLock
and (tonumber(character:GetAttribute("Food")) or 100) > 35
then
return false
end

local animalName = character:GetAttribute("AnimalName") or ""
if CARNIVORES[animalName] then
return false
end
local water = character:GetAttribute('Water')
local drinkTrigger = shared._growthGameName == "SavannahLife" and 88 or 90

-- If AutoDrink is enabled but has not claimed an active water action yet,
-- AutoEat may continue normally. As soon as _drinkingToFull/approach/drinking
-- becomes active, the mutex at the top pauses AutoEat automatically.
if (character:GetAttribute('Food') or 0) < 90 then
local ingestionAvaliable = CanStartEatDrink(character)

if ingestionAvaliable == 'Eat' then
ChangeCharacterSubState('Eating')
elseif goToNearestSource() then
local root = character:FindFirstChild("HumanoidRootPart")
if not root then return end
local rootPosition = root.Position

-- Rejected grass patches belong only to the current Character instance.
if autoEatRejectedGrassCharacter ~= character then
autoEatRejectedGrassCharacter = character
autoEatRejectedGrassPatches = {}
end

local now = os.clock()
pruneAutoEatRejectedGrassPatches(now)
local grassPosition = nil

-- If nearby terrain grass proved not actually eatable, search outside all
-- short-lived rejected patches instead of circling inside the same area.
if #autoEatRejectedGrassPatches > 0 then
grassPosition = FindNearestGrassExcluding(rootPosition)
if not grassPosition then
return false
end
else
grassPosition = FindNearestGrass(rootPosition, grassStartingRadius)
end

if not grassPosition then
return
end

local grassDistance = grassFlatDistance(rootPosition, grassPosition)

if grassDistance <= AUTOEAT_NEAR_GRASS_DEADZONE then
-- First try the correct interaction from the current position. Sometimes
-- Savannah already considers the tiny patch eatable even though it is under us.
local closeIngestion = CanStartEatDrink(character)

if closeIngestion == "Eat" then
ChangeCharacterSubState("Eating")
return false
end

-- It is physically too close but Savannah still says it cannot eat.
-- Blacklist the whole local patch, not only this exact raycast point.
addAutoEatRejectedGrassPatch(rootPosition, "too-close-not-eatable")

goatPrint(string.format(
"[AutoEat] Uneatable grass patch rejected for %.1fs | radius=%.1f | distance=%.1f",
AUTOEAT_REJECT_GRASS_TIME,
AUTOEAT_REJECT_GRASS_RADIUS,
grassDistance
))

local alternativeGrass = FindNearestGrassExcluding(rootPosition)
if not alternativeGrass then
return false
end

grassPosition = alternativeGrass
end

if shared._animalTweening then
return
end

local humanoid = character:FindFirstChild("Humanoid")
if not humanoid then return end
local heightVector = Vector3.new(0, humanoid.HipHeight, 0)
local goalPosition = grassPosition + heightVector
local direction = (goalPosition - rootPosition)

-- Extra zero-vector safety: never issue a movement command to the exact
-- current body position.
if direction.Magnitude <= 0.05 then
return false
end

local goalCFrame = CFrame.lookAlong(goalPosition - direction.Unit, direction)
local walked = Animal.WalkToAsync(goalCFrame)
if walked == false then
Animal.TweenToAsync(goalCFrame)
end

-- Terrain may still be Material.Grass even when Savannah no longer allows eating there.
-- After arriving, wait briefly for the real Eat interaction. If it never appears,
-- blacklist the whole local patch so AutoEat cannot circle through nearby raycast points.
local postMoveDeadline = os.clock() + AUTOEAT_POST_MOVE_EAT_CHECK
local postMoveCanEat = false
while os.clock() < postMoveDeadline do
local liveCharacter = player.Character
if liveCharacter ~= character then return false end
local ingestionNow = CanStartEatDrink(character)
if ingestionNow == "Eat" then
ChangeCharacterSubState("Eating")
postMoveCanEat = true
break
end
task.wait(0.15)
end

if not postMoveCanEat then
local liveRoot = character:FindFirstChild("HumanoidRootPart")
if liveRoot then
local remainingToTarget = grassFlatDistance(liveRoot.Position, grassPosition)
if remainingToTarget <= AUTOEAT_POST_MOVE_TARGET_TOLERANCE then
addAutoEatRejectedGrassPatch(liveRoot.Position, "arrived-but-cannot-eat")
goatPrint(string.format(
"[AutoEat] Arrived but cannot eat — rejecting local grass patch | radius=%.1f | targetDist=%.1f",
AUTOEAT_REJECT_GRASS_RADIUS,
remainingToTarget
))
return false
end
end
end
else
return false
end
else
return false
end
end,
}),
Checkbox({
label = 'Auto eat carcass (patrol)',
shortLabel = 'Auto Carcass',
isChecked = autoCarcassChecked,
accent = Color3.fromRGB(255, 90, 105),
controlPriority = {character = 2},
OnUserChanged = function(state)
carcassUserAllowed = state == true
if not carcassUserAllowed then
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
local currentCharacter = player.Character
stopCarcassMovement(currentCharacter)
if currentCharacter then
currentCharacter:SetAttribute("_carcassInteractionLock", false)
currentCharacter:SetAttribute("_carcassFeedCycle", false)
end
goatPrint("[Carcass][instance " .. tostring(SCRIPT_INSTANCE) .. "] Manual OFF — automatic re-enable blocked")
SetGoatHudStatus("Auto Carcass", "Desativado", Color3.fromRGB(130, 145, 165))
else
goatPrint("[Carcass][instance " .. tostring(SCRIPT_INSTANCE) .. "] Manual ON — automatic survival restore allowed")
SetGoatHudStatus("Auto Carcass", "Ativado • aguardando fome", Color3.fromRGB(255, 90, 105))
end
end,
WhileChecked = function()
local character = player.Character
if not character then return false end

SetClientSubStateChangesEnabled(true)
if shared._inGrowthReset then return false end
if character:GetAttribute("_returningToLand") then return false end

local animalName = character:GetAttribute("AnimalName") or ""
if not CARNIVORES[animalName] then
return false
end

local food = character:GetAttribute("Food") or 100
local feedCycle = character:GetAttribute("_carcassFeedCycle") == true

if feedCycle then
if food >= CARCASS_STOP_FOOD then
character:SetAttribute("_carcassFeedCycle", false)
return false
end
else
if food >= CARCASS_START_FOOD then
return false
end
character:SetAttribute("_carcassFeedCycle", true)
end

local water = character:GetAttribute("Water") or 100

if shared._goatCarcassMustYieldToWater(character, water) then
return false
end

if shared._autoQuestZoneLock
or shared._autoQuestTravelLock
or character:GetAttribute("_autoQuestZoneLock")
or character:GetAttribute("_autoQuestTravelLock")
then
return false
end

-- Emergency self-heal must be conservative.
-- A final approach, TerrainSafety correction, tween fallback or WaterEscape
-- can legitimately keep the patrol busy for several seconds. Do not recycle
-- a healthy patrol just because carcassOwnsMovement is temporarily false.
if shared._autoQuestCarnivoreFoodEmergency == true
and carcassPatrolRunning
and not carcassOwnsMovement
and not shared._animalTweening
and not cachedCarcassTarget
and not character:GetAttribute("_carcassInteractionLock")
and not character:GetAttribute("_drinkingToFull")
and not shared._fixedWaterLandRecoveryActive
and not shared._slWaterEscapeActive
and not shared._SL_WATER_ESCAPE_TOKEN
and (os.clock() - (tonumber(shared._goatCarcassPatrolHeartbeat) or 0)) > 12.0
then
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
lastCarcassRadarAt = 0
shared._goatCarcassForceFreshScan = true
goatPrint("[CarcassRadar] Emergency stale patrol reset — no target/movement for 12s")
end

if not carcassPatrolRunning then
if shared._autoQuestCarnivoreFoodEmergency == true then
SetGoatHudStatus("Auto Carcass", "FOOD EMERGENCY • searching carcass", Color3.fromRGB(255, 90, 105))
end
startCarcassPatrol(character)
end

return false
end,
}),
Checkbox({
label = 'Auto drink',
isChecked = autoDrinkChecked,
accent = Color3.fromRGB(0, 170, 255),
controlPriority = {character = 2},
WhileChecked = function()
if shared._autoDrinkOwnerGeneration ~= AUTO_DRINK_OWNER_GENERATION then
autoDrinkChecked(false)
return false
end

local character = player.Character
if not character then return false end

-- A slot/animal switch creates a new Character instance. Reset every
-- AutoDrink-local lock from the previous instance before doing anything else.
if lastAutoDrinkCharacter ~= character then
if lastAutoDrinkCharacter ~= nil then
goatPrint("[AutoDrink] Character changed — clearing old drink/search locks")
end

autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkApproachActive = false
autoDrinkApproachCharacter = nil
autoDrinkApproachStartedAt = 0

autoDrinkShoreReturnActive = false
autoDrinkShoreReturnCharacter = nil

drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = 0
drinkCommandLastProgressAt = 0

savedDrinkShorePoint = nil
savedDrinkPoint = nil
savedWaterPosition = nil
savedLandPosition = nil

returningToLand = false
character:SetAttribute("_returningToLand", false)
character:SetAttribute("_drinkingToFull", false)

lastSafeWaterSearchAt = 0

autoDrinkIdleStallCharacter = nil
autoDrinkIdleStallSince = 0
autoDrinkIdleStallPosition = nil

lastAutoDrinkCharacter = character
SetClientSubStateChangesEnabled(true)
end

if shared._autoQuestSwimLock then return false end

-- VISIT_ZONES owns movement. Normal AutoDrink must not start a competing
-- shore route while the quest is crossing zones. Water <= 30 is a real
-- survival emergency and is intentionally allowed through.
if shared._autoQuestVisitZonesLock
and not character:GetAttribute('_drinkingToFull')
and not character:GetAttribute('_returningToLand')
and not autoDrinkApproachActive
and not autoDrinkShoreReturnActive
and not returningToLand
and (tonumber(character:GetAttribute("Water")) or 100) > 30
then
return false
end

local safetyRoot = character:FindFirstChild('HumanoidRootPart')
if safetyRoot and safetyRoot.Anchored then
safetyRoot.Anchored = false
safetyRoot.AssemblyLinearVelocity = Vector3.zero
safetyRoot.AssemblyAngularVelocity = Vector3.zero
end

if not drinkCommandLatched then
SetClientSubStateChangesEnabled(true)
end

if shared._inGrowthReset then
autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkApproachActive = false
autoDrinkShoreReturnActive = false
character:SetAttribute('_drinkingToFull', false)
character:SetAttribute('_returningToLand', false)
returningToLand = false
returnToLandToken = returnToLandToken + 1
savedWaterPosition = nil
savedLandPosition = nil
savedDrinkPoint = nil
savedDrinkShorePoint = nil

drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = 0
drinkCommandLastProgressAt = 0
SetClientSubStateChangesEnabled(true)

return false
end

local water = character:GetAttribute('Water') or 0

-- Water has absolute survival priority once it reaches 80%.
-- From this point AutoDrink owns movement until Water is full and the
-- character safely returns to the saved shore.
local drinkTrigger = 80

if returningToLand
or character:GetAttribute('_returningToLand')
or autoDrinkShoreReturnActive then
return false
end

if water >= 99.9 then
if drinkCommandLatched then
goatPrint(string.format(
"[AutoDrink] Drinking complete | water %.1f%%",
water
))
end

drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = 0
drinkCommandLastProgressAt = 0
SetClientSubStateChangesEnabled(true)

local wasDrinking = character:GetAttribute('_drinkingToFull') == true
local hadDrinkRoute = savedDrinkShorePoint ~= nil or savedDrinkPoint ~= nil or savedWaterPosition ~= nil

if (wasDrinking or hadDrinkRoute) and not autoDrinkApproachActive then
returnToSavedDrinkShore(character)
else
character:SetAttribute('_drinkingToFull', false)
end
return false
end

-- Global carnivore food emergency owns movement over NORMAL AutoDrink.
-- Existing water emergency remains the escape hatch at <= 18%.
if shared._autoQuestCarnivoreFoodEmergency == true
and water > 18
then
if character:GetAttribute('_drinkingToFull') == true then
character:SetAttribute('_drinkingToFull', false)
end

if drinkCommandLatched then
drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = water
drinkCommandLastProgressAt = os.clock()
SetClientSubStateChangesEnabled(true)
end

return false
end

if water <= drinkTrigger then
local wasClaimed = character:GetAttribute('_drinkingToFull') == true
character:SetAttribute('_drinkingToFull', true)

-- During Food Emergency, AutoDrink is only allowed to start at critical
-- Water (<=18). Once that happens, immediately release any Carcass route.
if shared._autoQuestCarnivoreFoodEmergency == true
and water <= 18
and not wasClaimed
then
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
stopCarcassMovement(character)
cachedCarcassTarget = nil
goatPrint(string.format(
"[SurvivalLock] CRITICAL WATER TAKEOVER | Water %.1f%% <= 18%% | Carcass paused until drink full",
water
))
end

if not wasClaimed then
goatPrint(string.format(
"[SurvivalLock] WATER PRIORITY ON | Water %.1f%% <= 80%% | AutoEat paused",
water
))
end

SetGoatHudStatus(
'Auto Drink',
string.format('Água %.0f%% • procurando margem segura', water),
Color3.fromRGB(0, 170, 255)
)
end

if not character:GetAttribute('_drinkingToFull') then return false end

-- One Drinking command at a time. Keep Savannah's substate changes disabled
-- while Water is progressing. Only unlock for a retry if Water has genuinely
-- stalled for several seconds.
if drinkCommandLatched and drinkCommandCharacter ~= character then
goatPrint("[AutoDrink] Clearing stale Drinking lock from previous character")
drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = water
drinkCommandLastProgressAt = os.clock()
SetClientSubStateChangesEnabled(true)
end

if drinkCommandLatched then
local now = os.clock()

local animalNameNow = tostring(character:GetAttribute("AnimalName") or "")
local growthNow = tonumber(character:GetAttribute("Growth"))
or tonumber(character:GetAttribute("GrowthPercentage"))
or 1

local dlBabyTRexDrink =
game.GameId == 8198412649
and animalNameNow == "TRex"
and growthNow < 0.25

-- Baby TRex in DinoLife gains Water much more slowly and sometimes in sparse ticks.
-- Treat even tiny real gains as progress and give it a much larger stall window.
local progressEpsilon = dlBabyTRexDrink and 0.001 or 0.02
local stallTimeout = dlBabyTRexDrink and 30.0 or AUTO_DRINK_COMMAND_STALL_TIMEOUT

if water > drinkCommandLastWater + progressEpsilon then
drinkCommandLastWater = water
drinkCommandLastProgressAt = now

if dlBabyTRexDrink then
goatPrint(string.format(
"[AutoDrink] [DL] Baby TRex drink progress | water=%.1f%% | stall timer reset",
water
))
end
end

local heldFor = now - drinkCommandIssuedAt
local stalledFor = now - drinkCommandLastProgressAt

if heldFor < AUTO_DRINK_COMMAND_MIN_HOLD
or stalledFor < stallTimeout
then
return false
end

goatPrint(string.format(
"[AutoDrink] Drinking stalled — retry unlocked | water=%.1f%% | started=%.1f%% | stalled=%.1fs",
water,
drinkCommandWaterAtIssue,
stalledFor
))

drinkCommandLatched = false
drinkCommandCharacter = nil
drinkCommandIssuedAt = 0
drinkCommandWaterAtIssue = 0
drinkCommandLastWater = water
drinkCommandLastProgressAt = now
SetClientSubStateChangesEnabled(true)
end

-- DL baby TRex: if WaterEscape is already handling an accidental swim,
-- AutoDrink must wait until that recovery fully finishes. Otherwise both
-- systems try to move the same juvenile at the same time.
local autoDrinkAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local autoDrinkGrowth = tonumber(character:GetAttribute("Growth"))
or tonumber(character:GetAttribute("GrowthPercentage"))
or 1

local dlBabyTRexWaterEscape =
game.GameId == 8198412649
and autoDrinkAnimalName == "TRex"
and autoDrinkGrowth < 0.25
and globalWaterEscapeActive == true
and globalWaterEscapeCharacter == character

if dlBabyTRexWaterEscape then
drinkCommandLatched = false
drinkCommandCharacter = nil
SetClientSubStateChangesEnabled(true)

local now = os.clock()
if now - (tonumber(shared._dlBabyTRexWaterEscapeWaitLogAt) or 0) >= 2.0 then
shared._dlBabyTRexWaterEscapeWaitLogAt = now
goatPrint(string.format(
"[AutoDrink] [DL] Baby TRex waiting for WaterEscape to finish | state=%s | replicated=%s | water=%.1f%%",
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState")),
water
))
end

return false
end

-- Never switch to Drinking while Savannah already considers the animal submerged.
local submerged, submergedReason = isSubmergedForAutoDrink(character)
if submerged then
local submergedAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(submergedAnimalName)

drinkCommandLatched = false
SetClientSubStateChangesEnabled(true)

if fullyAquaticDL then
character:SetAttribute('_drinkingToFull', false)
character:SetAttribute('_returningToLand', false)
returningToLand = false
savedDrinkShorePoint = nil
savedLandPosition = nil

if (tonumber(shared._goatMosasaurusSubmergedOkLogAt) or 0) + 8 < os.clock() then
shared._goatMosasaurusSubmergedOkLogAt = os.clock()
goatPrint(string.format(
'[AutoDrink][DL] Mosasaurus Swimming/%s is valid — land recovery suppressed',
tostring(character:GetAttribute("ReplicatedMovementState"))
))
end

return false
end

goatPrint(string.format('[AutoDrink] Drinking blocked while submerged | reason=%s', tostring(submergedReason)))
-- Keep water priority latched. The shore-return routine decides whether
-- Water is truly full or whether AutoDrink must retry from safe land.
character:SetAttribute('_drinkingToFull', true)
if savedDrinkShorePoint then
returnToSavedDrinkShore(character)
else
beginReturnToLand(character)
end
return false
end

if autoDrinkApproachActive then
local staleCharacter = autoDrinkApproachCharacter ~= character
local staleTimeout =
autoDrinkApproachStartedAt > 0
and (os.clock() - autoDrinkApproachStartedAt) > AUTO_DRINK_APPROACH_HARD_TIMEOUT

local idleStall = false
local stallRoot = character:FindFirstChild("HumanoidRootPart")
local stallState = tostring(character:GetAttribute("MovementState") or "")
local stallReplicated = tonumber(character:GetAttribute("ReplicatedMovementState"))
local stallSwimming = stallState == "Swimming" or stallReplicated == 7

if not staleCharacter
and not stallSwimming
and stallRoot
then
local currentPos = stallRoot.Position
local lowVelocity = stallRoot.AssemblyLinearVelocity.Magnitude < 1.5
local appearsIdle =
stallState == "Idling"
or stallReplicated == 1

if appearsIdle and lowVelocity then
if autoDrinkIdleStallCharacter ~= character
or not autoDrinkIdleStallPosition
then
autoDrinkIdleStallCharacter = character
autoDrinkIdleStallSince = os.clock()
autoDrinkIdleStallPosition = currentPos
else
local flatMoved = Vector3.new(
currentPos.X - autoDrinkIdleStallPosition.X,
0,
currentPos.Z - autoDrinkIdleStallPosition.Z
).Magnitude

if flatMoved > AUTO_DRINK_IDLE_STALL_DISTANCE then
autoDrinkIdleStallSince = os.clock()
autoDrinkIdleStallPosition = currentPos
elseif os.clock() - autoDrinkIdleStallSince >= AUTO_DRINK_IDLE_STALL_TIME then
idleStall = true
end
end
else
autoDrinkIdleStallCharacter = character
autoDrinkIdleStallSince = os.clock()
autoDrinkIdleStallPosition = currentPos
end
else
autoDrinkIdleStallCharacter = nil
autoDrinkIdleStallSince = 0
autoDrinkIdleStallPosition = nil
end

if staleCharacter or staleTimeout or idleStall then
goatPrint(string.format(
"[AutoDrink] Approach watchdog cleared stale lock | characterChanged=%s | timeout=%s | idleStall=%s",
tostring(staleCharacter),
tostring(staleTimeout),
tostring(idleStall)
))

autoDrinkRouteGeneration = autoDrinkRouteGeneration + 1
autoDrinkApproachActive = false
autoDrinkApproachCharacter = nil
autoDrinkApproachStartedAt = 0

autoDrinkIdleStallCharacter = nil
autoDrinkIdleStallSince = 0
autoDrinkIdleStallPosition = nil

-- Allow an immediate fresh shore search after a confirmed idle stall.
if idleStall then
lastSafeWaterSearchAt = 0
SetClientSubStateChangesEnabled(true)
goatPrint(string.format(
"[AutoDrink] IDLE STALL recovery — restarting safe-water search | water=%.1f%%",
water
))
end
else
return false
end
end

local ingestionAvailable = CanStartEatDrink(character, true)
if ingestionAvailable == 'Eat' then ingestionAvailable = nil end

if ingestionAvailable == 'Drink'
and os.clock() < (tonumber(character:GetAttribute("_autoDrinkInvalidShoreUntil")) or 0)
then
do
    local nowLog = os.clock()
    local lastLog = tonumber(shared._autoDrinkLastRejectedShoreLogAt) or 0
    if (nowLog - lastLog) >= 10 then
        shared._autoDrinkLastRejectedShoreLogAt = nowLog
        goatPrint("[AutoDrink] Drinking command blocked | last shore was rejected")
    end
end
ingestionAvailable = nil
end

if ingestionAvailable == 'Drink' then
Animal.CancelTween(true)
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
local root = character:FindFirstChild('HumanoidRootPart')
if root and not savedDrinkPoint then
savedDrinkPoint = root.Position
savedWaterPosition = root.Position
end

SetGoatHudStatus(
'Auto Drink',
string.format('Bebendo • Água %.0f%%', water),
Color3.fromRGB(0, 170, 255)
)
SetClientSubStateChangesEnabled(false)

local blockedNow, blockedReason = isSubmergedForAutoDrink(character)
if blockedNow then
drinkCommandLatched = false
SetClientSubStateChangesEnabled(true)

local blockedAnimalName = tostring(character:GetAttribute("AnimalName") or "")
local fullyAquaticDL =
type(shared._goatIsDLFullyAquaticName) == "function"
and shared._goatIsDLFullyAquaticName(blockedAnimalName)

if fullyAquaticDL then
character:SetAttribute('_drinkingToFull', false)
character:SetAttribute('_returningToLand', false)
returningToLand = false
savedDrinkShorePoint = nil
savedLandPosition = nil
goatPrint('[AutoDrink][DL] Mosasaurus final submerged check accepted — staying in water')
return false
end

character:SetAttribute('_drinkingToFull', true)
goatPrint(string.format('[AutoDrink] Drinking cancelled at final check | reason=%s', tostring(blockedReason)))
if savedDrinkShorePoint then
returnToSavedDrinkShore(character)
else
beginReturnToLand(character)
end
return false
end

drinkCommandLatched = true
drinkCommandCharacter = character
drinkCommandIssuedAt = os.clock()
drinkCommandWaterAtIssue = water
drinkCommandLastWater = water
drinkCommandLastProgressAt = drinkCommandIssuedAt

goatPrint(string.format(
"[AutoDrink] Drinking started | water=%.1f%% | command locked",
water
))

ChangeCharacterSubState('Drinking')
if root then
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
end
return false
end

if goToNearestSource() then
startSafeDrinkApproach(character)
end
return false
end
}),
Checkbox({
label = 'Go to nearest food/water source',
shortLabel = 'Nearest food / water',
isChecked = goToNearestSource,
accent = Color3.fromRGB(0, 170, 255),
}),
}
end
function __DARKLUA_BUNDLE_MODULES.S()
local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local source = vide.source
local Animal = __DARKLUA_BUNDLE_MODULES.load('I')
local Checkbox = __DARKLUA_BUNDLE_MODULES.load('M')
local create = vide.create
local player = game:GetService('Players').LocalPlayer

local growNewSource = source(false)
local growExistingSource = source(false)
local spawnBeachSource = source(false)  -- independente: não toca nos grows
local questScannerSource = source(false) -- Auto Quest master toggle

return {
Checkbox({
label = 'Automatically leave from inside terrain',
shortLabel = 'Leave Terrain',
isChecked = true,
accent = Color3.fromRGB(0, 170, 255),
controlPriority = {character = 1},
WhileChecked = (function()
local terrainStreak = 0
local TERRAIN_REQUIRED = 10
local FELINE_BURIED_REQUIRED = 3
local FELINE_MIN_BURY_DEPTH = 2.25
local TERRAIN_RESCUE_COOLDOWN = 2.0
local lastTerrainRescueAt = 0

local terrainSurfaceParams = RaycastParams.new()
terrainSurfaceParams.FilterType = Enum.RaycastFilterType.Include
terrainSurfaceParams.FilterDescendantsInstances = { workspace.Terrain }

local function getBurialDepth(root)
if not root then return nil, nil end
local origin = root.Position + Vector3.new(0, 28, 0)
local result = workspace:Raycast(origin, Vector3.new(0, -60, 0), terrainSurfaceParams)
if not result or result.Material == Enum.Material.Water then
return nil, nil
end

return result.Position.Y - root.Position.Y, result.Position
end

local function rescueToSurface(character, root, surfacePosition)
if not character or not root or not surfacePosition then return false end
if os.clock() - lastTerrainRescueAt < TERRAIN_RESCUE_COOLDOWN then return false end

local humanoid = character:FindFirstChild("Humanoid")
local lift = math.max((humanoid and humanoid.HipHeight or 2), 2) + 0.75
local target = Vector3.new(root.Position.X, surfacePosition.Y + lift, root.Position.Z)
local rotation = root.CFrame - root.Position

lastTerrainRescueAt = os.clock()
root.CFrame = CFrame.new(target) * rotation
root.AssemblyLinearVelocity = Vector3.zero
root.AssemblyAngularVelocity = Vector3.zero
return true
end

return function()
local character = player.Character
if not character then return end
local root = character:FindFirstChild("HumanoidRootPart")
if not root then return end

if character:GetAttribute('_drinkingToFull')
or character:GetAttribute('_returningToLand')
or character:GetAttribute('_carcassInteractionLock')
then
terrainStreak = 0
return false
end

if shared._animalTweening then
terrainStreak = 0
return false
end

local animalName = character:GetAttribute("AnimalName") or ""
local isLionOrTiger = (animalName == "Lion" or animalName == "Tiger")

if isLionOrTiger then
local depth, surfacePosition = getBurialDepth(root)
if depth and depth >= FELINE_MIN_BURY_DEPTH then
terrainStreak = terrainStreak + 1
if terrainStreak >= FELINE_BURIED_REQUIRED then
terrainStreak = 0
if rescueToSurface(character, root, surfacePosition) then
goatPrint(string.format(
"[TerrainSafety] %s genuinely buried (depth=%.1f) — rescued to surface",
animalName, depth
))
end
end
else
terrainStreak = 0
end
return false
end

if Animal.IsInsideTerrain() then
terrainStreak = terrainStreak + 1
if terrainStreak < TERRAIN_REQUIRED then
return false
end
terrainStreak = 0

local depth, surfacePosition = getBurialDepth(root)
if depth and depth >= 2.25 and surfacePosition then
rescueToSurface(character, root, surfacePosition)
end
else
terrainStreak = 0
end

return false
end
end)(),
}),
Checkbox({
label = 'Grow new slots',
shortLabel = 'Grow New',
isChecked = growNewSource,
accent = Color3.fromRGB(0, 170, 255),
OnChanged = function(state)
if shared._setGrowNewSlots then
shared._setGrowNewSlots(state)
end
end,
}),
Checkbox({
label = 'Grow existing slots',
shortLabel = 'Grow Existing',
isChecked = growExistingSource,
accent = Color3.fromRGB(0, 170, 255),
OnChanged = function(state)
if shared._setGrowExistingSlots then
shared._setGrowExistingSlots(state)
end
end,
}),
Checkbox({
label = 'AFK Coins Farm',
isChecked = source(false),
accent = Color3.fromRGB(255, 195, 70),
OnChanged = function(state)
if shared._setParkingMode then
shared._setParkingMode(state)
end
end,
}),
Checkbox({
label = 'Spawn Beach mode (spawn + auto reset)',
shortLabel = 'Spawn Beach',
isChecked = spawnBeachSource,
accent = Color3.fromRGB(0, 170, 255),
labelColor = Color3.fromRGB(205, 218, 232),
OnChanged = function(state)
if shared._spawnBeachMode then
shared._spawnBeachMode(state)
end
end,
}),
Checkbox({
label = 'Auto Quest (Beta)',
shortLabel = 'Auto Quest',
isChecked = questScannerSource,
accent = Color3.fromRGB(0, 170, 255),
labelColor = Color3.fromRGB(205, 218, 232),
OnChanged = function(state)
if shared._setAutoQuest then
shared._setAutoQuest(state)
else
shared._autoQuestPendingState = state == true
end
end,
}),
}
end
function __DARKLUA_BUNDLE_MODULES.T()
local icons = __DARKLUA_BUNDLE_MODULES.load('E')
local survivalCarcass = __DARKLUA_BUNDLE_MODULES.load('R')
local growthSafety = __DARKLUA_BUNDLE_MODULES.load('S')

return {
icon = icons.untitled.icons['user-02'],
sections = {
{
name = 'Survival',
content = {survivalCarcass[1], survivalCarcass[3], survivalCarcass[4]},
},
{
name = 'Carcass',
content = {survivalCarcass[2]},
},
{
name = 'Growth',
content = {growthSafety[2], growthSafety[3], growthSafety[4], growthSafety[5]},
},
{
name = 'Safety',
content = {growthSafety[1]},
},
{
name = 'Quests',
content = {growthSafety[6]},
},
},
}
end
function __DARKLUA_BUNDLE_MODULES.X()
return {
categories = {
__DARKLUA_BUNDLE_MODULES.load('T'),
},
}
end
end

local vide = __DARKLUA_BUNDLE_MODULES.load('x')
local source = vide.source
local create = vide.create
local root = vide.root
local Window = __DARKLUA_BUNDLE_MODULES.load('C')
local Category = __DARKLUA_BUNDLE_MODULES.load('G')

function App()
local categories = {}
local containers = {}
local isOpenedSources = {}

for i, v in __DARKLUA_BUNDLE_MODULES.load('X').categories do
local isOpened = source(i == 1)

isOpenedSources[i] = isOpened

local category, container = Category({
icon = v.icon,
isOpened = isOpened,
sections = v.sections,
})

categories[i] = category
containers[i] = container
end

return create'ScreenGui'{
Window{
categories = categories,
containers = containers,
isOpenedSources = isOpenedSources,
},
}
end

if not game:IsLoaded() then
game.Loaded:Wait()
end

local toggleBtn = nil
local destroy
local hudStatusSetter = nil

destroy = root(function()
local app = App()

app.Parent = game:GetService('CoreGui')
app.ZIndexBehavior = Enum.ZIndexBehavior.Global

local hudWindow = app:FindFirstChild("TheGoatHUD", true)
if hudWindow then
local statusFrame = Instance.new("Frame")
statusFrame.Name = "ExecutionStatus"
statusFrame.AnchorPoint = Vector2.new(0, 1)
statusFrame.Position = UDim2.new(0, 7, 1, -8)
statusFrame.Size = UDim2.new(1, -14, 0, 88)
statusFrame.BackgroundColor3 = Color3.fromRGB(14, 24, 40)
statusFrame.BackgroundTransparency = 0.01
statusFrame.BorderSizePixel = 0
statusFrame.ZIndex = 20
statusFrame.Parent = hudWindow

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusFrame

local statusStroke = Instance.new("UIStroke")
statusStroke.Color = Color3.fromRGB(0, 170, 255)
statusStroke.Transparency = 0.10
statusStroke.Thickness = 1.15
statusStroke.Parent = statusFrame

local accentBar = Instance.new("Frame")
accentBar.Name = "Accent"
accentBar.Position = UDim2.new(0, 0, 0, 7)
accentBar.Size = UDim2.new(0, 2, 1, -14)
accentBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
accentBar.BorderSizePixel = 0
accentBar.ZIndex = 21
accentBar.Parent = statusFrame
local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(1, 0)
accentCorner.Parent = accentBar

local cap = Instance.new("TextLabel")
cap.Name = "Caption"
cap.BackgroundTransparency = 1
cap.Position = UDim2.fromOffset(9, 4)
cap.Size = UDim2.new(1, -82, 0, 11)
cap.Font = Enum.Font.GothamBold
cap.Text = "AÇÃO ATUAL  •  QUESTS"
cap.TextColor3 = Color3.fromRGB(92, 200, 255)
cap.TextSize = 9
cap.ZIndex = 22
cap.TextXAlignment = Enum.TextXAlignment.Left
cap.Parent = statusFrame

-- Status language only. Script logic, logs and internal feature names are untouched.
local statusLanguage = "USA"
shared._goatStatusLanguage = "USA"


local function L(brText, usText)
return statusLanguage == "USA" and usText or brText
end

-- ============================================================
-- DISPLAY-ONLY LANGUAGE LAYER
-- This never changes internal labels, quest parsing, remotes,
-- feature names used by logic, or any gameplay behavior.
-- It only changes TextLabel/TextButton text and HUD rendering.
-- ============================================================
local VISUAL_LANGUAGE_ENTRIES = {
{
BR = "SOBREVIVÊNCIA",
USA = "SURVIVAL",
aliases = {"Survival", "SURVIVAL", "Sobrevivência", "SOBREVIVÊNCIA"},
},
{
BR = "Comer automático",
USA = "Auto eat",
aliases = {"Auto eat", "Comer automático"},
},
{
BR = "Beber automático",
USA = "Auto drink",
aliases = {"Auto drink", "Beber automático"},
},
{
BR = "Comida / água próxima",
USA = "Nearest food / water",
aliases = {
"Nearest food / water",
"Go to nearest food/water source",
"Comida / água próxima",
},
},
{
BR = "CARCAÇA",
USA = "CARCASS",
aliases = {"Carcass", "CARCASS", "Carcaça", "CARCAÇA"},
},
{
BR = "Carcaça automática",
USA = "Auto Carcass",
aliases = {
"Auto Carcass",
"Auto eat carcass (patrol)",
"Carcaça automática",
},
},
{
BR = "CRESCIMENTO",
USA = "GROWTH",
aliases = {"Growth", "GROWTH", "Crescimento", "CRESCIMENTO"},
},
{
BR = "Crescer novo",
USA = "Grow New",
aliases = {"Grow New", "Grow new slots", "Crescer novo"},
},
{
BR = "Crescer existentes",
USA = "Grow Existing",
aliases = {
"Grow Existing",
"Grow existing slots",
"Crescer existentes",
},
},
{
BR = "Farm de moedas AFK",
USA = "AFK Coins Farm",
aliases = {"AFK Coins Farm", "Farm de moedas AFK"},
},
{
BR = "Praia de Spawn",
USA = "Spawn Beach",
aliases = {
"Spawn Beach",
"Spawn Beach mode (spawn + auto reset)",
"Praia de Spawn",
},
},
{
BR = "SEGURANÇA",
USA = "SAFETY",
aliases = {"Safety", "SAFETY", "Segurança", "SEGURANÇA"},
},
{
BR = "Sair do terreno",
USA = "Leave Terrain",
aliases = {
"Leave Terrain",
"Automatically leave from inside terrain",
"Sair do terreno",
},
},
{
BR = "MISSÕES",
USA = "QUESTS",
aliases = {"Quests", "QUESTS", "Missões", "MISSÕES"},
},
{
BR = "Missão automática",
USA = "Auto Quest",
aliases = {"Auto Quest", "Auto Quest (Beta)", "Missão automática"},
},
}

local VISUAL_LANGUAGE_LOOKUP = {}

for _, entry in ipairs(VISUAL_LANGUAGE_ENTRIES) do
VISUAL_LANGUAGE_LOOKUP[entry.BR] = entry
VISUAL_LANGUAGE_LOOKUP[entry.USA] = entry

for _, alias in ipairs(entry.aliases) do
VISUAL_LANGUAGE_LOOKUP[alias] = entry
end
end

local function translateExactVisualText(rawText)
local s = tostring(rawText or "")
local entry = VISUAL_LANGUAGE_LOOKUP[s]

if not entry then
return s
end

return statusLanguage == "USA" and entry.USA or entry.BR
end

local function translateQuestTitleForDisplay(rawTitle)
local s = tostring(rawTitle or "")

if statusLanguage == "USA" then
return s
end

local n = s:match("^Grow as any character for (%d+) minutes %(.-100%% growth%).$")
if n then
return "Cresça com qualquer personagem por "
.. tostring(n)
.. " minutos (< 100% de crescimento)."
end

n = s:match("^Play for atleast (%d+) minutes%.$")
if n then
return "Jogue por pelo menos " .. tostring(n) .. " minutos."
end

n = s:match("^Travel a distance of atleast (%d+) as any character%.$")
if n then
return "Percorra pelo menos "
.. tostring(n)
.. " de distância com qualquer personagem."
end

n = s:match("^Swim a distance of atleast (%d+) as any character%.$")
if n then
return "Nade pelo menos "
.. tostring(n)
.. " de distância com qualquer personagem."
end

n = s:match("^Be in a group with atleast one other player for (%d+) minutes%.$")
if n then
return "Fique em um grupo com pelo menos outro jogador por "
.. tostring(n)
.. " minutos."
end

n = s:match("^Be in a group with atleast one other player for (%d+) seconds%.$")
if n then
return "Fique em um grupo com pelo menos outro jogador por "
.. tostring(n)
.. " segundos."
end

-- Keep unknown/new Savannah quest names unchanged rather than risking
-- any wrong translation. Internal quest parsing never uses this copy.
return s
end

local translateMenuVisuals = nil

local function makeLanguageButton(name, textValue, xOffset)
local button = Instance.new("TextButton")
button.Name = name
button.AnchorPoint = Vector2.new(1, 0)
button.Position = UDim2.new(1, xOffset, 0, 2)
button.Size = UDim2.fromOffset(30, 14)
button.BackgroundColor3 = Color3.fromRGB(24, 39, 60)
button.BackgroundTransparency = 0.08
button.BorderSizePixel = 0
button.AutoButtonColor = true
button.Font = Enum.Font.GothamBold
button.Text = textValue
button.TextSize = 8
button.TextColor3 = Color3.fromRGB(145, 180, 215)
button.ZIndex = 25
button.Parent = statusFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = button

local stroke = Instance.new("UIStroke")
stroke.Name = "SelectionStroke"
stroke.Color = Color3.fromRGB(70, 110, 150)
stroke.Transparency = 0.30
stroke.Thickness = 1
stroke.Parent = button

return button
end

local brButton = makeLanguageButton("LanguageBR", "BR", -35)
local usaButton = makeLanguageButton("LanguageENG", "ENG", -2)

translateMenuVisuals = function()
if not app or not app.Parent then
return
end

for _, obj in ipairs(app:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextButton"))
and obj ~= brButton
and obj ~= usaButton
and not obj:IsDescendantOf(statusFrame)
then
local translated = translateExactVisualText(obj.Text)

if translated ~= obj.Text then
obj.Text = translated
end
end
end
end

local function updateLanguageButtons()
-- Visual language identity:
-- BR active = green, USA active = red.
-- Inactive button stays dark so the selected language is obvious.
local brSelected = Color3.fromRGB(34, 197, 94)
local usaSelected = Color3.fromRGB(239, 68, 68)
local idle = Color3.fromRGB(24, 39, 60)

local textSelected = Color3.fromRGB(255, 255, 255)
local textIdle = Color3.fromRGB(145, 180, 215)
local idleStroke = Color3.fromRGB(70, 110, 150)

local brActive = statusLanguage == "BR"
local usaActive = statusLanguage == "USA"

brButton.BackgroundColor3 = brActive and brSelected or idle
usaButton.BackgroundColor3 = usaActive and usaSelected or idle

brButton.TextColor3 = brActive and textSelected or textIdle
usaButton.TextColor3 = usaActive and textSelected or textIdle

local brStroke = brButton:FindFirstChild("SelectionStroke")
local usStroke = usaButton:FindFirstChild("SelectionStroke")

if brStroke then
brStroke.Color = brActive and brSelected or idleStroke
brStroke.Transparency = brActive and 0 or 0.30
end

if usStroke then
usStroke.Color = usaActive and usaSelected or idleStroke
usStroke.Transparency = usaActive and 0 or 0.30
end
end

updateLanguageButtons()
translateMenuVisuals()
cap.Text = L("AÇÃO ATUAL  •  MISSÕES", "CURRENT ACTION  •  QUESTS")

local actionLabel = Instance.new("TextLabel")
actionLabel.Name = "Action"
actionLabel.BackgroundTransparency = 1
actionLabel.Position = UDim2.fromOffset(9, 15)
actionLabel.Size = UDim2.new(1, -18, 0, 16)
actionLabel.Font = Enum.Font.GothamBold
actionLabel.Text = L("Aguardando...", "Waiting...")
actionLabel.TextColor3 = Color3.fromRGB(205, 222, 240)
actionLabel.TextSize = 12
actionLabel.ZIndex = 22
actionLabel.TextTruncate = Enum.TextTruncate.AtEnd
actionLabel.TextXAlignment = Enum.TextXAlignment.Left
actionLabel.Parent = statusFrame

local detailLabel = Instance.new("TextLabel")
detailLabel.Name = "Detail"
detailLabel.BackgroundTransparency = 1
detailLabel.Position = UDim2.fromOffset(9, 29)
detailLabel.Size = UDim2.new(1, -18, 0, 12)
detailLabel.Font = Enum.Font.GothamMedium
detailLabel.Text = L("Nenhuma ação em execução", "No action running")
detailLabel.TextColor3 = Color3.fromRGB(155, 185, 215)
detailLabel.TextSize = 10
detailLabel.ZIndex = 22
detailLabel.TextTruncate = Enum.TextTruncate.AtEnd
detailLabel.TextXAlignment = Enum.TextXAlignment.Left
detailLabel.Parent = statusFrame

local metricsLabel = Instance.new("TextLabel")
metricsLabel.Name = "Metrics"
metricsLabel.BackgroundTransparency = 1
metricsLabel.Position = UDim2.fromOffset(9, 72)
metricsLabel.Size = UDim2.new(1, -18, 0, 11)
metricsLabel.Font = Enum.Font.GothamMedium
metricsLabel.Text = "Animal --  •  F --  W --  G --"
metricsLabel.TextColor3 = Color3.fromRGB(120, 160, 205)
metricsLabel.TextSize = 10
metricsLabel.ZIndex = 22
metricsLabel.TextTruncate = Enum.TextTruncate.AtEnd
metricsLabel.TextXAlignment = Enum.TextXAlignment.Left
metricsLabel.Parent = statusFrame

local questLabel = Instance.new("TextLabel")
questLabel.Name = "QuestSummary"
questLabel.BackgroundTransparency = 1
questLabel.Position = UDim2.fromOffset(9, 42)
questLabel.Size = UDim2.new(1, -18, 0, 28)
questLabel.Font = Enum.Font.GothamMedium
questLabel.Text = L(
"MISSÕES • aguardando Missão automática",
"QUESTS • waiting for Auto Quest"
)
questLabel.TextColor3 = Color3.fromRGB(145, 180, 215)
questLabel.TextSize = 9
questLabel.TextWrapped = false
questLabel.TextTruncate = Enum.TextTruncate.AtEnd
questLabel.TextXAlignment = Enum.TextXAlignment.Left
questLabel.TextYAlignment = Enum.TextYAlignment.Top
questLabel.ZIndex = 22
questLabel.Parent = statusFrame

local function translateStatusText(rawText)
local s = tostring(rawText or "")

local actionExact = {
["Auto Drink"] = {BR = "Beber automático", USA = "Auto Drink"},
["Auto Carcass"] = {BR = "Carcaça automática", USA = "Auto Carcass"},
["Grow New"] = {BR = "Crescer novo", USA = "Grow New"},
["Grow Existing"] = {BR = "Crescer existentes", USA = "Grow Existing"},
["Spawn Beach"] = {BR = "Praia de Spawn", USA = "Spawn Beach"},
["Water Escape"] = {BR = "Saída da água", USA = "Water Escape"},
["Auto Quest • Grow"] = {BR = "Missão Auto • Crescer", USA = "Auto Quest • Grow"},
["Auto Quest • Travel"] = {BR = "Missão Auto • Viagem", USA = "Auto Quest • Travel"},
["Auto Quest • Swim"] = {BR = "Missão Auto • Natação", USA = "Auto Quest • Swim"},
["Auto Quest • Claim"] = {BR = "Missão Auto • Resgatar", USA = "Auto Quest • Claim"},
["Auto Quest • Passive"] = {BR = "Missão Auto • Passiva", USA = "Auto Quest • Passive"},
["Auto Quest • Zone"] = {BR = "Missão Auto • Zona", USA = "Auto Quest • Zone"},
}

local exactAction = actionExact[s]
if exactAction then
return statusLanguage == "USA" and exactAction.USA or exactAction.BR
end

if statusLanguage == "USA" then
local exact = {
["Aguardando..."] = "Waiting...",
["Nenhuma ação em execução"] = "No action running",
["Em execução"] = "Running",
["Carcass encontrada"] = "Carcass found",
["Voltando para terra"] = "Returning to land",
["Retorno para terra concluído"] = "Return to land complete",
["Retorno para margem concluído"] = "Return to shore complete",
["Terra alcançada"] = "Land reached",
["Entrou na água • procurando terra"] = "Entered water • searching for land",
["Entrou na água • voltando para terra"] = "Entered water • returning to land",
["Desativado"] = "Disabled",
["Ativado"] = "Enabled",
["Ativado • aguardando fome"] = "Enabled • waiting for hunger",
["Ativado • modo parking"] = "Enabled • parking mode",
["Ativado • ciclando slots"] = "Enabled • cycling slots",
["Abra Daily/Weekly • somente GUI visível"] = "Open Daily/Weekly • visible GUI only",
["Estrutural read-only • abra Daily/Weekly"] = "Structural read-only • open Daily/Weekly",
["Menu / sem personagem"] = "Menu / no character",
["QUESTS • aguardando Auto Quest"] = "QUESTS • waiting for Auto Quest",
["MISSÕES • aguardando Auto Quest"] = "QUESTS • waiting for Auto Quest",
["QUESTS • concluídas / aguardando claim"] = "QUESTS • completed / waiting for claim",
["MISSÕES • concluídas / aguardando resgate"] = "QUESTS • completed / waiting for claim",
["QUESTS • aguardando leitura"] = "QUESTS • waiting for scan",
["MISSÕES • aguardando leitura"] = "QUESTS • waiting for scan",
["ATIVA"] = "ACTIVE",
["PASSIVA"] = "PASSIVE",
["PAUSADA • animal 100%"] = "PAUSED • animal 100%",
["PAUSADA • sem slot <100%"] = "PAUSED • no slot <100%",
["CONCLUÍDA"] = "COMPLETED",
}

if exact[s] then
return exact[s]
end

s = s:gsub("Água ([%d%.]+%%) • procurando margem segura", "Water %1 • searching for safe shore")
s = s:gsub("Bebendo • Água ([%d%.]+%%)", "Drinking • Water %1")
s = s:gsub("([%d%.]+) studs de distância", "%1 studs away")
s = s:gsub("(%d+) cards reais • D (%d+) • W (%d+) • %? (%d+)",
"%1 real cards • D %2 • W %3 • ? %4")

s = s:gsub("^Semanal •", "Weekly •")
s = s:gsub("^Diária •", "Daily •")
s = s:gsub(" — mudando para ", " — switching to ")
s = s:gsub(" • mudando para ", " • switching to ")
s = s:gsub("procurando slot <100%%", "searching for slot <100%%")
s = s:gsub("restante ([^•]+)", "remaining %1")
s = s:gsub(" • CRESCENDO", " • GROWING")
s = s:gsub(" • Pulando", " • Skipping")
s = s:gsub("nenhum slot <100%% conseguiu spawn confirmado", "no <100%% slot got confirmed spawn")
s = s:gsub("próxima missão", "next mission")
s = s:gsub("tentar novamente em", "retry in")
s = s:gsub("erro ao executar missão", "mission execution error")
s = s:gsub("animal 100%% — mudando para ", "animal 100%% — switching to ")

return s
end

-- BR display
local exactBR = {
["Waiting..."] = "Aguardando...",
["No action running"] = "Nenhuma ação em execução",
["Running"] = "Em execução",
["Carcass found"] = "Carcaça encontrada",
["Returning to land"] = "Voltando para terra",
["Return to land complete"] = "Retorno para terra concluído",
["Return to shore complete"] = "Retorno para margem concluído",
["Land reached"] = "Terra alcançada",
["Disabled"] = "Desativado",
["Enabled"] = "Ativado",
["Enabled • waiting for hunger"] = "Ativado • aguardando fome",
["Enabled • parking mode"] = "Ativado • modo estacionamento",
["Enabled • cycling slots"] = "Ativado • ciclando slots",
["Menu / no character"] = "Menu / sem personagem",
["QUESTS • waiting for Auto Quest"] = "MISSÕES • aguardando Missão automática",
["QUESTS • completed / waiting for claim"] = "MISSÕES • concluídas / aguardando resgate",
["QUESTS • waiting for scan"] = "MISSÕES • aguardando leitura",
["ACTIVE"] = "ATIVA",
["PASSIVE"] = "PASSIVA",
["PAUSED • animal 100%"] = "PAUSADA • animal 100%",
["PAUSED • no slot <100%"] = "PAUSADA • sem slot <100%",
["COMPLETED"] = "CONCLUÍDA",
}

if exactBR[s] then
return exactBR[s]
end

s = s:gsub("Water ([%d%.]+%%) • searching for safe shore", "Água %1 • procurando margem segura")
s = s:gsub("Drinking • Water ([%d%.]+%%)", "Bebendo • Água %1")
s = s:gsub("([%d%.]+) studs away", "%1 studs de distância")

s = s:gsub("^Weekly •", "Semanal •")
s = s:gsub("^Daily •", "Diária •")
s = s:gsub(" — switching to ", " — mudando para ")
s = s:gsub(" • switching to ", " • mudando para ")
s = s:gsub("searching for slot <100%%", "procurando slot <100%%")
s = s:gsub("remaining ([^•]+)", "restante %1")
s = s:gsub(" • GROWING", " • CRESCENDO")
s = s:gsub(" • Skipping", " • Pulando")
s = s:gsub("no <100%% slot got confirmed spawn", "nenhum slot <100%% conseguiu spawn confirmado")
s = s:gsub("next mission", "próxima missão")
s = s:gsub("retry in", "tentar novamente em")
s = s:gsub("mission execution error", "erro ao executar missão")

return s
end

local lastRawAction = "Aguardando..."
local lastRawDetail = ""
local lastAccent = Color3.fromRGB(0, 170, 255)

local function renderHudStatus()
if not statusFrame.Parent then return end

local actionText = translateStatusText(lastRawAction)
local detailText = translateStatusText(lastRawDetail)

cap.Text = L("AÇÃO ATUAL  •  MISSÕES", "CURRENT ACTION  •  QUESTS")
actionLabel.Text = actionText
detailLabel.Text =
detailText ~= ""
and detailText
or L("Em execução", "Running")

local accent = typeof(lastAccent) == "Color3"
and lastAccent
or Color3.fromRGB(0, 170, 255)

accentBar.BackgroundColor3 = accent
statusStroke.Color = accent
actionLabel.TextColor3 = accent:Lerp(Color3.fromRGB(215, 228, 240), 0.42)
detailLabel.TextColor3 = accent:Lerp(Color3.fromRGB(155, 185, 215), 0.28)
metricsLabel.TextColor3 = accent:Lerp(Color3.fromRGB(120, 160, 205), 0.18)
end

hudStatusSetter = function(actionText, detailText, accentColor)
if not statusFrame.Parent then return end

lastRawAction = tostring(actionText or "Aguardando...")
lastRawDetail = tostring(detailText or "")
lastAccent =
typeof(accentColor) == "Color3"
and accentColor
or Color3.fromRGB(0, 170, 255)

renderHudStatus()
end
shared._goatHudSetStatus = hudStatusSetter

local function setStatusLanguage(language)
local normalized = language == "USA" and "USA" or "BR"

if normalized == statusLanguage then
return
end

statusLanguage = normalized
shared._goatStatusLanguage = normalized
updateLanguageButtons()
translateMenuVisuals()
renderHudStatus()

goatPrint("[HUD] Status language:", normalized)
end

brButton.MouseButton1Click:Connect(function()
setStatusLanguage("BR")
end)

usaButton.MouseButton1Click:Connect(function()
setStatusLanguage("USA")
end)

task.spawn(function()
while statusFrame.Parent and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
translateMenuVisuals()

local ch = game:GetService("Players").LocalPlayer.Character
if ch then
local animal = ch:GetAttribute("AnimalName") or "--"
local food = ch:GetAttribute("Food")
local water = ch:GetAttribute("Water")
local growth = ch:GetAttribute("GrowthPercentage")
local function pct(v)
if type(v) ~= "number" then return "--" end
local shown = v <= 1.05 and v * 100 or v
return tostring(math.floor(shown + 0.5)) .. "%"
end
metricsLabel.Text = string.format(
"%s  •  F %s  W %s  G %s",
tostring(animal), pct(food), pct(water), pct(growth)
)
else
metricsLabel.Text = L("Menu / sem personagem", "Menu / no character")
end

do
local quests = shared._autoQuestData
if type(quests) == "table" and #quests > 0 then
local rows = {}
local activeType = nil
local lock = shared._autoQuestHudLock
if type(lock) == "table" then
local a = tostring(lock.action or "")
if a:find("Swim", 1, true) then activeType = "SWIM_DISTANCE"
elseif a:find("Travel", 1, true) then activeType = "TRAVEL_DISTANCE"
elseif a:find("Grow", 1, true) then activeType = "GROW_TIME"
elseif a:find("Visit Zones", 1, true) then activeType = "VISIT_ZONES"
elseif a:find("Zone", 1, true) then activeType = "SURVIVE_ZONE"
elseif a:find("Animal", 1, true) then activeType = "SURVIVE_TIME"
end
end
for _, q in ipairs(quests) do
if not q.completed and #rows < 3 then
local cur, goal = q.progressCurrent, q.progressTarget
local prog = "?"
if type(cur) == "number" and type(goal) == "number" then
prog = string.format("%g/%g", cur, goal)
end
local qType = q.questType or q.type
local mode =
(qType == activeType)
and L("ATIVA", "ACTIVE")
or L("PASSIVA", "PASSIVE")

if qType == "GROUP_TIME" then
mode = L("PASSIVA", "PASSIVE")
end

if qType == "GROW_TIME" then
local gs = shared._autoQuestGrowState
if type(gs) == "table"
and gs.category == q.category
and gs.name == q.name
then
if gs.phase == "active" then
mode = string.format(
"%s • %s %s",
L("ATIVA", "ACTIVE"),
tostring(gs.animal or "?"),
tostring(gs.growthText or "")
)
elseif gs.phase == "switching" then
mode = L("PAUSADA • animal 100%", "PAUSED • animal 100%")
elseif gs.phase == "blocked" then
mode = L("PAUSADA • sem slot <100%", "PAUSED • no slot <100%")
elseif gs.phase == "complete" then
mode = L("CONCLUÍDA", "COMPLETED")
end
end
end

local title = translateQuestTitleForDisplay(
tostring(q.title or q.name or qType or "Quest")
)
if #title > 20 then title = title:sub(1, 19) .. "…" end
rows[#rows + 1] = string.format("%s • %s • %s", title, prog, mode)
end
end
questLabel.Text =
#rows > 0
and table.concat(rows, "\n")
or L(
"MISSÕES • concluídas / aguardando resgate",
"QUESTS • completed / waiting for claim"
)
else
questLabel.Text = L(
"MISSÕES • aguardando leitura",
"QUESTS • waiting for scan"
)
end
end

local pendingHud = shared._autoQuestPendingHud
if type(pendingHud) == "table" then
shared._autoQuestPendingHud = nil
pcall(
hudStatusSetter,
pendingHud.action,
pendingHud.detail or "",
pendingHud.color
)
end

task.wait(1)
end
end)
end

shared.LECleanup = function()
shared._autoQuestHudLock = nil
if shared._goatHudSetStatus == hudStatusSetter then
shared._goatHudSetStatus = nil
end
destroy()
app:Destroy()
if toggleBtn then toggleBtn:Destroy() end
end

local restoreGui = Instance.new("ScreenGui")
restoreGui.Name = "TheGoatPremiumRestore"
restoreGui.ResetOnSpawn = false
restoreGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
restoreGui.Parent = game:GetService('CoreGui')

local restoreBtn = Instance.new("TextButton")
restoreBtn.Name = "RestoreButton"
restoreBtn.Size = UDim2.new(0, 78, 0, 24)
restoreBtn.Position = UDim2.new(0, 10, 0, 72)
restoreBtn.BackgroundColor3 = Color3.fromRGB(9, 14, 23)
restoreBtn.BackgroundTransparency = 0.06
restoreBtn.BorderSizePixel = 0
restoreBtn.AutoButtonColor = true
restoreBtn.Text = "THE GOAT"
restoreBtn.TextColor3 = Color3.fromRGB(160, 220, 255)
restoreBtn.TextSize = 9
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.Visible = false
restoreBtn.Parent = restoreGui

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 7)
restoreCorner.Parent = restoreBtn

local restoreStroke = Instance.new("UIStroke")
restoreStroke.Color = Color3.fromRGB(0, 190, 255)
restoreStroke.Thickness = 1
restoreStroke.Transparency = 0.24
restoreStroke.Parent = restoreBtn

local guiVisible = true
local header = hudWindow and hudWindow:FindFirstChild("Header")
if header then
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeButton"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(12, 22, 36)
minimizeBtn.BackgroundTransparency = 0.04
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Size = UDim2.fromOffset(18, 18)
minimizeBtn.AutoButtonColor = true
minimizeBtn.LayoutOrder = 100
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.fromRGB(175, 230, 255)
minimizeBtn.TextSize = 15
minimizeBtn.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 5)
minCorner.Parent = minimizeBtn

local minStroke = Instance.new("UIStroke")
minStroke.Color = Color3.fromRGB(0, 170, 230)
minStroke.Transparency = 0.34
minStroke.Thickness = 1
minStroke.Parent = minimizeBtn

minimizeBtn.MouseButton1Click:Connect(function()
guiVisible = false
if hudWindow then
hudWindow.Visible = false
end
restoreBtn.Visible = true
end)
end

restoreBtn.MouseButton1Click:Connect(function()
guiVisible = true
if hudWindow then
hudWindow.Visible = true
end
restoreBtn.Visible = false
end)

local restoreDragging = false
local restoreDragStart = nil
local restoreStartPos = nil

restoreBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
restoreDragging = true
restoreDragStart = input.Position
restoreStartPos = restoreBtn.Position
end
end)

restoreBtn.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
restoreDragging = false
end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
if restoreDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - restoreDragStart
restoreBtn.Position = UDim2.new(
restoreStartPos.X.Scale,
restoreStartPos.X.Offset + delta.X,
restoreStartPos.Y.Scale,
restoreStartPos.Y.Offset + delta.Y
)
end
end)

toggleBtn = restoreGui
end)

do
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local questScannerEnabled = false
local lastQuestSnapshot = nil
local lastNoQuestReason = nil

shared._questScannerData = {}
shared._questScannerEnabled = false

local function qclean(value)
local s = tostring(value or "")
s = s:gsub("<[^>]->", "")
s = s:gsub("[%c]", " ")
s = s:gsub("%s+", " ")
s = s:match("^%s*(.-)%s*$") or ""
return s
end

local function qlower(value)
return string.lower(qclean(value))
end

local function isTextObject(obj)
return obj and (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox"))
end

local function readText(obj)
if not isTextObject(obj) then return "" end
local ok, value = pcall(function() return obj.Text end)
return ok and qclean(value) or ""
end

local function isActuallyVisible(obj)
local current = obj
while current do
if current:IsA("ScreenGui") then
if current.Enabled == false then return false end
elseif current:IsA("GuiObject") then
if current.Visible == false then return false end
end
current = current.Parent
end
return true
end

local function parseNumber(raw)
if raw == nil then return nil end
return tonumber((tostring(raw):gsub(",", "")))
end

local function parseProgressLabel(textValue)
local s = qclean(textValue)
local lower = string.lower(s)

local a, b = s:match("^([%d,]+%.?%d*)%s*/%s*([%d,]+%.?%d*)%s*$")
if not a then
a, b = s:match("^[Pp]rogress:?%s*([%d,]+%.?%d*)%s*/%s*([%d,]+%.?%d*)%s*$")
end
if a and b then
return parseNumber(a), parseNumber(b), "count"
end

local pa, pb = s:match("^([%d%.]+)%s*%%%s*/%s*([%d%.]+)%s*%%%s*$")
if pa and pb then
return tonumber(pa), tonumber(pb), "percent"
end

local am, as, bm, bs = s:match("^(%d+):(%d%d)%s*/%s*(%d+):(%d%d)$")
if am and as and bm and bs then
return tonumber(am) * 60 + tonumber(as), tonumber(bm) * 60 + tonumber(bs), "seconds"
end

return nil, nil, nil
end

local function isClaimText(textValue)
local s = qlower(textValue)
return s == "claim" or s == "claim reward" or s == "collect" or s == "collect reward"
end

local noiseFragments = {
"gamepass", "update log", "use code", "settings", "server list",
"select a server", "join random server", "hide other players", "speech bubbles",
"reflections", "swaying trees", "still loading your save", "are you sure you want to reset",
"clear saved growth", "walk/run toggle", "your boost:", "drag a button to move it",
"noyo hat", "noyo mug", "plus subscribers", "coins multiplier", "faster than all characters",
}

local function containsNoise(textValue)
local s = qlower(textValue)
if s:sub(1, 1) == "•" then return true end
for _, fragment in ipairs(noiseFragments) do
if s:find(fragment, 1, true) then return true end
end
return false
end

local function looksLikeQuestSentence(textValue)
local s = qclean(textValue)
local lower = string.lower(s)
if #s < 8 or #s > 220 then return false end
if containsNoise(s) then return false end
if isClaimText(s) then return false end
if parseProgressLabel(s) then return false end

local starters = {
"be ", "grow ", "play ", "survive ", "travel ", "keep ", "eat ", "drink ",
"stay ", "spend ", "visit ", "reach ", "join ", "remain ", "run ", "walk ",
"swim ", "swimming ", "nade ", "nadar ",
}
for _, starter in ipairs(starters) do
if lower:sub(1, #starter) == starter then return true end
end

if lower:find("atleast", 1, true) or lower:find("at least", 1, true) then return true end
if lower:find("for %d+ minute") or lower:find("distance of atleast", 1, true) then return true end
if lower:find("food and water stats", 1, true) and lower:find("above", 1, true) then return true end

return false
end

local function classifyQuest(name)
local s = qlower(name)

if game.GameId == 8198412649 then
if s:find("survive", 1, true) and s:find("at night", 1, true) then
return "NIGHT_OWL"
end
if s:find("travel", 1, true)
and s:find("distance", 1, true)
and s:find("on land", 1, true)
then
return "LAND_DISTANCE"
end
end

-- New Daily/Weekly quest: Visit N different zones as any character.
if s:find("visit", 1, true) and s:find("different zone", 1, true) then
return "VISIT_ZONES"
end

if s:find("swim", 1, true) or s:match("^nade%s") or s:match("^nadar%s") then
return "SWIM_DISTANCE"
end

if s:find("group", 1, true) and (s:find("minute", 1, true) or s:find("hour", 1, true)) then
return "GROUP_TIME"
end
if s:find("grow as", 1, true) or (s:find("growth", 1, true) and s:find("minute", 1, true)) then
return "GROW_TIME"
end
if s:find("play for", 1, true) then
return "PLAY_TIME"
end
if s:find("survive", 1, true) and s:find("zone", 1, true) then
return "SURVIVE_ZONE"
end
if s:find("survive", 1, true) or s:find("stay alive", 1, true) then
return "SURVIVE_TIME"
end
if s:find("travel", 1, true) and s:find("distance", 1, true) then
return "TRAVEL_DISTANCE"
end
if s:find("food and water stats", 1, true) and s:find("above", 1, true) then
return "MAINTAIN_STATS"
end
if s:find("drink", 1, true) or s:find("water", 1, true) then
return "DRINK"
end
if s:find("eat", 1, true) or s:find("food", 1, true) or s:find("carcass", 1, true) then
return "EAT"
end
return "UNKNOWN"
end

local function inferTargetFromName(name)
local lower = qlower(name)
local n = lower:match("for%s+atleast%s+(%d+)%s+minutes?")
or lower:match("for%s+at least%s+(%d+)%s+minutes?")
or lower:match("for%s+(%d+)%s+minutes?")
if n then return tonumber(n) * 60, "seconds" end

n = lower:match("for%s+(%d+)%s+hours?")
if n then return tonumber(n) * 3600, "seconds" end

n = lower:match("distance%s+of%s+atleast%s+([%d,]+)")
or lower:match("distance%s+of%s+at%s+least%s+([%d,]+)")
if n then return parseNumber(n), "distance" end
n = lower:match("pelo%s+menos%s+([%d.,]+)")
if n and (lower:find("nade", 1, true) or lower:find("nadar", 1, true)) then
return tonumber((n:gsub("[.,]", ""))), "distance"
end

return nil, nil
end

local function categoryFromNode(node)
local current = node
for _ = 1, 10 do
if not current then break end
local n = string.lower(current.Name or "")
if n:find("daily", 1, true) then return "Daily" end
if n:find("weekly", 1, true) then return "Weekly" end
current = current.Parent
end
return "Unknown"
end

local function collectVisibleTexts(container)
local texts = {}
local textObjects = {}
local okDesc, descendants = pcall(function() return container:GetDescendants() end)
if not okDesc or not descendants then return texts, textObjects end

for i = 1, math.min(#descendants, 120) do
local obj = descendants[i]
if isTextObject(obj) and isActuallyVisible(obj) then
local t = readText(obj)
if t ~= "" then
texts[#texts + 1] = t
textObjects[#textObjects + 1] = obj
end
end
end
return texts, textObjects
end

local function inspectCandidateCard(container)
local texts, textObjects = collectVisibleTexts(container)
local questTexts = {}
local progressCurrent, progressTarget, progressUnit = nil, nil, nil
local claimButton = nil

for i, t in ipairs(texts) do
local obj = textObjects[i]
local cur, target, unit = parseProgressLabel(t)
if cur and target then
if not progressTarget or target > progressTarget then
progressCurrent, progressTarget, progressUnit = cur, target, unit
end
elseif obj:IsA("TextButton") and isClaimText(t) then
claimButton = obj
elseif looksLikeQuestSentence(t) then
questTexts[#questTexts + 1] = t
end
end

table.sort(questTexts, function(a, b) return #a > #b end)
local description = questTexts[1]
local title = nil
if #questTexts > 1 then
for i = #questTexts, 2, -1 do
if questTexts[i] ~= description and #questTexts[i] <= 80 then
title = questTexts[i]
break
end
end
end

return {
texts = texts,
questTexts = questTexts,
description = description,
title = title,
progressCurrent = progressCurrent,
progressTarget = progressTarget,
progressUnit = progressUnit,
claimButton = claimButton,
category = categoryFromNode(container),
}
end

local function scoreCard(info, depth)
if not info or not info.description then return -999 end
local score = 0
if info.progressTarget then score = score + 8 end
if info.claimButton then score = score + 5 end
if info.category ~= "Unknown" then score = score + 2 end
if #info.texts >= 2 and #info.texts <= 14 then score = score + 3 end
if #info.texts > 24 then score = score - 8 end
score = score - (depth * 0.35) -- prefer the smallest useful ancestor
return score
end

local function findCardFromAnchor(anchor)
local bestCard, bestInfo, bestScore = nil, nil, -999
local current = anchor.Parent
for depth = 1, 7 do
if not current then break end
if current:IsA("GuiObject") and isActuallyVisible(current) then
local info = inspectCandidateCard(current)
local score = scoreCard(info, depth)
if score > bestScore then
bestCard, bestInfo, bestScore = current, info, score
end
end
current = current.Parent
end
if bestScore < 7 then return nil, nil end
return bestCard, bestInfo
end

local function scanQuestGui()
local playerGui = player:FindFirstChildOfClass("PlayerGui")
if not playerGui then return {}, "PlayerGui ainda não disponível" end

local okDesc, descendants = pcall(function() return playerGui:GetDescendants() end)
if not okDesc or not descendants then return {}, "Falha ao ler PlayerGui" end

local anchors = {}
for _, obj in ipairs(descendants) do
if isTextObject(obj) and isActuallyVisible(obj) then
local t = readText(obj)
local cur, target = parseProgressLabel(t)
if cur and target then
anchors[#anchors + 1] = obj
elseif obj:IsA("TextButton") and isClaimText(t) then
anchors[#anchors + 1] = obj
end
end
end

local quests = {}
local seenCards = {}
for _, anchor in ipairs(anchors) do
local card, info = findCardFromAnchor(anchor)
if card and info and not seenCards[card] then
seenCards[card] = true

local name = info.description
local current = info.progressCurrent
local target = info.progressTarget
local unit = info.progressUnit
if not target then
target, unit = inferTargetFromName(name)
end

local completed = current ~= nil and target ~= nil and target > 0 and current >= target
local path = "?"
pcall(function() path = card:GetFullName() end)

quests[#quests + 1] = {
category = info.category,
title = info.title,
name = name,
questType = classifyQuest(name),
progressCurrent = current,
progressTarget = target,
progressUnit = unit,
claimVisible = info.claimButton ~= nil,
completed = completed,
source = "visible_card",
path = path,
}
end
end

table.sort(quests, function(a, b)
local order = {Daily = 1, Weekly = 2, Unknown = 3}
local ao = order[a.category] or 9
local bo = order[b.category] or 9
if ao ~= bo then return ao < bo end
return string.lower(a.name or "") < string.lower(b.name or "")
end)

return quests, nil
end

local function progressString(q)
local current, target, unit = q.progressCurrent, q.progressTarget, q.progressUnit
if current ~= nil and target ~= nil then
if unit == "seconds" then return string.format("%g/%gs", current, target) end
if unit == "percent" then return string.format("%g/%g%%", current, target) end
return string.format("%g/%g", current, target)
elseif target ~= nil then
if unit == "seconds" then return string.format("?/%gs", target) end
return string.format("?/%g", target)
end
return "sem progresso explícito"
end

local function buildSnapshot(quests)
local parts = {}
for _, q in ipairs(quests) do
parts[#parts + 1] = table.concat({
q.category or "?", q.title or "", q.name or "?", q.questType or "?",
tostring(q.progressCurrent), tostring(q.progressTarget), tostring(q.claimVisible),
tostring(q.completed), q.path or "?",
}, "|")
end
return table.concat(parts, "\n")
end

local function qcolor(c)
if typeof(c) ~= "Color3" then return "?" end
return string.format("%d,%d,%d", math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5))
end

local function describeTabHints()
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local questGui = playerGui and playerGui:FindFirstChild("QuestsScreenGui")
if not questGui then
goatPrint("[QuestScannerV3][TAB] QuestsScreenGui não encontrado")
return
end

local hints = {}
for _, obj in ipairs(questGui:GetDescendants()) do
if isTextObject(obj) then
local t = readText(obj)
local l = string.lower(t)
if l == "daily" or l == "weekly" or l:find("daily quests", 1, true) or l:find("weekly quests", 1, true) then
local path = "?"
pcall(function() path = obj:GetFullName() end)
local bg = "-"
local tc = "-"
local bt = "-"
if obj:IsA("GuiObject") then
pcall(function() bg = qcolor(obj.BackgroundColor3) end)
pcall(function() bt = tostring(obj.BackgroundTransparency) end)
end
pcall(function() tc = qcolor(obj.TextColor3) end)
hints[#hints+1] = string.format(
"%s text=%s vis=%s bg=%s bt=%s textColor=%s path=%s",
obj.ClassName, t, tostring(isActuallyVisible(obj)), bg, bt, tc, path
)
end
end
end

if #hints == 0 then
goatPrint("[QuestScannerV3][TAB] nenhum texto Daily/Weekly detectado")
else
for i, line in ipairs(hints) do
goatPrint(string.format("[QuestScannerV3][TAB] #%d %s", i, line))
end
end
end

local function describeCardButtons(q)
if not q or not q.path then return end
local playerGui = player:FindFirstChildOfClass("PlayerGui")
if not playerGui then return end

local frameName = tostring(q.path):match("(QuestFrame%d+)")
local questGui = playerGui:FindFirstChild("QuestsScreenGui")
local scroll = questGui and questGui:FindFirstChild("Frame") and questGui.Frame:FindFirstChild("RefScrollingFrame")
local frame = scroll and frameName and scroll:FindFirstChild(frameName)
if not frame then return end

local rows = {}
for _, obj in ipairs(frame:GetDescendants()) do
if obj:IsA("TextButton") or obj:IsA("ImageButton") then
local txt = obj:IsA("TextButton") and readText(obj) or ""
local path = "?"
pcall(function() path = obj:GetFullName() end)
local active, interactable = "?", "?"
pcall(function() active = tostring(obj.Active) end)
pcall(function() interactable = tostring(obj.Interactable) end)
rows[#rows+1] = string.format(
"%s name=%s text=%s visible=%s active=%s interactable=%s path=%s",
obj.ClassName, obj.Name, txt ~= "" and txt or "-", tostring(isActuallyVisible(obj)), active, interactable, path
)
end
end

if #rows == 0 then
goatPrint(string.format("[QuestScannerV3][BUTTONS] %s | nenhum botão no card", q.title or q.name or "?"))
else
for i = 1, math.min(#rows, 12) do
goatPrint(string.format("[QuestScannerV3][BUTTONS] %s | %s", q.title or q.name or "?", rows[i]))
end
end
end

local function publishStructuralDiagnostics(quests)
describeTabHints()
for _, q in ipairs(quests) do
describeCardButtons(q)
end
end

local function publishQuestScan(quests)
shared._questScannerData = quests

local daily, weekly, unknown = 0, 0, 0
for _, q in ipairs(quests) do
if q.category == "Daily" then daily = daily + 1
elseif q.category == "Weekly" then weekly = weekly + 1
else unknown = unknown + 1 end
end

goatPrint(string.format(
"[QuestScannerV3] ===== %d card(s) REAL(is) | Daily=%d | Weekly=%d | Unknown=%d =====",
#quests, daily, weekly, unknown
))

for i, q in ipairs(quests) do
goatPrint(string.format(
"[QuestScannerV3] #%d [%s] titulo=%s | missao=%s | tipo=%s | progresso=%s | claimVisivel=%s | concluida=%s | path=%s",
i,
q.category,
q.title or "-",
q.name,
q.questType,
progressString(q),
tostring(q.claimVisible),
tostring(q.completed),
q.path or "?"
))
end

publishStructuralDiagnostics(quests)

if #quests == 0 then
goatPrint("[QuestScannerV3] Nenhum card de missão VISÍVEL encontrado.")
goatPrint("[QuestScannerV3] Abra a tela Daily ou Weekly e deixe os cards visíveis durante o scan.")
end

if shared._goatHudSetStatus then
if #quests > 0 then
shared._goatHudSetStatus(
"Quest Scanner V3",
string.format("%d cards reais • D %d • W %d • ? %d", #quests, daily, weekly, unknown),
Color3.fromRGB(0, 170, 255)
)
else
shared._goatHudSetStatus(
"Quest Scanner V3",
"Abra Daily/Weekly • somente GUI visível",
Color3.fromRGB(0, 170, 255)
)
end
end
end

shared._scanQuestsNow = function()
local quests, err = scanQuestGui()
if err then
goatWarn("[QuestScannerV3] " .. tostring(err))
return quests
end
publishQuestScan(quests)
lastQuestSnapshot = buildSnapshot(quests)
return quests
end

shared._setQuestScanner = function(state)
questScannerEnabled = state == true
shared._questScannerEnabled = questScannerEnabled
lastQuestSnapshot = nil
lastNoQuestReason = nil

goatPrint("[QuestScannerV3]", questScannerEnabled and "ATIVADO (STRUCTURE READ-ONLY)" or "DESATIVADO")
if shared._goatHudSetStatus then
shared._goatHudSetStatus(
"Quest Scanner V3",
questScannerEnabled and "Estrutural read-only • abra Daily/Weekly" or "Desativado",
questScannerEnabled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(130, 145, 165)
)
end
end

if shared._questScannerPendingState ~= nil then
shared._setQuestScanner(shared._questScannerPendingState == true)
shared._questScannerPendingState = nil
end

task.spawn(function()
while shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
if questScannerEnabled then
local quests, err = scanQuestGui()
if err then
if err ~= lastNoQuestReason then
lastNoQuestReason = err
goatWarn("[QuestScannerV3] " .. tostring(err))
end
else
lastNoQuestReason = nil
local snapshot = buildSnapshot(quests)
if snapshot ~= lastQuestSnapshot then
lastQuestSnapshot = snapshot
publishQuestScan(quests)
end
end
end
task.wait(3)
end
end)
end

task.spawn(function()
local VirtualUser = game:GetService("VirtualUser")
trackRuntimeConnection(game:GetService("Players").LocalPlayer.Idled:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
task.wait(1)
VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end))
end)
task.spawn(function()
local VirtualUser = game:GetService("VirtualUser")
local camera = workspace.CurrentCamera
while true do
task.wait(240) -- every 4 minutes
pcall(function()
local cf = camera.CFrame
camera.CFrame = cf * CFrame.Angles(0, math.rad(0.5), 0)
task.wait(0.1)
camera.CFrame = cf
end)
pcall(function()
VirtualUser:Button2Down(Vector2.new(0, 0), camera.CFrame)
task.wait(0.1)
VirtualUser:Button2Up(Vector2.new(0, 0), camera.CFrame)
end)
pcall(function()
VirtualUser:KeyDown(0x57) -- W key
task.wait(0.1)
VirtualUser:KeyUp(0x57)
end)
end
end)
task.spawn(function()
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer
trackRuntimeConnection(RunService.Heartbeat:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
if player.Character then
pcall(function() player.Character:SetAttribute("Stamina", 100) end)
end
end))
end)
task.spawn(function()
local RunService = game:GetService("RunService")
local Lighting   = game:GetService("Lighting")
trackRuntimeConnection(RunService.Heartbeat:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
Lighting.ClockTime = 12
end))
end)
task.spawn(function()
local Players       = game:GetService("Players")
local RS            = game:GetService("ReplicatedStorage")
local CoreGui       = game:GetService("CoreGui")
local RunService    = game:GetService("RunService")
local player        = Players.LocalPlayer

local GAME_CONFIGS = {
[6174994284] = {
name           = "SavannahLife",
expectedAnimal = nil, -- any Savannah saved animal is valid
growSpawn      = Vector3.new(-6711.7, 10.8, 2929.6),
warSpawn       = Vector3.new(-6089.58, -1.15, 4203.44),
safePos        = Vector3.new(-6711.7, 10.8, 2929.6),
beachReset     = Vector3.new(-6417.24560546875, 5.450773812812793, 4339.9563128125),
dangerY        = -100,
babySpawnArgs  = {
Elephant = "Elephant",
Lion     = "Lion",
Giraffe  = "Giraffe",
Hippo    = "Hippo",
Rhino    = "Rhino",
Impala   = "Impala",
Cheetah  = "Cheetah",
Crocodile = "Crocodile",
Croc = "Croc",
WildDog  = "WildDog",
["Wild Dog"] = "Wild Dog",
AfricanWildDog = "AfricanWildDog",
["African Wild Dog"] = "African Wild Dog",
},
},
[18214855317] = {
name           = "SavannahLife",
expectedAnimal = nil, -- any Savannah saved animal is valid
growSpawn      = Vector3.new(-6711.7, 10.8, 2929.6),
warSpawn       = Vector3.new(-6089.58, -1.15, 4203.44),
safePos        = Vector3.new(-6711.7, 10.8, 2929.6),
beachReset     = Vector3.new(-6417.24560546875, 5.450773812812793, 4339.9563128125),
dangerY        = -100,
babySpawnArgs  = {
Elephant = "Elephant",
Lion     = "Lion",
Giraffe  = "Giraffe",
Hippo    = "Hippo",
Rhino    = "Rhino",
Impala   = "Impala",
Cheetah  = "Cheetah",
Crocodile = "Crocodile",
Croc = "Croc",
WildDog  = "WildDog",
["Wild Dog"] = "Wild Dog",
AfricanWildDog = "AfricanWildDog",
["African Wild Dog"] = "African Wild Dog",
},
},
[9237322219] = {
name           = "JungleLife",
expectedAnimal = "Gorilla",    -- warns if a slot isn't a Gorilla
growSpawn      = Vector3.new(1166.8350830078125, 24.75099754333496, -358.32073974609375),
warSpawn       = Vector3.new(1166.8350830078125, 24.75099754333496, -358.32073974609375),
safePos        = Vector3.new(1166.8350830078125, 24.75099754333496, -358.32073974609375),
beachReset     = Vector3.new(1259.171, 23.215, -365.520), -- JL: destino ao chegar em 100%
dangerY        = -100,
babySpawnArgs  = {
Gorilla  = "Gorilla",
},
},
[8198412649] = {
name           = "DinoLife",
expectedAnimal = nil,
growSpawn      = Vector3.new(335.063, 55.712, 19.966),
warSpawn       = Vector3.new(335.063, 55.712, 19.966),
safePos        = Vector3.new(335.063, 55.712, 19.966),
beachReset     = Vector3.new(335.063, 55.712, 19.966), -- DL: destino ao chegar em 100%
dangerY        = -100,
babySpawnArgs  = {}, -- DL: generic; falls back to the exact AnimalName
},
}

local function detectConfigByAnimal()
local deadline = tick() + 15
while tick() < deadline do
local ch = player.Character
if ch then
local animal = ch:GetAttribute("AnimalName")
if animal and animal ~= "" then
local JUNGLE_ANIMALS = { Gorilla=true, Chimpanzee=true, Leopard=true, Mandrill=true }
if JUNGLE_ANIMALS[animal] then
goatPrint("[GrowthLoop] Animal-detection: " .. animal .. " -> JungleLife")
return GAME_CONFIGS[9237322219]
end
local DINO_ANIMALS = {
Deinosuchus=true,
Mosasaurus=true,
WaterSpinosaurus=true,
Pteranodon=true,
Ankylosaurus=true,
Brachiosaurus=true,
Carnotaurus=true,
Gallimimus=true,
LandSpinosaurus=true,
Pachycephalosaurus=true,
Stegosaurus=true,
TRex=true,
Triceratops=true,
Velociraptor=true,

-- Legacy aliases kept for compatibility.
Rex=true,
["T-Rex"]=true,
Tyrannosaurus=true,
["Tyrannosaurus Rex"]=true,
}
if DINO_ANIMALS[animal] then
goatPrint("[GrowthLoop] Animal-detection: " .. animal .. " -> DinoLife")
return GAME_CONFIGS[8198412649]
end
local SAVANNAH_ANIMALS = { Elephant=true, Lion=true, Giraffe=true, Hippo=true, Rhino=true, Impala=true, Zebra=true, Cheetah=true, Hyena=true, Wildbeest=true, Crocodile=true, Croc=true, WildDog=true, ["Wild Dog"]=true, AfricanWildDog=true, ["African Wild Dog"]=true }
if SAVANNAH_ANIMALS[animal] then
goatPrint("[GrowthLoop] Animal-detection: " .. animal .. " -> SavannahLife")
return GAME_CONFIGS[18214855317]
end
goatWarn("[GrowthLoop] Unknown animal: " .. tostring(animal))
return nil
end
end
task.wait(0.5)
end
goatWarn("[GrowthLoop] Animal-detection timed out")
return nil
end

local gameConfig = GAME_CONFIGS[game.GameId]
if not gameConfig then
goatWarn("[GrowthLoop] GameId " .. tostring(game.GameId) .. " not recognised - waiting for character to detect by animal")
gameConfig = detectConfigByAnimal()
if not gameConfig then
goatWarn("[GrowthLoop] Detection failed - defaulting to SavannahLife config")
gameConfig = GAME_CONFIGS[18214855317]
end
end
shared._growthGameName = gameConfig.name
goatPrint("[GrowthLoop] Detected game: " .. gameConfig.name)

local growNewSlots      = false
local growExistingSlots = false
local spawnBeachActive  = false  -- Spawn Beach mode ON = cicla slots pela praia

shared._growNewSlotsActive = false
shared._growExistingSlotsActive = false

local MAX_SLOTS              = 40
local slotsGrownThisCycle    = 0   -- counts only original existing slots grown
local allExistingGrown       = false
local parkingMode            = false  -- true = all 40 slots grown, just eat/drink on slot 1
shared._parkingModeActive    = false
local cancelGrowthWorkIfIdle = nil
local doExistingSlotCycle = nil
local growExistingToggleLastState = nil
local growExistingToggleLastAt = 0
local growNewToggleLastState = nil
local growNewToggleLastAt = 0

local function growthAutomationActive()
return growNewSlots
or growExistingSlots
or parkingMode
or spawnBeachActive
end

local function setParkingModeState(state)
parkingMode = state
shared._parkingModeActive = state
end

shared._setGrowNewSlots = function(state)
state = state == true

-- Some UI builds can fire the Grow New callback twice for one click.
-- Mirror the proven debounce already used by Grow Existing.
local now = os.clock()
if growNewToggleLastState == state
and (now - growNewToggleLastAt) < 0.75
then
return
end
growNewToggleLastState = state
growNewToggleLastAt = now

growNewSlots = state
shared._growNewSlotsActive = state
goatPrint("[GrowthLoop] Grow new slots:", state)

if shared._goatHudSetStatus then
shared._goatHudSetStatus("Grow New", state and "Ativado" or "Desativado", Color3.fromRGB(0, 170, 255))
end

if state then
if type(shared._authorizeCarcassForGrowth) == "function" then
pcall(shared._authorizeCarcassForGrowth, "Grow New")
end
-- Turning Grow New ON must immediately start the survival side of
-- growth for the CURRENT unfinished animal. Previously survival
-- was only re-enabled after a newly-created slot spawned, which
-- made the toggle look like it did nothing.
task.defer(function()
if not growNewSlots or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
local ch = player.Character
local growth = ch and ch:GetAttribute("GrowthPercentage")
local hum = ch and ch:FindFirstChild("Humanoid")

if ch and hum and hum.Health > 0 and type(growth) == "number" and growth < 1 then
if type(shared._setGrowSurvival) == "function" then
shared._setGrowSurvival(true, "Grow New activated")
end
goatPrint("[GrowthLoop] Grow New ACTIVE — growing current slot until 100%")
elseif type(growth) == "number" and growth >= 1 then
-- Heartbeat owns the 100% -> beach/reset transition.
goatPrint("[GrowthLoop] Grow New ACTIVE — current slot already 100%; reset transition queued")
end
end)
elseif cancelGrowthWorkIfIdle then
cancelGrowthWorkIfIdle("Grow New OFF")
end
end
local function setGrowExistingSurvivalForAnimal(animalName, state)
state = state == true
local carnivore = shared._isCarnivoreName
and shared._isCarnivoreName(animalName)
or false

if carnivore then
-- Carnivore: Eat OFF + Carcass ON + Drink ON.
if shared._setAutoEatInternal then pcall(shared._setAutoEatInternal, false) end
if shared._autoEatChecked then pcall(shared._autoEatChecked, false) end
local carcassActive = false
if shared._setAutoCarcassInternal then
local ok, active = pcall(shared._setAutoCarcassInternal, state)
carcassActive = ok and active == true
end
if shared._autoCarcassChecked then pcall(shared._autoCarcassChecked, state) end
if shared._setAutoDrinkInternal then pcall(shared._setAutoDrinkInternal, state) end
if shared._autoDrinkChecked then pcall(shared._autoDrinkChecked, state) end

goatPrint("[GrowthLoop] [Existing] Carnivore survival:",
tostring(animalName),
"| Eat=OFF | Carcass=" .. (carcassActive and "ON" or "OFF"),
"| Drink=" .. (state and "ON" or "OFF"))
else
-- Herbivore: Eat ON + Carcass OFF + Drink ON.
if shared._setAutoCarcassInternal then pcall(shared._setAutoCarcassInternal, false) end
if shared._autoCarcassChecked then pcall(shared._autoCarcassChecked, false) end
if shared._setAutoEatInternal then pcall(shared._setAutoEatInternal, state) end
if shared._autoEatChecked then pcall(shared._autoEatChecked, state) end
if shared._setAutoDrinkInternal then pcall(shared._setAutoDrinkInternal, state) end
if shared._autoDrinkChecked then pcall(shared._autoDrinkChecked, state) end

goatPrint("[GrowthLoop] [Existing] Herbivore survival:",
tostring(animalName),
"| Eat=" .. (state and "ON" or "OFF"),
"| Carcass=OFF",
"| Drink=" .. (state and "ON" or "OFF"))
end
end

shared._setGrowExistingSlots = function(state)
state = state == true

-- Some UI builds fire OnChanged twice for one click.
local now = os.clock()
if growExistingToggleLastState == state
and (now - growExistingToggleLastAt) < 0.75
then
return
end
growExistingToggleLastState = state
growExistingToggleLastAt = now

growExistingSlots = state
shared._growExistingSlotsActive = state
goatPrint("[GrowthLoop] Grow existing slots:", state)

if shared._goatHudSetStatus then
shared._goatHudSetStatus(
"Grow Existing",
state and "Ativado" or "Desativado",
Color3.fromRGB(0, 170, 255)
)
end

if state then
if type(shared._authorizeCarcassForGrowth) == "function" then
pcall(shared._authorizeCarcassForGrowth, "Grow Existing")
end
task.defer(function()
if not growExistingSlots
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
then
return
end

local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
local growth = ch and ch:GetAttribute("GrowthPercentage")
local animalName = ch and ch:GetAttribute("AnimalName") or ""

if ch and hum and hum.Health > 0
and type(growth) == "number"
and growth < 1
then
-- Immediately activate the correct survival package for the
-- CURRENT unfinished existing slot.
setGrowExistingSurvivalForAnimal(animalName, true)
goatPrint("[GrowthLoop] Grow Existing ACTIVE — growing current slot until 100%")
return
end

if ch and hum and hum.Health > 0
and type(growth) == "number"
and growth >= 1
then
-- Current slot is already complete: immediately move to the
-- next existing slot instead of waiting for another growth event.
goatPrint("[GrowthLoop] Grow Existing ACTIVE — current slot 100%; searching next existing slot")
if type(doExistingSlotCycle) == "function" then
task.spawn(doExistingSlotCycle)
else
goatWarn("[GrowthLoop] Grow Existing cycle is not ready yet")
end
return
end

goatWarn("[GrowthLoop] Grow Existing ACTIVE — no live character/growth available yet")
end)
else
local ch = player.Character
local animalName = ch and ch:GetAttribute("AnimalName") or ""
setGrowExistingSurvivalForAnimal(animalName, false)

if cancelGrowthWorkIfIdle then
cancelGrowthWorkIfIdle("Grow Existing OFF")
end
end
end
local pendingParkMode = false  -- set true if parking toggled before doParkOnSlotOne exists
local function setAfkSurvivalForAnimal(animalName)
local normalized = string.lower(tostring(animalName or "")):gsub("[^%a]", "")
local carnivore =
(type(shared._isCarnivoreName) == "function"
and shared._isCarnivoreName(tostring(animalName or "")) == true)
or normalized == "lion"
or normalized == "tiger"
or normalized == "trex"
or normalized == "velociraptor"
or normalized == "croc"
or normalized == "crocodile"
or normalized == "hyena"
or normalized == "leopard"
or normalized == "cheetah"

local function safeCall(key, value)
local fn = shared[key]
if type(fn) ~= "function" then return false end
local ok, err = pcall(fn, value)
if not ok then goatWarn("[GrowthLoop] [AFK] setter error:", key, err) end
return ok
end

-- IMPORTANT: the checkbox callbacks can visually change the HUD while
-- the real worker remains OFF. Drive the internal workers explicitly.
local drinkInternal = safeCall("_setAutoDrinkInternal", true)
local drinkUi = safeCall("_autoDrinkChecked", true)

local eatInternal, eatUi, carcassInternal, carcassUi
if carnivore then
eatInternal = safeCall("_setAutoEatInternal", false)
eatUi = safeCall("_autoEatChecked", false)
carcassInternal = safeCall("_setAutoCarcassInternal", true)
carcassUi = safeCall("_autoCarcassChecked", true)

goatPrint("[GrowthLoop] [AFK] Carnivore workers ON:", tostring(animalName),
"| drinkInternal=", drinkInternal,
"| drinkUI=", drinkUi,
"| carcassInternal=", carcassInternal,
"| carcassUI=", carcassUi)
else
carcassInternal = safeCall("_setAutoCarcassInternal", false)
carcassUi = safeCall("_autoCarcassChecked", false)
eatInternal = safeCall("_setAutoEatInternal", true)
eatUi = safeCall("_autoEatChecked", true)

goatPrint("[GrowthLoop] [AFK] Herbivore workers ON:", tostring(animalName),
"| drinkInternal=", drinkInternal,
"| drinkUI=", drinkUi,
"| eatInternal=", eatInternal,
"| eatUI=", eatUi)
end
end

local afkToggleLastState = nil
local afkToggleLastAt = 0

shared._setParkingMode = function(state)
state = state == true

-- Some executor/UI builds fire OnChanged twice for one click.
-- Ignore only an identical duplicate arriving in the same short window.
local now = os.clock()
if afkToggleLastState == state and (now - afkToggleLastAt) < 0.75 then
return
end
afkToggleLastState = state
afkToggleLastAt = now

-- Lock the exact animal/slot active when AFK Coins is enabled.
if state then
local ch = player.Character
shared._afkCoinsLockedCharacterName = ch and ch:GetAttribute("CharacterName") or shared._currentGrowthName
shared._afkCoinsLockedAnimalName = ch and ch:GetAttribute("AnimalName") or nil
goatPrint("[GrowthLoop] [AFK] Locked:", tostring(shared._afkCoinsLockedAnimalName), "|", tostring(shared._afkCoinsLockedCharacterName))
else
shared._afkCoinsLockedCharacterName = nil
shared._afkCoinsLockedAnimalName = nil
end
setParkingModeState(state)
goatPrint("[GrowthLoop] Parking mode:", state)
if shared._goatHudSetStatus then
shared._goatHudSetStatus(
"AFK Coins",
state and "Ativado • modo parking" or "Desativado",
Color3.fromRGB(255, 195, 70)
)
end
if state then
-- AFK Coins activation is passive: keep the CURRENT live animal.
-- No reset, no menu, no respawn and no forced slot 1.
pendingParkMode = false
local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
if ch and hum and hum.Health > 0 then
shared._afkCoinsLockedCharacterName = ch:GetAttribute("CharacterName")
shared._afkCoinsLockedAnimalName = ch:GetAttribute("AnimalName")
shared._currentGrowthName = shared._afkCoinsLockedCharacterName or shared._currentGrowthName
goatPrint("[GrowthLoop] [AFK] Staying on current animal — no activation respawn:",
tostring(shared._afkCoinsLockedAnimalName), "|",
tostring(shared._afkCoinsLockedCharacterName))
-- Explicitly drive the real survival toggle APIs.
setAfkSurvivalForAnimal(shared._afkCoinsLockedAnimalName or ch:GetAttribute("AnimalName"))
-- One delayed verification is enough; duplicate UI events are debounced above.
task.delay(0.50, function()
if parkingMode and player.Character == ch then
setAfkSurvivalForAnimal(shared._afkCoinsLockedAnimalName or ch:GetAttribute("AnimalName"))
end
end)
else
goatWarn("[GrowthLoop] [AFK] No live animal to lock; activation will not force a spawn")
end
else
pendingParkMode = false
if cancelGrowthWorkIfIdle then
cancelGrowthWorkIfIdle("AFK Coins OFF")
end
end
end

local SAVANNAH_SLOTS = {}

local SAVANNAH_LION_SLOTS = {}

local JUNGLE_SLOTS = {}

local JUNGLE_TIGER_SLOTS = {}

local DINO_SLOTS = {}

local existingSlots = {}
local originalSlotCount = 0
local trackedSlots = {}
local trackedSlotLookup = {}

local function findSlotIndexByName(name, pool)
if not name then
return nil
end

pool = pool or trackedSlots

for i, v in ipairs(pool) do
if v == name then
return i
end
end

return nil
end

local function getTrackedSlotTotal()
return math.min(#trackedSlots, MAX_SLOTS)
end

local function trackSlotName(name)
if not name then
return false
end

if trackedSlotLookup[name] then
return false
end

if #trackedSlots >= MAX_SLOTS then
goatWarn("[GrowthLoop] Tracked slot list already at max capacity — skipping add for:", name)
return false
end

table.insert(trackedSlots, name)
trackedSlotLookup[name] = true
return true
end

local function pickSlotListForAnimal(animal)
if gameConfig.name == "DinoLife" then
return DINO_SLOTS
elseif gameConfig.name == "JungleLife" then
if (animal == "Lion" or animal == "Tiger") and #JUNGLE_TIGER_SLOTS > 0 then
return JUNGLE_TIGER_SLOTS
end
return JUNGLE_SLOTS
else
if (animal == "Lion" or animal == "Tiger") and #SAVANNAH_LION_SLOTS > 0 then
return SAVANNAH_LION_SLOTS
end
return SAVANNAH_SLOTS
end
end

local existingSlotIndex = 1

local poolIndexes = {}
local function getPoolIndex(pool)
return poolIndexes[pool] or 1
end
local function advancePoolIndex(pool)
local cur = getPoolIndex(pool)
poolIndexes[pool] = (cur % #pool) + 1
end

local namePool =
(gameConfig.name == "DinoLife" and DINO_SLOTS)
or (gameConfig.name == "JungleLife" and JUNGLE_SLOTS)
or SAVANNAH_SLOTS
local newSlotIndex = 1  -- sequential pointer, no randomness

local NEW_SLOT_NAME_POOL = {
"TGoat || 🐐",
"TGoat || 🦁",
"TGoat || 🦏",
"TGoat || 🦛",
"TGoat || 🦍",
"TGoat || 🦒",
"TGoat || 🐘",
"TGoat || 🐊",
"TGoat || 🐆",
"TGoat || 🦓",
"TGoat || 🐺",
"TGoat || 🦅",
"TGoat || 🐉",
"TGoat || 🔥",
"TGoat || ⚡",
"TGoat || 💀",
"TGoat || 👑",
"TGoat || 🗡️",
"TGoat || 🛡️",
"TGoat || 🎯",
"TGoat || 💎",
"TGoat || 🏆",
"TGoat || ⭐",
"TGoat || 🌟",
"TGoat || 💥",
"TGoat || 🦴",
"TGoat || 🐾",
"TGoat || 🌑",
"TGoat || 🌀",
"TGoat || 🪓",
"TGoat || 🏴",
"TGoat || 👊",
"TGoat || 🐍",
"TGoat || 🦂",
"TGoat || 🦜",
"TGoat || 🐻",
"TGoat || ❄️",
"TGoat || 💣",
}
local fallbackIndex = 1

local function getUniqueName(animal)
local pool = namePool
if animal then
local animalPool = pickSlotListForAnimal(animal)
if animalPool and #animalPool > 0 then
pool = animalPool
end
end
if #pool == 0 then
pool = NEW_SLOT_NAME_POOL
local name = pool[((fallbackIndex - 1) % #pool) + 1]
fallbackIndex = fallbackIndex + 1
return name
end
local name = pool[((newSlotIndex - 1) % #pool) + 1]
newSlotIndex = newSlotIndex + 1
return name
end

local function removeName(name)
end

do
local ALLOWED_EXISTING_ANIMALS_BY_GAME = {
SavannahLife = {
Elephant = true,
Lion = true,
Giraffe = true,
Hippo = true,
Rhino = true,
Impala = true,
Zebra = true,
Cheetah = true,
Hyena = true,
Wildbeest = true,
Crocodile = true,
Croc = true,
WildDog = true,
["Wild Dog"] = true,
AfricanWildDog = true,
["African Wild Dog"] = true,
},
JungleLife = {
Gorilla = true,
Chimpanzee = true,
Leopard = true,
Mandrill = true,
Tiger = true,
Lion = true,
},
DinoLife = {
-- Aquatic carnivores
Deinosuchus = true,
Mosasaurus = true,
WaterSpinosaurus = true,

-- Flying carnivore
Pteranodon = true,

-- Land herbivores / grass-eaters for survival logic
Ankylosaurus = true,
Brachiosaurus = true,
Gallimimus = true,
Pachycephalosaurus = true,
Stegosaurus = true,
Triceratops = true,

-- Land carnivores
Carnotaurus = true,
LandSpinosaurus = true,
TRex = true,
Velociraptor = true,

-- Legacy aliases kept for compatibility.
Rex = true,
["T-Rex"] = true,
Tyrannosaurus = true,
["Tyrannosaurus Rex"] = true,
},
}

local savedSlotRecords = {}
local lastSavedCharacterRefresh = 0
local SAVE_REFRESH_INTERVAL = 1

-- Grow Existing only: temporarily skip a slot that failed to spawn so the
-- watchdog recovery does not select the exact same broken slot forever.
shared._failedExistingSlotUntil = {}
local failedExistingSlotUntil = shared._failedExistingSlotUntil
local FAILED_EXISTING_SLOT_COOLDOWN = 120
local warnedMissingSavedCharactersAPI = false
local warnedSavedCharactersReadFailed = false

existingSlots = {}
originalSlotCount = 0
trackedSlots = {}
trackedSlotLookup = {}
existingSlotIndex = 1

local function isPlayerDataReplication(candidate)
return type(candidate) == "table" and type(candidate.GetKeyData) == "function"
end

local function resolvePlayerDataReplication()
local cached = shared._playerDataReplication
if isPlayerDataReplication(cached) then
return cached
end

local directCandidates = {
shared.PlayerDataReplication,
_G.PlayerDataReplication,
}

if type(getgenv) == "function" then
local ok, env = pcall(getgenv)
if ok and type(env) == "table" then
table.insert(directCandidates, env.PlayerDataReplication)
end
end

for _, candidate in ipairs(directCandidates) do
if isPlayerDataReplication(candidate) then
shared._playerDataReplication = candidate
return candidate
end
end

local searchRoots = {
RS,
player:FindFirstChild("PlayerScripts"),
player:FindFirstChild("PlayerGui"),
}

for _, root in ipairs(searchRoots) do
if root then
local moduleScript = root:FindFirstChild("PlayerDataReplication", true)
if moduleScript and moduleScript:IsA("ModuleScript") then
local ok, result = pcall(require, moduleScript)
if ok and isPlayerDataReplication(result) then
shared._playerDataReplication = result
return result
end
end
end
end

return nil
end

local function findSavedCharactersMenu()
local cached = shared._savedCharactersMenu
if typeof(cached) == "Instance" and cached.Parent then
return cached
end

local playerGui = player:FindFirstChildOfClass("PlayerGui")
local menu = (playerGui and playerGui:FindFirstChild("SavedCharactersMenu", true))
or CoreGui:FindFirstChild("SavedCharactersMenu", true)

if menu then
shared._savedCharactersMenu = menu
end

return menu
end

local function setSelectedSavedCharacterName(name)
if type(name) ~= "string" or name == "" then
return
end

local menu = findSavedCharactersMenu()
if menu then
pcall(function()
menu:SetAttribute("UniqueCharacterName", name)
end)
end
end

local function rebuildTrackedFromRecords(records)
trackedSlots = {}
trackedSlotLookup = {}

for _, entry in ipairs(records) do
local name = entry.CharacterName
if type(name) == "string" and name ~= "" and not trackedSlotLookup[name] then
table.insert(trackedSlots, name)
trackedSlotLookup[name] = true
end
end
end

local function syncSavedCharacterRecords(force)
local now = tick()
if not force and (now - lastSavedCharacterRefresh) < SAVE_REFRESH_INTERVAL then
return savedSlotRecords
end

lastSavedCharacterRefresh = now

local replication = resolvePlayerDataReplication()
if not replication then
if not warnedMissingSavedCharactersAPI then
warnedMissingSavedCharactersAPI = true
goatWarn("[GrowthLoop] PlayerDataReplication was not found - keeping last saved slot snapshot")
end
return savedSlotRecords
end

local ok, rawList = pcall(function()
return replication.GetKeyData("SavedCharacters")
end)

if not ok or type(rawList) ~= "table" then
if not warnedSavedCharactersReadFailed then
warnedSavedCharactersReadFailed = true
goatWarn("[GrowthLoop] Failed to read SavedCharacters - keeping last saved slot snapshot")
end
return savedSlotRecords
end

warnedSavedCharactersReadFailed = false
local allowedAnimals = ALLOWED_EXISTING_ANIMALS_BY_GAME[gameConfig.name]
local nextRecords = {}
local nextNames = {}
local seen = {}

for _, entry in ipairs(rawList) do
if type(entry) == "table" then
local charName = entry.CharacterName
local animalName = entry.AnimalName
if type(charName) == "string"
and charName ~= ""
and type(animalName) == "string"
and animalName ~= ""
and not seen[charName]
then
table.insert(nextRecords, entry)
table.insert(nextNames, charName)
seen[charName] = true
if #nextRecords >= MAX_SLOTS then
break
end
end
end
end

savedSlotRecords = nextRecords
existingSlots = nextNames

if gameConfig.name == "DinoLife" then
table.clear(DINO_SLOTS)
for _, savedName in ipairs(nextNames) do
table.insert(DINO_SLOTS, savedName)
end
end

rebuildTrackedFromRecords(nextRecords)

if #existingSlots == 0 or existingSlotIndex > #existingSlots then
existingSlotIndex = 1
end

if originalSlotCount == 0 and #existingSlots > 0 then
originalSlotCount = #existingSlots
end

return savedSlotRecords
end

local function findSavedCharacterRecordByName(name, records)
if type(name) ~= "string" or name == "" then
return nil
end

records = records or syncSavedCharacterRecords()
for _, entry in ipairs(records) do
if entry.CharacterName == name then
return entry
end
end

return nil
end

local function getFirstExistingSlotRecord()
local records = syncSavedCharacterRecords(true)
return records[1]
end

local function getNextExistingSlotRecord()
local records = syncSavedCharacterRecords(true)
if #records == 0 then
return nil, nil, 0
end

local idx
local currentIdx = findSlotIndexByName(shared._currentGrowthName, existingSlots)
if currentIdx then
idx = (currentIdx % #records) + 1
else
if existingSlotIndex < 1 or existingSlotIndex > #records then
existingSlotIndex = 1
end
idx = existingSlotIndex
end

-- Spawn Beach is independent from Grow Existing:
-- only cycle slots that are already fully grown.
-- Savannah can report a visually-100% slot as 0.999999999..., so use
-- a tiny tolerance instead of requiring an exact 1.0.
if spawnBeachActive then
local FULL_GROWTH_THRESHOLD = 0.999

for step = 0, #records - 1 do
local candidateIdx = ((idx - 1 + step) % #records) + 1
local candidate = records[candidateIdx]
local candidateName = candidate and candidate.CharacterName
local candidateGrowth = candidate and tonumber(candidate.GrowthPercentage) or nil

if candidateGrowth and candidateGrowth >= FULL_GROWTH_THRESHOLD then
existingSlotIndex = (candidateIdx % #records) + 1

if step > 0 then
goatPrint(
"[GrowthLoop] [Beach] Skipped incomplete slot(s) — next 100% slot:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)
end

return candidate, candidateIdx, #records
end

if candidate then
goatPrint(
"[GrowthLoop] [Beach] Skipping incomplete slot:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", candidateGrowth and string.format("%.1f%%", candidateGrowth * 100) or "unknown"
)
end
end

goatPrint("[GrowthLoop] [Beach] No 100% saved slot found in this pass")
return nil, nil, #records
end

-- Grow Existing STRICT rule:
-- only choose existing saved slots that are actually below 100%.
-- Visually-full slots can be reported as 0.999999..., so 0.999 is treated as full.
-- Failed-spawn cooldown still applies, but a 100% slot is NEVER used as fallback.
if growExistingSlots and not spawnBeachActive then
local now = os.clock()
local FULL_GROWTH_THRESHOLD = 0.999
local unfinishedFound = false
local blockedUnfinishedFound = false

for step = 0, #records - 1 do
local candidateIdx = ((idx - 1 + step) % #records) + 1
local candidate = records[candidateIdx]
local candidateName = candidate and candidate.CharacterName
local candidateGrowth = candidate and tonumber(candidate.GrowthPercentage) or nil
local blockedUntil = candidateName and failedExistingSlotUntil[candidateName] or nil

if blockedUntil and blockedUntil <= now then
failedExistingSlotUntil[candidateName] = nil
blockedUntil = nil
end

if candidateGrowth and candidateGrowth < FULL_GROWTH_THRESHOLD then
unfinishedFound = true

if not blockedUntil then
existingSlotIndex = (candidateIdx % #records) + 1

if step > 0 then
goatPrint(
"[GrowthLoop] [Existing] Skipped full/failed slot(s) — next incomplete slot:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)
else
goatPrint(
"[GrowthLoop] [Existing] Next incomplete slot:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)
end

return candidate, candidateIdx, #records
else
blockedUnfinishedFound = true
goatPrint(
"[GrowthLoop] [Existing] Incomplete slot temporarily blocked:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)
end
elseif candidateGrowth then
goatPrint(
"[GrowthLoop] [Existing] Skipping 100% slot:",
candidateIdx, "/", #records, ":", tostring(candidateName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)
else
goatPrint(
"[GrowthLoop] [Existing] Skipping slot with unknown growth:",
candidateIdx, "/", #records, ":", tostring(candidateName)
)
end
end

-- If unfinished slots exist but all are temporarily blocked because of a
-- previous spawn failure, clear only the temporary cooldowns and search
-- unfinished slots one more time. Never fall back to a 100% slot.
if unfinishedFound and blockedUnfinishedFound then
table.clear(failedExistingSlotUntil)
goatWarn("[GrowthLoop] [Existing] All incomplete slots temporarily blocked — cooldown reset")

for step = 0, #records - 1 do
local candidateIdx = ((idx - 1 + step) % #records) + 1
local candidate = records[candidateIdx]
local candidateGrowth = candidate and tonumber(candidate.GrowthPercentage) or nil

if candidateGrowth and candidateGrowth < FULL_GROWTH_THRESHOLD then
existingSlotIndex = (candidateIdx % #records) + 1

goatPrint(
"[GrowthLoop] [Existing] Retry incomplete slot after cooldown reset:",
candidateIdx, "/", #records, ":", tostring(candidate.CharacterName),
"| growth:", string.format("%.1f%%", candidateGrowth * 100)
)

return candidate, candidateIdx, #records
end
end
end

goatPrint("[GrowthLoop] [Existing] No saved slot below 100% — Grow Existing cycle complete")
return nil, nil, #records
end

local entry = records[idx]
existingSlotIndex = (idx % #records) + 1
return entry, idx, #records
end

local function sanitizeNameSeed(text)
text = tostring(text or ""):gsub("[^%w]+", "")
if text == "" then
text = "Slot"
end
return string.sub(text, 1, 18)
end

findSlotIndexByName = function(name, pool)
if not name then
return nil
end

pool = pool or trackedSlots

for i, value in ipairs(pool) do
if value == name then
return i
end
end

return nil
end

getTrackedSlotTotal = function()
syncSavedCharacterRecords()
return math.min(#trackedSlots, MAX_SLOTS)
end

trackSlotName = function(name)
if not name or trackedSlotLookup[name] then
return false
end

if #trackedSlots >= MAX_SLOTS then
goatWarn("[GrowthLoop] Tracked slot list already at max capacity - skipping add for:", name)
return false
end

table.insert(trackedSlots, name)
trackedSlotLookup[name] = true
return true
end

local newSlotNamePool = {
"TGoat || 🐐",
"TGoat || 🦁",
"TGoat || 🐯",
"TGoat || 🦏",
"TGoat || 🦛",
"TGoat || 🦍",
"TGoat || 🦒",
"TGoat || 🐘",
"TGoat || 🐊",
"TGoat || 🐆",
"TGoat || 🦓",
"TGoat || 🐺",
"TGoat || 🦅",
"TGoat || 🐉",
"TGoat || 🔥",
"TGoat || ⚡",
"TGoat || 💀",
"TGoat || 👑",
"TGoat || 🗡️",
"TGoat || 🛡️",
"TGoat || 🎯",
"TGoat || 💎",
"TGoat || 🏆",
"TGoat || ⭐",
"TGoat || 🌟",
"TGoat || 💥",
"TGoat || 🦴",
"TGoat || 🐾",
"TGoat || 🌑",
"TGoat || 🌀",
"TGoat || 🪓",
"TGoat || 🏴",
"TGoat || 👊",
"TGoat || 🐍",
"TGoat || 🦑",
"TGoat || 🦂",
"TGoat || 🦜",
"TGoat || 🐻",
"TGoat || ❄️",
"TGoat || 💣",
}

getUniqueName = function(animal)
local usedNames = {}
for _, entry in ipairs(syncSavedCharacterRecords(true)) do
if type(entry.CharacterName) == "string" and entry.CharacterName ~= "" then
usedNames[entry.CharacterName] = true
end
end

-- Use the first globally unused NEW-SLOT name for every animal.
-- This prevents Lion from deriving/reusing an older saved-slot name.
for _, candidate in ipairs(newSlotNamePool) do
if not usedNames[candidate] then
goatPrint("[GrowthLoop] Next NEW SLOT:", candidate,
"| SavedCharacters:", #syncSavedCharacterRecords())
return candidate
end
end

local base = sanitizeNameSeed(animal or gameConfig.expectedAnimal or "Slot")
for i = 1, 999 do
local candidate = string.format("%s%d", base, i)
if not usedNames[candidate] then
return candidate
end
end

return string.format("%s%d", base, math.floor(os.clock() * 1000))
end

removeName = function(name)
return nil
end

shared._syncSavedCharacterRecords = syncSavedCharacterRecords
shared._findSavedCharacterRecordByName = findSavedCharacterRecordByName
shared._getFirstExistingSlotRecord = getFirstExistingSlotRecord
shared._getNextExistingSlotRecord = getNextExistingSlotRecord
shared._setSelectedSavedCharacterName = setSelectedSavedCharacterName
shared._getParkSlotRecord = function()
local records = syncSavedCharacterRecords(true)

local currentName = nil
local ch = player.Character
if ch then
local ok, value = pcall(function()
return ch:GetAttribute("CharacterName")
end)
if ok and type(value) == "string" and value ~= "" then
currentName = value
end
end
if currentName then
local entry = findSavedCharacterRecordByName(currentName, records)
if entry then
return entry
end
end

local menu = findSavedCharactersMenu()
local selected = nil
if menu then
local ok, value = pcall(function()
return menu:GetAttribute("UniqueCharacterName")
end)
if ok then
selected = value
end
end

if type(selected) == "string" and selected ~= "" then
local entry = findSavedCharacterRecordByName(selected, records)
if entry then
return entry
end
end

return records[1]
end

syncSavedCharacterRecords(true)
if originalSlotCount == 0 then
goatWarn("[GrowthLoop] WARNING: SavedCharacters returned no valid slots for", gameConfig.name)
end
end

local isLooping = false
local loopToken = 0
local newSlotRetryNotBefore = 0
local newSlotSpawnInProgress = false

local function forceUnlockGrowthLoop(reason)
loopToken = loopToken + 1
isLooping = false
shared._inGrowthReset = false
goatWarn("[GrowthLoop] Force-unlocked growth loop: " .. tostring(reason))
end

cancelGrowthWorkIfIdle = function(reason)
if growthAutomationActive() then return end
newSlotSpawnInProgress = false
shared._growNewSpawnInProgress = false
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
if isLooping or shared._inGrowthReset then
forceUnlockGrowthLoop(reason or "all growth automation OFF")
else
shared._inGrowthReset = false
end
end

local WALK_TO_BEACH_TIMEOUT = 420  -- segundos antes de desistir (7 min — caminhada lenta e plausível)

-- Before any Grow/Spawn-Beach reset, an animal stuck in Savannah's
-- Swimming state must be repaired first. Resetting while Swimming/7 can
-- leave the animal permanently stuck on the beach/restart countdown.
local function isGrowthResetSwimBugged(character)
if not character then
return false
end

local state = tostring(character:GetAttribute("MovementState") or "")
local replicated = tonumber(character:GetAttribute("ReplicatedMovementState"))

return state == "Swimming" or replicated == 7
end

local function recoverSwimBeforeGrowthReset(character)
if not character or player.Character ~= character then
return false
end

if not isGrowthResetSwimBugged(character) then
return true
end

-- These are intentionally local to the Growth PreReset flow.
-- The AutoDrink copies live in another lexical scope in this script.
local PRE_RESET_WATER_POINT = Vector3.new(-6565.300, -29.467, 4619.873)
local PRE_RESET_LAND_POINT  = Vector3.new(-6570.467, -7.801, 4432.124)

-- Prevent multiple GrowthLoop ticks from starting the same repair at once.
if shared._growthPreResetRecoveryActive then
return false
end

shared._growthPreResetRecoveryActive = true

local function finishPreResetRecovery(result)
shared._growthPreResetRecoveryActive = false
return result == true
end

local hum = character:FindFirstChildOfClass("Humanoid")
local root = character:FindFirstChild("HumanoidRootPart")
if not hum or not root or hum.Health <= 0 then
return finishPreResetRecovery(false)
end

local animalName = tostring(character:GetAttribute("AnimalName") or "?")

goatPrint(string.format(
"[GrowthLoop] [PreReset] SWIM BUG detected | animal=%s | state=%s | replicated=%s",
animalName,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))

if type(shared._goatHudSetStatus) == "function" then
pcall(
shared._goatHudSetStatus,
"Spawn Beach",
"Corrigindo natação antes do reset",
Color3.fromRGB(255, 185, 70)
)
end

shared._fixedWaterLandRecoveryActive = true
shared._fixedWaterLandRecoveryCharacter = character

local function clearRecoveryLock()
if shared._fixedWaterLandRecoveryCharacter == character then
shared._fixedWaterLandRecoveryActive = false
shared._fixedWaterLandRecoveryCharacter = nil
end
end

local function stopRecoveryMovement()
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1

if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end

shared._animalTweening = false

local r = character:FindFirstChild("HumanoidRootPart")
local h = character:FindFirstChildOfClass("Humanoid")

if r and h then
pcall(function()
h:MoveTo(r.Position)
end)
end
end

local function moveRecoveryTarget(target, label, useGrounded)
local ARRIVAL = 8
local SCAN = 0.25
local STUCK_WINDOW = 5
local MIN_MOVEMENT = 1.5
local MAX_RESTARTS = 8
local DEADLINE = os.clock() + 420

local function distanceNow()
if player.Character ~= character then
return math.huge
end

local r = character:FindFirstChild("HumanoidRootPart")
if not r then
return math.huge
end

return Vector3.new(
target.X - r.Position.X,
0,
target.Z - r.Position.Z
).Magnitude
end

local firstDistance = distanceNow()

goatPrint(string.format(
"[GrowthLoop] [PreReset] %s START | animal=%s | distance=%.1f",
label,
animalName,
firstDistance
))

if firstDistance <= ARRIVAL then
goatPrint(string.format(
"[GrowthLoop] [PreReset] %s ARRIVED | distance=%.1f",
label,
firstDistance
))
return true
end

stopRecoveryMovement()
task.wait(0.30)

local restarts = 0

while os.clock() < DEADLINE do
if player.Character ~= character then
stopRecoveryMovement()
goatWarn("[GrowthLoop] [PreReset] character changed — recovery cancelled")
return false
end

local h = character:FindFirstChildOfClass("Humanoid")
local r = character:FindFirstChild("HumanoidRootPart")

if not h or not r or h.Health <= 0 then
stopRecoveryMovement()
return false
end

local d = distanceNow()
if d <= ARRIVAL then
stopRecoveryMovement()

goatPrint(string.format(
"[GrowthLoop] [PreReset] %s ARRIVED | distance=%.1f | y=%.1f",
label,
d,
r.Position.Y
))

task.wait(1.0)
return true
end

if restarts > MAX_RESTARTS then
stopRecoveryMovement()
goatWarn("[GrowthLoop] [PreReset] max route recalculations reached")
return false
end

local walkDone = false
local walkError = nil

task.spawn(function()
local ok, result = pcall(function()
if type(shared._animalWalkToAsync) ~= "function" then
error("shared._animalWalkToAsync unavailable")
end

if useGrounded then
return shared._animalWalkToAsync(
CFrame.new(target),
{ groundedRecovery = true }
)
end

return shared._animalWalkToAsync(CFrame.new(target))
end)

if not ok then
walkError = result
end

walkDone = true
end)

local checkpointAt = os.clock()
local checkpointPos = r.Position
local restartReason = nil

while not walkDone and os.clock() < DEADLINE do
if player.Character ~= character then
restartReason = "character_changed"
break
end

r = character:FindFirstChild("HumanoidRootPart")
h = character:FindFirstChildOfClass("Humanoid")

if not r or not h or h.Health <= 0 then
restartReason = "character_invalid"
break
end

d = distanceNow()

if d <= ARRIVAL then
stopRecoveryMovement()

goatPrint(string.format(
"[GrowthLoop] [PreReset] %s ARRIVED | distance=%.1f | y=%.1f",
label,
d,
r.Position.Y
))

task.wait(1.0)
return true
end

if os.clock() - checkpointAt >= STUCK_WINDOW then
local moved = (r.Position - checkpointPos).Magnitude

if moved < MIN_MOVEMENT then
restartReason = "stuck"
break
end

checkpointAt = os.clock()
checkpointPos = r.Position
end

task.wait(SCAN)
end

if restartReason == "character_changed"
or restartReason == "character_invalid"
then
stopRecoveryMovement()
return false
end

if walkError then
goatWarn("[GrowthLoop] [PreReset] movement error: " .. tostring(walkError))
end

restarts = restarts + 1

goatPrint(string.format(
"[GrowthLoop] [PreReset] %s recalculating route (%d/%d)",
label,
restarts,
MAX_RESTARTS
))

stopRecoveryMovement()
task.wait(0.30)
end

stopRecoveryMovement()
goatWarn("[GrowthLoop] [PreReset] recovery timeout")
return false
end

-- Long travel: approach the known land point using the grounded
-- Auto-Carcass-style movement so the animal does not clip through terrain.
local currentRoot = character:FindFirstChild("HumanoidRootPart")
local distanceToWater = math.huge

if currentRoot then
distanceToWater = Vector3.new(
PRE_RESET_WATER_POINT.X - currentRoot.Position.X,
0,
PRE_RESET_WATER_POINT.Z - currentRoot.Position.Z
).Magnitude
end

if distanceToWater > 260 then
local approached = moveRecoveryTarget(
PRE_RESET_LAND_POINT,
"CARCASS-GROUND LAND APPROACH",
true
)

if not approached then
clearRecoveryLock()
return finishPreResetRecovery(false)
end
end

if player.Character ~= character then
clearRecoveryLock()
return finishPreResetRecovery(false)
end

local reachedWater = moveRecoveryTarget(
PRE_RESET_WATER_POINT,
"FIXED WATER ENTRY",
false
)

if not reachedWater then
clearRecoveryLock()
return finishPreResetRecovery(false)
end

task.wait(1.50)

if player.Character ~= character then
clearRecoveryLock()
return finishPreResetRecovery(false)
end

local reachedLand = moveRecoveryTarget(
PRE_RESET_LAND_POINT,
"FIXED LAND EXIT",
false
)

if not reachedLand then
clearRecoveryLock()
return finishPreResetRecovery(false)
end

task.wait(0.75)

local finalState = tostring(character:GetAttribute("MovementState") or "")
local finalReplicated = tonumber(character:GetAttribute("ReplicatedMovementState"))
local finalHum = character:FindFirstChildOfClass("Humanoid")

local fixed =
finalState ~= "Swimming"
and finalReplicated ~= 7

goatPrint(string.format(
"[GrowthLoop] [PreReset] RECOVERY END | animal=%s | fixed=%s | state=%s | replicated=%s | floor=%s",
animalName,
tostring(fixed),
finalState,
tostring(finalReplicated),
tostring(finalHum and finalHum.FloorMaterial or "nil")
))

clearRecoveryLock()

if fixed then
if type(shared._goatHudSetStatus) == "function" then
pcall(
shared._goatHudSetStatus,
"Spawn Beach",
"Natação corrigida • indo para praia",
Color3.fromRGB(0, 170, 255)
)
end
return finishPreResetRecovery(true)
end

goatWarn("[GrowthLoop] [PreReset] Swimming/7 ainda ativo — RESET BLOQUEADO")
return finishPreResetRecovery(false)
end

local BEACH_ARRIVAL_DISTANCE = 8
local BEACH_SCAN_INTERVAL = 0.25
local BEACH_STUCK_WINDOW = 5.0
local BEACH_MIN_MOVEMENT = 1.5
local BEACH_MAX_RESTARTS = 8

local function walkToBeachReset()
local beachGeneration = tonumber(shared._spawnBeachGeneration) or 0

local function beachWorkerCancelled()
return (tonumber(shared._spawnBeachGeneration) or 0) ~= beachGeneration
end

local beach = gameConfig and gameConfig.beachReset
if not beach then
goatPrint("[GrowthLoop] [Beach] beachReset não configurado para este jogo — resetando no lugar")
return true
end

local startingCharacter = player.Character

if beachWorkerCancelled() then
goatPrint("[GrowthLoop] [Beach] Worker cancelado • geração antiga antes de iniciar")
return false
end

-- Cancel an old AutoDrink return synchronously. Without this, the stale
-- return worker can keep pulling the animal back to savedLandPosition
-- while Spawn Beach is already trying to move in the opposite direction.
if type(shared._cancelAutoDrinkReturnForGrowth) == "function" then
pcall(
shared._cancelAutoDrinkReturnForGrowth,
startingCharacter,
"Spawn Beach/Grow"
)
task.wait(0.20)
end

local root = startingCharacter and startingCharacter:FindFirstChild("HumanoidRootPart")
local humanoid = startingCharacter and startingCharacter:FindFirstChild("Humanoid")
if not root or not humanoid or humanoid.Health <= 0 then
goatWarn("[GrowthLoop] [Beach] Sem personagem vivo — reset cancelado")
return false
end

-- Critical reset gate:
-- never approach/reset at Spawn Beach while Savannah still owns the animal
-- as Swimming/7. Fix the state first using the validated water->land route.
if isGrowthResetSwimBugged(startingCharacter) then
local recovered = recoverSwimBeforeGrowthReset(startingCharacter)

if not recovered then
goatWarn("[GrowthLoop] [Beach] Reset cancelado — animal ainda bugado em Swimming/7")

if type(shared._goatHudSetStatus) == "function" then
pcall(
shared._goatHudSetStatus,
"Spawn Beach",
"Reset bloqueado • corrigindo natação",
Color3.fromRGB(255, 90, 90)
)
end

return false
end

root = startingCharacter:FindFirstChild("HumanoidRootPart")
humanoid = startingCharacter:FindFirstChildOfClass("Humanoid")

if not root or not humanoid or humanoid.Health <= 0 then
return false
end
end

local function flatDistance()
local ch = player.Character
local r = ch and ch:FindFirstChild("HumanoidRootPart")
if ch ~= startingCharacter or not r then
return math.huge
end
return (Vector3.new(beach.X, 0, beach.Z) - Vector3.new(r.Position.X, 0, r.Position.Z)).Magnitude
end

local function stopBeachMovement()
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

local ch = player.Character
local r = ch and ch:FindFirstChild("HumanoidRootPart")
local h = ch and ch:FindFirstChild("Humanoid")
if h and r then
pcall(function()
h:MoveTo(r.Position)
end)
end
end

local initialDistance = flatDistance()
if initialDistance <= BEACH_ARRIVAL_DISTANCE then
goatPrint("[GrowthLoop] [Beach] Já está na praia — resetando")
return true
end

goatPrint(string.format(
"[GrowthLoop] [Beach] Spawn Beach usando movimento TERRESTRE estilo Auto Carcass (%.0f studs)",
initialDistance
))

stopBeachMovement()
task.wait(0.35)

local globalDeadline = os.clock() + WALK_TO_BEACH_TIMEOUT
local restartCount = 0

while os.clock() < globalDeadline do
if beachWorkerCancelled() then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Worker antigo cancelado • nova geração assumiu movimento")
return false
end

local ch = player.Character
local h = ch and ch:FindFirstChild("Humanoid")
root = ch and ch:FindFirstChild("HumanoidRootPart")
if ch ~= startingCharacter or not root or not h or h.Health <= 0 then
stopBeachMovement()
goatWarn("[GrowthLoop] [Beach] Personagem mudou/morreu durante a caminhada — reset cancelado")
return false
end

local remainingBefore = flatDistance()
if remainingBefore <= BEACH_ARRIVAL_DISTANCE then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Spawn Beach confirmado — reset liberado")
task.wait(1.25)
return true
end

if restartCount > BEACH_MAX_RESTARTS then
stopBeachMovement()
goatWarn("[GrowthLoop] [Beach] Limite de recálculos atingido — reset cancelado para não resetar fora da praia")
return false
end

local walkDone = false
local walkResult = nil
local walkError = nil

task.spawn(function()
local ok, result = pcall(function()
if type(shared._animalWalkToAsync) ~= "function" then
error("shared._animalWalkToAsync indisponível")
end
return shared._animalWalkToAsync(
CFrame.new(beach),
{ groundedRecovery = true }
)
end)
if ok then
walkResult = result
else
walkError = result
end
walkDone = true
end)

local checkpointAt = os.clock()
local checkpointPos = root.Position
local lastHudAt = 0
local restartReason = nil

while not walkDone and os.clock() < globalDeadline do
if beachWorkerCancelled() then
restartReason = "generation_cancelled"
break
end

ch = player.Character
h = ch and ch:FindFirstChild("Humanoid")
root = ch and ch:FindFirstChild("HumanoidRootPart")

if ch ~= startingCharacter or not root or not h or h.Health <= 0 then
restartReason = "character_invalid"
break
end

local remaining = flatDistance()
if remaining <= BEACH_ARRIVAL_DISTANCE then
stopBeachMovement()
goatPrint(string.format(
"[GrowthLoop] [Beach] Chegou na praia (%.1f studs) — reset liberado",
remaining
))
task.wait(1.25)
return true
end

if os.clock() - lastHudAt >= 1.0 then
lastHudAt = os.clock()
if type(shared._goatHudSetStatus) == "function" then
pcall(
shared._goatHudSetStatus,
"Spawn Beach",
string.format("Indo para praia • %.0f studs", remaining),
Color3.fromRGB(0, 170, 255)
)
end
end

if os.clock() - checkpointAt >= BEACH_STUCK_WINDOW then
local moved = (root.Position - checkpointPos).Magnitude
if moved < BEACH_MIN_MOVEMENT then
restartReason = "stuck"
break
end
checkpointAt = os.clock()
checkpointPos = root.Position
end

task.wait(BEACH_SCAN_INTERVAL)
end

if os.clock() >= globalDeadline then
stopBeachMovement()
goatWarn("[GrowthLoop] [Beach] Timeout da caminhada — reset cancelado para não resetar fora da praia")
return false
end

if restartReason == "character_invalid" then
stopBeachMovement()
goatWarn("[GrowthLoop] [Beach] Personagem inválido durante o trajeto — reset cancelado")
return false
end

if restartReason == "generation_cancelled" or beachWorkerCancelled() then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Worker antigo encerrado • sem recalcular rota")
return false
end

local remainingAfter = flatDistance()
if remainingAfter <= BEACH_ARRIVAL_DISTANCE then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Distância final confirmada — reset liberado")
task.wait(1.25)
return true
end

restartCount = restartCount + 1

if walkError then
goatWarn("[GrowthLoop] [Beach] Erro no movimento:", tostring(walkError))
elseif restartReason == "stuck" then
goatPrint(string.format(
"[GrowthLoop] [Beach] Sem progresso — recalculando rota (%d/%d)",
restartCount,
BEACH_MAX_RESTARTS
))
elseif walkDone then
goatPrint(string.format(
"[GrowthLoop] [Beach] Caminhada terminou longe da praia (%.0f studs) — recalculando (%d/%d)",
remainingAfter,
restartCount,
BEACH_MAX_RESTARTS
))
elseif walkResult == false then
goatPrint(string.format(
"[GrowthLoop] [Beach] Movimento pediu novo cálculo (%d/%d)",
restartCount,
BEACH_MAX_RESTARTS
))
end

stopBeachMovement()

local settleDeadline = os.clock() + 1.25
while not walkDone and os.clock() < settleDeadline do
if beachWorkerCancelled() then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Worker antigo cancelado durante settle")
return false
end
task.wait(0.05)
end

if beachWorkerCancelled() then
stopBeachMovement()
goatPrint("[GrowthLoop] [Beach] Worker antigo cancelado antes de novo cálculo")
return false
end

task.wait(0.30)
end

stopBeachMovement()
goatWarn("[GrowthLoop] [Beach] Não foi possível confirmar chegada ao Spawn Beach — reset cancelado")
return false
end

local function withLock(fn)
if isLooping then return false end
isLooping = true
loopToken = loopToken + 1
local myToken = loopToken
shared._inGrowthReset = true  -- block auto drink/eat from interfering
local ok, err = pcall(fn)
if loopToken == myToken then
shared._inGrowthReset = false
isLooping = false
end
if not ok then goatWarn("[GrowthLoop] Error:", err) end
return ok
end

local function setGrowSurvival(state, reason)
local ch = player.Character
local animalName = ch and ch:GetAttribute("AnimalName") or ""
local isCarnivore = shared._isCarnivoreName and shared._isCarnivoreName(animalName) or false
local foodMode = "off"

if shared._autoEatChecked then
shared._autoEatChecked(state and not isCarnivore)
end

if isCarnivore then
local carcassActive = false
if shared._setAutoCarcassInternal then
carcassActive = shared._setAutoCarcassInternal(state) == true
end
if state then
foodMode = carcassActive and "carcass patrol" or "carcass MANUAL OFF"
end
else
if shared._setAutoCarcassInternal then shared._setAutoCarcassInternal(false) end
if state then foodMode = "grass" end
end

if shared._setAutoDrinkInternal then
shared._setAutoDrinkInternal(state)
end

goatPrint(string.format("[GrowthLoop] Survival %s — food:%s%s",
state and "ON" or "OFF",
foodMode,
reason and (" — " .. reason) or ""))
end

local currentGrowthName = nil
shared._currentGrowthName = nil
local currentAnimalName = nil
local currentGender     = nil
local currentSkin       = nil

local function waitForAttribute(character, attrName, timeout)
timeout = timeout or 10
local waited = 0
while waited < timeout do
local val = character:GetAttribute(attrName)
if val ~= nil then return val end
task.wait(0.2)
waited = waited + 0.2
end
return nil
end

local function getSlotInfo(character)
local animal = character:GetAttribute("AnimalName") or currentAnimalName or "Elephant"
local gender = character:GetAttribute("Gender")     or currentGender or "Female"
local skin   = character:GetAttribute("Skin")       or currentSkin or "Default"
return animal, gender, skin
end

local function extractMotherName(result)
if type(result) == "string" and result ~= "" then
return result
end

if type(result) ~= "table" then
return nil
end

for _, value in ipairs(result) do
if type(value) == "string" and value ~= "" then
return value
end
if type(value) == "table" then
local name = value.PlayerName or value.Name or value.DisplayName or value.UserName or value.Username
if type(name) == "string" and name ~= "" then
return name
end
end
end

for _, value in pairs(result) do
if type(value) == "string" and value ~= "" then
return value
end
if type(value) == "table" then
local name = value.PlayerName or value.Name or value.DisplayName or value.UserName or value.Username
if type(name) == "string" and name ~= "" then
return name
end
end
end

return nil
end

local function isBabySavedCharacter(entry)
if type(entry) ~= "table" then
return false
end

local growth = entry.GrowthPercentage
return type(growth) == "number" and growth <= 0.01
end

local function requestBabyMotherName(entry)
local remote = RS:FindFirstChild("BabySpawnsRequestMotherNamesRemoteFunction")
if not remote or type(entry) ~= "table" then
return nil
end

local animal = entry.AnimalName
if type(animal) ~= "string" or animal == "" then
return nil
end

local requestArg = (gameConfig.babySpawnArgs and gameConfig.babySpawnArgs[animal]) or animal

for attempt = 1, 4 do
local ok, result = pcall(function()
return remote:InvokeServer(requestArg)
end)

if ok then
local motherName = extractMotherName(result)
if motherName then
goatPrint("[GrowthLoop] Baby mother selected for", entry.CharacterName, ":", motherName,
"| attempt:", attempt)
return motherName
end
else
goatWarn("[GrowthLoop] Baby mother request failed for:", animal, "| attempt:", attempt)
end

if attempt < 4 then
task.wait(1)
end
end

goatWarn("[GrowthLoop] No baby mother name returned after retries for:", entry.CharacterName)
return nil
end

local function trackCurrentCharacter()
local character = player.Character
if not character then return end
local name = waitForAttribute(character, "CharacterName", 8)
if name then
currentGrowthName = name
shared._currentGrowthName = name
trackSlotName(name)
currentAnimalName, currentGender, currentSkin = getSlotInfo(character)
goatPrint("[GrowthLoop] Now tracking:", currentGrowthName,
"| Animal:", currentAnimalName,
"| Gender:", currentGender)
else
goatWarn("[GrowthLoop] Timed out waiting for CharacterName")
end
end

local function tryNoMotherSpawnUi(charName)
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then return false end

local terms = {
"no mother",
"without mother",
"spawn alone",
"play alone",
"sem mãe",
"sem mae",
"sozinho",
"sem mother",
}

local function matches(obj)
if not obj:IsA("GuiButton") or not obj.Visible then
return false
end

local s = string.lower(tostring(obj.Name or ""))
if obj:IsA("TextButton") then
s = s .. " " .. string.lower(tostring(obj.Text or ""))
end

for _, term in ipairs(terms) do
if s:find(term, 1, true) then
return true
end
end

return false
end

for _, obj in ipairs(pg:GetDescendants()) do
if matches(obj) then
local fired = false

if type(firesignal) == "function" then
fired = pcall(firesignal, obj.MouseButton1Click)
end

if not fired then
fired = pcall(function()
obj:Activate()
end)
end

if fired then
goatPrint("[GrowthLoop] No-mother UI selected for:", charName)
return true
end
end
end

return false
end

local function waitForExactSpawn(charName, timeout, cancelCheck)
local waited = 0
local spawnedCharacter = nil
local stableHits = 0
timeout = tonumber(timeout) or 18

while waited < timeout do
if type(cancelCheck) == "function" and cancelCheck() == true then
return nil
end
task.wait(0.2)
waited = waited + 0.2
if type(cancelCheck) == "function" and cancelCheck() == true then
return nil
end

local ch = player.Character
if ch and ch:FindFirstChild("HumanoidRootPart") then
local cname = ch:GetAttribute("CharacterName")
if cname == charName then
stableHits = stableHits + 1
spawnedCharacter = ch
if stableHits >= 3 then
return spawnedCharacter
end
else
stableHits = 0
spawnedCharacter = nil
end
else
stableHits = 0
spawnedCharacter = nil
end
end

return nil
end

local function isGuiActuallyVisible(obj)
if not obj or not obj:IsA("GuiObject") then
return false
end

local cur = obj
while cur do
if cur:IsA("GuiObject") and cur.Visible == false then
return false
end
if cur:IsA("LayerCollector") and cur.Enabled == false then
return false
end
cur = cur.Parent
end

return true
end

local function activateGuiButton(button)
if not button or not button:IsA("GuiButton") or not isGuiActuallyVisible(button) then
return false, "invalid/hidden"
end

if type(firesignal) == "function" then
local ok = pcall(firesignal, button.MouseButton1Click)
if ok then
return true, "firesignal"
end
end

local okActivate = pcall(function()
button:Activate()
end)
if okActivate then
return true, "activate"
end

if type(getconnections) == "function" then
local ok, conns = pcall(getconnections, button.MouseButton1Click)
if ok and type(conns) == "table" then
for _, conn in ipairs(conns) do
if conn and type(conn.Function) == "function" then
local fired = pcall(function()
conn.Function()
end)
if fired then
return true, "connection"
end
end
end
end
end

return false, "no activation method"
end

local function findVisibleTextButtonByTerms(root, terms)
if not root then return nil end

for _, obj in ipairs(root:GetDescendants()) do
if obj:IsA("TextButton") and isGuiActuallyVisible(obj) then
local s = string.lower(tostring(obj.Text or "") .. " " .. tostring(obj.Name or ""))
for _, term in ipairs(terms) do
if s:find(term, 1, true) then
return obj
end
end
end
end

return nil
end

local function clickExistingCharacterCard(menu, charName)
if not menu then return false end
local wanted = tostring(charName or "")
if wanted == "" then return false end

local exactLabel = nil
for _, obj in ipairs(menu:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextButton"))
and isGuiActuallyVisible(obj)
and tostring(obj.Text or "") == wanted then
exactLabel = obj
break
end
end

if not exactLabel then
goatPrint("[Existing-UI] Character card text not found:", wanted)
return false
end

if exactLabel:IsA("GuiButton") then
local ok, method = activateGuiButton(exactLabel)
if ok then
goatPrint("[Existing-UI] Selected character:", wanted, "| method:", method)
return true
end
end

-- Usually the name is a TextLabel inside a clickable slot/card.
local cur = exactLabel.Parent
for _ = 1, 6 do
if not cur or cur == menu then break end

if cur:IsA("GuiButton") and isGuiActuallyVisible(cur) then
local ok, method = activateGuiButton(cur)
if ok then
goatPrint("[Existing-UI] Selected character:", wanted, "| method:", method)
return true
end
end

-- Some card layouts use a Frame with a transparent ImageButton/TextButton.
for _, child in ipairs(cur:GetChildren()) do
if child:IsA("GuiButton") and isGuiActuallyVisible(child) then
local ok, method = activateGuiButton(child)
if ok then
goatPrint("[Existing-UI] Selected character:", wanted, "| method:", method)
return true
end
end
end

cur = cur.Parent
end

goatPrint("[Existing-UI] Found character text but no clickable card:", wanted)
return false
end

local function findCharacterPlayButton(menu)
if not menu then return nil end

local best = nil
local bestScore = -math.huge

for _, obj in ipairs(menu:GetDescendants()) do
if obj:IsA("GuiButton") and isGuiActuallyVisible(obj) then
local name = string.lower(tostring(obj.Name or ""))
local txt = obj:IsA("TextButton") and string.lower(tostring(obj.Text or "")) or ""
local combined = name .. " " .. txt

-- Avoid destructive/editor buttons.
if not combined:find("delete", 1, true)
and not combined:find("excluir", 1, true)
and not combined:find("edit", 1, true)
and not combined:find("editar", 1, true)
then
local score = 0

if txt == "▶" or txt == "►" or txt == ">" then score = score + 120 end
if combined:find("play", 1, true) then score = score + 100 end
if combined:find("jogar", 1, true) then score = score + 100 end
if combined:find("spawn", 1, true) then score = score + 90 end
if combined:find("select", 1, true) then score = score + 25 end

local okColor, c = pcall(function() return obj.BackgroundColor3 end)
if okColor and c and c.G > c.R + 0.12 and c.G > c.B + 0.12 then
score = score + 35
end

-- The confirmed button in the new Characters UI is at the bottom.
local okPos, pos = pcall(function() return obj.AbsolutePosition end)
if okPos and pos then
score = score + math.min(pos.Y / 100, 15)
end

if score > bestScore then
bestScore = score
best = obj
end
end
end
end

if bestScore < 20 then
return nil
end

return best
end

local function tryExistingCharacterMenuFlow(charName, cancelCheck)
local function existingUiCancelled()
return type(cancelCheck) == "function" and cancelCheck() == true
end

if existingUiCancelled() then
return false
end
local pg = player:FindFirstChildOfClass("PlayerGui")
if not pg then
return false
end

local function resolveExistingCharactersMenu()
local cached = shared._savedCharactersMenu
if typeof(cached) == "Instance" and cached.Parent then
return cached
end

local menu =
pg:FindFirstChild("SavedCharactersMenu", true)
or CoreGui:FindFirstChild("SavedCharactersMenu", true)

if menu then
shared._savedCharactersMenu = menu
end

return menu
end

local function targetCardVisible(menu)
if not menu then
return false
end

for _, obj in ipairs(menu:GetDescendants()) do
if (obj:IsA("TextLabel") or obj:IsA("TextButton"))
and isGuiActuallyVisible(obj)
and tostring(obj.Text or "") == tostring(charName) then
return true
end
end

return false
end

-- After the latest Savannah Life update, player.Character can become nil
-- while the loading/menu backend is not ready yet. Retry the SAME target
-- at a slow cadence and confirm only the exact CharacterName.
local function retryDirectMenuSpawn(label, confirmSeconds)
if existingUiCancelled() then
goatPrint("[Existing-UI] Backend retry cancelled • stale UI/death transition")
return false
end

local current = player.Character
if current then
return current:GetAttribute("CharacterName") == charName
end

local setSelectedSavedCharacterName = shared._setSelectedSavedCharacterName
if type(setSelectedSavedCharacterName) == "function" then
pcall(function() setSelectedSavedCharacterName(charName) end)
end

local ok, result = pcall(function()
return RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName)
end)

goatPrint("[Existing-UI] " .. tostring(label)
.. " | target=" .. tostring(charName)
.. " | ok=" .. tostring(ok)
.. " | result=" .. tostring(result))

if not ok then return false end

local deadline = os.clock() + (tonumber(confirmSeconds) or 5)
while os.clock() < deadline do
if existingUiCancelled() then
goatPrint("[Existing-UI] Backend confirmation cancelled • stale UI/death transition")
return false
end

local live = player.Character
if live and live:GetAttribute("CharacterName") == charName then
goatPrint("[Existing-UI] Menu/backend spawn CONFIRMED | target=" .. tostring(charName))
return true
end
if live and live:GetAttribute("CharacterName") ~= nil then
return false
end
task.wait(0.20)
end
return false
end

goatPrint("[Existing-UI] Direct spawn did not finish — waiting for real Characters menu")

-- PHASE 1:
-- Character=nil is no longer treated as proof that the SL menu/backend is
-- fully ready. Keep the same target and retry slowly while loading advances.
local menuStateDeadline = os.clock() + 24
local menuBackendRetriesDone = 0
local MENU_BACKEND_RETRIES = 3

while os.clock() < menuStateDeadline do
if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end
local current = player.Character

if not current then
if menuBackendRetriesDone == 0 then
goatPrint("[Existing-UI] Menu state confirmed | current=nil | target=" .. tostring(charName))
end

if menuBackendRetriesDone < MENU_BACKEND_RETRIES then
menuBackendRetriesDone = menuBackendRetriesDone + 1
local confirmed = retryDirectMenuSpawn(
"Menu backend retry " .. tostring(menuBackendRetriesDone) .. "/" .. tostring(MENU_BACKEND_RETRIES),
4.5
)
if confirmed then return true end
task.wait(0.75)
else
goatPrint("[Existing-UI] Menu backend still not ready after retries — UI fallback allowed | target=" .. tostring(charName))
break
end
else
local currentName = current:GetAttribute("CharacterName")
if currentName == charName then return true end
end

task.wait(0.20)
end

-- PHASE 2:
-- Wait for either the Characters card to already exist OR the main
-- JOGAR/PLAY button to become available. The UI itself may load late.
local menu = nil
local cardVisible = false
local mainPlay = nil
local entryDeadline = os.clock() + 15

while os.clock() < entryDeadline do
if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end
menu = resolveExistingCharactersMenu()
cardVisible = targetCardVisible(menu)

if cardVisible then
break
end

mainPlay = findVisibleTextButtonByTerms(pg, {"jogar", "play"})
if mainPlay then
break
end

task.wait(0.20)
end

-- Open Characters only once, and only after the button actually exists.
if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end

if not cardVisible then
if not mainPlay then
goatPrint("[Existing-UI] Main JOGAR/PLAY still not ready — trying final backend recovery | target=" .. tostring(charName))
if retryDirectMenuSpawn("Menu stall final backend retry", 7.0) then return true end
goatPrint("[Existing-UI] Main JOGAR/PLAY still not ready — keeping slot unconfirmed | target=" .. tostring(charName))
return false
end

local ok, method = activateGuiButton(mainPlay)
goatPrint(
"[Existing-UI] Main JOGAR/PLAY click:",
tostring(ok),
"| method:",
tostring(method)
)

if not ok then
return false
end
end

-- PHASE 3:
-- After PLAY, allow the saved-character cards enough time to populate.
-- The previous 4-second window was too short on slower menu transitions.
local cardsDeadline = os.clock() + 20

while os.clock() < cardsDeadline do
if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end
menu = resolveExistingCharactersMenu()
cardVisible = targetCardVisible(menu)

if cardVisible then
goatPrint(
"[Existing-UI] Characters menu/card READY | target="
.. tostring(charName)
)
break
end

-- If the target character spawned while waiting, treat that as success.
local current = player.Character
if current and current:GetAttribute("CharacterName") == charName then
return true
end

task.wait(0.20)
end

if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end

if not menu or not cardVisible then
goatPrint("[Existing-UI] Characters menu/card still not ready after extended wait — trying backend recovery | target=" .. tostring(charName))
if retryDirectMenuSpawn("Cards stall backend retry", 7.0) then return true end
goatPrint("[Existing-UI] Characters menu/card still not ready after extended wait | target=" .. tostring(charName))
return false
end

if not clickExistingCharacterCard(menu, charName) then
goatPrint(
"[Existing-UI] Target card found but click failed | target="
.. tostring(charName)
)
return false
end

task.wait(0.35)

-- PHASE 4:
-- The green Play button can also appear slightly after the card selection.
local playButton = nil
local playDeadline = os.clock() + 8

while os.clock() < playDeadline do
if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end
playButton = findCharacterPlayButton(menu)

if playButton then
break
end

local current = player.Character
if current and current:GetAttribute("CharacterName") == charName then
return true
end

task.wait(0.20)
end

if existingUiCancelled() then
goatPrint("[Existing-UI] Cancelled — Spawn Beach was turned OFF")
return false
end

if not playButton then
goatPrint("[Existing-UI] Green Play button not ready after extended wait — trying backend recovery | target=" .. tostring(charName))
if retryDirectMenuSpawn("Character Play stall backend retry", 7.0) then return true end
goatPrint("[Existing-UI] Green Play button not ready after extended wait | target=" .. tostring(charName))
return false
end

local ok, method = activateGuiButton(playButton)
goatPrint(
"[Existing-UI] Character Play click:",
tostring(ok),
"| method:",
tostring(method)
)

return ok
end

local function growthSpawnDiagValue(value)
local t = type(value)
if t == "nil" or t == "number" or t == "boolean" or t == "string" then
return tostring(value)
end

if t == "table" then
local ok, encoded = pcall(function()
return HttpService:JSONEncode(value)
end)
if ok then
return encoded
end
end

return tostring(value)
end

local function spawnAndSetup(slotEntryOrName, options)
options = type(options) == "table" and options or {}
local cancelCheck = type(options.cancelCheck) == "function" and options.cancelCheck or nil
local spawnAbortGeneration = tonumber(shared._existingUiAbortGeneration) or 0

local function spawnTransitionCancelled()
if (tonumber(shared._existingUiAbortGeneration) or 0) ~= spawnAbortGeneration then
return true
end
return type(cancelCheck) == "function" and cancelCheck() == true
end

local syncSavedCharacterRecords = shared._syncSavedCharacterRecords
local findSavedCharacterRecordByName = shared._findSavedCharacterRecordByName
local setSelectedSavedCharacterName = shared._setSelectedSavedCharacterName

local entry = slotEntryOrName
local charName
if type(slotEntryOrName) == "table" then
charName = slotEntryOrName.CharacterName
else
charName = slotEntryOrName
end

if type(charName) ~= "string" or charName == "" then
goatWarn("[GrowthLoop] spawnAndSetup called without a valid CharacterName")
return false
end

local preferNoMother = options.preferNoMother == true

-- NEW SLOT already has CharacterName/AnimalName locally. Do not wait up to
-- 6 seconds for SavedCharacters replication before trying to spawn it.
-- Existing slots keep the normal live-record lookup.
if not preferNoMother
and type(findSavedCharacterRecordByName) == "function"
and type(syncSavedCharacterRecords) == "function" then
for _ = 1, 12 do
if spawnTransitionCancelled() then
goatPrint("[Existing-DIAG] Spawn cancelled — Spawn Beach OFF")
return false
end
local records = syncSavedCharacterRecords(true)
local liveEntry = findSavedCharacterRecordByName(charName, records)
if liveEntry then
entry = liveEntry
break
end
task.wait(0.5)
end
end

if type(entry) ~= "table" then
entry = { CharacterName = charName }
end

goatPrint(
"[Existing-DIAG] Entry | name=" .. tostring(charName)
.. " | animal=" .. tostring(entry.AnimalName)
.. " | growth=" .. tostring(entry.GrowthPercentage)
.. " | gender=" .. tostring(entry.Gender)
.. " | baby=" .. tostring(isBabySavedCharacter(entry))
)

if type(setSelectedSavedCharacterName) == "function" then
setSelectedSavedCharacterName(charName)
goatPrint("[Existing-DIAG] SavedCharacters selection set:", tostring(charName))
end

local spawnedCharacter = nil

if preferNoMother then
goatPrint("[GrowthLoop] New slot FAST no-mother spawn:", charName)

-- New slots created by this script belong to the local player.
-- Never request/wait for BabySpawns mother names in this path.
for attempt = 1, 3 do
local spawnOk, spawnErr = pcall(function()
RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName)
end)

if not spawnOk then
goatWarn("[GrowthLoop] Direct no-mother spawn attempt", attempt, "failed:", spawnErr)
else
spawnedCharacter = waitForExactSpawn(charName, attempt == 1 and 2.5 or 3.5, spawnTransitionCancelled)
if spawnedCharacter then
break
end
end

-- Some servers expose a confirmation button instead of accepting
-- the direct call immediately. Click only an explicit no-mother option.
tryNoMotherSpawnUi(charName)
spawnedCharacter = waitForExactSpawn(charName, 1.5, spawnTransitionCancelled)
if spawnedCharacter then
break
end
task.wait(0.35)
end
else
local isBaby = isBabySavedCharacter(entry)
local motherName = isBaby and requestBabyMotherName(entry) or nil

goatPrint(
"[Existing-DIAG] Before spawn | name=" .. tostring(charName)
.. " | baby=" .. tostring(isBaby)
.. " | mother=" .. tostring(motherName)
)

if spawnTransitionCancelled() then
goatPrint("[Existing-DIAG] Direct spawn cancelled • stale UI/death transition")
return false
end

local spawnOk, spawnResult = pcall(function()
if motherName then
return RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName, motherName)
else
return RS.SpawnAsCharacterRemoteFunction:InvokeServer(charName)
end
end)

goatPrint(
"[Existing-DIAG] Spawn remote | ok=" .. tostring(spawnOk)
.. " | result=" .. growthSpawnDiagValue(spawnResult)
)

local immediate = player.Character
goatPrint(
"[Existing-DIAG] Immediately after remote | current="
.. tostring(immediate and immediate:GetAttribute("CharacterName") or "nil")
)

if not spawnOk then
goatWarn("[GrowthLoop] SpawnAsCharacter failed:", spawnResult)
return false
end

-- Keep compatibility with the old direct remote first.
-- Savannah can now return ok=true/result=nil without actually changing
-- CharacterName, so never treat the remote call itself as a successful switch.
spawnedCharacter = waitForExactSpawn(charName, 2.0, spawnTransitionCancelled)

if not spawnedCharacter then
local beforeFallback = player.Character
local beforeFallbackName =
beforeFallback
and beforeFallback:GetAttribute("CharacterName")
or nil

goatPrint(
"[Existing-DIAG] Direct spawn NOT confirmed | expected="
.. tostring(charName)
.. " | stillCurrent="
.. tostring(beforeFallbackName)
.. " | switching through Characters UI"
)

-- Run the Characters-menu fallback defensively so an UI helper error
-- cannot abort AutoQuest/Grow Existing.
for uiAttempt = 1, 3 do
if spawnTransitionCancelled() then
goatPrint("[Existing-DIAG] Spawn transaction cancelled • stale UI/death transition")
return false
end
if spawnedCharacter then
break
end

goatPrint(
"[Existing-UI] Slot switch attempt "
.. tostring(uiAttempt)
.. "/3 | target="
.. tostring(charName)
)

local uiOk, uiResult = pcall(function()
return tryExistingCharacterMenuFlow(charName, spawnTransitionCancelled)
end)

if not uiOk then
goatWarn(
"[Existing-UI] Characters menu flow error | attempt="
.. tostring(uiAttempt)
.. " | target="
.. tostring(charName)
.. " | error="
.. tostring(uiResult)
)
else
goatPrint(
"[Existing-DIAG] Characters UI flow attempted:",
tostring(uiResult),
"| attempt:",
tostring(uiAttempt)
)
end

-- The only success condition is the exact live CharacterName.
local confirmWindow = uiOk and uiResult and 12 or 6
spawnedCharacter = waitForExactSpawn(charName, confirmWindow, spawnTransitionCancelled)

if spawnedCharacter then
goatPrint(
"[Existing-DIAG] SLOT SWITCH CONFIRMED | target="
.. tostring(charName)
.. " | attempt="
.. tostring(uiAttempt)
)
break
end

local currentAfterAttempt = player.Character
local currentAfterAttemptName =
currentAfterAttempt
and currentAfterAttempt:GetAttribute("CharacterName")
or nil

goatWarn(
"[Existing-DIAG] Slot still unchanged | target="
.. tostring(charName)
.. " | current="
.. tostring(currentAfterAttemptName)
.. " | attempt="
.. tostring(uiAttempt)
)

-- Re-assert the selected saved-character name before retrying the UI.
if type(setSelectedSavedCharacterName) == "function" then
pcall(function()
setSelectedSavedCharacterName(charName)
end)
end

task.wait(0.75)
end
end

local afterWait = player.Character
local afterWaitName =
afterWait
and afterWait:GetAttribute("CharacterName")
or nil

goatPrint(
"[Existing-DIAG] After spawn flow | expected=" .. tostring(charName)
.. " | current=" .. tostring(afterWaitName)
.. " | matched=" .. tostring(
spawnedCharacter ~= nil
and afterWaitName == charName
)
)
end

if not spawnedCharacter or spawnedCharacter:GetAttribute("CharacterName") ~= charName then
local current = player.Character
goatWarn("[GrowthLoop] Correct character never appeared for:", charName,
"| current:", current and tostring(current:GetAttribute("CharacterName")) or "nil")
return false
end

-- For NEW SLOT, CharacterName alone is not enough. Verify the species too,
-- so a requested Lion can never be accepted as Elephant/another animal.
if preferNoMother and type(entry.AnimalName) == "string" and entry.AnimalName ~= "" then
local expectedAnimal = entry.AnimalName
local actualAnimal = spawnedCharacter:GetAttribute("AnimalName")
local waitedAnimal = 0
while (type(actualAnimal) ~= "string" or actualAnimal == "") and waitedAnimal < 2 do
task.wait(0.1)
waitedAnimal = waitedAnimal + 0.1
actualAnimal = spawnedCharacter:GetAttribute("AnimalName")
end
if actualAnimal ~= expectedAnimal then
goatWarn("[GrowthLoop] NEW SLOT species mismatch | expected:", expectedAnimal,
"| got:", tostring(actualAnimal), "| slot:", charName)
return false
end
end

trackSlotName(charName)
if type(syncSavedCharacterRecords) == "function" then
syncSavedCharacterRecords(true)
end

local FOOD_TYPE_BY_ANIMAL = {
Elephant   = "Grass",
Lion       = "Meat",
Tiger      = "Meat",
["Tyrannosaurus Rex"] = "Meat",
Tyrannosaurus = "Meat",
["T-Rex"]   = "Meat",
TRex        = "Meat",
Rex         = "Meat",
Velociraptor = "Meat",
Cheetah    = "Meat",
Leopard    = "Meat",
WildDog    = "Meat",
["Wild Dog"] = "Meat",
AfricanWildDog = "Meat",
["African Wild Dog"] = "Meat",
Giraffe    = "Grass",
Hippo      = "Grass",
Rhino      = "Grass",
Gorilla    = "Grass",
Crocodile  = "Meat",
Croc       = "Meat",
}
local animal = spawnedCharacter:GetAttribute("AnimalName") or "Elephant"
local foodType = FOOD_TYPE_BY_ANIMAL[animal] or "Grass"
pcall(function()
RS.AnimalGameFrameworkShared.Utils.CanEatDrink.SetFoodTypeRemoteEvent:FireServer(foodType)
goatPrint("[GrowthLoop] Set food type:", foodType, "for:", animal)
end)
task.wait(0.5)
pcall(function()
RS.SaveCharacterStatsRemoteEvent:FireServer(charName, "Oxygen", 100)
RS.SaveCharacterStatsRemoteEvent:FireServer(charName, "Stamina", 100)
end)
goatPrint("[GrowthLoop] Spawn verified:", charName, "| Animal:", animal)
return true
end

shared._spawnAndSetup = spawnAndSetup
shared._setGrowSurvival = setGrowSurvival

local function safeTP(character, targetPos)
local root = character:FindFirstChild("HumanoidRootPart")
local hum  = character:FindFirstChild("Humanoid")
if not root or not hum then return false end

root.Anchored = true
hum:ChangeState(Enum.HumanoidStateType.Physics)

local safeTarget = Vector3.new(targetPos.X, targetPos.Y + 3, targetPos.Z)

local attempts = 0
repeat
attempts = attempts + 1
for _ = 1, 30 do
local r = character:FindFirstChild("HumanoidRootPart")
if r then
r.CFrame = CFrame.new(safeTarget)
end
task.wait()
end
task.wait(0.3)

local currentRoot = character:FindFirstChild("HumanoidRootPart")
if currentRoot then
local yPos = currentRoot.Position.Y
if yPos >= (targetPos.Y - 2) then
goatPrint("[GrowthLoop] TP confirmed at Y:", yPos)
break
else
goatWarn("[GrowthLoop] TP still off at Y:", yPos, "— retrying (attempt", attempts, ")")
end
end
until attempts >= 5

task.wait(0.5)
local finalRoot = character:FindFirstChild("HumanoidRootPart")
if finalRoot then finalRoot.Anchored = false end
hum:ChangeState(Enum.HumanoidStateType.GettingUp)
for _ = 1, 10 do
character:SetAttribute("MovementDisabled", false)
task.wait(0.1)
end
return true
end

local GROW_SPAWN   = gameConfig.growSpawn
local TP_TOLERANCE = 12  -- studs: how close we need to be to consider TP successful
shared._growSpawn  = GROW_SPAWN  -- expose so carcass eat can TP back

local function confirmedTP(character, targetPos, label, maxAttempts)
maxAttempts = maxAttempts or 6

for attempt = 1, maxAttempts do
local root = character:FindFirstChild("HumanoidRootPart")
local hum  = character:FindFirstChild("Humanoid")
if not root or not hum then
goatWarn("[GrowthLoop] [" .. label .. "] No root/hum on attempt " .. attempt)
task.wait(1)
else
root.Anchored = false
hum:ChangeState(Enum.HumanoidStateType.Physics)
for _ = 1, 25 do
if character and character:FindFirstChild("HumanoidRootPart") then
character:SetPrimaryPartCFrame(CFrame.new(targetPos))
end
task.wait()
end
task.wait(1)
hum:ChangeState(Enum.HumanoidStateType.GettingUp)
for _ = 1, 10 do
character:SetAttribute("MovementDisabled", false)
task.wait(0.1)
end

local r = character:FindFirstChild("HumanoidRootPart")
if r then
local dist = (r.Position - targetPos).Magnitude
goatPrint(string.format("[GrowthLoop] [%s] TP attempt %d — dist: %.1f studs", label, attempt, dist))
if dist <= TP_TOLERANCE then
goatPrint("[GrowthLoop] [" .. label .. "] TP confirmed on attempt " .. attempt)
return true
else
goatWarn("[GrowthLoop] [" .. label .. "] Too far (" .. string.format("%.1f", dist) .. " studs) — retrying")
end
end
end
end
goatWarn("[GrowthLoop] [" .. label .. "] Failed after " .. maxAttempts .. " attempts — continuing anyway")
return false
end

local function teleportAndEnable(newChar, charName)
if not growthAutomationActive() then
goatPrint("[GrowthLoop] Setup cancelado — nenhum modo automático está ativo")
return false
end

local charWait = 0
while charWait < 18 do
task.wait(0.2)
charWait = charWait + 0.2
local ch = player.Character
if ch and ch:FindFirstChild("HumanoidRootPart") then
local cname = ch:GetAttribute("CharacterName")
if cname == charName then
newChar = ch
break
end
end
end

if not newChar or newChar:GetAttribute("CharacterName") ~= charName then
goatWarn("[GrowthLoop] Correct character never appeared, skipping TP:", charName)
return false
end

task.wait(1.5)
local ch = player.Character
if ch and ch:FindFirstChild("HumanoidRootPart") and ch:GetAttribute("CharacterName") == charName then
newChar = ch
else
goatWarn("[GrowthLoop] Character changed/disappeared before TP:", charName)
return false
end

local animal, gender, skin = getSlotInfo(newChar)
currentAnimalName = animal
currentGender     = gender
currentSkin       = skin
goatPrint("[GrowthLoop] Slot info — Animal:", animal, "| Gender:", gender, "| Skin:", skin)

task.wait(7)

if not growthAutomationActive() then
goatPrint("[GrowthLoop] Setup cancelado durante settle — automação desligada")
return false
end

local stable = player.Character
if not stable or not stable:FindFirstChild("HumanoidRootPart")
or stable:GetAttribute("CharacterName") ~= charName
then
goatWarn("[GrowthLoop] Slot disappeared during settle:", charName)
return false
end

setGrowSurvival(true, "verified respawn complete; growth survival resumed")
return true
end

local function resetToMenu()
pcall(function()
RS.CustomCharacterResetRemoteFunction:InvokeServer()
end)
task.wait(2)
end

-- Auto Quest Grow uses the exact proven Grow Existing transition:
--   disable survival movement
--   walk to Spawn Beach
--   confirm arrival
--   reset to menu
-- WaterEscape/AutoDrink are blocked by withLock while this runs.
local function prepareAutoQuestGrowSlotSwitch()
local prepared = false

local lockOk = withLock(function()
setGrowSurvival(false, "Auto Quest Grow switching slot via Spawn Beach")

goatPrint("[AutoQuest] Grow slot switch • going to Spawn Beach before reset")

local beachOk = walkToBeachReset()
if not beachOk then
goatWarn("[AutoQuest] Grow slot switch • Spawn Beach not confirmed — reset cancelled")
return
end

shared._expectedCharacterRemoving = true
goatPrint("[AutoQuest] Grow slot switch • Spawn Beach confirmed — resetting to Characters menu")

local beforeResetCharacter = player.Character
local beforeResetName =
beforeResetCharacter
and beforeResetCharacter:GetAttribute("CharacterName")
or nil

resetToMenu()

-- Do not assume the fixed 2-second reset delay means the menu is ready.
-- Savannah can take several more seconds to actually remove the live
-- character. Only allow the target spawn after the old character is gone.
local menuDeadline = os.clock() + 15
local menuReady = false

while os.clock() < menuDeadline do
local current = player.Character
local currentName =
current
and current:GetAttribute("CharacterName")
or nil

local oldCharacterGone =
current == nil
or current ~= beforeResetCharacter
or currentName == nil

if oldCharacterGone then
menuReady = true
goatPrint(
"[AutoQuest] Grow slot switch • Characters menu READY | previous="
.. tostring(beforeResetName)
.. " | current="
.. tostring(currentName or "nil/menu")
)
break
end

task.wait(0.20)
end

if not menuReady then
shared._expectedCharacterRemoving = false
local current = player.Character
goatWarn(
"[AutoQuest] Grow slot switch • menu transition TIMEOUT | previous="
.. tostring(beforeResetName)
.. " | current="
.. tostring(
current
and current:GetAttribute("CharacterName")
or "nil/menu"
)
.. " | target spawn CANCELLED"
)
return
end

prepared = true
end)

if not lockOk then
goatWarn("[AutoQuest] Grow slot switch • growth lock unavailable")
return false
end

return prepared
end

shared._prepareAutoQuestGrowSlotSwitch = prepareAutoQuestGrowSlotSwitch

-- Keep old direct helper available for other legacy callers, but AutoQuest
-- no longer uses it by itself.
shared._resetToMenuForGrowth = resetToMenu

local function recoverPreviousAfterNewSlotFailure(previousEntry, previousName, reason)
newSlotSpawnInProgress = false
shared._growNewSpawnInProgress = false
newSlotRetryNotBefore = os.clock() + 12

goatWarn("[GrowthLoop] NEW SLOT recovery:", tostring(reason),
"| retry in 12s | previous:", tostring(previousName))

if not previousName then
goatWarn("[GrowthLoop] NEW SLOT recovery unavailable — previous CharacterName missing")
return false
end

local recoverTarget = previousEntry or previousName
local ok = spawnAndSetup(recoverTarget)
if not ok then
goatWarn("[GrowthLoop] NEW SLOT immediate recovery failed for:", tostring(previousName),
"— watchdog remains available")
return false
end

currentGrowthName = previousName
shared._currentGrowthName = previousName

local ch = player.Character
if ch then
local animal, gender, skin = getSlotInfo(ch)
currentAnimalName = animal
currentGender = gender
currentSkin = skin
end

goatPrint("[GrowthLoop] NEW SLOT failure recovered immediately to:",
tostring(previousName), "| retry cooldown: 12s")
return true
end

-- NEW SLOT: after CreateNewCharacter succeeds, wait for the server-side
-- SavedCharacters list to expose that exact slot before starting spawn retries.
-- This avoids immediately treating a just-created slot as a failed spawn.
local function waitForCreatedNewSlot(newName, expectedAnimal, timeout)
local syncSavedCharacterRecords = shared._syncSavedCharacterRecords
local findSavedCharacterRecordByName = shared._findSavedCharacterRecordByName
local deadline = os.clock() + (tonumber(timeout) or 12)
local lastEntry = nil

if type(syncSavedCharacterRecords) ~= "function"
or type(findSavedCharacterRecordByName) ~= "function" then
return nil
end

while os.clock() < deadline do
local ok, records = pcall(syncSavedCharacterRecords, true)
if ok and type(records) == "table" then
local entry = findSavedCharacterRecordByName(newName, records)
if entry then
lastEntry = entry
local animal = entry.AnimalName
if expectedAnimal == nil
or expectedAnimal == ""
or animal == nil
or animal == ""
or animal == expectedAnimal then
goatPrint("[GrowthLoop] NEW SLOT replicated:", newName,
"| Animal:", tostring(animal),
"| Growth:", tostring(entry.GrowthPercentage))
return entry
end
end
end
task.wait(0.5)
end

if lastEntry then
goatWarn("[GrowthLoop] NEW SLOT replicated with unexpected animal | slot:",
newName, "| expected:", tostring(expectedAnimal),
"| got:", tostring(lastEntry.AnimalName))
else
goatWarn("[GrowthLoop] NEW SLOT replication wait timed out:", newName)
end
return lastEntry
end

-- NEW SLOT only: use the same simple naming strategy from the older
-- working Grow New flow. Nothing outside New Slot uses this helper.
local function getReliableNewSlotName(previousName, animalName)
local usedNames = {}
local syncSavedCharacterRecords = shared._syncSavedCharacterRecords

if type(syncSavedCharacterRecords) == "function" then
local ok, records = pcall(syncSavedCharacterRecords, true)
if ok and type(records) == "table" then
for _, entry in ipairs(records) do
if type(entry) == "table"
and type(entry.CharacterName) == "string"
and entry.CharacterName ~= ""
then
usedNames[entry.CharacterName] = true
end
end
end
end

-- Matches the old working behavior:
-- "TGoat || ..." -> TGoat1 / TGoat2 / TGoat3...
-- Keep this sanitizer local to New Slot. The older sanitizeNameSeed()
-- lives inside another scope and is not callable here.
local base = tostring(
previousName or shared._currentGrowthName
or animalName or gameConfig.expectedAnimal or "Slot"
):gsub("[^%w]+", "")

-- Prevent suffix nesting:
-- TGoat2 must continue as TGoat3/TGoat4..., never TGoat21.
base = base:gsub("%d+$", "")

if base == "" then
base = tostring(animalName or gameConfig.expectedAnimal or "Slot")
:gsub("[^%w]+", "")
:gsub("%d+$", "")
end
if base == "" then
base = "Slot"
end
base = string.sub(base, 1, 18)

for i = 1, 999 do
local candidate = string.format("%s%d", base, i)
if not usedNames[candidate] then
goatPrint("[GrowthLoop] NEW SLOT next free name:", candidate)
return candidate
end
end

return string.format("%s%d", base, math.floor(os.clock() * 1000))
end

local function doGrowthReset()
withLock(function()
if gameConfig.name == "DinoLife" then
goatPrint("[GrowthLoop] [DL] Grow New cycle starting")
end
if os.clock() < newSlotRetryNotBefore then
return
end

-- Keep the current 100% protection and Spawn Beach movement.
setGrowSurvival(false, "100% reached; survival locked until respawn")

shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false

local fullChar = player.Character
if fullChar then
fullChar:SetAttribute("_drinkingToFull", false)
fullChar:SetAttribute("_returningToLand", false)
end
task.wait(0.20)

if not walkToBeachReset() then
goatPrint("[GrowthLoop] Reset cancelado durante a caminhada até a praia")
return
end

local character = player.Character
if not character then return end

local animalName, gender, skin = getSlotInfo(character)
local previousName = character:GetAttribute("CharacterName") or currentGrowthName

local syncSavedCharacterRecords = shared._syncSavedCharacterRecords
local findSavedCharacterRecordByName = shared._findSavedCharacterRecordByName

local previousEntry = nil
if type(syncSavedCharacterRecords) == "function"
and type(findSavedCharacterRecordByName) == "function"
and previousName
then
local ok, records = pcall(syncSavedCharacterRecords, true)
if ok and type(records) == "table" then
previousEntry = findSavedCharacterRecordByName(previousName, records)
end
end

-- IMPORTANT: use only the proven old naming flow for NEW SLOT.
local newName = getReliableNewSlotName(previousName, animalName)

goatPrint("[GrowthLoop] Full grown! Creating new slot:", newName,
"| Animal:", animalName, "| Gender:", gender)

-- From this point until spawn/recovery finishes, Grow New owns the menu.
-- The generic watchdog must not force-unlock this valid pending spawn.
newSlotSpawnInProgress = true
shared._growNewSpawnInProgress = true

resetToMenu()

-- Same proven core flow as the old script:
-- Create -> short wait -> normal SpawnAsCharacter path.
local createOk, createErr = pcall(function()
RS.CreateNewCharacterRemoteFunction:InvokeServer(
newName, animalName, gender, skin
)
end)

if not createOk then
goatWarn("[GrowthLoop] CreateNewCharacter failed:", createErr)
recoverPreviousAfterNewSlotFailure(
previousEntry, previousName, "CreateNewCharacter exception"
)
return
end

-- Give Savannah time to persist the newly-created slot before spawning it.
-- The old flow waited a fixed 2s, which was too short on slower servers.
local replicatedEntry = waitForCreatedNewSlot(newName, animalName, 12)

-- Retry the SAME newly-created slot before falling back to the previous one.
-- Each spawnAndSetup call already has its own exact CharacterName checks and
-- no-mother direct-spawn retries; these outer rounds cover delayed replication.
local spawnOk = false
local newSlotEntry = replicatedEntry or {
CharacterName = newName,
AnimalName = animalName,
GrowthPercentage = 0,
}

for round = 1, 3 do
if not growNewSlots or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then
goatWarn("[GrowthLoop] NEW SLOT spawn cancelled — Grow New disabled/instance changed")
newSlotSpawnInProgress = false
shared._growNewSpawnInProgress = false
return
end

goatPrint("[GrowthLoop] NEW SLOT spawn round " .. round .. "/3:", newName)
spawnOk = spawnAndSetup(newSlotEntry, {
preferNoMother = true,
})

if spawnOk then
goatPrint("[GrowthLoop] NEW SLOT spawn CONFIRMED on round " .. round .. "/3:", newName)
break
end

if round < 3 then
goatWarn("[GrowthLoop] NEW SLOT still not ready — retrying SAME slot:",
newName, "| next round in 4s")
task.wait(4)
local refreshed = waitForCreatedNewSlot(newName, animalName, 4)
if refreshed then
newSlotEntry = refreshed
end
end
end

if not spawnOk then
goatWarn("[GrowthLoop] NEW SLOT spawn failed after 3 rounds:", newName)
recoverPreviousAfterNewSlotFailure(
previousEntry, previousName,
"same new slot failed after 3 spawn rounds"
)
return
end

local setupOk = teleportAndEnable(nil, newName)
if not setupOk then
goatWarn("[GrowthLoop] New slot spawned but setup/TP was not confirmed:", newName)
recoverPreviousAfterNewSlotFailure(
previousEntry, previousName,
"post-spawn setup failed"
)
return
end

newSlotSpawnInProgress = false
shared._growNewSpawnInProgress = false
newSlotRetryNotBefore = 0
currentGrowthName = newName
shared._currentGrowthName = newName
currentAnimalName = animalName
currentGender     = gender
currentSkin       = skin

local added = trackSlotName(newName)
goatPrint("[GrowthLoop] Now growing VERIFIED:", newName,
"| Total slots:", getTrackedSlotTotal(), "| Added:", added)
end)
end

doExistingSlotCycle = function()
local beachCycleStarted = spawnBeachActive == true
local beachCycleGeneration = tonumber(shared._spawnBeachGeneration) or 0

withLock(function()
local function beachCycleCancelled()
return beachCycleStarted
and (
spawnBeachActive ~= true
or (tonumber(shared._spawnBeachGeneration) or 0) ~= beachCycleGeneration
)
end

if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Cycle cancelled immediately — mode OFF")
return
end
if gameConfig.name == "DinoLife" then
goatPrint("[GrowthLoop] [DL] Grow Existing cycle starting")
end
setGrowSurvival(false, "switching existing slot via Spawn Beach")

if not walkToBeachReset() then
goatPrint("[GrowthLoop] Troca de slot cancelada durante a caminhada até a praia")
return
end

if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Cycle cancelled after beach walk — mode OFF")
return
end

local getNextExistingSlotRecord = shared._getNextExistingSlotRecord
local entry, idx, total = nil, nil, 0
if type(getNextExistingSlotRecord) == "function" then
entry, idx, total = getNextExistingSlotRecord()
end

if not entry then
goatWarn("[GrowthLoop] [Existing] SavedCharacters has no valid slots for", gameConfig.name)
if spawnBeachActive then
goatPrint("[GrowthLoop] [Beach] Sem slots válidos — tentando de novo em 5s (loop)")
task.wait(5)
task.spawn(doExistingSlotCycle)
end
return
end

local slotName = entry.CharacterName
goatPrint("[GrowthLoop] [Existing] Moving to slot",
idx, "/", total, ":", slotName, "| Animal:", tostring(entry.AnimalName))

resetToMenu()

local spawnOk = false
if spawnBeachActive then
for attempt = 1, 3 do
-- Spawn Beach only: keep the growth lock alive even if the current
-- spawnAndSetup fallback throws (ex.: existing 9509 in the 17e base).
-- This lets attempt 2/3 run instead of unwinding withLock and triggering
-- death recovery back to the previous slot.
if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Spawn attempts cancelled — mode OFF")
return
end

local callOk, callResult = pcall(spawnAndSetup, entry, {
cancelCheck = beachCycleCancelled,
})

if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Spawn flow cancelled — mode OFF")
return
end

if callOk then
spawnOk = callResult == true
else
spawnOk = false
goatWarn("[GrowthLoop] [Beach] Spawn attempt " .. attempt .. "/3 error caught:", tostring(callResult))
end

if spawnOk then
goatPrint("[GrowthLoop] [Beach] Spawn attempt " .. attempt .. "/3 SUCCESS:", slotName)
break
end

goatWarn("[GrowthLoop] [Existing] Spawn attempt " .. attempt .. "/3 falhou:", slotName)
if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Retry cancelled — mode OFF")
return
end
task.wait(2)
end

if not spawnOk then
if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Spawn failed but mode is OFF — no next cycle")
return
end
goatWarn("[GrowthLoop] [Beach] Spawn falhou após 3 tentativas — avançando pro próximo slot em 5s")
task.wait(5)
if not beachCycleCancelled() then
task.spawn(doExistingSlotCycle)
end
return
end
else
spawnOk = spawnAndSetup(entry)
if not spawnOk then
shared._failedExistingSlotUntil = shared._failedExistingSlotUntil or {}
shared._failedExistingSlotUntil[slotName] = os.clock() + 120
goatWarn("[GrowthLoop] [Existing] Failed to spawn:", slotName,
"| temporarily skipping for", 120, "seconds")
return
end

-- Successful spawn: remove any old temporary failure marker for this slot.
if shared._failedExistingSlotUntil then
shared._failedExistingSlotUntil[slotName] = nil
end
end

if beachCycleCancelled() then
goatPrint("[GrowthLoop] [Beach] Mode turned OFF after spawn — stopping cycle here")
return
end

task.wait(1)
local ch = player.Character
if ch then
local growth = waitForAttribute(ch, "GrowthPercentage", 8)
local slotIsFull = growth and (
growth >= 1
or (spawnBeachActive and growth >= 0.999)
)

if slotIsFull then
goatPrint("[GrowthLoop] [Existing] Slot", slotName, "already 100% — avançando pro próximo")
if growExistingSlots then
task.spawn(doExistingSlotCycle)
elseif spawnBeachActive and not beachCycleCancelled() then
task.spawn(doExistingSlotCycle)
end
return
end

local animal, gender = getSlotInfo(ch)
goatPrint("[GrowthLoop] [Existing] Slot:", slotName,
"| Animal:", animal, "| Gender:", gender)
end

local setupOk = teleportAndEnable(nil, slotName)
if not setupOk then
goatWarn("[GrowthLoop] [Existing] Setup failed after spawn:", slotName)
return
end

local live = player.Character
local liveAnimal = live and live:GetAttribute("AnimalName") or tostring(entry.AnimalName or "")
if growExistingSlots then
setGrowExistingSurvivalForAnimal(liveAnimal, true)
end

currentGrowthName = slotName
shared._currentGrowthName = slotName
goatPrint("[GrowthLoop] [Existing] Now growing:", slotName,
"| Animal:", tostring(liveAnimal))
end)
end

doParkOnSlotOne = function()
local getParkSlotRecord = shared._getParkSlotRecord
local lockedName = shared._afkCoinsLockedCharacterName
local lockedAnimal = shared._afkCoinsLockedAnimalName

-- AFK Coins recovery uses the exact CharacterName captured on activation.
-- This prevents death recovery from falling back to another animal/slot.
local slotOneEntry = nil
if not lockedName then
slotOneEntry = type(getParkSlotRecord) == "function" and getParkSlotRecord() or nil
end
local slotOne = lockedName or (slotOneEntry and slotOneEntry.CharacterName)
if not slotOne then
goatWarn("[GrowthLoop] [AFK] No locked saved slot available - cannot recover")
return
end
goatPrint("[GrowthLoop] [AFK] Recover target:", tostring(lockedAnimal), "|", tostring(slotOne))

withLock(function()
local ch = player.Character
local growth = ch and ch:GetAttribute("GrowthPercentage")
if growth and growth < 1 then
goatPrint(string.format("[GrowthLoop] [Park] Current slot not full (%.0f%%) - growing existing first", growth * 100))
setParkingModeState(false)
growExistingSlots = true
task.spawn(function() doExistingSlotCycle() end)
return
end

goatPrint("[GrowthLoop] [Park] Parking on slot:", slotOne)

setGrowSurvival(false, "parking slot transition")

resetToMenu()
task.wait(1)

local spawnOk = false
for attempt = 1, 3 do
spawnOk = spawnAndSetup(slotOneEntry or slotOne)
if spawnOk then break end
goatWarn("[GrowthLoop] [Park] Spawn attempt " .. attempt .. " failed - retrying")
task.wait(2)
end

if not spawnOk then
goatWarn("[GrowthLoop] [Park] All spawn attempts failed - watchdog will retry")
return
end

teleportAndEnable(nil, slotOne)
currentGrowthName = slotOne
shared._currentGrowthName = slotOne
goatPrint("[GrowthLoop] [Park] Parked on " .. slotOne .. " - passive coins active")

task.wait(2)
setGrowSurvival(true, "parked survival")
end)
end

shared._runParkingMode = doParkOnSlotOne

shared._spawnBeachMode = function(state)
if state then
local wasAlreadyActive = spawnBeachActive == true

-- IMPORTANT: duplicate ON events must NOT invalidate the active beach worker.
-- The previous build incremented _spawnBeachGeneration on every ON callback,
-- so a second ON immediately cancelled the worker that had just started.
if not wasAlreadyActive then
shared._spawnBeachGeneration = (tonumber(shared._spawnBeachGeneration) or 0) + 1
spawnBeachActive = true

if shared._goatHudSetStatus then
shared._goatHudSetStatus("Spawn Beach", "Ativado • ciclando slots", Color3.fromRGB(0, 170, 255))
end

goatPrint(
"[GrowthLoop] [Beach] Spawn Beach mode ON — ciclando slots existentes | gen="
.. tostring(shared._spawnBeachGeneration)
)
else
goatPrint(
"[GrowthLoop] [Beach] Duplicate ON ignored • keeping current worker | gen="
.. tostring(shared._spawnBeachGeneration)
)
end

if parkingMode then
setParkingModeState(false)
end

-- If there is no live growth worker, ensure one exists, but keep the SAME
-- generation when this was only a duplicate ON callback.
if not isLooping then
task.spawn(function() doExistingSlotCycle() end)
end
else
if spawnBeachActive ~= true then
goatPrint("[GrowthLoop] [Beach] Duplicate OFF ignored • already disabled")
return
end

if shared._goatHudSetStatus then
shared._goatHudSetStatus("Spawn Beach", "Desativado", Color3.fromRGB(0, 170, 255))
end

goatPrint("[GrowthLoop] [Beach] Spawn Beach mode OFF — cancelando")
shared._spawnBeachGeneration = (tonumber(shared._spawnBeachGeneration) or 0) + 1
spawnBeachActive = false
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1

if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

if cancelGrowthWorkIfIdle then
cancelGrowthWorkIfIdle("Spawn Beach OFF")
elseif isLooping then
forceUnlockGrowthLoop("spawn beach mode off")
end
end
end

if pendingParkMode then
-- Legacy pending activation is intentionally discarded.
-- AFK Coins only respawns after an actual death.
pendingParkMode = false
end

local function doDeathRecovery()
if not growthAutomationActive() then return end
if not currentGrowthName then return end
withLock(function()
if not growthAutomationActive() then return end
if parkingMode then
goatPrint("[GrowthLoop] Death in AFK Coins — recovering locked animal/slot")
task.wait(2)
task.spawn(doParkOnSlotOne)
return
end
goatPrint("[GrowthLoop] Death detected! Returning to:", currentGrowthName)
task.wait(2)
if not growthAutomationActive() then
goatPrint("[GrowthLoop] Death recovery cancelado — automação foi desligada")
return
end
local ok = spawnAndSetup(currentGrowthName)
if not ok then
goatWarn("[GrowthLoop] Death recovery failed for:", currentGrowthName)
return
end
teleportAndEnable(nil, currentGrowthName)
end)
end

task.spawn(trackCurrentCharacter)

local lastGrowth = 0
local growthCheckReady = false

local function armGrowthCheck(character)
growthCheckReady = false
lastGrowth = 0
task.spawn(function()
local val = waitForAttribute(character, "GrowthPercentage", 15)
if val ~= nil then
lastGrowth = (val >= 1) and 0 or val
growthCheckReady = true
else
goatWarn("[GrowthLoop] GrowthPercentage never appeared")
end
end)
end

task.spawn(function()
local ch = player.Character
if ch then armGrowthCheck(ch) end
end)

trackRuntimeConnection(RunService.Heartbeat:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
if isLooping then return end
if not growthCheckReady then return end
local character = player.Character
if not character then return end

local growth = character:GetAttribute("GrowthPercentage")
if not growth then return end

if not growthAutomationActive() then
lastGrowth = growth
return
end

if growth >= 1 and lastGrowth >= 0.9 then
local bothOn = growExistingSlots and growNewSlots

if parkingMode then
return
end

if bothOn then
if not allExistingGrown then
slotsGrownThisCycle = slotsGrownThisCycle + 1
goatPrint("[GrowthLoop] [Smart] Original slot grown: " .. slotsGrownThisCycle .. " / " .. originalSlotCount)
if slotsGrownThisCycle >= originalSlotCount then
allExistingGrown = true
slotsGrownThisCycle = 0
goatPrint("[GrowthLoop] [Smart] All " .. originalSlotCount .. " original slots grown — now creating new slots")
end
task.spawn(doExistingSlotCycle)
elseif getTrackedSlotTotal() < MAX_SLOTS then
if os.clock() >= newSlotRetryNotBefore then
goatPrint("[GrowthLoop] [Smart] Creating new slot (" .. getTrackedSlotTotal() .. "/" .. MAX_SLOTS .. ")")
task.spawn(doGrowthReset)
end
else
setParkingModeState(true)
goatPrint("[GrowthLoop] [Smart] All " .. MAX_SLOTS .. " slots grown — parking on slot 1 for passive coins")
task.spawn(doParkOnSlotOne)
end
elseif growExistingSlots then
task.spawn(doExistingSlotCycle)
elseif growNewSlots then
if os.clock() >= newSlotRetryNotBefore then
task.spawn(doGrowthReset)
end
elseif spawnBeachActive then
task.spawn(doExistingSlotCycle)
end
return
end

local hum = character:FindFirstChild("Humanoid")
if hum and hum.Health <= 0 then
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
carcassOwnsMovement = false
cachedCarcassTarget = nil
shared._autoQuestCarnivoreFoodEmergency = false
if not growthAutomationActive() then
lastGrowth = growth
return
end
if isLooping then
goatWarn("[GrowthLoop] Death while isLooping=true — force unlocking")
forceUnlockGrowthLoop("death detected while locked")
end
lastGrowth = growth
task.spawn(doDeathRecovery)
return
end

lastGrowth = growth
end))

trackRuntimeConnection(player.CharacterAdded:Connect(function(character)
shared._growthPreResetRecoveryActive = false
shared._fixedWaterLandRecoveryGeneration =
(tonumber(shared._fixedWaterLandRecoveryGeneration) or 0) + 1

shared._fixedWaterLandRecoveryActive = false
shared._fixedWaterLandRecoveryCharacter = nil
shared._fixedWaterLandRecoveryOwnerGeneration = nil
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end

-- New Character = new survival lifecycle.
carcassPatrolToken = (tonumber(carcassPatrolToken) or 0) + 1
carcassPatrolRunning = false
carcassOwnsMovement = false
cachedCarcassTarget = nil
cachedCarcassTargetAt = 0
shared._goatCarcassForceFreshScan = true

-- Do not keep the dead Character's food-emergency latch on the respawned animal.
shared._autoQuestCarnivoreFoodEmergency = false

pcall(function()
character:SetAttribute("_carcassInteractionLock", false)
character:SetAttribute("_drinkingToFull", false)
character:SetAttribute("_returningToLand", false)
end)

-- Force AutoDrink to execute its existing new-character cleanup next tick.
lastAutoDrinkCharacter = nil

goatPrint("[SurvivalLock] Respawn reset | stale Carcass/Drink locks cleared")

lastGrowth = 0
growthCheckReady = false
armGrowthCheck(character)
task.spawn(trackCurrentCharacter)
end))

local hudGui = Instance.new("ScreenGui")
hudGui.Name = "GrowthLoopHUD"
hudGui.ResetOnSpawn = false
hudGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
hudGui.Parent = game:GetService("CoreGui")

local CARD_W, CARD_H = 190, 68
local hudFrame = Instance.new("Frame")
hudFrame.Size = UDim2.new(0, CARD_W, 0, CARD_H)
hudFrame.Position = UDim2.new(1, -(CARD_W + 8), 0, 8)
hudFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 14)
hudFrame.BackgroundTransparency = 0.05
hudFrame.BorderSizePixel = 0
hudFrame.Parent = hudGui
Instance.new("UICorner", hudFrame).CornerRadius = UDim.new(0, 10)
local hudStroke = Instance.new("UIStroke", hudFrame)
hudStroke.Color = Color3.fromRGB(0, 140, 255)
hudStroke.Thickness = 1.2
hudStroke.Transparency = 0.5

local accent = Instance.new("Frame")
accent.Size = UDim2.new(0, 3, 1, -14)
accent.Position = UDim2.new(0, 0, 0, 7)
accent.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
accent.BorderSizePixel = 0
accent.Parent = hudFrame
Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 2)
local accentGlow = Instance.new("Frame")
accentGlow.Size = UDim2.new(0, 8, 1, -10)
accentGlow.Position = UDim2.new(0, -2, 0, 5)
accentGlow.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
accentGlow.BackgroundTransparency = 0.7
accentGlow.BorderSizePixel = 0
accentGlow.ZIndex = -1
accentGlow.Parent = hudFrame
Instance.new("UICorner", accentGlow).CornerRadius = UDim.new(0, 4)

local function lbl(y, sz, bold)
local l = Instance.new("TextLabel")
l.Size = UDim2.new(1, -16, 0, sz + 2)
l.Position = UDim2.new(0, 12, 0, y)
l.BackgroundTransparency = 1
l.TextColor3 = Color3.fromRGB(200, 215, 255)
l.TextSize = sz
l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
l.TextXAlignment = Enum.TextXAlignment.Left
l.TextTruncate = Enum.TextTruncate.AtEnd
l.Parent = hudFrame
return l
end

local lblSlot   = lbl(6,  12, true)   -- "god [2/40]"
local lblGrowth = lbl(22, 11, false)  -- "Growth: 73%"
local lblBar    = lbl(36, 9,  false)  -- progress bar
local lblMode   = lbl(51, 9,  false)  -- mode
lblBar.Font = Enum.Font.Code

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -26, 0, 5)
barBg.Position = UDim2.new(0, 12, 0, 36)
barBg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
barBg.BorderSizePixel = 0
barBg.Parent = hudFrame
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
barBg.ClipsDescendants = true

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
barFill.ZIndex = 2
local barGlow = Instance.new("Frame")
barGlow.Size = UDim2.new(1, 0, 1, 2)
barGlow.Position = UDim2.new(0, 0, 0, -1)
barGlow.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
barGlow.BackgroundTransparency = 0.65
barGlow.BorderSizePixel = 0
barGlow.ZIndex = 1
barGlow.Parent = barBg
Instance.new("UICorner", barGlow).CornerRadius = UDim.new(1, 0)
lblBar.Text = ""

task.spawn(function()
while true do
task.wait(0.5)
local ch = player.Character
local growth = ch and ch:GetAttribute("GrowthPercentage") or 0
local slotName = currentGrowthName or "—"
local growthPct = math.floor(growth * 100)

local trackedTotal = getTrackedSlotTotal()
local slotIdx = findSlotIndexByName(currentGrowthName) or 0
if trackedTotal > 0 then
slotIdx = math.clamp(slotIdx, 0, trackedTotal)
else
slotIdx = 0
end
lblSlot.Text = string.format("%s  [%d/%d]", slotName, slotIdx, trackedTotal)

lblGrowth.Text = string.format("Growth: %d%%", growthPct)
local pct = math.clamp(growth, 0, 1)
if pct < 0.5 then
lblGrowth.TextColor3 = Color3.fromRGB(255, math.floor(pct * 2 * 200), 60)
else
lblGrowth.TextColor3 = Color3.fromRGB(math.floor((1-pct)*2*255), 210, 60)
end

barFill.Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0)

local mode, col
if parkingMode then
mode = "* passive coins"
col = Color3.fromRGB(0, 200, 255)
elseif growExistingSlots and growNewSlots then
col = Color3.fromRGB(0, 170, 255)
if allExistingGrown then
mode = "* smart > new slots"
else
mode = string.format("* smart > existing %d/%d", slotsGrownThisCycle, originalSlotCount)
end
elseif growExistingSlots then
mode = "* growing existing"
col = Color3.fromRGB(0, 200, 230)
elseif growNewSlots then
mode = "* growing new"
col = Color3.fromRGB(80, 180, 255)
else
mode = "* idle"
col = Color3.fromRGB(40, 50, 80)
end
lblMode.Text = mode
lblMode.TextColor3 = col
accent.BackgroundColor3 = col
end
end)

task.spawn(function()
local stuckTimer = 0
local STUCK_THRESHOLD = 60

local parkStuckTimer = 0
local PARK_STUCK_THRESHOLD = 30

while shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
task.wait(15)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then break end

local ch = player.Character
local hasRoot   = ch and ch:FindFirstChild("HumanoidRootPart") ~= nil
local hasGrowth = ch and ch:GetAttribute("GrowthPercentage") ~= nil

if parkingMode then
if not hasRoot or not hasGrowth then
parkStuckTimer = parkStuckTimer + 15
if parkStuckTimer < PARK_STUCK_THRESHOLD then
goatWarn(string.format("[Watchdog] [Park] No character for %ds — waiting", parkStuckTimer))
end
if parkStuckTimer >= PARK_STUCK_THRESHOLD then
parkStuckTimer = 0
goatWarn("[Watchdog] [Park] Recovering — respawning slot 1 for passive coins")
if isLooping then
forceUnlockGrowthLoop("parking menu watchdog")
end
task.spawn(doParkOnSlotOne)
end
else
parkStuckTimer = 0
end
continue
end

local anyModeOn = growExistingSlots or growNewSlots
if not anyModeOn then
stuckTimer = 0
continue
end

-- Grow New can legitimately remain in the Characters menu while Savannah
-- persists a newly-created slot and while spawnAndSetup retries that SAME slot.
-- Do not let the generic 60s watchdog break the growth lock or spawn the
-- previous 100% character in the middle of that transaction.
if growNewSlots and (newSlotSpawnInProgress or shared._growNewSpawnInProgress) then
if not hasRoot or not hasGrowth then
if stuckTimer ~= 0 then stuckTimer = 0 end
goatPrint("[Watchdog] Grow New spawn pending — menu wait is expected; recovery suppressed")
end
continue
end

if not hasRoot or not hasGrowth then
stuckTimer = stuckTimer + 15
goatWarn(string.format("[Watchdog] No character/growth for %ds — stuck in menu?", stuckTimer))

if stuckTimer >= STUCK_THRESHOLD then
stuckTimer = 0
if isLooping then
forceUnlockGrowthLoop("menu watchdog")
end
local getFirstExistingSlotRecord = shared._getFirstExistingSlotRecord
local fallbackEntry = type(getFirstExistingSlotRecord) == "function"
and getFirstExistingSlotRecord()
or nil
local recoverSlot = currentGrowthName or (fallbackEntry and fallbackEntry.CharacterName)
goatWarn("[Watchdog] Stuck threshold reached — recovering slot: " .. tostring(recoverSlot))

withLock(function()
setGrowSurvival(false, "watchdog recovery")

local spawnOk = spawnAndSetup(recoverSlot)
if not spawnOk then
goatWarn("[Watchdog] spawnAndSetup failed for: " .. tostring(recoverSlot))
return
end

task.wait(1)
local newCh = player.Character
if newCh then
local g = waitForAttribute(newCh, "GrowthPercentage", 8)
local animal, gender, skin = getSlotInfo(newCh)
currentAnimalName = animal
currentGender = gender
currentSkin = skin
if g and g >= 1 then
goatPrint("[Watchdog] Recovered slot already 100% — triggering next cycle")
if growExistingSlots or spawnBeachActive then
task.spawn(doExistingSlotCycle)
elseif growNewSlots then
task.spawn(doGrowthReset)
end
return
end
goatPrint("[Watchdog] Recovery slot info — Animal:", animal, "| Gender:", gender, "| Skin:", skin)
task.wait(1)
end

teleportAndEnable(nil, recoverSlot)
currentGrowthName = recoverSlot
shared._currentGrowthName = recoverSlot
goatPrint("[Watchdog] Recovery complete — now growing: " .. tostring(recoverSlot))
end)
end
else
stuckTimer = 0
end
end
end)

task.spawn(function()
local LOW_THRESHOLD = 40

while shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
task.wait(1)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then break end
if isLooping then continue end

local ch = player.Character
if not ch then
continue
end

local animalName = ch:GetAttribute("AnimalName") or ""
local isCarnivore = shared._isCarnivoreName and shared._isCarnivoreName(animalName) or false

if not isCarnivore then
if shared._autoQuestCarnivoreFoodEmergency == true then
shared._autoQuestCarnivoreFoodEmergency = false
goatPrint("[SurvivalLock] FOOD PRIORITY OFF | non-carnivore")
end
continue
end

local food = tonumber(ch:GetAttribute("Food"))
if not food then continue end

if food <= LOW_THRESHOLD then
if shared._autoQuestCarnivoreFoodEmergency ~= true then
shared._autoQuestCarnivoreFoodEmergency = true
shared._goatCarcassForceFreshScan = true

-- Cancel the previous normal movement owner immediately. Carcass will
-- acquire a fresh target on its next worker tick.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

goatWarn(string.format(
"[SurvivalLock] FOOD PRIORITY ON | %s food %.1f%% <= 40%% | Carcass radius=2000 until 100%%",
animalName,
food
))
end

if shared._setAutoCarcassInternal
and not (shared._getAutoCarcassInternal and shared._getAutoCarcassInternal())
then
pcall(shared._setAutoCarcassInternal, true)
end

elseif shared._autoQuestCarnivoreFoodEmergency == true
and food >= 99.9
then
shared._autoQuestCarnivoreFoodEmergency = false
shared._goatCarcassForceFreshScan = false

goatPrint(string.format(
"[SurvivalLock] FOOD PRIORITY OFF | %s food %.1f%% | full",
animalName,
food
))
end
end
end)

goatPrint("[GrowthLoop] Auto growth loop started.")
end)

task.spawn(function()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local enabled = false
local runToken = 0
local stopNativeTravel
local pauseDLQuestForRespawn

shared._autoQuestWorkerGeneration = shared._autoQuestWorkerGeneration or 0

if game.GameId == 8198412649 then
shared._dlAutoQuestProfile = true
goatPrint("[AutoQuest][DL] Separate DinoLife profile ACTIVE | SL/JL logic untouched")
else
shared._dlAutoQuestProfile = false
end

shared._autoQuestZoneLock = false
shared._autoQuestTravelLock = false
shared._autoQuestSwimLock = false
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil

local function setTravelMovementLock(state)
state = state == true

if not state and type(stopNativeTravel) == "function" then
stopNativeTravel()
end

local ch = player.Character
shared._autoQuestTravelLock = state
if ch then
ch:SetAttribute("_autoQuestTravelLock", state)
end

if state then
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
end
end

local function setZoneMovementLock(state)
state = state == true

local ch = player.Character
if shared._autoQuestZoneLock == state then
if ch then ch:SetAttribute("_autoQuestZoneLock", state) end
return
end

shared._autoQuestZoneLock = state
if ch then ch:SetAttribute("_autoQuestZoneLock", state) end

if state then
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
goatPrint("[AutoQuest] Zone lock ON • Auto Carcass pausada temporariamente")
else
goatPrint("[AutoQuest] Zone lock OFF • Auto Carcass liberada")
end
end

local function setSwimMovementLock(state)
state = state == true
local previous = shared._autoQuestSwimLock == true
shared._autoQuestSwimLock = state
local ch = player.Character
if ch then ch:SetAttribute("_autoQuestSwimLock", state) end
if previous == state then return end
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then pcall(shared._animalCancelTween, true) end
shared._animalTweening = false
setZoneMovementLock(state)
if not state and type(stopNativeTravel) == "function" then pcall(stopNativeTravel) end
end

local lastClaimAt = {}
local travelStep = 0
local zoneCache = {}
local zoneRejectedPoints = {}

shared._autoQuestEnabled = false
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
shared._autoQuestData = {}

local function clean(v)
local s = tostring(v or "")
s = s:gsub("<[^>]->", "")
s = s:gsub("[%c]", " ")
s = s:gsub("%s+", " ")
return (s:match("^%s*(.-)%s*$") or "")
end

local function lower(v)
return string.lower(clean(v))
end

local function number(raw)
if raw == nil then return nil end
return tonumber((tostring(raw):gsub(",", "")))
end

local function readText(obj)
if not obj or not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
return ""
end
local ok, value = pcall(function() return obj.Text end)
return ok and clean(value) or ""
end

local function parseProgressLabel(value)
local s = clean(value)
local a, b = s:match("^([%d,]+%.?%d*)%s*/%s*([%d,]+%.?%d*)%s*$")
if not a then
a, b = s:match("^[Pp]rogress:?%s*([%d,]+%.?%d*)%s*/%s*([%d,]+%.?%d*)%s*$")
end
if a and b then return number(a), number(b), "count" end

local pa, pb = s:match("^([%d%.]+)%s*%%%s*/%s*([%d%.]+)%s*%%%s*$")
if pa and pb then return tonumber(pa), tonumber(pb), "percent" end

local am, as, bm, bs = s:match("^(%d+):(%d%d)%s*/%s*(%d+):(%d%d)$")
if am and as and bm and bs then
return tonumber(am) * 60 + tonumber(as), tonumber(bm) * 60 + tonumber(bs), "seconds"
end
return nil, nil, nil
end

local noise = {
"gamepass", "update log", "use code", "settings", "server list",
"select a server", "join random server", "hide other players", "speech bubbles",
"reflections", "swaying trees", "still loading your save", "clear saved growth",
"walk/run toggle", "your boost:", "drag a button to move it", "noyo hat", "noyo mug",
}

local function looksLikeQuestSentence(value)
local s = clean(value)
local l = lower(s)
if #s < 4 or #s > 220 then return false end
if parseProgressLabel(s) then return false end
for _, n in ipairs(noise) do
if l:find(n, 1, true) then return false end
end
local starters = {"be ", "grow ", "play ", "survive ", "travel ", "keep ", "eat ", "drink ", "stay ", "spend ", "visit ", "reach ", "join ", "remain ", "run ", "walk ", "swim ", "swimming ", "nade ", "nadar "}
for _, st in ipairs(starters) do
if l:sub(1, #st) == st then return true end
end
return l:find("atleast", 1, true) ~= nil
or l:find("at least", 1, true) ~= nil
or l:find("distance of atleast", 1, true) ~= nil
end

local function classify(name)
local s = lower(name)

-- DinoLife-only quest types. SL/JL classification below remains unchanged.
if game.GameId == 8198412649 then
if s:find("survive", 1, true) and s:find("at night", 1, true) then
return "NIGHT_OWL"
end
if s:find("travel", 1, true)
and s:find("distance", 1, true)
and s:find("on land", 1, true)
then
return "LAND_DISTANCE"
end
end

-- Visit N different zones as any character.
if s:find("visit", 1, true) and s:find("different zone", 1, true) then
return "VISIT_ZONES"
end

if s:find("swim", 1, true) or s:match("^nade%s") or s:match("^nadar%s") then
return "SWIM_DISTANCE"
end
if s:find("group", 1, true) and (s:find("minute", 1, true) or s:find("hour", 1, true)) then return "GROUP_TIME" end
if s:find("grow as", 1, true) or (s:find("growth", 1, true) and s:find("minute", 1, true)) then return "GROW_TIME" end
if s:find("play for", 1, true) then return "PLAY_TIME" end
if s:find("survive", 1, true) and s:find("zone", 1, true) then return "SURVIVE_ZONE" end
if s:find("survive", 1, true) or s:find("stay alive", 1, true) then return "SURVIVE_TIME" end
if s:find("travel", 1, true) and s:find("distance", 1, true) then return "TRAVEL_DISTANCE" end
if s:find("food and water stats", 1, true) and s:find("above", 1, true) then return "MAINTAIN_STATS" end
if s:find("drink", 1, true) or s:find("water", 1, true) then return "DRINK" end
if s:find("eat", 1, true) or s:find("food", 1, true) or s:find("carcass", 1, true) then return "EAT" end
return "UNKNOWN"
end

local function inferTarget(name)
local s = lower(name)
local n = s:match("for%s+atleast%s+(%d+)%s+minutes?")
or s:match("for%s+at least%s+(%d+)%s+minutes?")
or s:match("for%s+(%d+)%s+minutes?")
if n then return tonumber(n) * 60, "seconds" end
n = s:match("for%s+(%d+)%s+hours?")
if n then return tonumber(n) * 3600, "seconds" end
n = s:match("distance%s+of%s+atleast%s+([%d,]+)") or s:match("distance%s+of%s+at%s+least%s+([%d,]+)")
if n then return number(n), "distance" end
n = s:match("pelo%s+menos%s+([%d.,]+)")
if n and (s:find("nade", 1, true) or s:find("nadar", 1, true)) then
return tonumber((n:gsub("[.,]", ""))), "distance"
end
return nil, nil
end

local function activateButton(button, claimMode)
if not button or not button:IsA("GuiButton") then return false, "button missing" end

-- Claim engine shared by DL/JL/SL.
-- First try MouseButton1Click via firesignal, then the existing fallbacks.
if type(firesignal) == "function" then
local ok = pcall(firesignal, button.MouseButton1Click)
if ok then return true, "firesignal" end
end

local okActivate = pcall(function() button:Activate() end)
if okActivate then return true, "activate" end

if type(getconnections) == "function" then
local ok, conns = pcall(getconnections, button.MouseButton1Click)
if ok and type(conns) == "table" and #conns > 0 then
for _, conn in ipairs(conns) do
if conn and type(conn.Function) == "function" then
local scheduled = pcall(function()
task.spawn(function()
pcall(conn.Function)
end)
end)
if scheduled then
return true, "connection_async"
end
end
end
end
end

return false, "failed"
end

local function questNodes()
local pg = player:FindFirstChildOfClass("PlayerGui")
local gui = pg and pg:FindFirstChild("QuestsScreenGui")
local frame = gui and gui:FindFirstChild("Frame")
local top = frame and frame:FindFirstChild("TopButtonsFrame")
local scroll = frame and frame:FindFirstChild("RefScrollingFrame")
return gui, top, scroll
end

local function inspectFrame(frame, category)
local texts = {}
local progressCurrent, progressTarget, progressUnit = nil, nil, nil
local clickButton, claimButton = nil, nil
local slTitle, slDescription = nil, nil

local isSL =
shared._goatIsSavannahLifeGame
and shared._goatIsSavannahLifeGame()

for _, obj in ipairs(frame:GetDescendants()) do
if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
local t = readText(obj)

if t ~= "" then
texts[#texts + 1] = t

-- Sempre use o progresso OFICIAL exibido pela própria QuestFrame.
-- Isso faz o SL reconhecer missão nova sem depender do nome dela.
local a, b, unit = parseProgressLabel(t)
if a and b and b > 0 then
-- Uma QuestFrame real possui um único progresso principal.
-- Se o ancestral inspecionado ainda estiver grande demais, prefira
-- o maior alvo como compatibilidade com o scanner antigo.
if not progressTarget or b > progressTarget then
progressCurrent, progressTarget, progressUnit = a, b, unit
end
end

-- Savannah Life tem dois layouts:
--   QuestFrame.InfoFrame...
--   QuestFrame.Content.InfoFrame...
-- Em ambos, pegue título/descrição pelo NOME do container, não pelo caminho.
if isSL then
local parent = obj.Parent
local insideInfoFrame = false
local depth = 0

while parent and parent ~= frame and depth < 6 do
depth = depth + 1
if parent.Name == "InfoFrame" then
insideInfoFrame = true
break
end
parent = parent.Parent
end

if insideInfoFrame then
if obj.Name == "TitleTextLabel" and not slTitle then
slTitle = t
elseif obj.Name == "InfoTextLabel" and not slDescription then
slDescription = t
end
end
end
end
end

if obj:IsA("GuiButton") then
if obj.Name == "ClickDetectorButton" then
clickButton = obj
elseif obj.Name == "ClaimButton" then
claimButton = obj
end
end
end

local description = slDescription
local title = slTitle

-- DL/JL e compatibilidade com layouts antigos continuam usando
-- a detecção textual anterior.
if not description then
local questTexts = {}

for _, t in ipairs(texts) do
if looksLikeQuestSentence(t) then
questTexts[#questTexts + 1] = t
end
end

table.sort(questTexts, function(a, b)
return #a > #b
end)

description = questTexts[1]
if not description then
return nil
end

if not title then
for i = #questTexts, 2, -1 do
if questTexts[i] ~= description and #questTexts[i] <= 80 then
title = questTexts[i]
break
end
end
end
end

if not progressTarget then
progressTarget, progressUnit = inferTarget(description)
end

-- No SL, "CLAIM" existir/estar visível NÃO significa missão concluída:
-- o jogo mantém ClaimButton e ClickDetectorButton presentes também em
-- cards incompletos. A conclusão depende exclusivamente do contador.
local completed =
progressCurrent ~= nil
and progressTarget ~= nil
and progressTarget > 0
and progressCurrent >= progressTarget

local index = tonumber(frame.Name:match("(%d+)$")) or 99

return {
category = category,
frame = frame,
index = index,
title = title,
name = description,
questType = classify(description),
progressCurrent = progressCurrent,
progressTarget = progressTarget,
progressUnit = progressUnit,
completed = completed,
clickButton = clickButton,
claimButton = claimButton,
}
end

local function scanCurrentCards(category)
local _, _, scroll = questNodes()
if not scroll then return {} end

local quests = {}
local seen = {}
local scanOrder = 0

-- New post-update cards can be nested deeper than the old QuestFrame<number>
-- layout. Use every explicit progress label (ex: 600/600) as an anchor,
-- then walk upward until the smallest ancestor that represents that quest.
for _, obj in ipairs(scroll:GetDescendants()) do
if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
local t = readText(obj)
local anchorCurrent, anchorTarget = parseProgressLabel(t)

if anchorCurrent and anchorTarget then
local current = obj.Parent
local bestQuest = nil
local depth = 0

while current and current ~= scroll and depth < 10 do
depth = depth + 1

if current:IsA("GuiObject") then
local q = inspectFrame(current, category)

if q
and q.progressCurrent == anchorCurrent
and q.progressTarget == anchorTarget
then
bestQuest = q
break
end
end

current = current.Parent
end

if bestQuest then
local key =
tostring(category) .. "|"
.. tostring(bestQuest.name) .. "|"
.. tostring(bestQuest.progressCurrent) .. "/"
.. tostring(bestQuest.progressTarget)

if not seen[key] then
seen[key] = true
scanOrder = scanOrder + 1

if bestQuest.index == 99 then
bestQuest.index = 1000 + scanOrder
end

quests[#quests + 1] = bestQuest

if shared._goatIsSavannahLifeGame
and shared._goatIsSavannahLifeGame()
and bestQuest.questType == "UNKNOWN" then
goatPrint(
"[AutoQuest][SL] Generic quest recognized | "
.. tostring(bestQuest.title or "?")
.. " | "
.. tostring(bestQuest.name or "?")
.. " | "
.. tostring(bestQuest.progressCurrent or "?")
.. "/"
.. tostring(bestQuest.progressTarget or "?")
.. " | done="
.. tostring(bestQuest.completed)
)
end
end
end
end
end
end

-- Compatibility fallback for any old card that has no explicit progress
-- anchor but is still readable by the previous direct-child method.
for _, child in ipairs(scroll:GetChildren()) do
if child:IsA("GuiObject") then
local q = inspectFrame(child, category)

if q then
local key =
tostring(category) .. "|"
.. tostring(q.name) .. "|"
.. tostring(q.progressCurrent) .. "/"
.. tostring(q.progressTarget)

if not seen[key] then
seen[key] = true
scanOrder = scanOrder + 1

if q.index == 99 then
q.index = 2000 + scanOrder
end

quests[#quests + 1] = q
end
end
end
end

table.sort(quests, function(a, b)
return a.index < b.index
end)

return quests
end

local function switchAndScan(category, token)
local _, top = questNodes()
if not top then return {}, false end
local btn = top:FindFirstChild(category .. "Button")
if not btn then return {}, false end
local ok = activateButton(btn)
if not ok then return {}, false end

local waited = 0
while waited < 3.25 do
if not enabled or runToken ~= token then return {}, false end
task.wait(0.25)
waited = waited + 0.25
end
return scanCurrentCards(category), true
end

local function scanAll(token)
local daily = switchAndScan("Daily", token)
if not enabled or runToken ~= token then return {} end
local weekly = switchAndScan("Weekly", token)
if not enabled or runToken ~= token then return {} end
local all = {}
for _, q in ipairs(daily) do all[#all + 1] = q end
for _, q in ipairs(weekly) do all[#all + 1] = q end
shared._autoQuestData = all
return all
end

local function progressText(q)
if q.progressCurrent == nil or q.progressTarget == nil then return "?" end
local pct = math.clamp((q.progressCurrent / math.max(q.progressTarget, 1)) * 100, 0, 100)
return string.format("%.0f%% (%g/%g)", pct, q.progressCurrent, q.progressTarget)
end

local function isMissionHudAction(action)
return action == "Auto Quest • Animal"
or action == "Auto Quest • Zone"
or action == "Auto Quest • Grow"
or action == "Auto Quest • Grow bloqueado"
or action == "Auto Quest • Travel"
or action == "Auto Quest • Swim"
or action == "Auto Quest • Passive"
or action == "Auto Quest • Bloqueado"
or action == "Auto Quest • Pulando"
end

local function status(action, detail, color)
goatPrint("[AutoQuest] " .. tostring(action) .. " | " .. tostring(detail or ""))

local finalColor = color or Color3.fromRGB(0, 170, 255)
if isMissionHudAction(action) then
shared._autoQuestHudLock = {
action = action,
detail = detail or "",
color = finalColor,
}
end

if shared._goatHudSetStatus then
local okHud, hudErr = pcall(shared._goatHudSetStatus, action, detail or "", finalColor)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail or "",
color = finalColor,
}
if shared._autoQuestLastHudError ~= tostring(hudErr) then
shared._autoQuestLastHudError = tostring(hudErr)
goatWarn("[AutoQuest] HUD update deferred:", tostring(hudErr))
end
end
end
end

local function clearMissionHudLock()
shared._autoQuestHudLock = nil
end

local function maintainSurvival()
if shared._autoQuestAnimalSwitchLock then return end
if shared._autoQuestSwimLock then return end
local ch = player.Character
if not ch then return end
local animal = ch:GetAttribute("AnimalName") or ""
local carnivore = shared._isCarnivoreName and shared._isCarnivoreName(animal) or false
if shared._autoEatChecked then pcall(shared._autoEatChecked, not carnivore) end
if shared._setAutoCarcassInternal then pcall(shared._setAutoCarcassInternal, carnivore) end
if shared._setAutoDrinkInternal then pcall(shared._setAutoDrinkInternal, true) end
end

local AUTOQUEST_SURVIVAL_TRIGGER_FOOD = 35
local AUTOQUEST_SURVIVAL_TRIGGER_WATER = 30
local AUTOQUEST_SURVIVAL_RELEASE_FOOD = 70
local AUTOQUEST_SURVIVAL_RELEASE_WATER = 65
local autoQuestSurvivalPriority = false

local AUTOQUEST_CARNIVORE_WATER_EMERGENCY = 18

local function runAutoQuestSurvivalPriority(forceMovementEmergency)
local ch = player.Character
if not ch then
autoQuestSurvivalPriority = false
return false
end

local hum = ch:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health <= 0 then
autoQuestSurvivalPriority = false
return false
end

local food = tonumber(ch:GetAttribute("Food")) or 100
local water = tonumber(ch:GetAttribute("Water")) or 100
local animal = tostring(ch:GetAttribute("AnimalName") or "?")
local carnivore = shared._isCarnivoreName and shared._isCarnivoreName(animal) or false

-- Normal survival thresholds stay unchanged.
-- Global carnivore emergency latch is also maintained by CarcassMonitor.
-- AutoQuest reuses the same shared state instead of creating a separate priority.
if not carnivore then
shared._autoQuestCarnivoreFoodEmergency = false
elseif food <= 40 then
if shared._autoQuestCarnivoreFoodEmergency ~= true then
shared._autoQuestCarnivoreFoodEmergency = true
shared._goatCarcassForceFreshScan = true
goatPrint(string.format(
"[AutoQuest] FOOD EMERGENCY fallback ON | animal=%s | food=%.1f%% <= 40%% | Carcass until 100%% | emergency radius=2000",
animal,
food
))
end
elseif shared._autoQuestCarnivoreFoodEmergency == true and food >= 99.9 then
shared._autoQuestCarnivoreFoodEmergency = false
goatPrint(string.format(
"[AutoQuest] FOOD EMERGENCY fallback OFF | animal=%s | food=%.1f%% | full",
animal,
food
))
end

local foodEmergency =
food <= AUTOQUEST_SURVIVAL_TRIGGER_FOOD
or (carnivore and shared._autoQuestCarnivoreFoodEmergency == true)

local waterEmergency = water <= AUTOQUEST_SURVIVAL_TRIGGER_WATER

-- Survival must be allowed to take over even during PASSIVE quests.
-- Previously this only activated while Zone/Travel/Swim movement was active,
-- which could leave Survive-As-Animal standing still at critical food.
if not autoQuestSurvivalPriority then
if foodEmergency or waterEmergency or forceMovementEmergency == true then
autoQuestSurvivalPriority = true

-- Survival owns movement until the emergency is over.
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

goatPrint(string.format(
"[AutoQuest] SURVIVAL PRIORITY ON | animal=%s | food=%.1f | water=%.1f | carnivore=%s",
animal,
food,
water,
tostring(carnivore)
))
end
end

if not autoQuestSurvivalPriority then
return false
end

-- Re-assert quest movement OFF every priority tick.
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

-- Resource arbitration for carnivores:
-- When food is critical, Carcass gets exclusive movement over AutoDrink,
-- unless water itself is critically dangerous.
if carnivore
and shared._autoQuestCarnivoreFoodEmergency == true
and food < 99.9
and water > AUTOQUEST_CARNIVORE_WATER_EMERGENCY
then
if shared._autoEatChecked then
pcall(shared._autoEatChecked, false)
end

if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, true)
end

-- Stop AutoDrink from holding movement while the lion/other carnivore
-- is starving. It will be restored automatically after food recovery.
if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, false)
end

status(
"Auto Quest • Survival",
string.format(
"%s • COMIDA CRÍTICA • Carcass prioridade • F%.0f%% W%.0f%%",
animal,
food,
water
),
Color3.fromRGB(255, 125, 70)
)

goatPrint(string.format(
"[AutoQuest] CARNIVORE FOOD PRIORITY | animal=%s | food=%.1f | water=%.1f | Carcass=ON | Drink=PAUSED",
animal,
food,
water
))
else
-- Normal survival behavior:
-- carnivore = Carcass + Drink; herbivore = Eat + Drink.
maintainSurvival()
end

food = tonumber(ch:GetAttribute("Food")) or 100
water = tonumber(ch:GetAttribute("Water")) or 100

if carnivore
and shared._autoQuestCarnivoreFoodEmergency == true
and food >= 99.9
then
shared._autoQuestCarnivoreFoodEmergency = false

goatPrint(string.format(
"[AutoQuest] FOOD EMERGENCY fallback OFF | animal=%s | food=%.1f%% | full",
animal,
food
))

-- Return to the unchanged normal survival workers.
-- If Water is <= 80%, the existing AutoDrink logic can now take over
-- and will continue its normal cycle until full.
maintainSurvival()
end

local busy =
ch:GetAttribute("_drinkingToFull") == true
or ch:GetAttribute("_returningToLand") == true
or ch:GetAttribute("_carcassInteractionLock") == true

-- Release only after BOTH resources are safely recovered.
if food >= AUTOQUEST_SURVIVAL_RELEASE_FOOD
and water >= AUTOQUEST_SURVIVAL_RELEASE_WATER
and shared._autoQuestCarnivoreFoodEmergency ~= true
and not busy
then
autoQuestSurvivalPriority = false

-- Restore the standard workers after an exclusive food-priority cycle.
maintainSurvival()

goatPrint(string.format(
"[AutoQuest] SURVIVAL PRIORITY OFF | animal=%s | food=%.1f | water=%.1f",
animal,
food,
water
))

return false
end

-- If food has recovered enough but Drink was paused during carnivore food
-- priority, restore normal survival immediately so water recovery can proceed.
if carnivore
and food > AUTOQUEST_SURVIVAL_TRIGGER_FOOD
and shared._autoQuestCarnivoreFoodEmergency ~= true
and shared._setAutoDrinkInternal
then
maintainSurvival()
end

status(
"Auto Quest • Survival",
string.format(
"%s • recuperando comida/água • F%.0f%% W%.0f%%",
animal,
food,
water
),
Color3.fromRGB(255, 185, 70)
)

return true
end

local AUTOQUEST_CLAIM_RETRY_SECONDS = 90

local function claimCompleted(quests, token)
local claimed = false

-- Process one visible tab at a time.
-- The previous version scanned Daily, switched to Weekly, then tried to click
-- stale Daily button references while Weekly was visible.
for _, category in ipairs({"Daily", "Weekly"}) do
if not enabled or runToken ~= token then
return claimed
end

local visibleCards, opened = switchAndScan(category, token)

if opened then
local attemptsInCategory = 0

while enabled and runToken == token and attemptsInCategory < 8 do
local cards = scanCurrentCards(category)
local target = nil
local key = nil

for _, q in ipairs(cards) do
if q.completed then
local candidateKey =
tostring(category) .. "|" .. lower(q.name or q.title or "")

local now = os.clock()

if now - (lastClaimAt[candidateKey] or 0)
>= AUTOQUEST_CLAIM_RETRY_SECONDS
then
target = q
key = candidateKey
break
end
end
end

if not target then
break
end

attemptsInCategory = attemptsInCategory + 1

local button = target.claimButton or target.clickButton

if not button then
lastClaimAt[key] =
os.clock() - (AUTOQUEST_CLAIM_RETRY_SECONDS - 20)

goatWarn(
"[AutoQuest] Claim sem botão atual | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
)

break
end

local beforeName = lower(target.name or target.title or "")
local beforeTarget = tonumber(target.progressTarget)
local beforeType = tostring(target.questType or "")

if shared._goatIsSavannahLifeGame
and shared._goatIsSavannahLifeGame() then
goatPrint(
"[AutoQuest][SL] Claim button selected | "
.. tostring(target.title or target.name)
.. " • "
.. tostring(button.Name)
)
end

local clicked, method = activateButton(button, true)

if clicked then
goatPrint(
"[AutoQuest] Claim attempt | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name) .. " • "
.. tostring(method)
.. " • verificando"
)
else
goatWarn(
"[AutoQuest] Claim click falhou | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
)
end

task.wait(1.35)

-- Re-scan the CURRENT visible tab after the click.
local afterCards = scanCurrentCards(category)
local stillThere = false

for _, live in ipairs(afterCards) do
local liveName = lower(live.name or live.title or "")
local sameName =
beforeName ~= ""
and liveName == beforeName

local sameFallback =
beforeType ~= ""
and tostring(live.questType or "") == beforeType
and beforeTarget ~= nil
and tonumber(live.progressTarget) == beforeTarget

if (sameName or sameFallback) and live.completed then
stillThere = true
break
end
end

if not stillThere then
lastClaimAt[key] = os.clock()
claimed = true

goatPrint(
"[AutoQuest] Claim CONFIRMADO | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
)

-- The game can rebuild the whole card list after a successful claim.
task.wait(0.75)
else
-- The click event fired but the server/UI did not accept the claim.
-- Try Activate() directly on the CURRENT button before giving up.
local refreshed = scanCurrentCards(category)
local retryQuest = nil

for _, live in ipairs(refreshed) do
local liveName = lower(live.name or live.title or "")
local sameName =
beforeName ~= ""
and liveName == beforeName

local sameFallback =
beforeType ~= ""
and tostring(live.questType or "") == beforeType
and beforeTarget ~= nil
and tonumber(live.progressTarget) == beforeTarget

if (sameName or sameFallback) and live.completed then
retryQuest = live
break
end
end

local retryButton = nil
if retryQuest then
retryButton = retryQuest.claimButton or retryQuest.clickButton
end

if retryButton then
local okActivate = pcall(function()
retryButton:Activate()
end)

if okActivate then
goatPrint(
"[AutoQuest] Claim retry Activate | "
.. tostring(category) .. " • "
.. tostring(retryQuest.title or retryQuest.name)
)

task.wait(1.0)

local verifyCards = scanCurrentCards(category)
local remains = false

for _, verify in ipairs(verifyCards) do
local verifyName = lower(verify.name or verify.title or "")
local sameName =
beforeName ~= ""
and verifyName == beforeName

local sameFallback =
beforeType ~= ""
and tostring(verify.questType or "") == beforeType
and beforeTarget ~= nil
and tonumber(verify.progressTarget) == beforeTarget

if (sameName or sameFallback) and verify.completed then
remains = true
break
end
end

if not remains then
lastClaimAt[key] = os.clock()
claimed = true

goatPrint(
"[AutoQuest] Claim CONFIRMADO | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
.. " • Activate"
)

task.wait(0.75)
else
lastClaimAt[key] =
os.clock() - (AUTOQUEST_CLAIM_RETRY_SECONDS - 20)

goatWarn(
"[AutoQuest] Claim NÃO confirmado | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
)
end
else
lastClaimAt[key] =
os.clock() - (AUTOQUEST_CLAIM_RETRY_SECONDS - 20)

goatWarn(
"[AutoQuest] Claim NÃO confirmado | "
.. tostring(category) .. " • "
.. tostring(target.title or target.name)
)
end
end
end
end
end
end

return claimed
end

local function normalizedAnimal(v)
return lower(v):gsub("[^%w]", "")
end

local function currentGrowthPercent()
local ch = player.Character
if not ch then return nil end
local g = ch:GetAttribute("GrowthPercentage")
if type(g) ~= "number" then return nil end
return g <= 1.05 and g * 100 or g
end

local AUTOQUEST_ANIMAL_SWITCH_DRINK_WAIT = 55
local AUTOQUEST_ANIMAL_SWITCH_MENU_WAIT = 12
local AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS = 2
local AUTOQUEST_ANIMAL_SWITCH_DRINK_TRIGGER = 80

local function autoQuestAnimalSwitchDrinkBusy(character)
if not character or player.Character ~= character then
return false
end

local water = tonumber(character:GetAttribute("Water")) or 100

local leaseActive =
shared._goatAutoDrinkWaterLeaseCharacter == character
and os.clock() < (tonumber(shared._goatAutoDrinkWaterLeaseUntil) or 0)

return
leaseActive
or character:GetAttribute("_drinkingToFull") == true
or character:GetAttribute("_returningToLand") == true
or water <= AUTOQUEST_ANIMAL_SWITCH_DRINK_TRIGGER
end

local function waitForAutoQuestAnimalSwitchDrinkRelease(character, targetName)
if not character or player.Character ~= character then
return true
end

-- Make sure normal survival is alive long enough to finish an already
-- required drink before the animal switch takes ownership.
maintainSurvival()

if not autoQuestAnimalSwitchDrinkBusy(character) then
return true
end

goatPrint(string.format(
"[AutoQuest] Animal switch WAIT • AutoDrink priority before %s | water=%.1f%%",
tostring(targetName),
tonumber(character:GetAttribute("Water")) or 100
))

status(
"Auto Quest • Animal",
tostring(targetName) .. " • aguardando AutoDrink terminar",
Color3.fromRGB(255, 185, 70)
)

local deadline = os.clock() + AUTOQUEST_ANIMAL_SWITCH_DRINK_WAIT
local nextLogAt = 0

while os.clock() < deadline do
if player.Character ~= character then
return true
end

if not autoQuestAnimalSwitchDrinkBusy(character) then
goatPrint(string.format(
"[AutoQuest] Animal switch • AutoDrink released | target=%s | water=%.1f%% | state=%s | replicated=%s",
tostring(targetName),
tonumber(character:GetAttribute("Water")) or 100,
tostring(character:GetAttribute("MovementState")),
tostring(character:GetAttribute("ReplicatedMovementState"))
))
return true
end

local now = os.clock()
if now >= nextLogAt then
nextLogAt = now + 5
goatPrint(string.format(
"[AutoQuest] Animal switch WAIT • AutoDrink still owns survival | target=%s | water=%.1f%%",
tostring(targetName),
tonumber(character:GetAttribute("Water")) or 100
))
end

-- Re-assert normal survival in case the drink worker has not started yet.
maintainSurvival()
task.wait(0.25)
end

goatWarn(string.format(
"[AutoQuest] Animal switch CANCELLED • AutoDrink did not release within %ds | target=%s",
AUTOQUEST_ANIMAL_SWITCH_DRINK_WAIT,
tostring(targetName)
))
return false
end

local function setAutoQuestAnimalSwitchExclusive(state, targetName)
state = state == true
shared._autoQuestAnimalSwitchLock = state

if state then
-- Stop every normal survival/movement owner only AFTER AutoDrink has
-- completed and returned to shore.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1

if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

if type(stopNativeTravel) == "function" then
pcall(stopNativeTravel)
end

if shared._setAutoEatInternal then pcall(shared._setAutoEatInternal, false) end
if shared._autoEatChecked then pcall(shared._autoEatChecked, false) end
if shared._setAutoCarcassInternal then pcall(shared._setAutoCarcassInternal, false) end
if shared._setAutoDrinkInternal then pcall(shared._setAutoDrinkInternal, false) end

goatPrint("[AutoQuest] Animal switch LOCK ON • exclusive transition | target=" .. tostring(targetName))
else
goatPrint("[AutoQuest] Animal switch LOCK OFF • target=" .. tostring(targetName))
-- Restore survival only after the transition lock has been released.
maintainSurvival()
end
end

local function prepareAutoQuestAnimalMenu(targetName)
local beforeCharacter = player.Character
local beforeName =
beforeCharacter
and beforeCharacter:GetAttribute("CharacterName")
or nil

for resetAttempt = 1, AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS do
local resetOk, resetErr = pcall(function()
local autoQuestRS = game:GetService("ReplicatedStorage")
local resetRemote = autoQuestRS:WaitForChild("CustomCharacterResetRemoteFunction", 5)

if not resetRemote then
error("CustomCharacterResetRemoteFunction not found")
end

resetRemote:InvokeServer()
end)

if not resetOk then
goatWarn(string.format(
"[AutoQuest] Animal switch • reset attempt %d/%d ERROR: %s",
resetAttempt,
AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS,
tostring(resetErr)
))
else
goatPrint(string.format(
"[AutoQuest] Animal switch • reset attempt %d/%d requested | previous=%s | target=%s",
resetAttempt,
AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS,
tostring(beforeName),
tostring(targetName)
))
end

local deadline = os.clock() + AUTOQUEST_ANIMAL_SWITCH_MENU_WAIT

while os.clock() < deadline do
local current = player.Character
local currentName =
current
and current:GetAttribute("CharacterName")
or nil
local hasRoot =
current
and current:FindFirstChild("HumanoidRootPart") ~= nil

-- Do not assume the reset delay means the menu exists.
-- Only spawn the requested slot once the live animal is actually gone.
local menuReady =
current == nil
or currentName == nil
or not hasRoot

if menuReady then
goatPrint(string.format(
"[AutoQuest] Animal switch • Characters menu READY | previous=%s | current=%s | target=%s",
tostring(beforeName),
tostring(currentName or "nil/menu"),
tostring(targetName)
))
return true
end

task.wait(0.20)
end

local current = player.Character
local currentName =
current
and current:GetAttribute("CharacterName")
or nil

goatWarn(string.format(
"[AutoQuest] Animal switch • reset attempt %d/%d TIMEOUT | stillCurrent=%s | target=%s",
resetAttempt,
AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS,
tostring(currentName or "nil/menu"),
tostring(targetName)
))

if resetAttempt < AUTOQUEST_ANIMAL_SWITCH_RESET_ATTEMPTS then
task.wait(0.75)
end
end

return false
end

local function spawnExistingAnimal(animalName, requireUnder100)
if type(shared._syncSavedCharacterRecords) ~= "function" or type(shared._spawnAndSetup) ~= "function" then
return false, "GrowthLoop ainda não está pronto"
end
local ok, records = pcall(shared._syncSavedCharacterRecords, true)
if not ok or type(records) ~= "table" then return false, "SavedCharacters indisponível" end
local wanted = normalizedAnimal(animalName)
local candidate = nil
for _, entry in ipairs(records) do
if type(entry) == "table" and normalizedAnimal(entry.AnimalName) == wanted then
local g = tonumber(entry.GrowthPercentage)
local pct = g and (g <= 1.05 and g * 100 or g) or 0
if not requireUnder100 or pct < 99.5 then
candidate = entry
break
end
end
end
if not candidate then
local available = {}
for _, entry in ipairs(records) do
if type(entry) == "table" then
local a = tostring(entry.AnimalName or "?")
local c = tostring(entry.CharacterName or "?")
available[#available + 1] = a .. "(" .. c .. ")"
end
end
goatPrint("[AutoQuest] Saved slots disponíveis:", table.concat(available, ", "))
return false, "nenhum slot salvo compatível"
end

goatPrint(string.format(
"[AutoQuest] Slot encontrado para %s: Animal=%s | Character=%s | Growth=%s",
tostring(animalName),
tostring(candidate.AnimalName),
tostring(candidate.CharacterName),
tostring(candidate.GrowthPercentage)
))

-- AutoQuest Animal Switch must not compete with AutoDrink.
-- First let the current animal finish drinking and return to shore.
local currentBeforeSwitch = player.Character

if currentBeforeSwitch then
local drinkReleased =
waitForAutoQuestAnimalSwitchDrinkRelease(
currentBeforeSwitch,
candidate.CharacterName
)

if not drinkReleased then
return false, "AutoDrink ainda estava com prioridade"
end
end

-- From this point until the spawn attempt ends, the animal switch owns
-- survival/movement exclusively. This prevents Carcass/AutoEat/AutoDrink
-- from restarting while Savannah is transitioning to the Characters menu.
setAutoQuestAnimalSwitchExclusive(true, candidate.CharacterName)

local transitionOk, spawned, transitionWhy = pcall(function()
local menuReady = prepareAutoQuestAnimalMenu(candidate.CharacterName)

if not menuReady then
return false, "menu de Characters não confirmou após reset"
end

-- IMPORTANT: one outer call only.
-- _spawnAndSetup already contains the proven internal backend/UI retries.
local callOk, callResult = pcall(shared._spawnAndSetup, candidate)

if not callOk then
goatWarn(
"[AutoQuest] Animal spawn call error caught: "
.. tostring(callResult)
)
return false, "spawn error • " .. tostring(callResult)
end

if callResult ~= true then
goatWarn(
"[AutoQuest] Animal spawn FAILED after internal retries: "
.. tostring(candidate.CharacterName)
)
return false, "spawn falhou após retries internos"
end

local live = player.Character
local liveName =
live
and live:GetAttribute("CharacterName")
or nil

if liveName ~= candidate.CharacterName then
goatWarn(string.format(
"[AutoQuest] Animal spawn returned success but exact slot not confirmed | expected=%s | current=%s",
tostring(candidate.CharacterName),
tostring(liveName)
))
return false, "slot exato não confirmado"
end

goatPrint(
"[AutoQuest] Animal spawn SUCCESS after confirmed menu: "
.. tostring(candidate.CharacterName)
)

return true, candidate.CharacterName
end)

-- Always release the exclusive switch lock, even if a protected call errors.
setAutoQuestAnimalSwitchExclusive(false, candidate.CharacterName)

if not transitionOk then
goatWarn(
"[AutoQuest] Animal switch protected transition ERROR: "
.. tostring(spawned)
)
return false, "transição protegida falhou • " .. tostring(spawned)
end

return spawned == true, transitionWhy
end

local function growthModeOwnsCurrentAnimal()
return shared._inGrowthReset == true
or shared._growNewSlotsActive == true
or shared._growExistingSlotsActive == true
end

local function currentAnimalForMovement()
local ch = player.Character
local animal = ch and ch:GetAttribute("AnimalName") or ""
return ch, tostring(animal or "")
end

local function ensureMovementAnimal(reason)
local ch = player.Character
local current = ch and ch:GetAttribute("AnimalName") or ""

-- DinoLife movement quests use ONLY Gallimimus or Velociraptor.
-- Prefer the current animal if it is already one of them.
-- Otherwise switch to a saved Gallimimus first, then Velociraptor.
if game.GameId == 8198412649 then
local root = ch and ch:FindFirstChild("HumanoidRootPart")
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
local currentNormalized = normalizedAnimal(current)
local gallimimusNormalized = normalizedAnimal("Gallimimus")
local velociraptorNormalized = normalizedAnimal("Velociraptor")

if ch
and root
and hum
and hum.Health > 0
and (
currentNormalized == gallimimusNormalized
or currentNormalized == velociraptorNormalized
)
then
goatPrint(
"[AutoQuest][DL] Movement animal kept: "
.. tostring(current)
.. " | " .. tostring(reason or "movement")
)
return true, false
end

if growthModeOwnsCurrentAnimal() then
status(
"Auto Quest • DL",
"GrowthLoop controla o slot atual • aguardando para trocar para Gallimimus/Velociraptor",
Color3.fromRGB(255, 185, 70)
)
return false, false
end

status(
"Auto Quest • DL",
tostring(reason or "movimento") .. " • procurando Gallimimus/Velociraptor",
Color3.fromRGB(0, 170, 255)
)

local ok, why = spawnExistingAnimal("Gallimimus", false)
if not ok then
ok, why = spawnExistingAnimal("Velociraptor", false)
end

if not ok then
status(
"Auto Quest • DL • Bloqueado",
"Gallimimus ou Velociraptor necessário • " .. tostring(why),
Color3.fromRGB(255, 185, 70)
)
return false, false
end

task.wait(2)
maintainSurvival()

local newCh = player.Character
local newAnimal = newCh and newCh:GetAttribute("AnimalName") or "?"
local newNormalized = normalizedAnimal(newAnimal)

if newNormalized ~= gallimimusNormalized
and newNormalized ~= velociraptorNormalized
then
goatWarn(
"[AutoQuest][DL] Movement animal switch returned unexpected animal: "
.. tostring(newAnimal)
)
return false, false
end

goatPrint(
"[AutoQuest][DL] Movement animal switched: "
.. tostring(newAnimal)
.. " | " .. tostring(reason or "movement")
)
return true, true
end

if normalizedAnimal(current) == normalizedAnimal("Lion")
or normalizedAnimal(current) == normalizedAnimal("Impala") then
return true, false
end

if growthModeOwnsCurrentAnimal() then
if ch and ch:FindFirstChild("HumanoidRootPart") and current ~= "" then
goatPrint(
"[AutoQuest] Growth animal lock • mantendo "
.. tostring(current)
.. " • " .. tostring(reason or "movimento")
)
return true, false
end

status(
"Auto Quest • Movimento",
"aguardando GrowthLoop estabilizar o animal atual",
Color3.fromRGB(255, 185, 70)
)
return false, false
end

status(
"Auto Quest • Movimento",
tostring(reason or "movimento") .. " • procurando Lion/Impala",
Color3.fromRGB(0, 170, 255)
)

local ok, why = spawnExistingAnimal("Lion", false)
if not ok then
ok, why = spawnExistingAnimal("Impala", false)
end
if not ok then
status(
"Auto Quest • Bloqueado",
"Lion ou Impala necessário • " .. tostring(why),
Color3.fromRGB(255, 185, 70)
)
return false, false
end

task.wait(2)
maintainSurvival()
local newCh = player.Character
local newAnimal = newCh and newCh:GetAttribute("AnimalName") or "?"
goatPrint("[AutoQuest] " .. tostring(newAnimal) .. " ativo • " .. tostring(reason or "movimento"))
return true, true
end

local function setGrowQuestState(q, phase, animal, growthPct, note)
shared._autoQuestGrowState = {
category = q and q.category or nil,
name = q and q.name or nil,
phase = phase,
animal = animal,
growth = growthPct,
growthText = type(growthPct) == "number"
and string.format("G%.0f%%", growthPct)
or "",
note = note,
}
end

local function growQuestSurvival(state, reason)
if type(shared._setGrowSurvival) == "function" then
local ok = pcall(shared._setGrowSurvival, state == true, reason or "Auto Quest Grow")
if ok then return end
end

if state then
maintainSurvival()
else
if shared._autoEatChecked then pcall(shared._autoEatChecked, false) end
if shared._setAutoCarcassInternal then pcall(shared._setAutoCarcassInternal, false) end
if shared._setAutoDrinkInternal then pcall(shared._setAutoDrinkInternal, false) end
end
end

local function ensureUnder100Growth(growQuest)
local ch = player.Character
local pct = currentGrowthPercent()
local animal = ch and tostring(ch:GetAttribute("AnimalName") or "?") or "?"
local charName = ch and tostring(ch:GetAttribute("CharacterName") or "?") or "?"
local description = clean(growQuest.name)
local requiredAnimal = description:match("[Gg]row%s+as%s+'([^']+)'")
or description:match('[Gg]row%s+as%s+"([^"]+)"')
local function matchesRequired(value)
return not requiredAnimal or normalizedAnimal(value) == normalizedAnimal(requiredAnimal)
end

if pct and pct < 99.5 and matchesRequired(animal) then
growQuestSurvival(true, "Auto Quest Grow active")
setGrowQuestState(growQuest, "active", animal, pct, charName)
return true, {
switched = false,
CharacterName = charName,
AnimalName = animal,
GrowthPercent = pct,
}
end

-- Current animal is 100% (or has no valid growth): do not wait on it,
-- because Grow quests only advance while Growth < 100%.
setGrowQuestState(growQuest, "switching", animal, pct or 100, "procurando slot <100%")
growQuestSurvival(false, "Auto Quest Grow switching from 100%")

if type(shared._syncSavedCharacterRecords) ~= "function"
or type(shared._spawnAndSetup) ~= "function"
then
setGrowQuestState(growQuest, "blocked", animal, pct, "GrowthLoop ainda não está pronto")
return false, "GrowthLoop ainda não está pronto"
end

local ok, records = pcall(shared._syncSavedCharacterRecords, true)
if not ok or type(records) ~= "table" then
setGrowQuestState(growQuest, "blocked", animal, pct, "SavedCharacters indisponível")
return false, "SavedCharacters indisponível"
end

local currentName = ch and ch:GetAttribute("CharacterName") or nil
local candidates = {}

for _, entry in ipairs(records) do
if type(entry) == "table" and type(entry.CharacterName) == "string" then
local g = tonumber(entry.GrowthPercentage)
local p = g and (g <= 1.05 and g * 100 or g) or nil

if p and p < 99.5 and matchesRequired(entry.AnimalName) and entry.CharacterName ~= currentName then
candidates[#candidates + 1] = {
entry = entry,
pct = p,
}
end
end
end

-- Prefer the least-grown slot so Auto Quest has the largest possible
-- uninterrupted <100% window before another switch is needed.
table.sort(candidates, function(a, b)
return a.pct < b.pct
end)

if #candidates == 0 then
setGrowQuestState(growQuest, "blocked", animal, pct, "não há slot existente abaixo de 100%")
return false, "não há slot existente abaixo de 100%"
end

for _, candidate in ipairs(candidates) do
local entry = candidate.entry

status(
"Auto Quest • Grow",
string.format(
"%s • animal 100%% — mudando para %s (%s, G%.0f%%)",
tostring(growQuest.category or "Quest"),
tostring(entry.CharacterName or "slot"),
tostring(entry.AnimalName or "?"),
candidate.pct
),
Color3.fromRGB(255, 185, 70)
)

if shared._characterTransitionLock == true then
goatPrint(
"[AutoQuest] Grow switch BLOCKED • transition already active | owner="
.. tostring(shared._characterTransitionOwner or "?")
.. " | target="
.. tostring(shared._characterTransitionTarget or "?")
)
return false, "character transition already active"
end

shared._characterTransitionGeneration = (tonumber(shared._characterTransitionGeneration) or 0) + 1
shared._characterTransitionLock = true
shared._characterTransitionOwner = "Grow"
shared._characterTransitionTarget = tostring(entry.CharacterName)
shared._expectedCharacterRemoving = false

-- Cancel any stale movement worker before taking menu/spawn ownership.
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

goatPrint(
"[AutoQuest] CHARACTER TRANSITION LOCK ON • owner=Grow | target="
.. tostring(entry.CharacterName)
.. " | gen="
.. tostring(shared._characterTransitionGeneration)
)

goatPrint(string.format(
"[AutoQuest] Grow <100%% • switching slot: %s | Animal=%s | Growth=%.1f%%",
tostring(entry.CharacterName),
tostring(entry.AnimalName),
candidate.pct
))

-- IMPORTANT:
-- Savannah only accepts the proven existing-slot switch reliably after the
-- animal reaches Spawn Beach. Do NOT call resetToMenu from an arbitrary map
-- position.
local prepared = false

if type(shared._prepareAutoQuestGrowSlotSwitch) == "function" then
goatPrint(
"[AutoQuest] Grow slot switch • preparing Spawn Beach reset | target="
.. tostring(entry.CharacterName)
)

local prepOk, prepResult = pcall(shared._prepareAutoQuestGrowSlotSwitch)

if not prepOk then
goatWarn(
"[AutoQuest] Grow slot switch • preparation error | target="
.. tostring(entry.CharacterName)
.. " | error="
.. tostring(prepResult)
)
else
prepared = prepResult == true
end
else
goatWarn("[AutoQuest] Grow slot switch • Spawn Beach preparation helper unavailable")
end

if not prepared then
shared._characterTransitionLock = false
shared._characterTransitionOwner = nil
shared._characterTransitionTarget = nil
shared._expectedCharacterRemoving = false
shared._characterTransitionGeneration = (tonumber(shared._characterTransitionGeneration) or 0) + 1

goatWarn(
"[AutoQuest] Grow slot switch • target NOT spawned because Spawn Beach/reset was not confirmed | target="
.. tostring(entry.CharacterName)
)
goatPrint("[AutoQuest] CHARACTER TRANSITION LOCK OFF • preparation failed")
continue
end

goatPrint(
"[AutoQuest] Grow slot switch • Spawn Beach/reset confirmed — spawning target="
.. tostring(entry.CharacterName)
)

local spawned = shared._spawnAndSetup(entry) == true
if spawned then
task.wait(1.25)

local live = player.Character
local liveName = live and live:GetAttribute("CharacterName")
local liveAnimal = live and tostring(live:GetAttribute("AnimalName") or entry.AnimalName or "?") or "?"
local livePct = currentGrowthPercent()

if live
and liveName == entry.CharacterName
and type(livePct) == "number"
and livePct < 99.5
and matchesRequired(liveAnimal)
then
shared._characterTransitionLock = false
shared._characterTransitionOwner = nil
shared._characterTransitionTarget = nil
shared._expectedCharacterRemoving = false
goatPrint("[AutoQuest] CHARACTER TRANSITION LOCK OFF • Grow target confirmed")

growQuestSurvival(true, "Auto Quest Grow switched to unfinished slot")
setGrowQuestState(growQuest, "active", liveAnimal, livePct, tostring(liveName))

goatPrint(string.format(
"[AutoQuest] Grow active • %s | %s | Growth=%.1f%%",
tostring(liveName),
tostring(liveAnimal),
livePct
))

return true, {
switched = true,
CharacterName = liveName,
AnimalName = liveAnimal,
GrowthPercent = livePct,
}
end

goatWarn(
"[AutoQuest] Grow slot verification failed:",
tostring(entry.CharacterName),
"| live=",
tostring(liveName),
"| growth=",
tostring(livePct)
)
end

if shared._characterTransitionLock == true
and shared._characterTransitionOwner == "Grow"
and tostring(shared._characterTransitionTarget or "") == tostring(entry.CharacterName)
then
shared._characterTransitionLock = false
shared._characterTransitionOwner = nil
shared._characterTransitionTarget = nil
shared._expectedCharacterRemoving = false
shared._characterTransitionGeneration = (tonumber(shared._characterTransitionGeneration) or 0) + 1
goatPrint("[AutoQuest] CHARACTER TRANSITION FAILSAFE OFF • target not confirmed")
end
end

setGrowQuestState(growQuest, "blocked", animal, pct, "nenhum slot <100% conseguiu spawn confirmado")
return false, "nenhum slot <100% conseguiu spawn confirmado"
end

local function growRemainingText(q)
local current = tonumber(q and q.progressCurrent)
local target = tonumber(q and q.progressTarget)
if not current or not target or target <= 0 then return "restante ?" end

local remaining = math.max(0, target - current)
local mins = math.floor(remaining / 60)
local secs = math.floor(remaining % 60)

if mins > 0 then
return string.format("restante %ds (~%dm%02ds)", remaining, mins, secs)
end
return string.format("restante %ds", remaining)
end


local function extractRequiredAnimal(name)
return clean(name):match("[Ss]urvive%s+as%s+'([^']+)'")
or clean(name):match('[Ss]urvive%s+as%s+"([^"]+)"')
end

local function extractZone(name)
return clean(name):match("[Zz]one%s+'([^']+)'")
or clean(name):match("[Ii]n%s+the%s+'([^']+)'%s+[Zz]one")
or clean(name):match("[Ii]n%s+'([^']+)'%s+[Zz]one")
end

local function groundPointAtXZ(x, z, referenceY, character)
local ignore = {}
if character then ignore[#ignore + 1] = character end

local topY = math.max(700, (tonumber(referenceY) or 0) + 350)
local origin = Vector3.new(x, topY, z)
local direction = Vector3.new(0, -2200, 0)

for _ = 1, 10 do
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = ignore
params.IgnoreWater = false

local hit = Workspace:Raycast(origin, direction, params)
if not hit then return nil end
if hit.Material == Enum.Material.Water then return nil end

local inst = hit.Instance
local skip = false
if inst and inst:IsA("BasePart") then
local n = string.lower(inst.Name or "")
if inst.Transparency >= 0.82
or not inst.CanCollide
or n:find("zone", 1, true)
or n:find("marker", 1, true)
or n:find("trigger", 1, true)
then
skip = true
end
end

if skip then
ignore[#ignore + 1] = inst
else
if hit.Normal and hit.Normal.Y < 0.42 then return nil end
return hit.Position + Vector3.new(0, 3, 0)
end
end
return nil
end

local function safeGroundNear(rawPos, character, maxRadius)
if not rawPos then return nil end

local radii = {0, 45, 90, 140, 200, 280, 380, 500, 650}
local limit = tonumber(maxRadius) or 650
local bestPoint, bestScore = nil, math.huge

for _, radius in ipairs(radii) do
if radius <= limit then
local samples = radius == 0 and 1 or (radius <= 140 and 8 or 16)
for i = 1, samples do
local angle = samples == 1 and 0 or ((i - 1) / samples) * math.pi * 2
local x = rawPos.X + math.cos(angle) * radius
local z = rawPos.Z + math.sin(angle) * radius
local p = groundPointAtXZ(x, z, rawPos.Y, character)
if p then
local flat = (Vector3.new(p.X, 0, p.Z) - Vector3.new(rawPos.X, 0, rawPos.Z)).Magnitude
local score = flat
if score < bestScore then
bestPoint, bestScore = p, score
end
end
end
if bestPoint then return bestPoint end
end
end
return nil
end

local function zoneObjectPosition(obj)
if not obj then return nil end
if obj:IsA("BasePart") then return obj.Position end
if obj:IsA("Model") then
local ok, cf = pcall(function() return obj:GetPivot() end)
if ok and cf then return cf.Position end
end
return nil
end

local function zonePointSignature(pos)
if not pos then return "nil" end
return string.format("%d:%d",
math.floor(pos.X / 20 + 0.5),
math.floor(pos.Z / 20 + 0.5)
)
end

local function rejectZonePoint(zoneName, pos, seconds)
if not zoneName or not pos then return end
local key = normalizedAnimal(zoneName)
zoneRejectedPoints[key] = zoneRejectedPoints[key] or {}
zoneRejectedPoints[key][zonePointSignature(pos)] =
os.clock() + (tonumber(seconds) or 35)
end

local function zonePointRejected(zoneName, pos)
if not zoneName or not pos then return false end
local key = normalizedAnimal(zoneName)
local bucket = zoneRejectedPoints[key]
if not bucket then return false end

local sig = zonePointSignature(pos)
local untilAt = bucket[sig]
if not untilAt then return false end

if untilAt <= os.clock() then
bucket[sig] = nil
return false
end
return true
end

local function zoneCandidateRank(obj, isModelPivot)
if not obj then return 9 end

local n = string.lower(tostring(obj.Name or ""))
local triggerWord =
n:find("trigger", 1, true)
or n:find("hitbox", 1, true)
or n:find("region", 1, true)
or n:find("area", 1, true)
or n:find("bounds", 1, true)
or n:find("volume", 1, true)

if obj:IsA("BasePart") then
-- Invisible/non-collidable large parts are commonly zone volumes.
local largeXZ = math.max(obj.Size.X, obj.Size.Z) >= 45
if triggerWord then return 0 end
if (obj.Transparency >= 0.65 or not obj.CanCollide) and largeXZ then
return 0
end
if isModelPivot then return 1 end
return 3
end

if obj:IsA("Model") then
return isModelPivot and 1 or 2
end

return 9
end

local function findZonePosition(zoneName)
if not zoneName or zoneName == "" then return nil end
local key = normalizedAnimal(zoneName)

-- Confirmed manually in-game: official Mbali River Bend counter increases here.
if key == normalizedAnimal("Mbali River Bend") then
local exactMbali = Vector3.new(-5054.930, -7.373, 4270.949)
return exactMbali, exactMbali, nil, false
end

local cached = zoneCache[key]
local matches = {}
local mbaliSabieAnchors = {}

local isMbaliRiverBend = key == normalizedAnimal("Mbali River Bend")

local function isMbaliCameraMarker(obj)
if not isMbaliRiverBend or not obj then
return false
end

local okPath, fullName = pcall(function()
return obj:GetFullName()
end)

local path = string.lower(okPath and tostring(fullName) or tostring(obj.Name or ""))
return path:find("menucamerapositions", 1, true) ~= nil
end

local function addUniqueMatch(obj)
if not obj then return end

for _, existing in ipairs(matches) do
if existing == obj then
return
end
end

matches[#matches + 1] = obj
end

if cached and cached.Parent and not isMbaliCameraMarker(cached) then
addUniqueMatch(cached)
end

for _, obj in ipairs(Workspace:GetDescendants()) do
if obj:IsA("BasePart") or obj:IsA("Model") then
local n = normalizedAnimal(obj.Name)

if n == key or n:find(key, 1, true) then
if not isMbaliCameraMarker(obj) then
addUniqueMatch(obj)
end
end

-- Mbali River Bend is physically close to Pride Rock, while the object
-- Workspace.MenuCameraPositions.MbaliRiverBend is only a cinematic marker.
-- Use Pride Rock / Pride Lands named geometry as search anchors instead.
if isMbaliRiverBend then
local prideNamed =
n:find("priderock", 1, true)
or n:find("pridelands", 1, true)
or n:find("lionrock", 1, true)
or n == "pride"

if prideNamed then
addUniqueMatch(obj)
end

local sabieNamed =
n:find("sabiedelta", 1, true)
or (n:find("sabie", 1, true) and n:find("delta", 1, true))
or n == "sabie"

if sabieNamed then
mbaliSabieAnchors[#mbaliSabieAnchors + 1] = obj
end
end
end
end

if #matches == 0 then return nil end

local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")

-- Select by semantic quality first, distance second. The previous
-- implementation selected the nearest scenery part inside a zone model,
-- which could make the bot think it had arrived while the official
-- counter stayed at 0.
local bestGround, bestRaw, bestObj = nil, nil, nil
local bestRank, bestDistance = math.huge, math.huge

local function consider(rawPos, obj, searchRadius, rankOverride)
if not rawPos then return end
local ground = safeGroundNear(rawPos, ch, searchRadius or 650)
if not ground then return end
if zonePointRejected(zoneName, ground) then return end

local rank = rankOverride
if rank == nil then
rank = zoneCandidateRank(obj, false)
end

local distance
if root then
distance = (
Vector3.new(ground.X, 0, ground.Z)
- Vector3.new(root.Position.X, 0, root.Position.Z)
).Magnitude
else
distance = (
Vector3.new(ground.X, 0, ground.Z)
- Vector3.new(rawPos.X, 0, rawPos.Z)
).Magnitude
end

if rank < bestRank or (rank == bestRank and distance < bestDistance) then
bestGround, bestRaw, bestObj = ground, rawPos, obj
bestRank, bestDistance = rank, distance
end
end

for _, obj in ipairs(matches) do
local rawPos = zoneObjectPosition(obj)
local objNorm = normalizedAnimal(obj.Name)

local isPrideAnchor =
isMbaliRiverBend
and (
objNorm:find("priderock", 1, true)
or objNorm:find("pridelands", 1, true)
or objNorm:find("lionrock", 1, true)
or objNorm == "pride"
)

-- For Mbali, do NOT use Pride Rock itself as the zone point.
-- User-confirmed layout: Mbali is behind Pride Rock, on the side
-- opposite Sabie Delta.
if not isPrideAnchor then
consider(rawPos, obj, 650, zoneCandidateRank(obj, true))
end

if isPrideAnchor and rawPos then
local nearestSabiePos = nil
local nearestSabieDist = math.huge

for _, sabieObj in ipairs(mbaliSabieAnchors) do
local sabiePos = zoneObjectPosition(sabieObj)

if sabiePos then
local flatSabieDist = (
Vector3.new(sabiePos.X, 0, sabiePos.Z)
- Vector3.new(rawPos.X, 0, rawPos.Z)
).Magnitude

if flatSabieDist < nearestSabieDist then
nearestSabieDist = flatSabieDist
nearestSabiePos = sabiePos
end
end
end

if nearestSabiePos then
-- Vector pointing FROM Sabie Delta THROUGH Pride Rock and beyond it.
local away = Vector3.new(
rawPos.X - nearestSabiePos.X,
0,
rawPos.Z - nearestSabiePos.Z
)

if away.Magnitude > 5 then
away = away.Unit

local function rotateXZ(v, deg)
local r = math.rad(deg)
local c, s = math.cos(r), math.sin(r)
return Vector3.new(
v.X * c - v.Z * s,
0,
v.X * s + v.Z * c
)
end

-- Mbali is close behind Pride Rock, so keep the search tight.
local radii = {80, 130, 190, 260, 340, 430}
local angles = {0, 12, -12, 24, -24, 38, -38}

for _, radius in ipairs(radii) do
for _, angle in ipairs(angles) do
local dir = rotateXZ(away, angle)

consider(
rawPos + dir * radius,
obj,
85,
0
)
end
end
end
end
end

-- Avoid generic Pride Rock descendant/edge sampling for Mbali;
-- it could send the animal back toward Sabie Delta.
if not isPrideAnchor and obj:IsA("BasePart") then
local sx = math.min(math.abs(obj.Size.X) * 0.38, 700)
local sz = math.min(math.abs(obj.Size.Z) * 0.38, 700)
local rank = zoneCandidateRank(obj, false)

if sx > 40 or sz > 40 then
consider(obj.Position + Vector3.new( sx, 0,  0), obj, 220, rank)
consider(obj.Position + Vector3.new(-sx, 0,  0), obj, 220, rank)
consider(obj.Position + Vector3.new( 0, 0,  sz), obj, 220, rank)
consider(obj.Position + Vector3.new( 0, 0, -sz), obj, 220, rank)
consider(obj.Position + Vector3.new( sx, 0,  sz), obj, 220, rank)
consider(obj.Position + Vector3.new(-sx, 0,  sz), obj, 220, rank)
consider(obj.Position + Vector3.new( sx, 0, -sz), obj, 220, rank)
consider(obj.Position + Vector3.new(-sx, 0, -sz), obj, 220, rank)
end

elseif not isPrideAnchor and obj:IsA("Model") then
-- Inspect the whole model and prefer likely zone volumes/triggers.
-- We still keep normal descendants as a last-resort fallback.
local fallbackChecked = 0

for _, d in ipairs(obj:GetDescendants()) do
if d:IsA("BasePart") then
local rank = zoneCandidateRank(d, false)

if rank <= 1 then
consider(d.Position, d, 180, rank)

local sx = math.min(math.abs(d.Size.X) * 0.32, 500)
local sz = math.min(math.abs(d.Size.Z) * 0.32, 500)
if sx > 30 or sz > 30 then
consider(d.Position + Vector3.new( sx, 0,  0), d, 140, rank)
consider(d.Position + Vector3.new(-sx, 0,  0), d, 140, rank)
consider(d.Position + Vector3.new( 0, 0,  sz), d, 140, rank)
consider(d.Position + Vector3.new( 0, 0, -sz), d, 140, rank)
end
elseif fallbackChecked < 32 then
consider(d.Position, d, 160, rank)
fallbackChecked = fallbackChecked + 1
end
end
end
end
end

if bestGround then
zoneCache[key] = bestObj
return bestGround, bestRaw, bestObj, false
end

-- If every strong candidate is temporarily rejected, use a raw X/Z
-- proxy only as a last resort. Do not reuse a rejected proxy.
local fallbackObj = matches[1]

if isMbaliRiverBend then
if isMbaliCameraMarker(fallbackObj) then
fallbackObj = nil
end

if fallbackObj then
local fallbackNorm = normalizedAnimal(fallbackObj.Name)
local fallbackIsPride =
fallbackNorm:find("priderock", 1, true)
or fallbackNorm:find("pridelands", 1, true)
or fallbackNorm:find("lionrock", 1, true)
or fallbackNorm == "pride"

if fallbackIsPride then
fallbackObj = nil
end
end
end

local rawFallback = fallbackObj and zoneObjectPosition(fallbackObj) or nil
if rawFallback then
local ch2 = player.Character
local root2 = ch2 and ch2:FindFirstChild("HumanoidRootPart")
local safeY = root2 and root2.Position.Y or 0
local proxy = Vector3.new(rawFallback.X, safeY, rawFallback.Z)
if not zonePointRejected(zoneName, proxy) then
return proxy, rawFallback, fallbackObj, true
end
end

return nil, rawFallback, fallbackObj, true
end

local function walkToPosition(pos)
if not pos or type(shared._animalWalkToAsync) ~= "function" then return false end
local ok, result = pcall(shared._animalWalkToAsync, CFrame.new(pos))
return ok and result == true
end

local function safeZoneLegToward(zoneGroundPos)
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root or not zoneGroundPos then return nil end

local flatDelta = Vector3.new(zoneGroundPos.X - root.Position.X, 0, zoneGroundPos.Z - root.Position.Z)
local flatDist = flatDelta.Magnitude
if flatDist < 3 then return nil end
local dir = flatDelta.Unit

local distances = flatDist <= 170
and {math.min(120, flatDist), math.min(80, flatDist), math.min(45, flatDist), math.min(24, flatDist)}
or {140, 105, 75, 45}

local angleOffsets = {0, 18, -18, 36, -36, 58, -58}

local function rotateXZ(v, deg)
local r = math.rad(deg)
local c, s = math.cos(r), math.sin(r)
return Vector3.new(v.X * c - v.Z * s, 0, v.X * s + v.Z * c)
end

local function usefulLeg(leg)
if not leg then return false end

local legFlat = (
Vector3.new(leg.X, 0, leg.Z)
- Vector3.new(root.Position.X, 0, root.Position.Z)
).Magnitude

local remaining = (
Vector3.new(zoneGroundPos.X, 0, zoneGroundPos.Z)
- Vector3.new(leg.X, 0, leg.Z)
).Magnitude

local progressGain = flatDist - remaining

-- Prevent the old 1-2 stud loop that could repeat hundreds of times.
if legFlat < 12 or progressGain < 8 then
return false
end

-- When the destination zone is far below us, do not keep choosing a leg
-- that stays on the same high shelf forever.
local verticalToZone = root.Position.Y - zoneGroundPos.Y
if verticalToZone > 70
and leg.Y > root.Position.Y - 2
and remaining > 120
then
return false
end

return math.abs(leg.Y - root.Position.Y) <= 65
end

for _, distance in ipairs(distances) do
if distance and distance >= 8 then
for _, angle in ipairs(angleOffsets) do
local d = rotateXZ(dir, angle)
local rawLeg = Vector3.new(
root.Position.X + d.X * distance,
root.Position.Y,
root.Position.Z + d.Z * distance
)
local leg = safeGroundNear(rawLeg, ch, 65)
if usefulLeg(leg) then
return leg
end
end
end
end

-- Direct X/Z ground fallback. This avoids safeGroundNear snapping back to a
-- nearby high surface instead of actually advancing toward the zone.
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {ch}

for _, distance in ipairs({105, 75, 45, 24}) do
local useDistance = math.min(distance, math.max(flatDist - 6, 8))
if useDistance >= 8 then
local probeXZ = root.Position + dir * useDistance
local originY = math.max(root.Position.Y, zoneGroundPos.Y) + 180

local hit = Workspace:Raycast(
Vector3.new(probeXZ.X, originY, probeXZ.Z),
Vector3.new(0, -520, 0),
params
)

if hit and hit.Material ~= Enum.Material.Water then
local directLeg = hit.Position + Vector3.new(0, 3, 0)
if usefulLeg(directLeg) then
return directLeg
end
end
end
end

return nil
end

local function safeTravelPoint()
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then return nil end
local dirs = {
Vector3.new(1,0,0), Vector3.new(0,0,1), Vector3.new(-1,0,0), Vector3.new(0,0,-1),
Vector3.new(1,0,1).Unit, Vector3.new(-1,0,1).Unit, Vector3.new(-1,0,-1).Unit, Vector3.new(1,0,-1).Unit,
}
for offset = 1, #dirs do
local idx = ((travelStep + offset - 1) % #dirs) + 1
local targetXZ = root.Position + dirs[idx] * 95
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {ch}
local hit = Workspace:Raycast(targetXZ + Vector3.new(0, 160, 0), Vector3.new(0, -360, 0), params)
if hit and hit.Material ~= Enum.Material.Water then
travelStep = idx
return hit.Position + Vector3.new(0, 3, 0)
end
end
return nil
end

local function travelLongPoint()
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then return nil end

local dirs = {
Vector3.new(1,0,0),
Vector3.new(0,0,1),
Vector3.new(-1,0,0),
Vector3.new(0,0,-1),
Vector3.new(1,0,1).Unit,
Vector3.new(-1,0,1).Unit,
Vector3.new(-1,0,-1).Unit,
Vector3.new(1,0,-1).Unit,
}

local distances = {650, 520, 380, 260}

for _, distance in ipairs(distances) do
for offset = 1, #dirs do
local idx = ((travelStep + offset - 1) % #dirs) + 1
local targetXZ = root.Position + dirs[idx] * distance

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {ch}

local hit = Workspace:Raycast(
targetXZ + Vector3.new(0, 220, 0),
Vector3.new(0, -520, 0),
params
)

if hit
and hit.Material ~= Enum.Material.Water
and hit.Position.Y <= (root.Position.Y + 4.5)
then
travelStep = idx
return hit.Position + Vector3.new(0, 3, 0)
end
end
end

return safeTravelPoint()
end

local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = nil
pcall(function()
VirtualInputManager = game:GetService("VirtualInputManager")
end)

local nativeForwardHeld = false
local nativeFastHeld = false

local function setNativeForward(state)
state = state == true
nativeForwardHeld = state
nativeFastHeld = state

if VirtualInputManager then
pcall(function()
VirtualInputManager:SendKeyEvent(
state,
Enum.KeyCode.LeftShift,
false,
game
)
VirtualInputManager:SendKeyEvent(
state,
Enum.KeyCode.W,
false,
game
)
end)
end

pcall(function()
if state then
VirtualUser:KeyDown(0x10) -- SHIFT
VirtualUser:KeyDown(0x57) -- W
else
VirtualUser:KeyUp(0x57)
VirtualUser:KeyUp(0x10)
end
end)
end

stopNativeTravel = function()
setNativeForward(false)
local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
if hum then
pcall(function()
hum:Move(Vector3.zero, false)
end)
end
end

local function beachMotorTravelTo(target, maxSeconds)
if not target or type(shared._animalWalkToAsync) ~= "function" then
return false, 0, "motor indisponível"
end

local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then return false, 0, "sem personagem" end

maxSeconds = tonumber(maxSeconds) or 55
local startPos = root.Position

local groundLockParams = RaycastParams.new()
groundLockParams.FilterType = Enum.RaycastFilterType.Exclude
groundLockParams.FilterDescendantsInstances = {ch}

local function getGroundUnder(currentRoot)
if not currentRoot then return nil end

local pos = currentRoot.Position
local offsets = {
Vector3.new(0, 0, 0),
Vector3.new(2.5, 0, 0),
Vector3.new(-2.5, 0, 0),
Vector3.new(0, 0, 2.5),
Vector3.new(0, 0, -2.5),
}

local best = nil
for _, off in ipairs(offsets) do
local origin = pos + off + Vector3.new(0, 120, 0)
local hit = Workspace:Raycast(
origin,
Vector3.new(0, -700, 0),
groundLockParams
)

if hit
and hit.Material ~= Enum.Material.Water
and (not best or hit.Position.Y > best.Position.Y)
then
best = hit
end
end

return best
end

local lastSoftCorrectionAt = 0

local function clampLionToGround(currentRoot)
local ground = getGroundUnder(currentRoot)
if not ground then
return false, false
end

local desiredY = ground.Position.Y + 3.2
local altitude = currentRoot.Position.Y - desiredY
local pos = currentRoot.Position

local look = currentRoot.CFrame.LookVector
local flatLook = Vector3.new(look.X, 0, look.Z)
if flatLook.Magnitude < 0.01 then
flatLook = Vector3.new(0, 0, -1)
else
flatLook = flatLook.Unit
end

if altitude > 2.6 and altitude <= 7.5 then
local now = os.clock()
local drop = math.min(altitude - 2.0, 1.8)
local correctedY = pos.Y - math.max(0.35, drop)

currentRoot.CFrame = CFrame.lookAt(
Vector3.new(pos.X, correctedY, pos.Z),
Vector3.new(pos.X, correctedY, pos.Z) + flatLook
)

local velocity = currentRoot.AssemblyLinearVelocity
currentRoot.AssemblyLinearVelocity = Vector3.new(
velocity.X,
math.min(velocity.Y, 0),
velocity.Z
)

lastSoftCorrectionAt = now
return true, false
end

if altitude > 7.5 then
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false

currentRoot.CFrame = CFrame.lookAt(
Vector3.new(pos.X, desiredY, pos.Z),
Vector3.new(pos.X, desiredY, pos.Z) + flatLook
)

local velocity = currentRoot.AssemblyLinearVelocity
currentRoot.AssemblyLinearVelocity = Vector3.new(
velocity.X,
0,
velocity.Z
)
currentRoot.AssemblyAngularVelocity = Vector3.zero

local hum = currentRoot.Parent and currentRoot.Parent:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 then
pcall(function()
hum:ChangeState(Enum.HumanoidStateType.Running)
end)
end

return true, true
end

return false, false
end

setNativeForward(true)

local done = false
local result = false
local errText = nil

task.spawn(function()
local ok, walkResult = pcall(
shared._animalWalkToAsync,
CFrame.new(target)
)
if ok then
result = walkResult == true
else
errText = tostring(walkResult)
end
done = true
end)

local deadline = os.clock() + maxSeconds
while enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and not done
and os.clock() < deadline
do
ch = player.Character
root = ch and ch:FindFirstChild("HumanoidRootPart")

if not root then break end

setNativeForward(true)

local correctedAltitude, hardCorrection = clampLionToGround(root)
if hardCorrection then
errText = "anti-fly reiniciando perna no chão"
goatPrint("[AutoQuest] Travel anti-fly • fuga vertical bloqueada • reiniciando no chão")
break
end

if ch:GetAttribute("_returningToLand") then
errText = "cedido ao retorno para terra"
break
elseif ch:GetAttribute("_drinkingToFull")
or ch:GetAttribute("_carcassInteractionLock")
then
errText = "cedido à sobrevivência"
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
break
end

task.wait(0.35)
end

if not done then
local currentCh = player.Character
local returnOwnsMovement = currentCh
and currentCh:GetAttribute("_returningToLand")

if not returnOwnsMovement then
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
end
end

stopNativeTravel()

ch = player.Character
root = ch and ch:FindFirstChild("HumanoidRootPart")
local moved = root and (root.Position - startPos).Magnitude or 0

if errText then
return false, moved, errText
end
if moved >= 8 then
return true, moved, result and "chegou" or "movimento parcial"
end
return false, moved, done and "sem deslocamento" or "timeout"
end

local function realWalkToPoint(target, maxSeconds)
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
if not ch or not root or not hum or not target then
stopNativeTravel()
return false, "sem personagem"
end

maxSeconds = tonumber(maxSeconds) or 12
local started = os.clock()
local startPos = root.Position
local lastPos = root.Position
local lastProgressAt = os.clock()
local movedTotal = 0

setNativeForward(true)

while enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and (os.clock() - started) < maxSeconds
do
ch = player.Character
root = ch and ch:FindFirstChild("HumanoidRootPart")
hum = ch and ch:FindFirstChildOfClass("Humanoid")
if not ch or not root or not hum or hum.Health <= 0 then
stopNativeTravel()
return false, "personagem indisponível"
end

if ch:GetAttribute("_drinkingToFull")
or ch:GetAttribute("_returningToLand")
or ch:GetAttribute("_carcassInteractionLock")
then
stopNativeTravel()
return false, "movimento cedido para sobrevivência"
end

local flat = Vector3.new(
target.X - root.Position.X,
0,
target.Z - root.Position.Z
)

if flat.Magnitude <= 7 then
stopNativeTravel()
return true, "chegou"
end

local dir = flat.Unit

if math.floor((os.clock() - started) * 10) % 8 == 0 then
setNativeForward(true)
end

pcall(function()
hum:Move(dir, false)
end)

local camera = Workspace.CurrentCamera
if camera then
pcall(function()
local cameraPos = camera.CFrame.Position
camera.CFrame = CFrame.lookAt(
cameraPos,
cameraPos + Vector3.new(dir.X, 0, dir.Z)
)
end)
end

local stepMoved = (root.Position - lastPos).Magnitude
if stepMoved >= 1 then
movedTotal = movedTotal + stepMoved
lastPos = root.Position
lastProgressAt = os.clock()
elseif os.clock() - lastProgressAt > 3.5 then
stopNativeTravel()
return false, "sem movimento real"
end

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {ch}
local below = Workspace:Raycast(
root.Position + Vector3.new(0, 8, 0),
Vector3.new(0, -30, 0),
params
)
if below and below.Material == Enum.Material.Water then
stopNativeTravel()
return false, "água detectada"
end

task.wait(0.1)
end

stopNativeTravel()
movedTotal = math.max(movedTotal, (root.Position - startPos).Magnitude)
return movedTotal >= 5, movedTotal >= 5 and "tempo da perna" or "sem progresso"
end

-- Retry blocked missions later without losing their official progress.
local deferredQuests = {}
local activeMission = nil
local deferralSerial = 0
local deferQuest
local NO_PROGRESS_SECONDS = 150
local RETRY_SECONDS = 180

local function missionIdentity(q)
if not q then return nil end
return table.concat({
tostring(q.category or ""), tostring(q.questType or ""),
lower(q.name or q.title or "")
}, "|")
end

local function missionAvailable(q)
local pending = deferredQuests[missionIdentity(q)]
return not pending or os.clock() >= pending.retryAt
end

local function beginMission(q)
if q.questType ~= "SWIM_DISTANCE" then setSwimMovementLock(false) end
local id = missionIdentity(q)
if not activeMission or activeMission.id ~= id then
activeMission = {
id = id, quest = q,
progress = tonumber(q.progressCurrent), lastProgressAt = os.clock()
}
deferredQuests[id] = nil
else
activeMission.quest = q
end
end

local function checkMissionProgress(quests)
if not activeMission then return end
for _, q in ipairs(quests) do
if missionIdentity(q) == activeMission.id then
if q.completed then
if q.questType == "SWIM_DISTANCE" then setSwimMovementLock(false) end
deferredQuests[activeMission.id] = nil
activeMission = nil
return
end
local current = tonumber(q.progressCurrent)
if current and (activeMission.progress == nil or current > activeMission.progress) then
activeMission.lastProgressAt = os.clock()
end
activeMission.progress = current or activeMission.progress
activeMission.quest = q
if os.clock() - activeMission.lastProgressAt >= NO_PROGRESS_SECONDS then
deferQuest(q, "contador oficial sem progresso por 150s")
end
return
end
end
end

local function firstIncomplete(quests, questType)
local parallelSafe =
questType == "TRAVEL_DISTANCE"
or questType == "LAND_DISTANCE"
or questType == "SWIM_DISTANCE"
or questType == "PLAY_TIME"
or questType == "EAT"
or questType == "DRINK"
or questType == "MAINTAIN_STATS"
or questType == "GROW_TIME"
or questType == "GROUP_TIME"
or questType == "VISIT_ZONES"

if not parallelSafe then
for _, q in ipairs(quests) do
if not q.completed and q.questType == questType and missionAvailable(q) then
return q
end
end
return nil
end

local best = nil
local bestTarget = -1
local parallelCount = 0

for _, q in ipairs(quests) do
if not q.completed
and q.questType == questType
and missionAvailable(q)
then
parallelCount = parallelCount + 1

local target = tonumber(q.progressTarget) or 0
if not best or target > bestTarget then
best = q
bestTarget = target
end
end
end

if best and parallelCount > 1 then
local logKey =
questType
.. "|"
.. tostring(bestTarget)
.. "|"
.. tostring(parallelCount)

if shared._autoQuestLastEfficiencyLog ~= logKey then
shared._autoQuestLastEfficiencyLog = logKey
goatPrint(string.format(
"[AutoQuest] Efficiency selection | %s | %d compatible quests advancing together | target=%g",
questType,
parallelCount,
bestTarget
))
end
end

return best
end

local zoneProgressMemory = {}
local zoneInsideUntil = {}

local function findMatchingLiveQuest(category, wanted)
local cards = scanCurrentCards(category)
local wantedName = lower(wanted and wanted.name or "")
local wantedTitle = lower(wanted and wanted.title or "")
for _, q in ipairs(cards) do
if wanted and q.questType == wanted.questType then
local qName = lower(q.name or "")
local qTitle = lower(q.title or "")
if (wantedName ~= "" and qName == wantedName)
or (wantedTitle ~= "" and qTitle == wantedTitle)
or wantedName == ""
then
return q
end
end
end
return nil
end

local function openQuestCategory(category)
local _, top = questNodes()
if not top then return false end
local btn = top:FindFirstChild(tostring(category) .. "Button")
if not btn then return false end
local ok = activateButton(btn)
if ok then
task.wait(0.45)
end
return ok == true
end

local function zoneProgressIsAdvancing(q)
if not q or q.progressCurrent == nil then return false end
local key = tostring(q.name or q.title or "zone")
local current = tonumber(q.progressCurrent) or 0
local previous = zoneProgressMemory[key]
zoneProgressMemory[key] = current

if previous ~= nil and current > previous then
zoneInsideUntil[key] = os.clock() + 12
return true
end
return (zoneInsideUntil[key] or 0) > os.clock()
end

-- Keep Grow missions sticky too. Once Auto Quest starts a Grow mission,
-- it stays on that exact Daily/Weekly mission until the official counter
-- reaches the target; temporary GUI changes cannot make it jump away.
local lockedGrowQuest = nil
local lockedGrowQuestMisses = 0

local function growQuestIdentity(q)
if not q then return nil end
return table.concat({
tostring(q.category or ""),
tostring(q.questType or ""),
tostring(q.name or q.title or ""),
tostring(q.progressTarget or "")
}, "|")
end

local function findLockedGrowQuest(quests)
if not lockedGrowQuest then return nil, false end
local wantedId = lockedGrowQuest.id
for _, q in ipairs(quests or {}) do
if q.questType == "GROW_TIME" and growQuestIdentity(q) == wantedId and missionAvailable(q) then
return q, true
end
end
return nil, false
end

local function runGrowQuest(growQuest, token)
if not growQuest or not enabled or runToken ~= token then return true end
beginMission(growQuest)

local current = tonumber(growQuest.progressCurrent) or 0
local target = tonumber(growQuest.progressTarget) or 0

if growQuest.completed or (target > 0 and current >= target) then
setGrowQuestState(growQuest, "complete", nil, nil, "contador oficial completo")
goatPrint("[AutoQuest] Grow mission completed:", tostring(growQuest.name))
lockedGrowQuest = nil
return true
end

local pct = currentGrowthPercent()
local ch = player.Character
local animal = ch and tostring(ch:GetAttribute("AnimalName") or "?") or "?"

if pct and pct >= 99.5 then
setGrowQuestState(growQuest, "switching", animal, pct, "animal 100%")
status(
"Auto Quest • Grow",
tostring(growQuest.category)
.. " • " .. progressText(growQuest)
.. " • " .. growRemainingText(growQuest)
.. " • animal 100% — procurando slot <100%",
Color3.fromRGB(255, 185, 70)
)
end

local ok, infoOrWhy = ensureUnder100Growth(growQuest)
if not ok then
status(
"Auto Quest • Grow bloqueado",
tostring(infoOrWhy) .. " • " .. progressText(growQuest),
Color3.fromRGB(255, 185, 70)
)
deferQuest(growQuest, tostring(infoOrWhy), 300)
return true
end

local info = infoOrWhy or {}
local livePct = tonumber(info.GrowthPercent) or currentGrowthPercent()
local liveAnimal = tostring(info.AnimalName or animal or "?")

setGrowQuestState(growQuest, "active", liveAnimal, livePct, info.CharacterName)

status(
"Auto Quest • Grow",
tostring(growQuest.category)
.. " • " .. progressText(growQuest)
.. " • " .. growRemainingText(growQuest)
.. " • " .. liveAnimal
.. " G" .. string.format("%.0f%%", livePct or 0)
.. " • CRESCENDO",
Color3.fromRGB(0, 170, 255)
)

task.wait(info.switched and 2.0 or 4.0)
return true
end

-- Keep the selected animal mission sticky. A temporary GUI refresh/scan
-- must never make Auto Quest abandon an unfinished animal mission.
local lockedAnimalQuest = nil
local lockedAnimalQuestMisses = 0

local function animalQuestIdentity(q)
if not q then return nil end
return table.concat({
tostring(q.category or ""),
tostring(q.questType or ""),
tostring(q.name or q.title or ""),
tostring(q.progressTarget or "")
}, "|")
end

local function findLockedAnimalQuest(quests)
if not lockedAnimalQuest then return nil, false end
local wantedId = lockedAnimalQuest.id
for _, q in ipairs(quests or {}) do
if q.questType == "SURVIVE_TIME" and animalQuestIdentity(q) == wantedId and missionAvailable(q) then
return q, true
end
end
return nil, false
end

deferQuest = function(q, reason, retrySeconds)
if not q then return end
deferralSerial = deferralSerial + 1
local waitSeconds = retrySeconds or RETRY_SECONDS
deferredQuests[missionIdentity(q)] = {
retryAt = os.clock() + waitSeconds, reason = tostring(reason)
}
lockedGrowQuest = nil
lockedGrowQuestMisses = 0
lockedAnimalQuest = nil
lockedAnimalQuestMisses = 0
activeMission = nil
shared._autoQuestGrowState = nil
clearMissionHudLock()
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
pcall(stopNativeTravel)
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
status(
"Auto Quest • Pulando",
tostring(q.category) .. " • " .. tostring(q.name or q.title)
.. " • " .. tostring(reason) .. " • próxima missão; tentar novamente em "
.. tostring(waitSeconds) .. "s",
Color3.fromRGB(255, 185, 70)
)
end

local swimDirection = 0
local swimCachedWaterPart = nil
local swimWaterLookupAt = -math.huge
local function swimWaterPart()
if swimCachedWaterPart and swimCachedWaterPart.Parent then return swimCachedWaterPart end
if os.clock() - swimWaterLookupAt < 5 then return nil end
swimWaterLookupAt = os.clock()
local part = Workspace:FindFirstChild("MainWaterPart", true)
swimCachedWaterPart = part and part:IsA("BasePart") and part or nil
return swimCachedWaterPart
end

local function swimColumnAt(x, z, aroundY)
local ch = player.Character
local part = swimWaterPart()
local surfaceY = nil
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {Workspace.Terrain}
params.IgnoreWater = false
local topY = math.max(700, (aroundY or 0) + 150)
local hit = Workspace:Raycast(Vector3.new(x, topY, z), Vector3.new(0, -1500, 0), params)
if hit and hit.Material == Enum.Material.Water then surfaceY = hit.Position.Y end
if part then
local probe = part.CFrame:PointToObjectSpace(Vector3.new(x, part.Position.Y, z))
if math.abs(probe.X) < part.Size.X * 0.5 - 2
and math.abs(probe.Z) < part.Size.Z * 0.5 - 2 then
local top = part.CFrame:PointToWorldSpace(Vector3.new(0, part.Size.Y * 0.5, 0))
surfaceY = math.max(surfaceY or -math.huge, top.Y)
end
end
params.IgnoreWater = true
local floor = Workspace:Raycast(Vector3.new(x, topY, z), Vector3.new(0, -1500, 0), params)
if not floor or floor.Normal.Y < 0.5 then return nil end
local floorPoint = floor.Position + Vector3.new(0, 3.2, 0)
-- Stay above the global fall recovery threshold, never inside ground.
if floorPoint.Y < -85 then return nil end
local underwater = surfaceY and floorPoint.Y <= surfaceY - 2.5
return floorPoint, underwater == true, surfaceY
end

local function findSwimEntry(root)
for _, radius in ipairs({0, 24, 48, 96, 160, 280, 480, 800}) do
local best, bestDistance = nil, math.huge
for i = 0, 11 do
local angle = i * math.pi / 6
local point, wet = swimColumnAt(root.Position.X + math.cos(angle) * radius,
root.Position.Z + math.sin(angle) * radius, root.Position.Y)
if point and wet and (point - root.Position).Magnitude < bestDistance then
best, bestDistance = point, (point - root.Position).Magnitude
end
end
if best then return best end
end
return nil
end

local function swimLegIsClear(root, goal, ch)
local delta = goal - root.Position
if math.abs(delta.Y) > 18 then return false end
for _, alpha in ipairs({0.33, 0.66, 1}) do
local sample = root.Position + delta * alpha
local floorPoint = swimColumnAt(sample.X, sample.Z, sample.Y)
if not floorPoint or math.abs(floorPoint.Y - sample.Y) > 6 then return false end
end
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = {ch}
local part = swimWaterPart()
if part then params.FilterDescendantsInstances = {ch, part} end
params.IgnoreWater = true
local obstacle = Workspace:Raycast(root.Position, delta, params)
return not obstacle or (obstacle.Position - goal).Magnitude < 2
end

local function nextSwimLeg(root, entry)
local dryApproach = entry and (Vector3.new(entry.X, 0, entry.Z)
- Vector3.new(root.Position.X, 0, root.Position.Z)).Magnitude > 22
local baseAngle = swimDirection * math.pi / 4
if dryApproach then
local delta = entry - root.Position
baseAngle = math.atan2(delta.Z, delta.X)
end
for _, turn in ipairs({0, 30, -30, 60, -60, 90, -90, 180}) do
local angle = baseAngle + math.rad(turn)
local point, wet = swimColumnAt(root.Position.X + math.cos(angle) * 18,
root.Position.Z + math.sin(angle) * 18, root.Position.Y)
if point and (dryApproach or wet) and swimLegIsClear(root, point, player.Character) then
return point, wet
end
end
return nil
end

local function moveSwimLeg(goal, token)
if type(shared._animalWalkToAsync) ~= "function" then return false end
local ch = player.Character
local done, moved = false, false
task.spawn(function()
local ok, result = pcall(shared._animalWalkToAsync, CFrame.new(goal), {swim = true})
moved = ok and result == true
done = true
end)
local deadline = os.clock() + 10
while not done and os.clock() < deadline and enabled and runToken == token
and player.Character == ch and shared._autoQuestSwimLock
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
task.wait(0.1)
end
if not done then
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then pcall(shared._animalCancelTween, true) end
shared._animalTweening = false
return false
end
return moved
end

local function runSwimQuest(q, token)
beginMission(q)

local dlSwimQuest = game.GameId == 8198412649
if dlSwimQuest then
-- Immediate lock: WaterEscape must not fight an intentional Swim quest.
setSwimMovementLock(true)
goatPrint("[AutoQuest][DL] Swim mission ACTIVE — WaterEscape temporarily SUSPENDED")
end

if growthModeOwnsCurrentAnimal() then
if dlSwimQuest then setSwimMovementLock(false) end
deferQuest(q, "GrowthLoop controla o slot atual", 60)
return
end
local movementOk, switched = ensureMovementAnimal("missão Swim")
if not movementOk then
if dlSwimQuest then setSwimMovementLock(false) end
deferQuest(
q,
dlSwimQuest and "Gallimimus/Velociraptor indisponível para Swim" or "Lion/Impala indisponível para Swim",
300
)
return
end
if switched then return end
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
if not root or not hum or hum.Health <= 0 then
deferQuest(q, "personagem indisponível para Swim", 60)
return
end
if ch:GetAttribute("_drinkingToFull") or ch:GetAttribute("_returningToLand")
or ch:GetAttribute("_carcassInteractionLock") then
status("Auto Quest • Swim", "aguardando comida/água terminar", Color3.fromRGB(255, 185, 70))
task.wait(2)
return
end
if (ch:GetAttribute("Food") or 100) <= AUTOQUEST_SURVIVAL_TRIGGER_FOOD
or (ch:GetAttribute("Water") or 100) <= AUTOQUEST_SURVIVAL_TRIGGER_WATER
then
if runAutoQuestSurvivalPriority(true) then
task.wait(2.5)
return
end
end
local entry = findSwimEntry(root)
if not entry then
deferQuest(q, "não encontrou água com fundo utilizável")
return
end

if globalWaterEscapeActive then
status(
"Auto Quest • Swim",
"aguardando saída da água terminar",
Color3.fromRGB(255, 185, 70)
)
task.wait(0.75)
return
end

setTravelMovementLock(false)
setSwimMovementLock(true)
openQuestCategory(q.category)
local startedAt, lastCounterCheck, failedLegs = os.clock(), 0, 0
while enabled and runToken == token and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._autoQuestSwimLock and os.clock() - startedAt < 65 do
ch = player.Character
root = ch and ch:FindFirstChild("HumanoidRootPart")
hum = ch and ch:FindFirstChildOfClass("Humanoid")
if not root or not hum or hum.Health <= 0 then
deferQuest(q, "personagem morreu ou foi trocado", 60)
return
end
local currentAnimal = normalizedAnimal(ch:GetAttribute("AnimalName") or "")
if game.GameId == 8198412649 then
if currentAnimal ~= normalizedAnimal("Gallimimus")
and currentAnimal ~= normalizedAnimal("Velociraptor")
then
deferQuest(q, "animal trocado; Swim DL exige Gallimimus/Velociraptor", 60)
setSwimMovementLock(false)
return
end
elseif currentAnimal ~= normalizedAnimal("Lion")
and currentAnimal ~= normalizedAnimal("Impala")
then
deferQuest(q, "animal trocado; Swim exige Lion/Impala", 60)
return
end
if runAutoQuestSurvivalPriority(false) then
task.wait(2.5)
return
end
if os.clock() - lastCounterCheck >= 1 then
local live = findMatchingLiveQuest(q.category, q)
if live then
q = live
checkMissionProgress({live})
if q.completed then
setSwimMovementLock(false)
status("Auto Quest • Swim", "contador completo • aguardando Claim", Color3.fromRGB(65, 220, 150))
return
end
if not activeMission then return end
end
lastCounterCheck = os.clock()
end
local goal, wet = nextSwimLeg(root, entry)
if not goal then
failedLegs = failedLegs + 1
swimDirection = (swimDirection + 1) % 8
if failedLegs >= 4 then
deferQuest(q, "sem passagem utilizável no fundo da água")
return
end
task.wait(0.5)
else
status("Auto Quest • Swim", tostring(ch:GetAttribute("AnimalName")) .. " • " .. progressText(q)
.. (wet and " • correndo pelo fundo da água" or " • entrando na água"), Color3.fromRGB(0, 170, 255))
local before = root.Position
local moved = moveSwimLeg(goal, token)
if not enabled or runToken ~= token or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then
return
end
local liveRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local delta = liveRoot and (liveRoot.Position - before).Magnitude or 0
if moved and delta >= 3 then failedLegs = 0 else failedLegs = failedLegs + 1 end
if failedLegs >= 4 then
deferQuest(q, "movimento Swim sem deslocamento")
return
end
if not moved then swimDirection = (swimDirection + 1) % 8 end
task.wait(0.15)
end
end
end

-- Known safe points for the "Visit different zones" quest.
-- Progress is NEVER assumed from arrival: the official quest counter must increase.
local VISIT_ZONES = {
-- PRIMARY: user-confirmed fixed points. Always try these first.
{name = "Pride Rock", pos = Vector3.new(-6212.573, -2.521, 4576.150), primary = true},
{name = "Mbali River Bend", pos = Vector3.new(-5181.099, -5.472, 4843.564), primary = true},
{name = "Savannah Mirage", pos = Vector3.new(-7081.541, -10.206, 2491.294), primary = true},
{name = "Hippo Swamp", pos = Vector3.new(-6932.970, 3.907, 3934.451), primary = true},
{name = "Sabie Delta", pos = Vector3.new(-7889.545, -0.631, 6817.426), primary = true},
}

local function currentDisplayedZone()
local gui = player:FindFirstChild("PlayerGui")
local zoneGui = gui and gui:FindFirstChild("ZoneDisplayScreenGui")
local label = zoneGui and zoneGui:FindFirstChild("TextLabel")
if not label then return nil end

local text = tostring(label.Text or "")
text = text:gsub("'", "")
text = text:match("^%s*(.-)%s*$")
if text == "" then return nil end
return text
end

local DL_ZONE_NAMES = {
"Nestrock",
"The Nesting Grounds",
"Starfall Crater",
"Smoketip Peak",
"Isla Umbra",
"Skyridge Point",
"Sequoia Heartwood",
"Slopehorn Hill",
}

local function getDLZoneGroundPoint(zoneModel)
if not zoneModel or not zoneModel.Parent then
return nil
end

local x, z
local ok, cf, size = pcall(function()
local c, s = zoneModel:GetBoundingBox()
return c, s
end)

if ok and cf then
x = cf.Position.X
z = cf.Position.Z
else
local pivotOk, pivot = pcall(function()
return zoneModel:GetPivot()
end)
if pivotOk and pivot then
x = pivot.Position.X
z = pivot.Position.Z
end
end

if not x or not z then
return nil
end

-- MapZones models use tall zone volumes (their pivot can be around Y=392).
-- Raycast to the real terrain/ground at the same X/Z instead.
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude

local exclude = { zoneModel }
local mapZones = workspace:FindFirstChild("MapZones")
if mapZones then
table.insert(exclude, mapZones)
end
if player.Character then
table.insert(exclude, player.Character)
end
params.FilterDescendantsInstances = exclude
params.IgnoreWater = false

local result = workspace:Raycast(
Vector3.new(x, 1200, z),
Vector3.new(0, -2000, 0),
params
)

if result then
-- Prefer terrain/solid ground. If the first hit is water, try again excluding water
-- is not available in RaycastParams, so move slightly around the zone center.
if result.Material ~= Enum.Material.Water then
return Vector3.new(x, result.Position.Y + 2.2, z)
end
end

-- Small local search around the zone X/Z for solid ground.
local offsets = {
Vector2.new(0, 0),
Vector2.new(35, 0),
Vector2.new(-35, 0),
Vector2.new(0, 35),
Vector2.new(0, -35),
Vector2.new(60, 60),
Vector2.new(-60, 60),
Vector2.new(60, -60),
Vector2.new(-60, -60),
}

for _, off in ipairs(offsets) do
local rx = x + off.X
local rz = z + off.Y
local hit = workspace:Raycast(
Vector3.new(rx, 1200, rz),
Vector3.new(0, -2000, 0),
params
)
if hit and hit.Material ~= Enum.Material.Water then
return Vector3.new(rx, hit.Position.Y + 2.2, rz)
end
end

return nil
end

local function runDLVisitZonesQuest(zoneQuest, token)
if not zoneQuest or not enabled or runToken ~= token then return end

beginMission(zoneQuest)
setSwimMovementLock(false)
setTravelMovementLock(false)
setZoneMovementLock(true)
stopNativeTravel()

local movementOk, movementSwitched = ensureMovementAnimal("DL Explore")
if not movementOk then
deferQuest(zoneQuest, "Gallimimus/Velociraptor indisponível para Explore", 90)
setZoneMovementLock(false)
return
end
if movementSwitched then
setZoneMovementLock(false)
return
end

openQuestCategory(zoneQuest.category)

local mapZones = workspace:FindFirstChild("MapZones")
if not mapZones then
goatWarn("[AutoQuest][DL] EXPLORE failed — Workspace.MapZones not found")
deferQuest(zoneQuest, "MapZones não encontrado", 30)
setZoneMovementLock(false)
return
end

local live = findMatchingLiveQuest(zoneQuest.category, zoneQuest) or zoneQuest
local lastProgress = tonumber(live.progressCurrent) or tonumber(zoneQuest.progressCurrent) or 0
local target = tonumber(live.progressTarget) or tonumber(zoneQuest.progressTarget) or 5
local startedAt = os.clock()

goatPrint(string.format(
"[AutoQuest][DL] EXPLORE started | %s | %g/%g | real MapZones route",
tostring(zoneQuest.category or "Quest"),
lastProgress,
target
))

local function waitForWaterEscapeToFinish()
local waited = false
while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and globalWaterEscapeActive
do
if not waited then
waited = true
goatPrint("[AutoQuest][DL] EXPLORE paused — waiting WaterEscape")
status(
"Auto Quest • DL Explore",
"WaterEscape ativo • aguardando retorno à terra",
Color3.fromRGB(255, 185, 70)
)
end
task.wait(0.35)
end
if waited then
goatPrint("[AutoQuest][DL] EXPLORE resumed — WaterEscape finished")
end
return enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
end

local function horizontalDistanceTo(point)
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root or not point then return math.huge end
return (
Vector3.new(root.Position.X, 0, root.Position.Z)
- Vector3.new(point.X, 0, point.Z)
).Magnitude
end

local function waitForDLCharacter()
local warned = false

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
do
local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
local root = ch and ch:FindFirstChild("HumanoidRootPart")

if ch
and hum
and hum.Health > 0
and root
and tostring(ch:GetAttribute("AnimalName") or "") ~= ""
then
if warned then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE character restored | animal=%s | health=%.1f",
tostring(ch:GetAttribute("AnimalName")),
tonumber(hum.Health) or 0
))
end
return true
end

if not warned then
warned = true
goatWarn("[AutoQuest][DL] EXPLORE paused — character dead/missing; waiting respawn")
status(
"Auto Quest • DL Explore",
"personagem morreu/sumiu • aguardando respawn",
Color3.fromRGB(255, 120, 80)
)
end

-- Never burn zone attempts while dead.
setZoneMovementLock(false)
task.wait(0.75)
end

return false
end

for _, zoneName in ipairs(DL_ZONE_NAMES) do
if not enabled
or runToken ~= token
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
or os.clock() - startedAt > 240
then
break
end

if not waitForWaterEscapeToFinish() then break end
if not waitForDLCharacter() then break end
setZoneMovementLock(true)

if runAutoQuestSurvivalPriority(false) then
task.wait(2.0)
setZoneMovementLock(false)
return
end

maintainSurvival()

local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
local current = tonumber(refreshed.progressCurrent) or lastProgress
local goal = tonumber(refreshed.progressTarget) or target
if refreshed.completed or (goal > 0 and current >= goal) then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE complete before next zone | %g/%g",
current,
goal
))
setZoneMovementLock(false)
return
end
lastProgress = current
target = goal
end

local zoneModel = mapZones:FindFirstChild(zoneName)
if not zoneModel then
goatWarn("[AutoQuest][DL] EXPLORE zone missing: " .. tostring(zoneName))
continue
end

local point = getDLZoneGroundPoint(zoneModel)

-- If center-ground lookup fails, reuse the older robust zone finder ONLY as
-- a target resolver. We do NOT invoke the old SURVIVE_ZONE quest handler.
if not point and type(findZonePosition) == "function" then
local fallbackPos = findZonePosition(zoneName)
if typeof(fallbackPos) == "Vector3" then
point = fallbackPos
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE fallback ground target | zone=%s | target=(%.1f, %.1f, %.1f)",
zoneName,
point.X,
point.Y,
point.Z
))
end
end

if not point then
goatWarn("[AutoQuest][DL] EXPLORE no safe ground point for zone: " .. tostring(zoneName))
continue
end

status(
"Auto Quest • DL Explore",
string.format(
"%s • %g/%g • indo para %s",
tostring(zoneQuest.category),
lastProgress,
target,
zoneName
),
Color3.fromRGB(0, 170, 255)
)

goatPrint(string.format(
"[AutoQuest][DL] EXPLORE moving | zone=%s | target=(%.1f, %.1f, %.1f)",
zoneName,
point.X,
point.Y,
point.Z
))

-- Repeatedly continue toward the SAME zone until truly close.
-- "movimento parcial" is never treated as arrival anymore.
local reachedZone = false
local moveAttempts = 0

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and moveAttempts < 14
and os.clock() - startedAt < 240
do
if not waitForWaterEscapeToFinish() then break end
if not waitForDLCharacter() then break end
setZoneMovementLock(true)

if runAutoQuestSurvivalPriority(false) then
task.wait(1.5)
continue
end

local distBefore = horizontalDistanceTo(point)
if distBefore <= 35 then
reachedZone = true
break
end

moveAttempts = moveAttempts + 1

local moved, movedStuds, why = beachMotorTravelTo(point, 65)

goatPrint(string.format(
"[AutoQuest][DL] EXPLORE approach #%d | zone=%s | moved=%s | studs=%.1f | distBefore=%.1f | %s",
moveAttempts,
zoneName,
tostring(moved),
tonumber(movedStuds) or 0,
distBefore,
tostring(why)
))

if tostring(why):find("sem personagem", 1, true)
or tostring(why):find("morto", 1, true)
or tostring(why):find("dead", 1, true)
then
-- Refund this attempt: death is not a navigation failure.
moveAttempts = math.max(0, moveAttempts - 1)
if not waitForDLCharacter() then break end
setZoneMovementLock(true)
continue
end

if not waitForWaterEscapeToFinish() then break end

local distAfter = horizontalDistanceTo(point)
if distAfter <= 35 then
reachedZone = true
break
end

-- If survival temporarily owned the movement, do not abandon the zone.
if tostring(why):find("sobreviv", 1, true) then
task.wait(1.0)
continue
end

-- No useful displacement: recompute target from zone data before retrying.
if (tonumber(movedStuds) or 0) < 3 then
local refreshedPoint = getDLZoneGroundPoint(zoneModel)
if refreshedPoint then point = refreshedPoint end
task.wait(0.6)
else
task.wait(0.2)
end
end

if not waitForDLCharacter() then
setZoneMovementLock(false)
return
end
setZoneMovementLock(true)

local finalDist = horizontalDistanceTo(point)

if not reachedZone then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE zone NOT reached | zone=%s | distance=%.1f | skipping validation",
zoneName,
finalDist
))
continue
end

goatPrint(string.format(
"[AutoQuest][DL] EXPLORE zone physically reached | zone=%s | distance=%.1f | validating official counter",
zoneName,
finalDist
))

-- Give the game's zone detector enough time to register ONLY after arrival.
local before = lastProgress
local registerDeadline = os.clock() + 6.0

while os.clock() < registerDeadline
and enabled
and runToken == token
do
if globalWaterEscapeActive then
break
end

task.wait(0.35)

local nowQuest = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if nowQuest then
local current = tonumber(nowQuest.progressCurrent) or before
local goal = tonumber(nowQuest.progressTarget) or target

if current > before then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE zone COUNTED | zone=%s | %g -> %g/%g",
zoneName,
before,
current,
goal
))
lastProgress = current
target = goal
break
end

if nowQuest.completed or (goal > 0 and current >= goal) then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE complete | zone=%s | %g/%g",
zoneName,
current,
goal
))
setZoneMovementLock(false)
return
end
end
end

if lastProgress <= before then
goatPrint(string.format(
"[AutoQuest][DL] EXPLORE zone not counted after REAL arrival | zone=%s | progress=%g/%g",
zoneName,
lastProgress,
target
))
end
end

local finalQuest = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if finalQuest then
local current = tonumber(finalQuest.progressCurrent) or lastProgress
local goal = tonumber(finalQuest.progressTarget) or target
if finalQuest.completed or (goal > 0 and current >= goal) then
goatPrint(string.format("[AutoQuest][DL] EXPLORE complete | %g/%g", current, goal))
setZoneMovementLock(false)
return
end
end

setZoneMovementLock(false)
deferQuest(zoneQuest, "Explore ainda incompleto; repetir somente rota DL pelas zonas reais", 20)
end

local function runVisitZonesQuest(zoneQuest, token)
if not zoneQuest or not enabled or runToken ~= token then return end

if game.GameId == 8198412649 then
return runDLVisitZonesQuest(zoneQuest, token)
end

beginMission(zoneQuest)
setSwimMovementLock(false)
setTravelMovementLock(false)
setZoneMovementLock(true)
stopNativeTravel()

local movementOk, movementSwitched = ensureMovementAnimal("visitando zonas")
if not movementOk then
deferQuest(zoneQuest, "Lion/Impala indisponível ou spawn ainda não pronto", 300)
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end
if movementSwitched then
setZoneMovementLock(false)
return
end

-- If AutoDrink already owned movement BEFORE Visit Zones started, do not
-- fight it. Give water recovery this cycle and retry Visit Zones afterwards.
local visitCharacter = player.Character
if visitCharacter
and (
visitCharacter:GetAttribute("_drinkingToFull") == true
or visitCharacter:GetAttribute("_returningToLand") == true
or autoDrinkApproachActive
or autoDrinkShoreReturnActive
or returningToLand
or drinkCommandLatched
)
then
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
setZoneMovementLock(false)
goatPrint("[AutoQuest] VISIT_ZONES waiting • AutoDrink already owns movement")
task.wait(2.5)
return
end

shared._autoQuestVisitZonesLock = true
shared._autoQuestVisitZonesExclusive = true
shared._autoQuestVisitZonesExclusiveToken = token
if visitCharacter then
visitCharacter:SetAttribute("_autoQuestVisitZonesLock", true)
end
goatPrint("[AutoQuest] VISIT_ZONES movement lock ON • EXCLUSIVE route lock • AutoEat/AutoDrink normal routes paused")

openQuestCategory(zoneQuest.category)

local live = findMatchingLiveQuest(zoneQuest.category, zoneQuest) or zoneQuest
local progress = tonumber(live.progressCurrent) or tonumber(zoneQuest.progressCurrent) or 0
local target = tonumber(live.progressTarget) or tonumber(zoneQuest.progressTarget) or 5

goatPrint(string.format(
"[AutoQuest] VISIT_ZONES started | %s | %g/%g",
tostring(zoneQuest.category or "Quest"),
progress,
target
))

-- Fixed points are primary. Only if a fixed point cannot be reached/count
-- do we ask the game's own named-zone resolver for a marker/fallback point.
local function visitZoneMarkerFallback(zoneName, fixedPos, beforeProgress)
if type(findZonePosition) ~= "function" then
return false
end

local markerPos = select(1, findZonePosition(zoneName))
if typeof(markerPos) ~= "Vector3" then
goatPrint("[AutoQuest] VISIT_ZONES marker fallback unavailable • " .. tostring(zoneName))
return false
end

local markerVsFixed = (
Vector3.new(markerPos.X, 0, markerPos.Z)
- Vector3.new(fixedPos.X, 0, fixedPos.Z)
).Magnitude

-- Do not waste time retrying effectively the same point.
if markerVsFixed < 18 then
return false
end

goatPrint(string.format(
"[AutoQuest] VISIT_ZONES fixed point failed/not counted • %s • fallback GAME MARKER • offset=%.0f",
tostring(zoneName),
markerVsFixed
))

local fallbackStarted = os.clock()
local fallbackLegs = 0
while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - fallbackStarted < 28
and fallbackLegs < 10
do
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then break end

local dist = (
Vector3.new(root.Position.X, 0, root.Position.Z)
- Vector3.new(markerPos.X, 0, markerPos.Z)
).Magnitude

if dist <= 18 then
break
end

fallbackLegs = fallbackLegs + 1
local leg = safeZoneLegToward(markerPos)
if not leg then
break
end

if not walkToPosition(leg) then
break
end

task.wait(0.12)
end

-- Small final push toward the marker so the animal actually crosses
-- the zone boundary instead of stopping just outside it.
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if root then
local delta = Vector3.new(
markerPos.X - root.Position.X,
0,
markerPos.Z - root.Position.Z
)
if delta.Magnitude > 2 then
local push = math.min(12, delta.Magnitude)
local pushTarget = root.Position + delta.Unit * push
pcall(walkToPosition, pushTarget)
end
end

local confirmAt = os.clock()
while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - confirmAt < 8
do
task.wait(0.65)

local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
local p = tonumber(refreshed.progressCurrent) or beforeProgress
if p > beforeProgress then
goatPrint(string.format(
"[AutoQuest] VISIT_ZONES marker fallback CONFIRMED • %s • %g -> %g",
tostring(zoneName),
beforeProgress,
p
))
return true
end
end
end

return false
end

for _, zone in ipairs(VISIT_ZONES) do
if not enabled
or runToken ~= token
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
then
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end

if globalWaterEscapeActive then
repeat
task.wait(0.35)
until not globalWaterEscapeActive
or not enabled
or runToken ~= token

if not enabled or runToken ~= token then
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end
end

if runAutoQuestSurvivalPriority(false) then
setZoneMovementLock(false)
task.wait(2.5)
return
end

maintainSurvival()

live = findMatchingLiveQuest(zoneQuest.category, zoneQuest) or live
if live then
progress = tonumber(live.progressCurrent) or progress
target = tonumber(live.progressTarget) or target
if live.completed or (target > 0 and progress >= target) then
goatPrint(string.format("[AutoQuest] VISIT_ZONES completed | %g/%g", progress, target))
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end
end

local before = progress
local alreadyHere = currentDisplayedZone()

status(
"Auto Quest • Visit Zones",
zone.name .. " • " .. tostring(progress) .. "/" .. tostring(target),
Color3.fromRGB(0, 170, 255)
)

goatPrint(string.format(
"[AutoQuest] VISIT_ZONES moving • %s • currentZone=%s • before=%g/%g • rota terrestre contínua",
zone.name,
tostring(alreadyHere or "?"),
before,
target
))

local moved = false
local legIndex = 0
local movementStarted = os.clock()
local visitBestDistance = math.huge
local visitStagnantLegs = 0

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - movementStarted < 45
and legIndex < 16
do
local character = player.Character
local root = character and character:FindFirstChild("HumanoidRootPart")
if not root then
break
end

local flatDistance = (
Vector3.new(root.Position.X, 0, root.Position.Z)
- Vector3.new(zone.pos.X, 0, zone.pos.Z)
).Magnitude

if flatDistance <= 22 then
moved = true
break
end

legIndex = legIndex + 1
local legPos = safeZoneLegToward(zone.pos)
if not legPos then
goatPrint("[AutoQuest] VISIT_ZONES no safe terrestrial leg • " .. zone.name)
break
end

local legDistance = (
Vector3.new(root.Position.X, 0, root.Position.Z)
- Vector3.new(legPos.X, 0, legPos.Z)
).Magnitude

goatPrint(string.format(
"[AutoQuest] Visit Zones continuous leg #%d • %s • dist=%d • leg=%d • legY=%.1f • markerY=%.1f",
legIndex,
zone.name,
math.floor(flatDistance + 0.5),
math.floor(legDistance + 0.5),
legPos.Y,
zone.pos.Y
))

local legMoved = walkToPosition(legPos)
if not legMoved then
goatPrint(
"[AutoQuest] VISIT_ZONES terrestrial leg failed • "
.. zone.name
.. " • leg #"
.. tostring(legIndex)
)
break
end

local afterCharacter = player.Character
local afterRoot = afterCharacter and afterCharacter:FindFirstChild("HumanoidRootPart")
if afterRoot then
local afterDistance = (
Vector3.new(afterRoot.Position.X, 0, afterRoot.Position.Z)
- Vector3.new(zone.pos.X, 0, zone.pos.Z)
).Magnitude

if afterDistance + 5 < visitBestDistance then
visitBestDistance = afterDistance
visitStagnantLegs = 0
else
visitStagnantLegs = visitStagnantLegs + 1
end

if visitStagnantLegs >= 3 then
goatPrint(string.format(
"[AutoQuest] VISIT_ZONES progress watchdog • %s • no useful progress for %d legs • dist=%.0f",
zone.name,
visitStagnantLegs,
afterDistance
))
break
end
end

if runAutoQuestSurvivalPriority(false) then
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then
cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false)
end
setZoneMovementLock(false)
goatPrint("[AutoQuest] VISIT_ZONES paused • survival emergency took movement priority")
return
end

task.wait(0.15)
end

if not moved then
if legIndex >= 16 then
goatPrint("[AutoQuest] VISIT_ZONES leg cap reached • " .. zone.name)
else
goatPrint("[AutoQuest] VISIT_ZONES fixed movement failed • " .. zone.name)
end

local fallbackConfirmed = visitZoneMarkerFallback(zone.name, zone.pos, before)
if fallbackConfirmed then
local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
progress = tonumber(refreshed.progressCurrent) or progress
target = tonumber(refreshed.progressTarget) or target
end
end

task.wait(0.5)
continue
end

-- Wait for the SERVER/OFFICIAL GUI quest counter. Merely reaching the point
-- does not count as success.
local confirmStarted = os.clock()
local confirmed = false
while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - confirmStarted < 12
 do
task.wait(0.75)

if runAutoQuestSurvivalPriority(false) then
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
goatPrint("[AutoQuest] VISIT_ZONES paused • survival emergency took movement priority")
return
end

maintainSurvival()

local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
local newProgress = tonumber(refreshed.progressCurrent) or progress
local newTarget = tonumber(refreshed.progressTarget) or target

if refreshed.completed or (newTarget > 0 and newProgress >= newTarget) then
progress = newProgress
target = newTarget
goatPrint(string.format(
"[AutoQuest] VISIT_ZONES final zone confirmed • %s • %g/%g",
tostring(currentDisplayedZone() or zone.name), progress, target
))
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end

if newProgress > before then
progress = newProgress
target = newTarget
confirmed = true

goatPrint(string.format(
"[AutoQuest] VISIT_ZONES confirmed • %s • %g/%g",
tostring(currentDisplayedZone() or zone.name),
progress,
target
))

status(
"Auto Quest • Visit Zones",
tostring(currentDisplayedZone() or zone.name)
.. " • CONFIRMADA • "
.. tostring(progress)
.. "/"
.. tostring(target),
Color3.fromRGB(65, 220, 150)
)
break
end
end
end

if not confirmed then
goatPrint(string.format(
"[AutoQuest] VISIT_ZONES fixed point not counted/already visited • %s • still %g/%g",
zone.name,
progress,
target
))

local fallbackConfirmed = visitZoneMarkerFallback(zone.name, zone.pos, before)
if fallbackConfirmed then
local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
progress = tonumber(refreshed.progressCurrent) or progress
target = tonumber(refreshed.progressTarget) or target
confirmed = true
end
end
end

task.wait(0.5)
end

-- Final official verification after all known zone points.
local final = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if final then
local current = tonumber(final.progressCurrent) or progress
local goal = tonumber(final.progressTarget) or target
if final.completed or (goal > 0 and current >= goal) then
goatPrint(string.format("[AutoQuest] VISIT_ZONES complete • %g/%g", current, goal))
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
return
end
end

shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
local cleanupCharacter = player.Character
if cleanupCharacter then cleanupCharacter:SetAttribute("_autoQuestVisitZonesLock", false) end
setZoneMovementLock(false)
goatPrint("[AutoQuest] VISIT_ZONES movement lock OFF • survival workers released")
deferQuest(
zoneQuest,
"percorreu zonas conhecidas mas contador ainda não completou",
60
)
end

local function runDLSurviveZoneQuest(zoneQuest, token)
if not zoneQuest or not enabled or runToken ~= token then return end

beginMission(zoneQuest)

setSwimMovementLock(false)
setTravelMovementLock(false)
setZoneMovementLock(true)
stopNativeTravel()

local zoneName = extractZone(zoneQuest.name)
or extractZone(zoneQuest.title)
or tostring(zoneQuest.title or "zona")

local movementOk, movementSwitched =
ensureMovementAnimal("Survive Zone • " .. tostring(zoneName))

if not movementOk then
setZoneMovementLock(false)
deferQuest(
zoneQuest,
"Gallimimus/Velociraptor indisponível para Survive Zone",
60
)
return
end

if movementSwitched then
setZoneMovementLock(false)
return
end

openQuestCategory(zoneQuest.category)

local live = findMatchingLiveQuest(zoneQuest.category, zoneQuest) or zoneQuest
local lastProgress = tonumber(live.progressCurrent) or tonumber(zoneQuest.progressCurrent) or 0
local targetProgress = tonumber(live.progressTarget) or tonumber(zoneQuest.progressTarget) or 0

local routeStartedAt = os.clock()
local insideConfirmed = false
local lastPoint = nil
local noProgressSince = os.clock()
local lastLoggedProgress = lastProgress

goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE started | zone=%s | %g/%g",
tostring(zoneName),
lastProgress,
targetProgress
))

local function getDLZoneTarget()
local mapZones = workspace:FindFirstChild("MapZones")
local zoneModel = mapZones and mapZones:FindFirstChild(zoneName)

if zoneModel and type(getDLZoneGroundPoint) == "function" then
local p = getDLZoneGroundPoint(zoneModel)
if p then
return p, "MapZones"
end
end

local p = nil
if type(findZonePosition) == "function" then
p = select(1, findZonePosition(zoneName))
end

if typeof(p) == "Vector3" then
return p, "fallback"
end

return nil, "none"
end

local function horizontalDistance(point)
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root or not point then return math.huge end

return (
Vector3.new(root.Position.X, 0, root.Position.Z)
- Vector3.new(point.X, 0, point.Z)
).Magnitude
end

-- DL-only route improvement:
-- choose the safest leg that ALSO reduces X/Z distance to the target zone.
-- This prevents large sideways detours and the "distance went up again" effect.
local function bestProgressZoneLeg(zoneGroundPos)
local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not ch or not root or not zoneGroundPos then
return nil, nil
end

local currentFlat = Vector3.new(root.Position.X, 0, root.Position.Z)
local targetFlat = Vector3.new(zoneGroundPos.X, 0, zoneGroundPos.Z)
local delta = targetFlat - currentFlat
local currentDist = delta.Magnitude

if currentDist < 3 then
return nil, currentDist
end

local dir = delta.Unit

local function rotateXZ(v, deg)
local r = math.rad(deg)
local c, s = math.cos(r), math.sin(r)
return Vector3.new(
v.X * c - v.Z * s,
0,
v.X * s + v.Z * c
)
end

-- Direct route first; small sidesteps only when direct ground is unsafe.
local angleOffsets = {0, 10, -10, 20, -20, 32, -32}

local distances
if currentDist > 1400 then
distances = {170, 140, 110, 80}
elseif currentDist > 700 then
distances = {145, 120, 95, 70}
elseif currentDist > 250 then
distances = {110, 85, 60, 40}
else
distances = {
math.min(80, currentDist),
math.min(55, currentDist),
math.min(32, currentDist),
math.min(18, currentDist),
}
end

local bestLeg = nil
local bestRemaining = math.huge
local bestAngle = nil

for _, distance in ipairs(distances) do
if distance and distance >= 8 then
for _, angle in ipairs(angleOffsets) do
local d = rotateXZ(dir, angle)
local rawLeg = Vector3.new(
root.Position.X + d.X * distance,
root.Position.Y,
root.Position.Z + d.Z * distance
)

local leg = safeGroundNear(rawLeg, ch, 42)

if leg and math.abs(leg.Y - root.Position.Y) <= 48 then
local legFlat = Vector3.new(leg.X, 0, leg.Z)
local remaining = (targetFlat - legFlat).Magnitude
local progress = currentDist - remaining

-- Never deliberately choose a leg that moves us farther away.
-- Require useful forward progress, except very near the target.
local minProgress = currentDist <= 120 and 1.5 or 8

if progress >= minProgress and remaining < bestRemaining then
bestLeg = leg
bestRemaining = remaining
bestAngle = angle

-- The straight path is best if it is safe and makes good progress.
if angle == 0 and progress >= math.min(distance * 0.70, 35) then
return bestLeg, bestRemaining, bestAngle
end
end
end
end
end
end

return bestLeg, bestRemaining, bestAngle
end

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - routeStartedAt < 150
do
local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
local root = ch and ch:FindFirstChild("HumanoidRootPart")

if not ch or not hum or hum.Health <= 0 or not root then
setZoneMovementLock(false)
goatWarn("[AutoQuest][DL] SURVIVE_ZONE paused — character dead/missing")
return
end

local animal = tostring(ch:GetAttribute("AnimalName") or "")
local norm = normalizedAnimal(animal)

if norm ~= normalizedAnimal("Gallimimus")
and norm ~= normalizedAnimal("Velociraptor")
then
setZoneMovementLock(false)
deferQuest(
zoneQuest,
"animal trocado; Survive Zone DL exige Gallimimus/Velociraptor",
30
)
return
end

if globalWaterEscapeActive then
status(
"Auto Quest • DL Zone",
tostring(zoneName) .. " • aguardando WaterEscape",
Color3.fromRGB(255, 185, 70)
)
task.wait(0.5)
continue
end

local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)

if refreshed then
local current = tonumber(refreshed.progressCurrent) or lastProgress
local goal = tonumber(refreshed.progressTarget) or targetProgress

if refreshed.completed or (goal > 0 and current >= goal) then
goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE complete | zone=%s | %g/%g",
tostring(zoneName),
current,
goal
))
setZoneMovementLock(false)
return
end

if current > lastProgress then
insideConfirmed = true
noProgressSince = os.clock()

if current ~= lastLoggedProgress then
goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE counter advancing | zone=%s | %g -> %g/%g",
tostring(zoneName),
lastProgress,
current,
goal
))
lastLoggedProgress = current
end
end

lastProgress = current
targetProgress = goal
end

-- Survival has priority. If it needs to leave for water/food, release
-- this cycle; next scan will route back to the same zone.
if runAutoQuestSurvivalPriority(false) then
setZoneMovementLock(false)
return
end

-- Keep normal survival enabled while staying in the zone.
maintainSurvival()

if insideConfirmed then
status(
"Auto Quest • DL Zone",
tostring(zoneName)
.. " • DENTRO DA ZONA • "
.. tostring(lastProgress)
.. "/"
.. tostring(targetProgress)
.. " • "
.. tostring(animal),
Color3.fromRGB(65, 220, 150)
)

-- If the counter stops for too long, assume we drifted out and reacquire.
if os.clock() - noProgressSince > 12 then
insideConfirmed = false
goatPrint(
"[AutoQuest][DL] SURVIVE_ZONE counter stalled — reacquiring zone: "
.. tostring(zoneName)
)
else
task.wait(1.5)
continue
end
end

local point, source = getDLZoneTarget()
lastPoint = point or lastPoint

if not point then
status(
"Auto Quest • DL Zone",
tostring(zoneName) .. " • sem ponto seguro",
Color3.fromRGB(255, 185, 70)
)

goatWarn(
"[AutoQuest][DL] SURVIVE_ZONE no safe point | zone="
.. tostring(zoneName)
)

setZoneMovementLock(false)
deferQuest(zoneQuest, "zona sem referência segura", 30)
return
end

local dist = horizontalDistance(point)

if dist <= 35 then
status(
"Auto Quest • DL Zone",
tostring(zoneName)
.. " • aguardando contador oficial • "
.. string.format("%.0f studs", dist),
Color3.fromRGB(0, 170, 255)
)

goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE physically reached | zone=%s | distance=%.1f | source=%s",
tostring(zoneName),
dist,
tostring(source)
))

-- Do not move away. Give the server time to start increasing seconds.
local verifyStart = os.clock()
local verifyBase = lastProgress

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() - verifyStart < 8
do
task.wait(0.75)

local verify = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if verify then
local nowProgress = tonumber(verify.progressCurrent) or verifyBase
local goal = tonumber(verify.progressTarget) or targetProgress

if verify.completed or (goal > 0 and nowProgress >= goal) then
setZoneMovementLock(false)
return
end

if nowProgress > verifyBase then
insideConfirmed = true
lastProgress = nowProgress
targetProgress = goal
noProgressSince = os.clock()

goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE ENTRY CONFIRMED | zone=%s | %g -> %g/%g",
tostring(zoneName),
verifyBase,
nowProgress,
goal
))
break
end
end
end

if not insideConfirmed then
goatPrint(
"[AutoQuest][DL] SURVIVE_ZONE reached point but counter not moving yet | zone="
.. tostring(zoneName)
)
end

task.wait(0.5)
continue
end

local leg, predictedRemaining, routeAngle = bestProgressZoneLeg(point)

if not leg then
goatPrint(
"[AutoQuest][DL] SURVIVE_ZONE no forward-safe leg — recalculating | zone="
.. tostring(zoneName)
.. " | dist=" .. string.format("%.0f", dist)
)
task.wait(0.7)
continue
end

status(
"Auto Quest • DL Zone",
tostring(zoneName)
.. " • "
.. math.floor(dist)
.. " studs • "
.. tostring(animal),
Color3.fromRGB(0, 170, 255)
)

local moved = walkToPosition(leg)

goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE moving | zone=%s | dist=%.0f -> predicted=%.0f | angle=%s | moved=%s | leg=(%.1f, %.1f, %.1f)",
tostring(zoneName),
dist,
tonumber(predictedRemaining) or dist,
tostring(routeAngle or 0),
tostring(moved),
leg.X,
leg.Y,
leg.Z
))

task.wait(moved and 0.15 or 0.5)
end

setZoneMovementLock(false)

if enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
then
goatPrint(string.format(
"[AutoQuest][DL] SURVIVE_ZONE cycle ended | zone=%s | progress=%g/%g | will continue next scan",
tostring(zoneName),
lastProgress,
targetProgress
))
end
end


-- GROUP_TIME automation.
-- Runs ONLY while Auto Quest is enabled AND an incomplete GROUP_TIME quest exists.
-- Existing groups are preserved. If not in a group:
--   1) join an existing group named "mission auto";
--   2) otherwise create "mission auto".
-- Group creation already uses the game's default automatic approval.
shared._goatAutoQuestEnsureMissionGroup = function(quests)
if shared._autoQuestEnabled ~= true then
return false, "autoquest_off"
end

local groupQuest = nil
if type(quests) == "table" then
for _, q in ipairs(quests) do
if type(q) == "table"
and q.completed ~= true
and tostring(q.questType or q.type or "") == "GROUP_TIME"
then
local current = tonumber(q.progressCurrent) or 0
local target = tonumber(q.progressTarget) or 0
if target <= 0 or current < target then
groupQuest = q
break
end
end
end
end

local now = os.clock()
local pg = player:FindFirstChildOfClass("PlayerGui")
local statsGui = pg and pg:FindFirstChild("AnimalStatsScreenGui")
local grouping = statsGui and statsGui:FindFirstChild("GroupingFrame", true)
local inGroupFrame = grouping and grouping:FindFirstChild("InGroupFrame", true)
local notInGroupFrame = grouping and grouping:FindFirstChild("NotInGroupFrame", true)

-- If the game's own UI confirms we are in a group, leave it alone.
if inGroupFrame and inGroupFrame.Visible == true then
shared._goatAutoQuestGroupCreateCandidateAt = nil
shared._goatAutoQuestGroupLastActionAt = nil
return true, "already_in_group"
end

-- If the UI explicitly says "not in group", continue. If the UI is still
-- loading, wait instead of firing group remotes blindly.
if notInGroupFrame and notInGroupFrame.Visible ~= true then
return false, "group_ui_transition"
end

local lastAction = tonumber(shared._goatAutoQuestGroupLastActionAt) or 0
if now - lastAction < 4.0 then
return false, "cooldown"
end

local otherGroups =
grouping and grouping:FindFirstChild("OtherGroupsScrollingFrame", true)

local missionCard = nil
if otherGroups then
for _, obj in ipairs(otherGroups:GetDescendants()) do
if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
local okText, rawText = pcall(function() return obj.Text end)
local txt = okText and tostring(rawText or ""):lower():gsub("^%s+", ""):gsub("%s+$", "") or ""
if txt == "mission auto" then
local node = obj
while node and node.Parent and node.Parent ~= otherGroups do
if tostring(node.Name):lower():find("groupinfocard", 1, true) then
break
end
node = node.Parent
end
missionCard = node or obj.Parent
break
end
end
end
end

if not groupQuest and not missionCard then
shared._goatAutoQuestGroupCreateCandidateAt = nil
shared._goatAutoQuestGroupLastActionAt = nil
return false, "helper_no_mission_auto"
end

if missionCard then
-- Captured manual join uses:
-- GroupActionRemoteEvent:FireServer("RequestJoin", 1)
-- Prefer the real remote because GUI firesignal can report success without joining.
local directRemote = game:GetService("ReplicatedStorage"):FindFirstChild("GroupActionRemoteEvent")
if directRemote and directRemote:IsA("RemoteEvent") then
shared._goatAutoQuestGroupLastActionAt = now
local okDirect = pcall(function()
directRemote:FireServer("RequestJoin", 1)
end)

goatPrint(
"[AutoQuest][Group] mission auto • DIRECT RequestJoin(1)"
.. (groupQuest and " • own GROUP_TIME" or " • helper account")
)

if okDirect then
return true, "join_direct_1"
end
end

-- Fallback to the game's own JOIN button.
local joinButton = nil
for _, obj in ipairs(missionCard:GetDescendants()) do
if obj:IsA("GuiButton") then
local combined = tostring(obj.Name or ""):lower()
for _, child in ipairs(obj:GetDescendants()) do
if child:IsA("TextLabel") or child:IsA("TextButton") then
local okText, rawText = pcall(function() return child.Text end)
if okText then
combined = combined .. " " .. tostring(rawText or ""):lower()
end
end
end
if combined:find("join", 1, true)
or combined:find("request", 1, true)
or combined:find("entrar", 1, true)
then
joinButton = obj
break
end
end
end

if joinButton then
shared._goatAutoQuestGroupLastActionAt = now
local okJoin, joinMode = activateButton(joinButton)
goatPrint(
"[AutoQuest][Group] mission auto found • JOIN requested via GUI"
.. " • mode=" .. tostring(joinMode)
)
return okJoin == true, "join_gui"
end

-- Fallback: if the card exposes an explicit numeric group id attribute,
-- use the captured game remote: RequestJoin, <groupId>.
local groupId = nil
local probe = missionCard
for _ = 1, 3 do
if not probe then break end
for key, value in pairs(probe:GetAttributes()) do
local lk = tostring(key):lower()
if (lk == "groupid" or lk == "group_id" or lk == "id")
and tonumber(value)
then
groupId = tonumber(value)
break
end
end
if groupId then break end
probe = probe.Parent
end

if groupId then
local rs = game:GetService("ReplicatedStorage")
local remote = rs:FindFirstChild("GroupActionRemoteEvent")
if remote and remote:IsA("RemoteEvent") then
shared._goatAutoQuestGroupLastActionAt = now
local ok = pcall(function()
remote:FireServer("RequestJoin", groupId)
end)
goatPrint(
"[AutoQuest][Group] mission auto found • RequestJoin("
.. tostring(groupId) .. ")"
)
return ok, "join_remote"
end
end

goatPrint("[AutoQuest][Group] mission auto found • waiting for JOIN control/group id")
shared._goatAutoQuestGroupLastActionAt = now
return false, "group_found_waiting"
end

-- No mission-auto group is visible.
-- Helper accounts never create it; only the account that owns GROUP_TIME does.
if not groupQuest then
return false, "helper_waiting_for_group"
end

-- Use a deterministic short stagger so several GROUP_TIME accounts
-- do not all create at exactly the same time.
if shared._goatAutoQuestGroupCreateCandidateAt == nil then
local userId = tonumber(player.UserId) or 0
local stagger = 1.0 + ((userId % 9) * 0.25)
shared._goatAutoQuestGroupCreateCandidateAt = now + stagger
goatPrint(string.format(
"[AutoQuest][Group] GROUP_TIME detected • mission auto not found • create check in %.2fs",
stagger
))
return false, "create_stagger"
end

if now < shared._goatAutoQuestGroupCreateCandidateAt then
return false, "create_wait"
end

-- Re-scan one final time before creation in case another scripted account
-- created "mission auto" during our stagger.
if otherGroups then
for _, obj in ipairs(otherGroups:GetDescendants()) do
if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
local okText, rawText = pcall(function() return obj.Text end)
local txt = okText and tostring(rawText or ""):lower():gsub("^%s+", ""):gsub("%s+$", "") or ""
if txt == "mission auto" then
shared._goatAutoQuestGroupCreateCandidateAt = nil
shared._goatAutoQuestGroupLastActionAt = 0
return false, "group_appeared_rescan"
end
end
end
end

local rs = game:GetService("ReplicatedStorage")
local remote = rs:FindFirstChild("GroupActionRemoteEvent")
if not remote or not remote:IsA("RemoteEvent") then
shared._goatAutoQuestGroupCreateCandidateAt = nil
goatWarn("[AutoQuest][Group] GroupActionRemoteEvent not found")
return false, "remote_missing"
end

shared._goatAutoQuestGroupCreateCandidateAt = nil
shared._goatAutoQuestGroupLastActionAt = now

local okCreate, createErr = pcall(function()
remote:FireServer(
"Create",
{
Name = "mission auto",
Color = "Terra Cotta",
}
)
end)

if okCreate then
goatPrint("[AutoQuest][Group] mission auto CREATE requested")
return true, "create"
end

goatWarn("[AutoQuest][Group] CREATE failed:", tostring(createErr))
return false, "create_failed"
end

local function runQuestStep(quests, token)
checkMissionProgress(quests)

if shared._goatAutoQuestEnsureMissionGroup then
pcall(shared._goatAutoQuestEnsureMissionGroup, quests)
end

if shared._autoQuestSwimLock and not firstIncomplete(quests, "SWIM_DISTANCE") then
setSwimMovementLock(false)
end
maintainSurvival()

if lockedGrowQuest then
local liveGrow, foundGrow = findLockedGrowQuest(quests)

if foundGrow then
lockedGrowQuestMisses = 0

local current = tonumber(liveGrow.progressCurrent) or 0
local target = tonumber(liveGrow.progressTarget) or 0

if liveGrow.completed or (target > 0 and current >= target) then
setGrowQuestState(liveGrow, "complete", nil, nil, "contador oficial completo")
goatPrint("[AutoQuest] Locked Grow mission completed:", tostring(lockedGrowQuest.name))
lockedGrowQuest = nil
lockedGrowQuestMisses = 0
else
runGrowQuest(liveGrow, token)
return
end
else
-- A completed/claimed Grow card can disappear from the GUI.
-- The old code kept that missing mission locked forever, so
-- Auto Quest only recovered after OFF -> ON cleared the lock.
lockedGrowQuestMisses = lockedGrowQuestMisses + 1

if lockedGrowQuestMisses >= 2 then
goatPrint(
"[AutoQuest] Grow lock released after consecutive missing scans:",
tostring(lockedGrowQuest.name)
)
lockedGrowQuest = nil
lockedGrowQuestMisses = 0
shared._autoQuestGrowState = nil
-- Continue in THIS cycle and select the next mission.
else
status(
"Auto Quest • Grow",
tostring(lockedGrowQuest.category or "Quest")
.. " • atualizando missão concluída...",
Color3.fromRGB(255, 185, 70)
)
goatPrint(
"[AutoQuest] Grow scan changed — waiting one confirmation scan:",
tostring(lockedGrowQuest.name)
)
task.wait(1.5)
return
end
end
end

if game.GameId ~= 8198412649 then
local animalQuest = nil
if lockedAnimalQuest then
local liveLocked, foundLocked = findLockedAnimalQuest(quests)
if foundLocked then
lockedAnimalQuestMisses = 0

local current = tonumber(liveLocked.progressCurrent) or 0
local target = tonumber(liveLocked.progressTarget) or 0

if liveLocked.completed or (target > 0 and current >= target) then
goatPrint("[AutoQuest] Locked animal mission completed:", lockedAnimalQuest.name)
lockedAnimalQuest = nil
lockedAnimalQuestMisses = 0
else
animalQuest = liveLocked
end
else
-- If the locked card disappears because it was completed/claimed
-- or Daily/Weekly refreshed, do not hold a dead animal lock forever.
lockedAnimalQuestMisses = lockedAnimalQuestMisses + 1

-- A stale Animal lock must not leave old Zone/Travel movement active.
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

if lockedAnimalQuestMisses >= 2 then
goatPrint(
"[AutoQuest] Animal lock released after consecutive missing scans:",
tostring(lockedAnimalQuest.name)
)
lockedAnimalQuest = nil
lockedAnimalQuestMisses = 0
clearMissionHudLock()
-- Continue in this same cycle and choose a live mission.
else
status(
"Auto Quest • Animal",
tostring(lockedAnimalQuest.animal or "Animal")
.. " • atualizando missão...",
Color3.fromRGB(255, 185, 70)
)
goatPrint(
"[AutoQuest] Animal scan changed — waiting one confirmation scan:",
tostring(lockedAnimalQuest.name)
)
maintainSurvival()
task.wait(1.5)
return
end
end
end

if not animalQuest then
animalQuest = firstIncomplete(quests, "SURVIVE_TIME")
if animalQuest then
local req = extractRequiredAnimal(animalQuest.name)
lockedAnimalQuest = {
id = animalQuestIdentity(animalQuest),
name = animalQuest.name,
animal = req,
}
lockedAnimalQuestMisses = 0
goatPrint("[AutoQuest] Mission locked until completion:",
tostring(animalQuest.name))
end
end
if animalQuest then
-- SURVIVE_TIME is passive: the server keeps counting while survival systems
-- protect the animal. Never clear an active survival emergency here.
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

if runAutoQuestSurvivalPriority(false) then
task.wait(1.25)
return
end

maintainSurvival()

beginMission(animalQuest)
local required = extractRequiredAnimal(animalQuest.name)
if required then
local ch = player.Character
local current = ch and ch:GetAttribute("AnimalName") or ""

if normalizedAnimal(current) ~= normalizedAnimal(required) then
status("Auto Quest • Animal", required .. " • procurando slot salvo", Color3.fromRGB(0, 170, 255))
local ok, why = spawnExistingAnimal(required, false)
if not ok then
deferQuest(animalQuest, required .. " • " .. tostring(why), 300)
return
end

task.wait(2)
maintainSurvival()
return
end

status(
"Auto Quest • Animal",
required .. " • " .. progressText(animalQuest),
Color3.fromRGB(0, 170, 255)
)
maintainSurvival()
task.wait(4)
return
end
status("Auto Quest • Passive", animalQuest.category .. " • " .. progressText(animalQuest), Color3.fromRGB(0, 170, 255))
task.wait(4)
return
end
end -- SL/JL animal SURVIVE lock only

if not enabled or runToken ~= token then return end

local visitZonesQuest = firstIncomplete(quests, "VISIT_ZONES")
if visitZonesQuest then
runVisitZonesQuest(visitZonesQuest, token)
return
end

local zoneQuest = firstIncomplete(quests, "SURVIVE_ZONE")

if game.GameId == 8198412649 and zoneQuest then
runDLSurviveZoneQuest(zoneQuest, token)
return
end

if game.GameId == 8198412649 then
zoneQuest = nil
end

setZoneMovementLock(zoneQuest ~= nil or shared._autoQuestSwimLock == true)

if zoneQuest then
beginMission(zoneQuest)
setZoneMovementLock(true)
local zoneName = extractZone(zoneQuest.name)

-- Survival must beat passive SURVIVE_ZONE waiting.
-- Previously this shortcut returned for 4s before checking food/water priority.
if runAutoQuestSurvivalPriority(false) then
setZoneMovementLock(false)
goatPrint(
"[AutoQuest] SURVIVE_ZONE paused • survival emergency took priority | zone="
.. tostring(zoneName or zoneQuest.title or "?")
)
task.wait(0.25)
return
end

if zoneProgressIsAdvancing(zoneQuest) then
status(
"Auto Quest • Zone",
tostring(zoneName or zoneQuest.title or "zona")
.. " • dentro da zona • "
.. progressText(zoneQuest),
Color3.fromRGB(0, 170, 255)
)
task.wait(4)
return
end

local movementOk, movementSwitched = ensureMovementAnimal("indo para " .. tostring(zoneName or "zona"))
if not movementOk then
deferQuest(zoneQuest, "Lion/Impala indisponível ou spawn ainda não pronto", 300)
return
end
if movementSwitched then
return
end

openQuestCategory(zoneQuest.category)

local liveQuest = findMatchingLiveQuest(zoneQuest.category, zoneQuest) or zoneQuest
local lastProgress = tonumber(liveQuest.progressCurrent or zoneQuest.progressCurrent or 0) or 0
local routeStartedAt = os.clock()
local legsDone = 0

-- A coordinate is only accepted as the real zone after the official
-- quest counter starts moving. If it does not, reject that point
-- and automatically try another zone reference.
local arrivalTargetSig = nil
local arrivalStartedAt = 0
local arrivalStartProgress = lastProgress

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and (os.clock() - routeStartedAt) < 105
do
if globalWaterEscapeActive then
task.wait(0.35)
continue
end

if runAutoQuestSurvivalPriority(false) then
setZoneMovementLock(false)
goatPrint(
"[AutoQuest] SURVIVE_ZONE route paused • survival emergency took priority | zone="
.. tostring(zoneName or zoneQuest.title or "?")
)
task.wait(0.25)
return
end

maintainSurvival()

local refreshed = findMatchingLiveQuest(zoneQuest.category, zoneQuest)
if refreshed then
local current = tonumber(refreshed.progressCurrent or 0) or 0
local target = tonumber(refreshed.progressTarget or zoneQuest.progressTarget or 0) or 0

if current > lastProgress then
zoneProgressMemory[tostring(zoneQuest.name or zoneQuest.title or "zone")] = current
zoneInsideUntil[tostring(zoneQuest.name or zoneQuest.title or "zone")] = os.clock() + 15
status(
"Auto Quest • Zone",
tostring(zoneName or zoneQuest.title or "zona")
.. " • dentro da zona • "
.. progressText(refreshed),
Color3.fromRGB(0, 170, 255)
)
goatPrint(string.format(
"[AutoQuest] Zone progress confirmed • %s • %g/%g • movement stopped",
tostring(zoneName or "?"), current, target
))
task.wait(4)
return
end

lastProgress = current
if target > 0 and current >= target then
return
end
end

local pos, rawZonePos, zoneObj, proxyOnly = findZonePosition(zoneName)
if not pos then
local extra = rawZonePos and string.format(" (marker Y %.1f)", rawZonePos.Y) or ""
local objName = zoneObj and (" • obj=" .. tostring(zoneObj.Name)) or ""
status(
"Auto Quest • Bloqueado",
"zona sem referência utilizável: " .. tostring(zoneName or zoneQuest.title or "?") .. extra,
Color3.fromRGB(255, 185, 70)
)
goatPrint("[AutoQuest] Zone reference failed • " .. tostring(zoneName or "?") .. extra .. objName)
deferQuest(zoneQuest, "zona sem referência utilizável")
return
end

local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then
task.wait(0.5)
continue
end

local dist = (
Vector3.new(pos.X, 0, pos.Z)
- Vector3.new(root.Position.X, 0, root.Position.Z)
).Magnitude

if dist <= 30 then
local targetSig = zonePointSignature(pos)

if arrivalTargetSig ~= targetSig then
arrivalTargetSig = targetSig
arrivalStartedAt = os.clock()
arrivalStartProgress = lastProgress

local objPath = "?"
if zoneObj then
local okPath, fullName = pcall(function() return zoneObj:GetFullName() end)
objPath = okPath and fullName or tostring(zoneObj.Name)
end

goatPrint(string.format(
"[AutoQuest] Zone candidate reached • %s • obj=%s • x=%.1f z=%.1f • validating official counter",
tostring(zoneName or "?"),
tostring(objPath),
pos.X,
pos.Z
))
end

local waited = os.clock() - arrivalStartedAt
status(
"Auto Quest • Zone",
tostring(zoneName or zoneQuest.title or "zona")
.. " • validando entrada "
.. string.format("%.0fs", waited),
Color3.fromRGB(0, 170, 255)
)

-- Never wait forever on a decorative/model reference.
if waited >= 8
and lastProgress <= arrivalStartProgress
then
rejectZonePoint(zoneName, pos, 40)
zoneCache[normalizedAnimal(zoneName)] = nil

local objName = zoneObj and tostring(zoneObj.Name) or "?"
goatPrint(string.format(
"[AutoQuest] Zone candidate rejected • %s • obj=%s • contador não avançou após %.1fs • procurando outro ponto",
tostring(zoneName or "?"),
objName,
waited
))

status(
"Auto Quest • Zone",
tostring(zoneName or zoneQuest.title or "zona")
.. " • referência não ativou contador • procurando outro ponto",
Color3.fromRGB(255, 185, 70)
)

arrivalTargetSig = nil
arrivalStartedAt = 0
task.wait(0.6)
continue
end

task.wait(1.0)
continue
end

-- We are moving toward a different candidate again.
arrivalTargetSig = nil
arrivalStartedAt = 0

local leg = safeZoneLegToward(pos)
if not leg then
status(
"Auto Quest • Zone",
"sem passo terrestre seguro • procurando desvio",
Color3.fromRGB(255, 185, 70)
)
goatPrint("[AutoQuest] Zone route rejected: no safe local ground leg")
task.wait(0.8)
continue
end

legsDone = legsDone + 1
local routeMode = proxyOnly and "aproximação X/Z" or "rota terrestre"

if legsDone == 1 or legsDone % 3 == 0 then
status(
"Auto Quest • Zone",
tostring(zoneName or zoneQuest.title or "zona")
.. " • " .. math.floor(dist) .. " studs • "
.. routeMode .. " contínua",
Color3.fromRGB(0, 170, 255)
)
end

goatPrint(string.format(
"[AutoQuest] Zone continuous leg #%d • %s • dist=%d • legY=%.1f%s%s",
legsDone,
tostring(zoneName or "?"),
math.floor(dist),
leg.Y,
rawZonePos and string.format(" • markerY=%.1f", rawZonePos.Y) or "",
proxyOnly and " • proxyXZ=true" or ""
))

local moved = walkToPosition(leg)

if not moved then
task.wait(0.25)
else
task.wait(0.05)
end
end

if enabled and runToken == token and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE then
deferQuest(zoneQuest, "não conseguiu entrar na zona e ativar o contador")
end
return
end

local growQuest = firstIncomplete(quests, "GROW_TIME")
if growQuest then
lockedGrowQuest = {
id = growQuestIdentity(growQuest),
category = growQuest.category,
name = growQuest.name,
}
lockedGrowQuestMisses = 0

goatPrint(
"[AutoQuest] Grow mission locked until official completion:",
tostring(growQuest.category),
"|",
tostring(growQuest.name)
)

runGrowQuest(growQuest, token)
return
end

local swimQuest = firstIncomplete(quests, "SWIM_DISTANCE")
if swimQuest then
runSwimQuest(swimQuest, token)
return
end
setSwimMovementLock(false)

local travelQuest =
firstIncomplete(quests, "TRAVEL_DISTANCE")
or (game.GameId == 8198412649 and firstIncomplete(quests, "LAND_DISTANCE"))

if travelQuest then
beginMission(travelQuest)
local movementOk, movementSwitched = ensureMovementAnimal("missão de distância")
if not movementOk then
deferQuest(
travelQuest,
game.GameId == 8198412649
and "Gallimimus/Velociraptor indisponível ou spawn ainda não pronto"
or "Lion/Impala indisponível ou spawn ainda não pronto",
300
)
return
end
if movementSwitched then
setTravelMovementLock(false)
return
end

setTravelMovementLock(true)
openQuestCategory(travelQuest.category)

local startedAt = os.clock()
local legs = 0
local lastRootPos = nil
local stuckLegs = 0

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and (os.clock() - startedAt) < 75
do
if globalWaterEscapeActive then
task.wait(0.35)
continue
end

if runAutoQuestSurvivalPriority(false) then
task.wait(2.5)
return
end

local liveTravel = findMatchingLiveQuest(travelQuest.category, travelQuest)
if liveTravel then
travelQuest = liveTravel
checkMissionProgress({liveTravel})
if liveTravel.completed or not activeMission then break end
end
maintainSurvival()

local ch = player.Character
local root = ch and ch:FindFirstChild("HumanoidRootPart")
if not root then
task.wait(0.5)
continue
end

if ch:GetAttribute("_drinkingToFull")
or ch:GetAttribute("_returningToLand")
or ch:GetAttribute("_carcassInteractionLock")
then
task.wait(0.5)
continue
end

local point = travelLongPoint()
if not point then
status(
"Auto Quest • Travel",
"procurando destino para missão de distância...",
Color3.fromRGB(255, 185, 70)
)
task.wait(0.6)
continue
end

legs = legs + 1
local travelCharacter = player.Character
local travelAnimal = travelCharacter and travelCharacter:GetAttribute("AnimalName") or "?"
status(
"Auto Quest • Travel",
travelQuest.category .. " • " .. progressText(travelQuest)
.. " • " .. tostring(travelAnimal) .. " • Spawn Beach + ground follow",
Color3.fromRGB(0, 170, 255)
)

local before = root.Position

local moved, movedStuds, moveReason = beachMotorTravelTo(point, 55)
task.wait(moved and 0.08 or 0.3)

ch = player.Character
root = ch and ch:FindFirstChild("HumanoidRootPart")
if root then
local delta = math.max(
tonumber(movedStuds) or 0,
(root.Position - before).Magnitude
)

if delta < 8 then
stuckLegs = stuckLegs + 1
goatPrint("[AutoQuest] Travel motor falhou • " .. tostring(moveReason))
else
stuckLegs = 0
goatPrint(string.format(
"[AutoQuest] Travel motor • +%.1f studs • %s",
delta,
tostring(moveReason)
))
end

if lastRootPos and (root.Position - lastRootPos).Magnitude < 3 then
stuckLegs = stuckLegs + 1
end
lastRootPos = root.Position

if stuckLegs >= 3 then
travelStep = (travelStep + 2) % 8
stuckLegs = 0
goatPrint("[AutoQuest] Travel motor • mudando direção")
end
end
end

setTravelMovementLock(false)
return
else
setTravelMovementLock(false)
end

local playQuest =
firstIncomplete(quests, "PLAY_TIME")
or firstIncomplete(quests, "MAINTAIN_STATS")
or firstIncomplete(quests, "DRINK")
or firstIncomplete(quests, "EAT")
or (game.GameId == 8198412649 and firstIncomplete(quests, "SURVIVE_TIME"))
or (game.GameId == 8198412649 and firstIncomplete(quests, "NIGHT_OWL"))

if playQuest then
beginMission(playQuest)
maintainSurvival()
status(
"Auto Quest • Passive",
tostring(playQuest.questType or "PASSIVE")
.. " • "
.. tostring(playQuest.category)
.. " • "
.. progressText(playQuest),
Color3.fromRGB(0, 170, 255)
)
task.wait(4)
return
end

-- GROUP_TIME automation runs in parallel above: join/create "mission auto" only while the quest exists.

clearMissionHudLock()
local pendingCount, nextRetry = 0, nil
local now = os.clock()
for _, q in ipairs(quests) do
if not q.completed then
pendingCount = pendingCount + 1
local pending = deferredQuests[missionIdentity(q)]
if pending and pending.retryAt > now then
nextRetry = math.min(nextRetry or pending.retryAt, pending.retryAt)
end
end
end
activeMission = nil
status("Auto Quest",
pendingCount > 0
and (tostring(pendingCount) .. " missão(ões) pendente(s) • "
.. (nextRetry and ("nova tentativa em " .. math.ceil(nextRetry - now) .. "s")
or "aguardando requisitos/progresso; Group auto ativo quando necessário"))
or "Todas as missões concluídas/aguardando claim",
Color3.fromRGB(65, 220, 150))
task.wait(5)
end

-- A skip must immediately advance using this same Daily/Weekly snapshot.
-- No rescanning or re-claiming between failed candidates.
local function runAvailableQuestStep(quests, token)
if shared._characterTransitionLock == true then
goatPrint(
"[AutoQuest] Parallel mission blocked • CHARACTER TRANSITION active | owner="
.. tostring(shared._characterTransitionOwner or "?")
.. " | target="
.. tostring(shared._characterTransitionTarget or "?")
)
task.wait(0.5)
return
end

if shared._autoQuestVisitZonesExclusive == true
and shared._autoQuestVisitZonesExclusiveToken ~= nil
and token ~= shared._autoQuestVisitZonesExclusiveToken
then
goatPrint(
"[AutoQuest] Parallel worker blocked • VISIT_ZONES exclusive token="
.. tostring(shared._autoQuestVisitZonesExclusiveToken)
.. " • workerToken="
.. tostring(token)
)
return
end

for attempt = 1, #quests + 1 do
if not enabled or runToken ~= token
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then
return
end
local beforeSkip = deferralSerial
local stepOk, stepError = xpcall(function()
runQuestStep(quests, token)
end, function(err) return tostring(err) end)
if not stepOk then
goatWarn("[AutoQuest] Mission step failed:", tostring(stepError))
if activeMission then
deferQuest(activeMission.quest, "erro ao executar missão; tentativa adiada")
elseif deferralSerial == beforeSkip then
return
end
end
if deferralSerial == beforeSkip then
return -- A mission started, is advancing, or all are pending.
end
goatPrint("[AutoQuest] Skip confirmed • selecting next mission NOW • attempt " .. tostring(attempt))
end
end

local function primeMissionHudLock(quests)
local q = firstIncomplete(quests, "SURVIVE_TIME")
if q then
local required = extractRequiredAnimal(q.name) or (q.title or "Animal")
local action = "Auto Quest • Animal"
local detail = tostring(required) .. " • " .. progressText(q)
local color = Color3.fromRGB(0, 170, 255)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

q = firstIncomplete(quests, "VISIT_ZONES")
if q then
local action = "Auto Quest • Visit Zones"
local detail = tostring(q.category or "Quest") .. " • " .. progressText(q)
local color = Color3.fromRGB(0, 170, 255)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

q = firstIncomplete(quests, "SURVIVE_ZONE")
if q then
local zone = extractZone(q.name) or q.title or "Zona"
local action = "Auto Quest • Zone"
local detail = tostring(zone) .. " • " .. progressText(q)
local color = Color3.fromRGB(0, 170, 255)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

q = firstIncomplete(quests, "GROW_TIME")
if q then
local pct = currentGrowthPercent()
local ch = player.Character
local animal = ch and tostring(ch:GetAttribute("AnimalName") or "?") or "?"
local paused = pct and pct >= 99.5
local action = "Auto Quest • Grow"
local detail = q.category .. " • " .. progressText(q)
.. " • " .. growRemainingText(q)
.. (paused
and " • animal 100% — procurando slot <100%"
or (" • " .. animal .. " G" .. string.format("%.0f%%", pct or 0) .. " • CRESCENDO"))
local color = paused and Color3.fromRGB(255, 185, 70) or Color3.fromRGB(0, 170, 255)

setGrowQuestState(q, paused and "switching" or "active", animal, pct, nil)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

q =
firstIncomplete(quests, "TRAVEL_DISTANCE")
or (game.GameId == 8198412649 and firstIncomplete(quests, "LAND_DISTANCE"))

if q then
local action, detail, color = "Auto Quest • Travel", q.category .. " • " .. progressText(q), Color3.fromRGB(0, 170, 255)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

q =
firstIncomplete(quests, "PLAY_TIME")
or firstIncomplete(quests, "MAINTAIN_STATS")
or firstIncomplete(quests, "DRINK")
or firstIncomplete(quests, "EAT")
or (game.GameId == 8198412649 and firstIncomplete(quests, "SURVIVE_TIME"))
or (game.GameId == 8198412649 and firstIncomplete(quests, "NIGHT_OWL"))

if q then
local action, detail, color =
"Auto Quest • Passive",
tostring(q.questType or "PASSIVE") .. " • " .. q.category .. " • " .. progressText(q),
Color3.fromRGB(0, 170, 255)
shared._autoQuestHudLock = {action = action, detail = detail, color = color}
if shared._goatHudSetStatus then
local okHud = pcall(shared._goatHudSetStatus, action, detail, color)
if not okHud then
shared._autoQuestPendingHud = {
action = action,
detail = detail,
color = color,
}
end
end
return
end

clearMissionHudLock()
end

local function startLoop()
if shared._autoQuestVisitZonesExclusive == true
and shared._autoQuestVisitZonesExclusiveToken ~= nil
and enabled
then
goatPrint("[AutoQuest] Worker restart BLOCKED • VISIT_ZONES exclusive route active")
return
end

runToken = runToken + 1
local token = runToken

shared._autoQuestWorkerGeneration = (shared._autoQuestWorkerGeneration or 0) + 1
local workerGeneration = shared._autoQuestWorkerGeneration

task.spawn(function()
status(
"Auto Quest",
"Lendo Daily + Weekly... • worker " .. tostring(workerGeneration),
Color3.fromRGB(0, 170, 255)
)

while enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._autoQuestWorkerGeneration == workerGeneration
do
local cycleOk, cycleErr = xpcall(function()

-- ================================================================
-- SAVANNAH LIFE AUTO QUEST DEATH / MENU RECOVERY
-- If the quest animal dies, Savannah can leave the account on the
-- Characters menu while AutoQuest continues scanning GUI cards.
-- Remember the last live slot and respawn it automatically.
-- ================================================================
if shared._goatIsSavannahLifeGame
and shared._goatIsSavannahLifeGame()
then
local slCh = player.Character
local slHum = slCh and slCh:FindFirstChildOfClass("Humanoid")
local slRoot = slCh and slCh:FindFirstChild("HumanoidRootPart")
local slCharacterName =
slCh
and tostring(slCh:GetAttribute("CharacterName") or "")
or ""
local slAnimalName =
slCh
and tostring(slCh:GetAttribute("AnimalName") or "")
or ""

if slCh
and slHum
and slHum.Health > 0
and slRoot
then
if slCharacterName ~= "" then
shared._slAutoQuestLastCharacterName = slCharacterName
end
if slAnimalName ~= "" then
shared._slAutoQuestLastAnimalName = slAnimalName
end

if slCharacterName ~= "" or slAnimalName ~= "" then
shared._slAutoQuestPersistentSlot = {
CharacterName = slCharacterName,
AnimalName = slAnimalName,
updatedAt = os.time(),
}

pcall(function()
if type(getgenv) == "function" then
getgenv().THE_GOAT_SL_AUTOQUEST_LAST_SLOT =
shared._slAutoQuestPersistentSlot
end
end)
end
else
clearMissionHudLock()
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
stopNativeTravel()

status(
"Auto Quest • SL",
"animal ausente/morto • recuperando slot salvo",
Color3.fromRGB(255, 120, 80)
)

if not shared._slAutoQuestRespawning then
shared._slAutoQuestRespawning = true
shared._slAutoQuestRespawnGeneration =
(tonumber(shared._slAutoQuestRespawnGeneration) or 0) + 1

local slRecoveryGeneration = shared._slAutoQuestRespawnGeneration

task.spawn(function()
local recoveryTarget = nil
local recoveryReason = nil

-- Savannah menu/spawn state needs a moment to finish rebuilding after death.
task.wait(0.75)

if not enabled
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
or shared._slAutoQuestRespawnGeneration ~= slRecoveryGeneration
then
shared._slAutoQuestRespawning = false
return
end

local syncOk, records = pcall(function()
if type(shared._syncSavedCharacterRecords) ~= "function" then
return nil
end
return shared._syncSavedCharacterRecords(true)
end)

if syncOk and type(records) == "table" then
local persistedSlot = shared._slAutoQuestPersistentSlot

if type(persistedSlot) ~= "table" then
pcall(function()
if type(getgenv) == "function"
and type(getgenv().THE_GOAT_SL_AUTOQUEST_LAST_SLOT) == "table"
then
persistedSlot = getgenv().THE_GOAT_SL_AUTOQUEST_LAST_SLOT
shared._slAutoQuestPersistentSlot = persistedSlot
end
end)
end

local wantedCharacter =
tostring(
shared._slAutoQuestLastCharacterName
or (type(persistedSlot) == "table" and persistedSlot.CharacterName)
or ""
)

if wantedCharacter ~= "" then
for _, entry in ipairs(records) do
if type(entry) == "table"
and tostring(entry.CharacterName or "") == wantedCharacter
then
recoveryTarget = entry
recoveryReason = "AFK-style exact remembered slot"
break
end
end
end
end

if not enabled
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
or shared._slAutoQuestRespawnGeneration ~= slRecoveryGeneration
then
shared._slAutoQuestRespawning = false
return
end

if not recoveryTarget then
goatWarn(
"[AutoQuest][SL] AFK-style recovery blocked • exact remembered slot unavailable"
)

-- Stop this worker so it cannot re-enter the missing-character branch every second.
runToken = runToken + 1
shared._autoQuestWorkerGeneration =
(tonumber(shared._autoQuestWorkerGeneration) or 0) + 1

goatPrint("[AutoQuest][SL] Recovery cooldown • exact slot unavailable • retry in 5s")

task.delay(5.0, function()
shared._slAutoQuestRespawning = false
if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._slAutoQuestDeathSignalBusy == true
then
startLoop()
end
end)

return
end

local targetName = tostring(recoveryTarget.CharacterName or "?")
local targetAnimal = tostring(recoveryTarget.AnimalName or "?")

goatPrint(
"[AutoQuest][SL] Death/menu recovery target • "
.. targetAnimal .. " | " .. targetName
.. " | " .. tostring(recoveryReason)
)

setAutoQuestAnimalSwitchExclusive(true, targetName)

local spawnOk = false
local spawnErr = nil

if type(shared._spawnAndSetup) == "function" then
local callOk, callResult = pcall(
shared._spawnAndSetup,
recoveryTarget
)

if callOk then
spawnOk = callResult == true
else
spawnErr = callResult
end
else
spawnErr = "GrowthLoop spawn helper unavailable"
end

task.wait(0.75)

local live = player.Character
local liveHum = live and live:FindFirstChildOfClass("Humanoid")
local liveRoot = live and live:FindFirstChild("HumanoidRootPart")
local liveName =
live
and tostring(live:GetAttribute("CharacterName") or "")
or ""

local confirmed =
spawnOk
and live ~= nil
and liveHum ~= nil
and liveHum.Health > 0
and liveRoot ~= nil
and (
targetName == "?"
or liveName == targetName
)

setAutoQuestAnimalSwitchExclusive(false, targetName)

if confirmed then
shared._slAutoQuestLastCharacterName = liveName ~= "" and liveName or targetName
shared._slAutoQuestLastAnimalName =
tostring(live:GetAttribute("AnimalName") or targetAnimal)

shared._slAutoQuestPersistentSlot = {
CharacterName = shared._slAutoQuestLastCharacterName,
AnimalName = shared._slAutoQuestLastAnimalName,
updatedAt = os.time(),
}

pcall(function()
if type(getgenv) == "function" then
getgenv().THE_GOAT_SL_AUTOQUEST_LAST_SLOT =
shared._slAutoQuestPersistentSlot
end
end)

goatPrint(
"[AutoQuest][SL] Death/menu recovery SUCCESS • "
.. tostring(shared._slAutoQuestLastAnimalName)
.. " | "
.. tostring(shared._slAutoQuestLastCharacterName)
)

-- Savannah can occasionally leave the old main/Characters menu rendered
-- even though the backend spawn is already confirmed. Clean ONLY the stale
-- overlay after a verified death recovery; never click PLAY and never respawn.
task.spawn(function()
for cleanupAttempt = 1, 8 do
local current = player.Character
local currentHum = current and current:FindFirstChildOfClass("Humanoid")
local currentRoot = current and current:FindFirstChild("HumanoidRootPart")
local currentName = current and tostring(current:GetAttribute("CharacterName") or "") or ""

if not current
or not currentHum
or currentHum.Health <= 0
or not currentRoot
or currentName ~= tostring(shared._slAutoQuestLastCharacterName or "")
then
return
end

local cleaned = false
local pg = player:FindFirstChildOfClass("PlayerGui")

if pg then
-- Explicit Characters overlay, if Savannah left it behind.
local savedMenu = pg:FindFirstChild("SavedCharactersMenu", true)
if savedMenu then
pcall(function()
if savedMenu:IsA("ScreenGui") then
savedMenu.Enabled = false
elseif savedMenu:IsA("GuiObject") then
savedMenu.Visible = false
end
end)
cleaned = true
end

-- Main Savannah menu: identify it by a visible JOGAR/PLAY button and hide
-- only that button's top UI container. THE GOAT panel is not touched.
for _, obj in ipairs(pg:GetDescendants()) do
if obj:IsA("TextButton") then
local txt = string.lower(tostring(obj.Text or ""))
if txt == "jogar" or txt == "play" then
local top = obj
local cur = obj

while cur and cur.Parent and cur.Parent ~= pg do
cur = cur.Parent
if cur:IsA("ScreenGui") then
top = cur
break
elseif cur:IsA("GuiObject") then
top = cur
end
end

pcall(function()
if top:IsA("ScreenGui") then
top.Enabled = false
elseif top:IsA("GuiObject") then
top.Visible = false
end
end)

cleaned = true
break
end
end
end
end

-- Also clear the cached menu reference so future legitimate menu flows
-- resolve a fresh instance instead of reusing the stale overlay.
if cleaned then
shared._savedCharactersMenu = nil
if cleanupAttempt == 1 then
goatPrint("[AutoQuest][SL] Stale menu overlay cleaned after confirmed recovery")
end
end

task.wait(0.25)
end
end)

do
local restoredAnimal =
tostring(live:GetAttribute("AnimalName") or targetAnimal or "")
local restoredCarnivore =
shared._isCarnivoreName
and shared._isCarnivoreName(restoredAnimal)
or false

if restoredCarnivore then
if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, false)
end
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, true)
end
else
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, false)
end
if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, true)
end
end

if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, true)
end
end

status(
"Auto Quest • SL",
"animal recuperado • novo ciclo limpo",
Color3.fromRGB(80, 220, 120)
)

goatPrint("[AutoQuest][SL] AFK-style recovery COMPLETE • fresh worker starting")

shared._slAutoQuestDeathSignalBusy = false
shared._slAutoQuestImmediateDeathReason = nil

runToken = runToken + 1
shared._autoQuestWorkerGeneration =
(tonumber(shared._autoQuestWorkerGeneration) or 0) + 1
shared._slAutoQuestRespawning = false

task.defer(function()
if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
then
startLoop()
end
end)
else
goatWarn(
"[AutoQuest][SL] Death/menu recovery FAILED • target="
.. targetName
.. " | current="
.. tostring(liveName ~= "" and liveName or "nil/menu")
.. " | error="
.. tostring(spawnErr or "spawn/verification failed")
)

-- Do not keep selecting/clicking the same slot every worker tick.
-- Kill the current worker and allow one clean retry after a cooldown.
runToken = runToken + 1
shared._autoQuestWorkerGeneration =
(tonumber(shared._autoQuestWorkerGeneration) or 0) + 1

goatPrint("[AutoQuest][SL] Recovery cooldown • spawn not confirmed • retry in 5s")

task.delay(5.0, function()
shared._slAutoQuestRespawning = false
if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._slAutoQuestDeathSignalBusy == true
then
startLoop()
end
end)

return
end

shared._slAutoQuestRespawning = false
end)
end

task.wait(1)
return
end
end

if game.GameId == 8198412649 then
local ch = player.Character
local hum = ch and ch:FindFirstChildOfClass("Humanoid")
local root = ch and ch:FindFirstChild("HumanoidRootPart")
local animalName = ch and tostring(ch:GetAttribute("AnimalName") or "") or ""

if not ch
or not hum
or hum.Health <= 0
or not root
then
clearMissionHudLock()
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

status(
"Auto Quest • DL",
"sem personagem • iniciando respawn automático",
Color3.fromRGB(255, 120, 80)
)

if not shared._dlAutoQuestRespawning
and type(pauseDLQuestForRespawn) == "function"
then
pauseDLQuestForRespawn("worker preflight missing character", ch)
end

task.wait(1)
return
end

-- AnimalName may arrive a little after Character/Root. Do not classify this as
-- a death or restart loop; simply wait for attributes to replicate.
if animalName == "" then
status(
"Auto Quest • DL",
"personagem voltou • aguardando AnimalName",
Color3.fromRGB(255, 185, 70)
)
task.wait(0.5)
return
end
end

local quests = scanAll(token)
if not enabled
or runToken ~= token
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
or shared._autoQuestWorkerGeneration ~= workerGeneration
then
return
end

if #quests == 0 then
setSwimMovementLock(false)
clearMissionHudLock()
status(
"Auto Quest",
"Quest GUI não respondeu; tentando novamente",
Color3.fromRGB(255, 185, 70)
)
task.wait(4)
return
end

local daily, weekly = 0, 0
for _, q in ipairs(quests) do
if q.category == "Daily" then
daily = daily + 1
else
weekly = weekly + 1
end
end

goatPrint(string.format(
"[AutoQuest] Scan: %d Daily + %d Weekly",
daily,
weekly
))

for _, q in ipairs(quests) do
goatPrint(string.format(
"[AutoQuest] [%s] %s | %s | %s | done=%s",
q.category,
q.questType,
q.name,
progressText(q),
tostring(q.completed)
))
end

local claimed = claimCompleted(quests, token)
if claimed then
-- Claiming can remove/rebuild the card immediately.
-- Never run the next mission from the pre-claim snapshot.
task.wait(1.25)

local refreshedQuests = scanAll(token)
if #refreshedQuests > 0 then
quests = refreshedQuests
goatPrint("[AutoQuest] Post-claim rescan complete — selecting next mission")
end
end

if enabled
and runToken == token
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._autoQuestWorkerGeneration == workerGeneration
then
runAvailableQuestStep(quests, token)
end
end, function(err)
local trace = tostring(err)
if debug and type(debug.traceback) == "function" then
local okTrace, tb = pcall(debug.traceback, tostring(err), 2)
if okTrace and tb then trace = tb end
end
return trace
end)

if not cycleOk then
goatWarn("[AutoQuest] Cycle error — worker recovered automatically:")
goatWarn(tostring(cycleErr))
shared._autoQuestLastCycleError = tostring(cycleErr)
if enabled and runToken == token and activeMission then
deferQuest(activeMission.quest, "erro ao executar missão; tentativa adiada")
end

task.wait(2)
end
end

goatPrint("[AutoQuest] Worker stopped | enabled=" .. tostring(enabled)
.. " | token=" .. tostring(token)
.. " | currentToken=" .. tostring(runToken)
.. " | worker=" .. tostring(workerGeneration)
.. " | activeWorker=" .. tostring(shared._autoQuestWorkerGeneration))
end)
end

-- ================================================================
-- SAVANNAH LIFE IMMEDIATE DEATH WATCHER
-- Detect death/removal immediately and wake the existing recovery flow.
-- Intentional AutoQuest animal switches are ignored.
-- ================================================================
if shared._goatIsSavannahLifeGame
and shared._goatIsSavannahLifeGame()
then
shared._slAutoQuestDeathSignalBusy =
shared._slAutoQuestDeathSignalBusy == true

shared._slAutoQuestHardDeathReset = function(reason)
if not enabled then return false end

runToken = runToken + 1
shared._autoQuestWorkerGeneration =
(tonumber(shared._autoQuestWorkerGeneration) or 0) + 1

shared._existingUiAbortGeneration =
(tonumber(shared._existingUiAbortGeneration) or 0) + 1
shared._spawnBeachGeneration =
(tonumber(shared._spawnBeachGeneration) or 0) + 1
shared._animalWalkGeneration =
(tonumber(shared._animalWalkGeneration) or 0) + 1

autoQuestSurvivalPriority = false
activeMission = nil
lockedGrowQuest = nil
lockedGrowQuestMisses = 0
lockedAnimalQuest = nil
lockedAnimalQuestMisses = 0
shared._autoQuestGrowState = nil
deferredQuests = {}

shared._autoQuestVisitZonesLock = false
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil

setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, false)
end
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, false)
end
if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, false)
end

clearMissionHudLock()
shared._slAutoQuestRespawning = false

goatPrint(
"[AutoQuest][SL] HARD DEATH RESET • old quest worker cancelled | reason="
.. tostring(reason or "?")
.. " | worker="
.. tostring(shared._autoQuestWorkerGeneration)
)

return true
end

shared._slAutoQuestBindDeathWatcher = function(character)
if not character then return end

local hum = character:FindFirstChildOfClass("Humanoid")
if not hum then
hum = character:WaitForChild("Humanoid", 5)
end
if not hum then return end

trackRuntimeConnection(hum.Died:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
if not enabled then return end
if shared._autoQuestAnimalSwitchLock then return end
if shared._slAutoQuestDeathSignalBusy then return end

local rememberedName =
tostring(character:GetAttribute("CharacterName") or "")
local rememberedAnimal =
tostring(character:GetAttribute("AnimalName") or "")

if rememberedName ~= "" then
shared._slAutoQuestLastCharacterName = rememberedName
end
if rememberedAnimal ~= "" then
shared._slAutoQuestLastAnimalName = rememberedAnimal
end

shared._slAutoQuestPersistentSlot = {
CharacterName = rememberedName,
AnimalName = rememberedAnimal,
updatedAt = os.time(),
}

pcall(function()
if type(getgenv) == "function" then
getgenv().THE_GOAT_SL_AUTOQUEST_LAST_SLOT =
shared._slAutoQuestPersistentSlot
end
end)

shared._slAutoQuestDeathSignalBusy = true
shared._slAutoQuestImmediateDeathReason = "Humanoid.Died"

if type(shared._slAutoQuestHardDeathReset) == "function" then
shared._slAutoQuestHardDeathReset("Humanoid.Died")
end

goatWarn(string.format(
"[AutoQuest][SL] IMMEDIATE DEATH • AFK-style recovery | slot=%s | animal=%s",
rememberedName ~= "" and rememberedName or "?",
rememberedAnimal ~= "" and rememberedAnimal or "?"
))

task.delay(20.0, function()
if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._slAutoQuestDeathSignalBusy == true
then
goatPrint("[AutoQuest][SL] AFK-style 20s settle complete • starting exact-slot recovery")
startLoop()
end
end)
end))
end

trackRuntimeConnection(player.CharacterRemoving:Connect(function(character)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
if not enabled then return end

if shared._characterTransitionLock == true
and shared._expectedCharacterRemoving == true
then
goatPrint(
"[AutoQuest][SL] CharacterRemoving EXPECTED • owner="
.. tostring(shared._characterTransitionOwner or "?")
.. " | target="
.. tostring(shared._characterTransitionTarget or "?")
.. " • Death Recovery ignored"
)
shared._expectedCharacterRemoving = false
return
end

if shared._autoQuestAnimalSwitchLock then return end
if shared._slAutoQuestDeathSignalBusy then return end

local hum = character and character:FindFirstChildOfClass("Humanoid")

-- CharacterRemoving is only treated as death/menu recovery when the
-- humanoid is already dead or invalid. Normal intentional switches stay untouched.
if hum and hum.Health > 0 then return end

shared._slAutoQuestDeathSignalBusy = true
shared._slAutoQuestImmediateDeathReason = "CharacterRemoving"

if type(shared._slAutoQuestHardDeathReset) == "function" then
shared._slAutoQuestHardDeathReset("CharacterRemoving")
end

goatWarn("[AutoQuest][SL] Character removed after death • AFK-style recovery")

task.delay(20.0, function()
if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and shared._slAutoQuestDeathSignalBusy == true
and shared._slAutoQuestRespawning ~= true
then
goatPrint("[AutoQuest][SL] CharacterRemoving 20s settle complete • starting exact-slot recovery")
startLoop()
end
end)
end))

trackRuntimeConnection(player.CharacterAdded:Connect(function(character)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end

shared._slAutoQuestDeathSignalBusy = false

task.spawn(function()
local hum = character:WaitForChild("Humanoid", 8)
if hum
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and type(shared._slAutoQuestBindDeathWatcher) == "function"
then
shared._slAutoQuestBindDeathWatcher(character)
end
end)
end))

if player.Character then
task.spawn(function()
if type(shared._slAutoQuestBindDeathWatcher) == "function" then
shared._slAutoQuestBindDeathWatcher(player.Character)
end
end)
end
end

-- ================================================================
-- DINO LIFE AUTO QUEST RESPAWN CONTROLLER
-- Keeps the toggle ON and actively respawns the SAME saved slot.
-- SL/JL are intentionally untouched.
-- ================================================================
if game.GameId == 8198412649 then
shared._dlAutoQuestRespawning = shared._dlAutoQuestRespawning == true
shared._dlAutoQuestRespawnGeneration = tonumber(shared._dlAutoQuestRespawnGeneration) or 0
shared._dlAutoQuestLastCharacterName = shared._dlAutoQuestLastCharacterName
shared._dlAutoQuestLastAnimalName = shared._dlAutoQuestLastAnimalName

local function rememberDLQuestCharacter(character)
if not character then return end

local characterName = tostring(character:GetAttribute("CharacterName") or "")
local animalName = tostring(character:GetAttribute("AnimalName") or "")

if characterName ~= "" then
shared._dlAutoQuestLastCharacterName = characterName
end
if animalName ~= "" then
shared._dlAutoQuestLastAnimalName = animalName
end
end

local function dlAutoQuestCharacterReady(character)
if not character or character ~= player.Character then
return false
end

local hum = character:FindFirstChildOfClass("Humanoid")
local root = character:FindFirstChild("HumanoidRootPart")

return hum ~= nil
and hum.Health > 0
and root ~= nil
end

local function findDLRespawnSlot()
if type(shared._syncSavedCharacterRecords) ~= "function" then
return nil, "SavedCharacters sync unavailable"
end

local ok, records = pcall(shared._syncSavedCharacterRecords, true)
if not ok or type(records) ~= "table" then
return nil, "SavedCharacters unavailable"
end

local wantedCharacter = tostring(shared._dlAutoQuestLastCharacterName or "")
local wantedAnimal = tostring(shared._dlAutoQuestLastAnimalName or "")
local growthTrackedCharacter = tostring(shared._currentGrowthName or "")

-- First priority: exact same CharacterName/slot remembered by Auto Quest.
if wantedCharacter ~= "" then
for _, entry in ipairs(records) do
if type(entry) == "table"
and tostring(entry.CharacterName or "") == wantedCharacter
then
return entry, "exact remembered slot"
end
end
end

-- Second priority: slot already tracked by the GrowthLoop.
-- This also helps if the script was reinjected while the player was dead/menu.
if growthTrackedCharacter ~= "" then
for _, entry in ipairs(records) do
if type(entry) == "table"
and tostring(entry.CharacterName or "") == growthTrackedCharacter
then
return entry, "GrowthLoop tracked slot"
end
end
end

-- Fallback: same dinosaur type if the exact CharacterName was not available.
if wantedAnimal ~= "" then
local normalizedWanted = normalizedAnimal(wantedAnimal)
for _, entry in ipairs(records) do
if type(entry) == "table"
and normalizedAnimal(entry.AnimalName or "") == normalizedWanted
then
return entry, "same animal fallback"
end
end
end

-- Last-resort DL recovery: if this script instance was injected while already
-- dead/menu and no previous CharacterName could be observed, respawn a saved slot
-- instead of waiting forever. Prefer an incomplete slot when available.
local firstSaved = nil
for _, entry in ipairs(records) do
if type(entry) == "table"
and tostring(entry.CharacterName or "") ~= ""
then
firstSaved = firstSaved or entry

local growth = tonumber(entry.GrowthPercentage)
local pct = growth and (growth <= 1.05 and growth * 100 or growth) or 0

if pct < 99.5 then
return entry, "menu fallback incomplete saved slot"
end
end
end

if firstSaved then
return firstSaved, "menu fallback first saved slot"
end

return nil, "saved slot not found"
end

local function waitDLRespawnReady(seconds)
local deadline = os.clock() + (tonumber(seconds) or 12)

while enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and os.clock() < deadline
do
local ch = player.Character
if dlAutoQuestCharacterReady(ch) then
rememberDLQuestCharacter(ch)
return ch
end
task.wait(0.30)
end

return nil
end

local function activelyRespawnDLQuestSlot(generation)
task.spawn(function()
task.wait(1.5)

for attempt = 1, 3 do
if not enabled
or shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE
or generation ~= shared._dlAutoQuestRespawnGeneration
then
return
end

-- If the game respawned us by itself meanwhile, just resume.
local existing = player.Character
if dlAutoQuestCharacterReady(existing) then
rememberDLQuestCharacter(existing)
shared._dlAutoQuestRespawning = false

goatPrint(string.format(
"[AutoQuest][DL] RESPAWN OK automatically | animal=%s | slot=%s",
tostring(existing:GetAttribute("AnimalName") or "?"),
tostring(existing:GetAttribute("CharacterName") or "?")
))

startLoop()
return
end

local entry, source = findDLRespawnSlot()

if not entry then
goatWarn(string.format(
"[AutoQuest][DL] Respawn attempt %d/3 — %s",
attempt,
tostring(source)
))
task.wait(2)
continue
end

status(
"Auto Quest • DL",
string.format(
"respawn %d/3 • %s",
attempt,
tostring(entry.CharacterName or entry.AnimalName or "slot")
),
Color3.fromRGB(255, 185, 70)
)

goatPrint(string.format(
"[AutoQuest][DL] RESPAWN attempt %d/3 | source=%s | slot=%s | animal=%s",
attempt,
tostring(source),
tostring(entry.CharacterName or "?"),
tostring(entry.AnimalName or "?")
))

local spawnOk = false

if type(shared._spawnAndSetup) == "function" then
local okSpawn, result = pcall(shared._spawnAndSetup, entry)
spawnOk = okSpawn and result == true

if not okSpawn then
goatWarn("[AutoQuest][DL] _spawnAndSetup error:", tostring(result))
end
else
goatWarn("[AutoQuest][DL] _spawnAndSetup unavailable")
end

local restored = waitDLRespawnReady(spawnOk and 14 or 6)

if restored then
rememberDLQuestCharacter(restored)
shared._dlAutoQuestRespawning = false
clearMissionHudLock()

status(
"Auto Quest • DL",
"RESPAWN OK • retomando Daily + Weekly",
Color3.fromRGB(0, 170, 255)
)

goatPrint(string.format(
"[AutoQuest][DL] RESPAWN OK — same slot restored | animal=%s | slot=%s",
tostring(restored:GetAttribute("AnimalName") or "?"),
tostring(restored:GetAttribute("CharacterName") or "?")
))

startLoop()
return
end

goatWarn(string.format(
"[AutoQuest][DL] RESPAWN attempt %d/3 failed | slot=%s",
attempt,
tostring(entry.CharacterName or "?")
))

task.wait(1.5)
end

if enabled
and shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE
and generation == shared._dlAutoQuestRespawnGeneration
then
status(
"Auto Quest • DL",
"respawn automático falhou • aguardando personagem",
Color3.fromRGB(255, 120, 80)
)
goatWarn("[AutoQuest][DL] Automatic respawn exhausted 3 attempts")
end
end)
end

pauseDLQuestForRespawn = function(reason, lostCharacter)
if not enabled then return end

rememberDLQuestCharacter(lostCharacter or player.Character)

if shared._dlAutoQuestRespawning then
return
end

shared._dlAutoQuestRespawning = true
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
shared._dlAutoQuestRespawnGeneration =
(tonumber(shared._dlAutoQuestRespawnGeneration) or 0) + 1

local generation = shared._dlAutoQuestRespawnGeneration

-- Invalidate current worker immediately, but DO NOT disable Auto Quest.
runToken = runToken + 1
shared._autoQuestWorkerGeneration = (shared._autoQuestWorkerGeneration or 0) + 1
autoQuestSurvivalPriority = false
activeMission = nil

setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()

shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

clearMissionHudLock()

status(
"Auto Quest • DL",
"morreu • respawnando mesmo slot...",
Color3.fromRGB(255, 120, 80)
)

goatWarn(string.format(
"[AutoQuest][DL] Character lost — starting SAME SLOT respawn | reason=%s | slot=%s | animal=%s",
tostring(reason or "character removed"),
tostring(shared._dlAutoQuestLastCharacterName or "?"),
tostring(shared._dlAutoQuestLastAnimalName or "?")
))

activelyRespawnDLQuestSlot(generation)
end

-- Continuously remember the current slot while alive.
task.spawn(function()
while shared._THEGOAT_SCRIPT_INSTANCE == SCRIPT_INSTANCE do
task.wait(1)
local ch = player.Character
if ch then
local hum = ch:FindFirstChildOfClass("Humanoid")
if hum and hum.Health > 0 then
rememberDLQuestCharacter(ch)
end
end
end
end)

trackRuntimeConnection(player.CharacterRemoving:Connect(function(character)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
if not enabled then return end
pauseDLQuestForRespawn("CharacterRemoving", character)
end))

trackRuntimeConnection(player.CharacterAdded:Connect(function(character)
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end

task.spawn(function()
local restored = waitDLRespawnReady(15)
if not restored then return end

rememberDLQuestCharacter(restored)

if not enabled then
shared._dlAutoQuestRespawning = false
return
end

-- If active recovery owns the respawn, it will restart the worker itself.
if shared._dlAutoQuestRespawning then
return
end

clearMissionHudLock()

goatPrint(string.format(
"[AutoQuest][DL] CharacterAdded ready | animal=%s | slot=%s",
tostring(restored:GetAttribute("AnimalName") or "?"),
tostring(restored:GetAttribute("CharacterName") or "?")
))
end)
end))
end

shared._setAutoQuest = function(state)
local wanted = state == true

if enabled == wanted and shared._autoQuestEnabled == wanted then
return
end

enabled = wanted
shared._autoQuestEnabled = enabled
shared._autoQuestVisitZonesExclusive = false
shared._autoQuestVisitZonesExclusiveToken = nil
if not enabled then
shared._characterTransitionLock = false
shared._characterTransitionOwner = nil
shared._characterTransitionTarget = nil
shared._expectedCharacterRemoving = false
shared._characterTransitionGeneration = (tonumber(shared._characterTransitionGeneration) or 0) + 1
end
runToken = runToken + 1

if enabled then
shared._spawnBeachGeneration = (tonumber(shared._spawnBeachGeneration) or 0) + 1
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
if type(shared._animalCancelTween) == "function" then
pcall(shared._animalCancelTween, true)
end
shared._animalTweening = false

goatPrint(
"[AutoQuest] Spawn Beach stale movement ABORT • Auto Quest owns movement | gen="
.. tostring(shared._spawnBeachGeneration)
)

clearMissionHudLock()

-- Restore the original Auto Quest survival behavior.
-- Auto Quest ON automatically enables the correct food system + AutoDrink.
-- This is intentionally outside VISIT_ZONES routing; Visit Zones may only
-- PAUSE these workers temporarily while it owns movement.
do
local ch = player.Character
local animalName = ch and tostring(ch:GetAttribute("AnimalName") or "") or ""
local carnivore = shared._isCarnivoreName
and shared._isCarnivoreName(animalName)
or false

if carnivore then
if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, false)
end
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, true)
end
else
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, false)
end
if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, true)
end
end

if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, true)
end

goatPrint(
"[AutoQuest] Survival AUTO ON | animal="
.. tostring(animalName ~= "" and animalName or "?")
.. " | Eat=" .. (carnivore and "OFF" or "ON")
.. " | Carcass=" .. (carnivore and "ON" or "OFF")
.. " | Drink=ON"
)
end

if game.GameId == 8198412649 then
status("Auto Quest • DL", "ATIVADO • Daily + Weekly • perfil DinoLife", Color3.fromRGB(0, 170, 255))
goatPrint("[AutoQuest][DL] ENABLED | Daily + Weekly | separate from SL/JL")
else
status("Auto Quest", "ATIVADO • Daily + Weekly", Color3.fromRGB(0, 170, 255))
end
startLoop()
else
shared._autoQuestWorkerGeneration = (shared._autoQuestWorkerGeneration or 0) + 1
if game.GameId == 8198412649 then
shared._dlAutoQuestRespawning = false
end
autoQuestSurvivalPriority = false
lockedGrowQuest = nil
lockedGrowQuestMisses = 0
lockedAnimalQuest = nil
lockedAnimalQuestMisses = 0
shared._autoQuestGrowState = nil
activeMission = nil
deferredQuests = {}

-- Original Auto Quest ownership: when Auto Quest is turned OFF, release
-- the survival automations it enabled.
if shared._setAutoEatInternal then
pcall(shared._setAutoEatInternal, false)
end
if shared._setAutoCarcassInternal then
pcall(shared._setAutoCarcassInternal, false)
end
if shared._setAutoDrinkInternal then
pcall(shared._setAutoDrinkInternal, false)
end

clearMissionHudLock()
setSwimMovementLock(false)
setZoneMovementLock(false)
setTravelMovementLock(false)
stopNativeTravel()
shared._animalWalkGeneration = (shared._animalWalkGeneration or 0) + 1
shared._animalTweening = false
status("Auto Quest", "Desativado", Color3.fromRGB(130, 145, 165))
end
end

if shared._autoQuestPendingState ~= nil then
local pending = shared._autoQuestPendingState == true
shared._autoQuestPendingState = nil
shared._setAutoQuest(pending)
end
end)

task.spawn(function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local GAME_SAFETY = {
[18214855317]    = { dangerY = -100, safePos = Vector3.new(-6711.7, 10.8, 2929.6) },
[6174994284]     = { dangerY = -100, safePos = Vector3.new(-6245.2, 10.0, 4664.3) },
[9237322219] = { dangerY = -100, safePos = Vector3.new(-6711.7, 10.8, 2929.6) },
[8198412649] = { dangerY = -100, safePos = Vector3.new(335.063, 55.712, 19.966) },
}
local safeCfg = GAME_SAFETY[game.GameId] or { dangerY = -100, safePos = Vector3.new(-6711.7, 10.8, 2929.6) }
local DANGER_Y = safeCfg.dangerY
local SAFE_POS = safeCfg.safePos

trackRuntimeConnection(RunService.Heartbeat:Connect(function()
if shared._THEGOAT_SCRIPT_INSTANCE ~= SCRIPT_INSTANCE then return end
local char = player.Character
if not char then return end
local root = char:FindFirstChild("HumanoidRootPart")
if not root then return end

if root.Position.Y < DANGER_Y then
goatPrint("[SafetyNet] Fell through map! Teleporting back...")
char:SetPrimaryPartCFrame(CFrame.new(SAFE_POS))
end
end))
end)
