## Extra vector2 maths & utils. Included by raylib.nim, don't import this module.

import math

proc v2*(x: float32, y: float32): Vector2 = return Vector2(x: x, y: y)

# vec*vec
proc `+`*(l: Vector2, r: Vector2): Vector2 = return Vector2(x: l.x + r.x, y: l.y + r.y)
proc `-`*(l: Vector2, r: Vector2): Vector2 = return Vector2(x: l.x - r.x, y: l.y - r.y)
proc `*`*(l: Vector2, r: Vector2): Vector2 = return Vector2(x: l.x * r.x, y: l.y * r.y)
proc `/`*(l: Vector2, r: Vector2): Vector2 = return Vector2(x: l.x / r.x, y: l.y / r.y)
proc dot*(l: Vector2, r: Vector2): float32 = return l.x * r.x + l.y * r.y

# vec*scal
proc `*`*(l: Vector2, r: float32): Vector2 = return Vector2(x: l.x * r, y: l.y * r)
proc `*`*(l: float32, r: Vector2): Vector2 = r * l
proc `/`*(l: Vector2, r: float32): Vector2 = return Vector2(x: l.x / r, y: l.y / r)
proc `/`*(l: float32, r: Vector2): Vector2 = r / l

# Mutations
proc `+=`*(l: var Vector2, r: Vector2) = l = l + r
proc `-=`*(l: var Vector2, r: Vector2) = l = l - r
proc `*=`*(l: var Vector2, r: Vector2) = l = l * r
proc `/=`*(l: var Vector2, r: Vector2) = l = l / r
proc `*=`*(l: var Vector2, r: float32) = l = l * r
proc `/=`*(l: var Vector2, r: float32) = l = l / r

# vec extra
proc angle*(v: Vector2): float32 = return arctan2(v.y, v.x)
proc len2*(v: Vector2): float32 = v.x * v.x + v.y * v.y
proc len*(v: Vector2): float32 = v.len2.sqrt
proc nor*(v: Vector2): Vector2 = v / v.len
