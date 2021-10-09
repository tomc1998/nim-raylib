# 
#   raylib v4.0 - A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)
# 
#   FEATURES:
#       - NO external dependencies, all required libraries included with raylib
#       - Multiplatform: Windows, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly,
#                        MacOS, Haiku, UWP, Android, Raspberry Pi, HTML5.
#       - Written in plain C code (C99) in PascalCase/camelCase notation
#       - Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES2 - choose at compile)
#       - Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
#       - Multiple Fonts formats supported (TTF, XNA fonts, AngelCode fonts)
#       - Outstanding texture formats support, including compressed formats (DXT, ETC, ASTC)
#       - Full 3d support for 3d Shapes, Models, Billboards, Heightmaps and more!
#       - Flexible Materials system, supporting classic maps and PBR maps
#       - Animated 3D models supported (skeletal bones animation) (IQM, glTF)
#       - Shaders support, including Model shaders and Postprocessing shaders
#       - Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
#       - Audio loading and playing with streaming support (WAV, OGG, MP3, FLAC, XM, MOD)
#       - VR stereo rendering with configurable HMD device parameters
#       - Bindings to multiple programming languages available!
# 
#   NOTES:
#       One default Font is loaded on InitWindow()->LoadFontDefault() [core, text]
#       One default Texture2D is loaded on rlglInit(), 1x1 white pixel R8G8B8A8 [rlgl] (OpenGL 3.3 or ES2)
#       One default Shader is loaded on rlglInit()->rlLoadShaderDefault() [rlgl] (OpenGL 3.3 or ES2)
#       One default RenderBatch is loaded on rlglInit()->rlLoadRenderBatch() [rlgl] (OpenGL 3.3 or ES2)
# 
#   DEPENDENCIES (included):
#       [core] rglfw (Camilla Löwy - github.com/glfw/glfw) for window/context management and input (PLATFORM_DESKTOP)
#       [rlgl] glad (David Herberth - github.com/Dav1dde/glad) for OpenGL 3.3 extensions loading (PLATFORM_DESKTOP)
#       [raudio] miniaudio (David Reid - github.com/mackron/miniaudio) for audio device/context management
# 
#   OPTIONAL DEPENDENCIES (included):
#       [core] msf_gif (Miles Fogle) for GIF recording
#       [core] sinfl (Micha Mettke) for DEFLATE decompression algorythm
#       [core] sdefl (Micha Mettke) for DEFLATE compression algorythm
#       [textures] stb_image (Sean Barret) for images loading (BMP, TGA, PNG, JPEG, HDR...)
#       [textures] stb_image_write (Sean Barret) for image writting (BMP, TGA, PNG, JPG)
#       [textures] stb_image_resize (Sean Barret) for image resizing algorithms
#       [textures] stb_perlin (Sean Barret) for Perlin noise image generation
#       [text] stb_truetype (Sean Barret) for ttf fonts loading
#       [text] stb_rect_pack (Sean Barret) for rectangles packing
#       [models] par_shapes (Philip Rideout) for parametric 3d shapes generation
#       [models] tinyobj_loader_c (Syoyo Fujita) for models loading (OBJ, MTL)
#       [models] cgltf (Johannes Kuhlmann) for models loading (glTF)
#       [raudio] dr_wav (David Reid) for WAV audio file loading
#       [raudio] dr_flac (David Reid) for FLAC audio file loading
#       [raudio] dr_mp3 (David Reid) for MP3 audio file loading
#       [raudio] stb_vorbis (Sean Barret) for OGG audio loading
#       [raudio] jar_xm (Joshua Reisenauer) for XM audio module loading
#       [raudio] jar_mod (Joshua Reisenauer) for MOD audio module loading
# 
# 
#   LICENSE: zlib/libpng
# 
#   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
#   BSD-like license that allows static linking with closed source software:
# 
#   Copyright (c) 2013-2021 Ramon Santamaria (@raysan5)
# 
#   This software is provided "as-is", without any express or implied warranty. In no event
#   will the authors be held liable for any damages arising from the use of this software.
# 
#   Permission is granted to anyone to use this software for any purpose, including commercial
#   applications, and to alter it and redistribute it freely, subject to the following restrictions:
# 
#     1. The origin of this software must not be misrepresented; you must not claim that you
#     wrote the original software. If you use this software in a product, an acknowledgment
#     in the product documentation would be appreciated but is not required.
# 
#     2. Altered source versions must be plainly marked as such, and must not be misrepresented
#     as being the original software.
# 
#     3. This notice may not be removed or altered from any source distribution.
#
converter int2in32*(self: int): int32 = self.int32
const LEXT* = when defined(windows): ".dll"
elif defined(macosx): ".dylib"
else: ".so"
template RAYLIB_VERSION*(): auto = "4.0"
# Function specifiers in case library is build/used as a shared library (Windows)
# NOTE: Microsoft specifiers to tell compiler that symbols are imported/exported from a .dll
{.pragma: RLAPI, cdecl, discardable, dynlib: "libraylib" & LEXT.}
# ----------------------------------------------------------------------------------
# Some basic Defines
# ----------------------------------------------------------------------------------
# Allow custom memory allocators
# NOTE: MSVC C++ compiler does not support compound literals (C99 feature)
# Plain structures in C++ (without constructors) can be initialized with { }
# NOTE: We set some defines with some data types declared by raylib
# Other modules (raymath, rlgl) also require some of those types, so,
# to be able to use those other modules as standalone (not depending on raylib)
# this defines are very useful for internal check and avoid type (re)definitions
template RL_COLOR_TYPE*(): auto = RL_COLOR_TYPE
template RL_RECTANGLE_TYPE*(): auto = RL_RECTANGLE_TYPE
template RL_VECTOR2_TYPE*(): auto = RL_VECTOR2_TYPE
template RL_VECTOR3_TYPE*(): auto = RL_VECTOR3_TYPE
template RL_VECTOR4_TYPE*(): auto = RL_VECTOR4_TYPE
template RL_QUATERNION_TYPE*(): auto = RL_QUATERNION_TYPE
template RL_MATRIX_TYPE*(): auto = RL_MATRIX_TYPE
# Some Basic Colors
# NOTE: Custom raylib color palette for amazing visuals on WHITE background
template LIGHTGRAY*(): auto = Color(r: 200, g: 200, b: 200, a: 255) # Light Gray
template GRAY*(): auto = Color(r: 130, g: 130, b: 130, a: 255) # Gray
template DARKGRAY*(): auto = Color(r: 80, g: 80, b: 80, a: 255) # Dark Gray
template YELLOW*(): auto = Color(r: 253, g: 249, b: 0, a: 255) # Yellow
template GOLD*(): auto = Color(r: 255, g: 203, b: 0, a: 255) # Gold
template ORANGE*(): auto = Color(r: 255, g: 161, b: 0, a: 255) # Orange
template PINK*(): auto = Color(r: 255, g: 109, b: 194, a: 255) # Pink
template RED*(): auto = Color(r: 230, g: 41, b: 55, a: 255) # Red
template MAROON*(): auto = Color(r: 190, g: 33, b: 55, a: 255) # Maroon
template GREEN*(): auto = Color(r: 0, g: 228, b: 48, a: 255) # Green
template LIME*(): auto = Color(r: 0, g: 158, b: 47, a: 255) # Lime
template DARKGREEN*(): auto = Color(r: 0, g: 117, b: 44, a: 255) # Dark Green
template SKYBLUE*(): auto = Color(r: 102, g: 191, b: 255, a: 255) # Sky Blue
template BLUE*(): auto = Color(r: 0, g: 121, b: 241, a: 255) # Blue
template DARKBLUE*(): auto = Color(r: 0, g: 82, b: 172, a: 255) # Dark Blue
template PURPLE*(): auto = Color(r: 200, g: 122, b: 255, a: 255) # Purple
template VIOLET*(): auto = Color(r: 135, g: 60, b: 190, a: 255) # Violet
template DARKPURPLE*(): auto = Color(r: 112, g: 31, b: 126, a: 255) # Dark Purple
template BEIGE*(): auto = Color(r: 211, g: 176, b: 131, a: 255) # Beige
template BROWN*(): auto = Color(r: 127, g: 106, b: 79, a: 255) # Brown
template DARKBROWN*(): auto = Color(r: 76, g: 63, b: 47, a: 255) # Dark Brown
template WHITE*(): auto = Color(r: 255, g: 255, b: 255, a: 255) # White
template BLACK*(): auto = Color(r: 0, g: 0, b: 0, a: 255) # Black
template BLANK*(): auto = Color(r: 0, g: 0, b: 0, a: 0) # Blank (Transparent)
template MAGENTA*(): auto = Color(r: 255, g: 0, b: 255, a: 255) # Magenta
template RAYWHITE*(): auto = Color(r: 245, g: 245, b: 245,
    a: 255) # My own White (raylib logo)
# ----------------------------------------------------------------------------------
# Structures Definition
# ----------------------------------------------------------------------------------
# Boolean type
# Vector2, 2 components
type Vector2* {.bycopy.} = object
  x*: float32 # Vector x component
  y*: float32 # Vector y component
              # Vector3, 3 components
type Vector3* {.bycopy.} = object
  x*: float32 # Vector x component
  y*: float32 # Vector y component
  z*: float32 # Vector z component
              # Vector4, 4 components
type Vector4* {.bycopy.} = object
  x*: float32 # Vector x component
  y*: float32 # Vector y component
  z*: float32 # Vector z component
  w*: float32 # Vector w component
              # Quaternion, 4 components (Vector4 alias)
type Quaternion* = Vector4
# Matrix, 4x4 components, column major, OpenGL style, right handed
type Matrix* {.bycopy.} = object
  m0*, m4*, m8*, m12*: float32  # Matrix first row (4 components)
  m1*, m5*, m9*, m13*: float32  # Matrix second row (4 components)
  m2*, m6*, m10*, m14*: float32 # Matrix third row (4 components)
  m3*, m7*, m11*, m15*: float32 # Matrix fourth row (4 components)
                                # Color, 4 components, R8G8B8A8 (32bit)
type Color* {.bycopy.} = object
  r*: uint8 # Color red value
  g*: uint8 # Color green value
  b*: uint8 # Color blue value
  a*: uint8 # Color alpha value
            # Rectangle, 4 components
type Rectangle* {.bycopy.} = object
  x*: float32      # Rectangle top-left corner position x
  y*: float32      # Rectangle top-left corner position y
  width*: float32  # Rectangle width
  height*: float32 # Rectangle height
                   # Image, pixel data stored in CPU memory (RAM)
type Image* {.bycopy.} = object
  data*: pointer  # Image raw data
  width*: int32   # Image base width
  height*: int32  # Image base height
  mipmaps*: int32 # Mipmap levels, 1 by default
  format*: int32  # Data format (PixelFormat type)
                  # Texture, tex data stored in GPU memory (VRAM)
type Texture* {.bycopy.} = object
  id*: uint32     # OpenGL texture id
  width*: int32   # Texture base width
  height*: int32  # Texture base height
  mipmaps*: int32 # Mipmap levels, 1 by default
  format*: int32  # Data format (PixelFormat type)
                  # Texture2D, same as Texture
type Texture2D* = Texture
# TextureCubemap, same as Texture
type TextureCubemap* = Texture
# RenderTexture, fbo for texture rendering
type RenderTexture* {.bycopy.} = object
  id*: uint32       # OpenGL framebuffer object id
  texture*: Texture # Color buffer attachment texture
  depth*: Texture   # Depth buffer attachment texture
                    # RenderTexture2D, same as RenderTexture
type RenderTexture2D* = RenderTexture
# NPatchInfo, n-patch layout info
type NPatchInfo* {.bycopy.} = object
  source*: Rectangle # Texture source rectangle
  left*: int32       # Left border offset
  top*: int32        # Top border offset
  right*: int32      # Right border offset
  bottom*: int32     # Bottom border offset
  layout*: int32     # Layout of the n-patch: 3x3, 1x3 or 3x1
                     # GlyphInfo, font characters glyphs info
type GlyphInfo* {.bycopy.} = object
  value*: int32    # Character value (Unicode)
  offsetX*: int32  # Character offset X when drawing
  offsetY*: int32  # Character offset Y when drawing
  advanceX*: int32 # Character advance position X
  image*: Image    # Character image data
                   # Font, font texture and GlyphInfo array data
type Font* {.bycopy.} = object
  baseSize*: int32       # Base size (default chars height)
  glyphCount*: int32     # Number of glyph characters
  glyphPadding*: int32   # Padding around the glyph characters
  texture*: Texture2D    # Texture atlas containing the glyphs
  recs*: ptr Rectangle   # Rectangles in texture for the glyphs
  glyphs*: ptr GlyphInfo # Glyphs info data
                         # Camera, defines position/orientation in 3d space
type Camera3D* {.bycopy.} = object
  position*: Vector3 # Camera position
  target*: Vector3   # Camera target it looks-at
  up*: Vector3       # Camera up vector (rotation over its axis)
  fovy*: float32 # Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
  projection*: int32 # Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
type Camera* = Camera3D
# Camera2D, defines position/orientation in 2d space
type Camera2D* {.bycopy.} = object
  offset*: Vector2   # Camera offset (displacement from target)
  target*: Vector2   # Camera target (rotation and zoom origin)
  rotation*: float32 # Camera rotation in degrees
  zoom*: float32     # Camera zoom (scaling), should be 1.0f by default
                     # Mesh, vertex data and vao/vbo
type Mesh* {.bycopy.} = object
  vertexCount*: int32   # Number of vertices stored in arrays
  triangleCount*: int32 # Number of triangles stored (indexed or not)
  vertices*: float32    # Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
  texcoords*: float32 # Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
  texcoords2*: float32 # Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
  normals*: float32     # Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
  tangents*: float32 # Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
  colors*: uint8        # Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
  indices*: uint16      # Vertex indices (in case vertex data comes indexed)
  animVertices*: float32 # Animated vertex positions (after bones transformations)
  animNormals*: float32 # Animated normals (after bones transformations)
  boneIds*: pointer     # Vertex bone ids, up to 4 bones influence by vertex (skinning)
  boneWeights*: float32 # Vertex bone weight, up to 4 bones influence by vertex (skinning)
  vaoId*: uint32        # OpenGL Vertex Array Object id
  vboId*: uint32        # OpenGL Vertex Buffer Objects id (default vertex data)
                        # Shader
type Shader* {.bycopy.} = object
  id*: uint32    # Shader program id
  locs*: pointer # Shader locations array (RL_MAX_SHADER_LOCATIONS)
                 # MaterialMap
type MaterialMap* {.bycopy.} = object
  texture*: Texture2D # Material map texture
  color*: Color       # Material map color
  value*: float32     # Material map value
                      # Material, includes shader and maps
type Material* {.bycopy.} = object
  shader*: Shader               # Material shader
  maps*: ptr MaterialMap        # Material maps array (MAX_MATERIAL_MAPS)
  params*: array[0..3, float32] # Material generic parameters (if required)
                                # Transform, vectex transformation data
type Transform* {.bycopy.} = object
  translation*: Vector3 # Translation
  rotation*: Quaternion # Rotation
  scale*: Vector3       # Scale
                        # Bone, skeletal animation bone
type BoneInfo* {.bycopy.} = object
  name*: array[0..31, char] # Bone name
  parent*: int32            # Bone parent
                            # Model, meshes, materials and animation data
type Model* {.bycopy.} = object
  transform*: Matrix       # Local transform matrix
  meshCount*: int32        # Number of meshes
  materialCount*: int32    # Number of materials
  meshes*: ptr Mesh        # Meshes array
  materials*: ptr Material # Materials array
  meshMaterial*: pointer   # Mesh material number
  boneCount*: int32        # Number of bones
  bones*: ptr BoneInfo     # Bones information (skeleton)
  bindPose*: ptr Transform # Bones base transformation (pose)
                           # ModelAnimation
type ModelAnimation* {.bycopy.} = object
  boneCount*: int32          # Number of bones
  frameCount*: int32         # Number of animation frames
  bones*: ptr BoneInfo       # Bones information (skeleton)
  framePoses*: ptr Transform # Poses array by frame
                             # Ray, ray for raycasting
type Ray* {.bycopy.} = object
  position*: Vector3  # Ray position (origin)
  direction*: Vector3 # Ray direction
                      # RayCollision, ray hit information
type RayCollision* {.bycopy.} = object
  hit*: bool         # Did the ray hit something?
  distance*: float32 # Distance to nearest hit
  point*: Vector3    # Point of nearest hit
  normal*: Vector3   # Surface normal of hit
                     # BoundingBox
type BoundingBox* {.bycopy.} = object
  min*: Vector3 # Minimum vertex box-corner
  max*: Vector3 # Maximum vertex box-corner
                # Wave, audio wave data
type Wave* {.bycopy.} = object
  frameCount*: uint32 # Total number of frames (considering channels)
  sampleRate*: uint32 # Frequency (samples per second)
  sampleSize*: uint32 # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  channels*: uint32   # Number of channels (1-mono, 2-stereo, ...)
  data*: pointer      # Buffer data pointer
type rAudioBuffer* {.bycopy.} = object
# AudioStream, custom audio stream
type AudioStream* {.bycopy.} = object
  buffer*: ptr rAudioBuffer # Pointer to internal data used by the audio system
  sampleRate*: uint32       # Frequency (samples per second)
  sampleSize*: uint32       # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
  channels*: uint32         # Number of channels (1-mono, 2-stereo, ...)
                            # Sound
type Sound* {.bycopy.} = object
  stream*: AudioStream # Audio stream
  frameCount*: uint32  # Total number of frames (considering channels)
                    # Music, audio stream, anything longer than ~10 seconds should be streamed
type Music* {.bycopy.} = object
  stream*: AudioStream # Audio stream
  frameCount*: uint32  # Total number of frames (considering channels)
  looping*: bool       # Music looping enable
  ctxType*: int32      # Type of music context (audio filetype)
  ctxData*: pointer    # Audio context data, depends on type
                       # VrDeviceInfo, Head-Mounted-Display device parameters
type VrDeviceInfo* {.bycopy.} = object
  hResolution*: int32              # Horizontal resolution in pixels
  vResolution*: int32              # Vertical resolution in pixels
  hScreenSize*: float32            # Horizontal size in meters
  vScreenSize*: float32            # Vertical size in meters
  vScreenCenter*: float32          # Screen center in meters
  eyeToScreenDistance*: float32    # Distance between eye and display in meters
  lensSeparationDistance*: float32 # Lens separation distance in meters
  interpupillaryDistance*: float32 # IPD (distance between pupils) in meters
  lensDistortionValues*: array[0..3, float32] # Lens distortion constant parameters
  chromaAbCorrection*: array[0..3, float32] # Chromatic aberration correction parameters
                                   # VrStereoConfig, VR stereo rendering configuration for simulator
type VrStereoConfig* {.bycopy.} = object
  projection*: array[0..1, Matrix]         # VR projection matrices (per eye)
  viewOffset*: array[0..1, Matrix]         # VR view offset matrices (per eye)
  leftLensCenter*: array[0..1, float32]    # VR left lens center
  rightLensCenter*: array[0..1, float32]   # VR right lens center
  leftScreenCenter*: array[0..1, float32]  # VR left screen center
  rightScreenCenter*: array[0..1, float32] # VR right screen center
  scale*: array[0..1, float32]             # VR distortion scale
  scaleIn*: array[0..1, float32]           # VR distortion scale in
                               # ----------------------------------------------------------------------------------
                                           # Enumerators Definition
                               # ----------------------------------------------------------------------------------
                                           # System/Window config flags
                               # NOTE: Every bit registers one state (use it with bit masks)
                                           # By default all flags are set to 0
type ConfigFlags* = enum
  FLAG_FULLSCREEN_MODE = 0x00000002    # Set to run program in fullscreen
  FLAG_WINDOW_RESIZABLE = 0x00000004   # Set to allow resizable window
  FLAG_WINDOW_UNDECORATED = 0x00000008 # Set to disable window decoration (frame and buttons)
  FLAG_WINDOW_TRANSPARENT = 0x00000010 # Set to allow transparent framebuffer
  FLAG_MSAA_4X_HINT = 0x00000020       # Set to try enabling MSAA 4X
  FLAG_VSYNC_HINT = 0x00000040         # Set to try enabling V-Sync on GPU
  FLAG_WINDOW_HIDDEN = 0x00000080      # Set to hide window
  FLAG_WINDOW_ALWAYS_RUN = 0x00000100  # Set to allow windows running while minimized
  FLAG_WINDOW_MINIMIZED = 0x00000200   # Set to minimize window (iconify)
  FLAG_WINDOW_MAXIMIZED = 0x00000400   # Set to maximize window (expanded to monitor)
  FLAG_WINDOW_UNFOCUSED = 0x00000800   # Set to window non focused
  FLAG_WINDOW_TOPMOST = 0x00001000     # Set to window always on top
  FLAG_WINDOW_HIGHDPI = 0x00002000     # Set to support HighDPI
  FLAG_INTERLACED_HINT = 0x00010000    # Set to try enabling interlaced video format (for V3D)
converter ConfigFlags2int32*(self: ConfigFlags): int32 = self.int32
# Trace log level
# NOTE: Organized by priority level
type TraceLogLevel* = enum
  LOG_ALL = 0 # Display all logs
  LOG_TRACE   # Trace logging, intended for internal use only
  LOG_DEBUG # Debug logging, used for internal debugging, it should be disabled on release builds
  LOG_INFO    # Info logging, used for program execution info
  LOG_WARNING # Warning logging, used on recoverable failures
  LOG_ERROR   # Error logging, used on unrecoverable failures
  LOG_FATAL   # Fatal logging, used to abort program: exit(EXIT_FAILURE)
  LOG_NONE    # Disable logging
converter TraceLogLevel2int32*(self: TraceLogLevel): int32 = self.int32
# Keyboard keys (US keyboard layout)
# NOTE: Use GetKeyPressed() to allow redefining
# required keys for alternative layouts
type KeyboardKey* = enum
  KEY_NULL = 0            # Key: NULL, used for no key pressed
  KEY_BACK = 4            # Key: Android back button
  KEY_VOLUME_UP = 24      # Key: Android volume up button
  KEY_VOLUME_DOWN = 25    # Key: Android volume down button
  KEY_SPACE = 32          # Key: Space
  KEY_APOSTROPHE = 39     # Key: '
  KEY_COMMA = 44          # Key: ,
  KEY_MINUS = 45          # Key: -
  KEY_PERIOD = 46         # Key: .
  KEY_SLASH = 47          # Key: /
  KEY_ZERO = 48           # Key: 0
  KEY_ONE = 49            # Key: 1
  KEY_TWO = 50            # Key: 2
  KEY_THREE = 51          # Key: 3
  KEY_FOUR = 52           # Key: 4
  KEY_FIVE = 53           # Key: 5
  KEY_SIX = 54            # Key: 6
  KEY_SEVEN = 55          # Key: 7
  KEY_EIGHT = 56          # Key: 8
  KEY_NINE = 57           # Key: 9
  KEY_SEMICOLON = 59      # Key: ;
  KEY_EQUAL = 61          # Key: =
  KEY_A = 65              # Key: A | a
  KEY_B = 66              # Key: B | b
  KEY_C = 67              # Key: C | c
  KEY_D = 68              # Key: D | d
  KEY_E = 69              # Key: E | e
  KEY_F = 70              # Key: F | f
  KEY_G = 71              # Key: G | g
  KEY_H = 72              # Key: H | h
  KEY_I = 73              # Key: I | i
  KEY_J = 74              # Key: J | j
  KEY_K = 75              # Key: K | k
  KEY_L = 76              # Key: L | l
  KEY_M = 77              # Key: M | m
  KEY_N = 78              # Key: N | n
  KEY_O = 79              # Key: O | o
  KEY_P = 80              # Key: P | p
  KEY_Q = 81              # Key: Q | q
  KEY_R = 82              # Key: R | r
  KEY_S = 83              # Key: S | s
  KEY_T = 84              # Key: T | t
  KEY_U = 85              # Key: U | u
  KEY_V = 86              # Key: V | v
  KEY_W = 87              # Key: W | w
  KEY_X = 88              # Key: X | x
  KEY_Y = 89              # Key: Y | y
  KEY_Z = 90              # Key: Z | z
  KEY_LEFT_BRACKET = 91   # Key: [
  KEY_BACKSLASH = 92      # Key: '\'
  KEY_RIGHT_BRACKET = 93  # Key: ]
  KEY_GRAVE = 96          # Key: `
  KEY_ESCAPE = 256        # Key: Esc
  KEY_ENTER = 257         # Key: Enter
  KEY_TAB = 258           # Key: Tab
  KEY_BACKSPACE = 259     # Key: Backspace
  KEY_INSERT = 260        # Key: Ins
  KEY_DELETE = 261        # Key: Del
  KEY_RIGHT = 262         # Key: Cursor right
  KEY_LEFT = 263          # Key: Cursor left
  KEY_DOWN = 264          # Key: Cursor down
  KEY_UP = 265            # Key: Cursor up
  KEY_PAGE_UP = 266       # Key: Page up
  KEY_PAGE_DOWN = 267     # Key: Page down
  KEY_HOME = 268          # Key: Home
  KEY_END = 269           # Key: End
  KEY_CAPS_LOCK = 280     # Key: Caps lock
  KEY_SCROLL_LOCK = 281   # Key: Scroll down
  KEY_NUM_LOCK = 282      # Key: Num lock
  KEY_PRINT_SCREEN = 283  # Key: Print screen
  KEY_PAUSE = 284         # Key: Pause
  KEY_F1 = 290            # Key: F1
  KEY_F2 = 291            # Key: F2
  KEY_F3 = 292            # Key: F3
  KEY_F4 = 293            # Key: F4
  KEY_F5 = 294            # Key: F5
  KEY_F6 = 295            # Key: F6
  KEY_F7 = 296            # Key: F7
  KEY_F8 = 297            # Key: F8
  KEY_F9 = 298            # Key: F9
  KEY_F10 = 299           # Key: F10
  KEY_F11 = 300           # Key: F11
  KEY_F12 = 301           # Key: F12
  KEY_KP_0 = 320          # Key: Keypad 0
  KEY_KP_1 = 321          # Key: Keypad 1
  KEY_KP_2 = 322          # Key: Keypad 2
  KEY_KP_3 = 323          # Key: Keypad 3
  KEY_KP_4 = 324          # Key: Keypad 4
  KEY_KP_5 = 325          # Key: Keypad 5
  KEY_KP_6 = 326          # Key: Keypad 6
  KEY_KP_7 = 327          # Key: Keypad 7
  KEY_KP_8 = 328          # Key: Keypad 8
  KEY_KP_9 = 329          # Key: Keypad 9
  KEY_KP_DECIMAL = 330    # Key: Keypad .
  KEY_KP_DIVIDE = 331     # Key: Keypad /
  KEY_KP_MULTIPLY = 332   # Key: Keypad *
  KEY_KP_SUBTRACT = 333   # Key: Keypad -
  KEY_KP_ADD = 334        # Key: Keypad +
  KEY_KP_ENTER = 335      # Key: Keypad Enter
  KEY_KP_EQUAL = 336      # Key: Keypad =
  KEY_LEFT_SHIFT = 340    # Key: Shift left
  KEY_LEFT_CONTROL = 341  # Key: Control left
  KEY_LEFT_ALT = 342      # Key: Alt left
  KEY_LEFT_SUPER = 343    # Key: Super left
  KEY_RIGHT_SHIFT = 344   # Key: Shift right
  KEY_RIGHT_CONTROL = 345 # Key: Control right
  KEY_RIGHT_ALT = 346     # Key: Alt right
  KEY_RIGHT_SUPER = 347   # Key: Super right
  KEY_KB_MENU = 348       # Key: KB menu
converter KeyboardKey2int32*(self: KeyboardKey): int32 = self.int32
# Add backwards compatibility support for deprecated names
template MOUSE_LEFT_BUTTON*(): auto = MOUSE_BUTTON_LEFT
template MOUSE_RIGHT_BUTTON*(): auto = MOUSE_BUTTON_RIGHT
template MOUSE_MIDDLE_BUTTON*(): auto = MOUSE_BUTTON_MIDDLE
# Mouse buttons
type MouseButton* = enum
  MOUSE_BUTTON_LEFT = 0    # Mouse button left
  MOUSE_BUTTON_RIGHT = 1   # Mouse button right
  MOUSE_BUTTON_MIDDLE = 2  # Mouse button middle (pressed wheel)
  MOUSE_BUTTON_SIDE = 3    # Mouse button side (advanced mouse device)
  MOUSE_BUTTON_EXTRA = 4   # Mouse button extra (advanced mouse device)
  MOUSE_BUTTON_FORWARD = 5 # Mouse button fordward (advanced mouse device)
  MOUSE_BUTTON_BACK = 6    # Mouse button back (advanced mouse device)
converter MouseButton2int32*(self: MouseButton): int32 = self.int32
# Mouse cursor
type MouseCursor* = enum
  MOUSE_CURSOR_DEFAULT = 0       # Default pointer shape
  MOUSE_CURSOR_ARROW = 1         # Arrow shape
  MOUSE_CURSOR_IBEAM = 2         # Text writing cursor shape
  MOUSE_CURSOR_CROSSHAIR = 3     # Cross shape
  MOUSE_CURSOR_POINTING_HAND = 4 # Pointing hand cursor
  MOUSE_CURSOR_RESIZE_EW = 5     # Horizontal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NS = 6     # Vertical resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NWSE = 7   # Top-left to bottom-right diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_NESW = 8 # The top-right to bottom-left diagonal resize/move arrow shape
  MOUSE_CURSOR_RESIZE_ALL = 9    # The omni-directional resize/move cursor shape
  MOUSE_CURSOR_NOT_ALLOWED = 10  # The operation-not-allowed shape
converter MouseCursor2int32*(self: MouseCursor): int32 = self.int32
# Gamepad buttons
type GamepadButton* = enum
  GAMEPAD_BUTTON_UNKNOWN = 0     # Unknown button, just for error checking
  GAMEPAD_BUTTON_LEFT_FACE_UP    # Gamepad left DPAD up button
  GAMEPAD_BUTTON_LEFT_FACE_RIGHT # Gamepad left DPAD right button
  GAMEPAD_BUTTON_LEFT_FACE_DOWN  # Gamepad left DPAD down button
  GAMEPAD_BUTTON_LEFT_FACE_LEFT  # Gamepad left DPAD left button
  GAMEPAD_BUTTON_RIGHT_FACE_UP   # Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
  GAMEPAD_BUTTON_RIGHT_FACE_RIGHT # Gamepad right button right (i.e. PS3: Square, Xbox: X)
  GAMEPAD_BUTTON_RIGHT_FACE_DOWN # Gamepad right button down (i.e. PS3: Cross, Xbox: A)
  GAMEPAD_BUTTON_RIGHT_FACE_LEFT # Gamepad right button left (i.e. PS3: Circle, Xbox: B)
  GAMEPAD_BUTTON_LEFT_TRIGGER_1 # Gamepad top/back trigger left (first), it could be a trailing button
  GAMEPAD_BUTTON_LEFT_TRIGGER_2 # Gamepad top/back trigger left (second), it could be a trailing button
  GAMEPAD_BUTTON_RIGHT_TRIGGER_1 # Gamepad top/back trigger right (one), it could be a trailing button
  GAMEPAD_BUTTON_RIGHT_TRIGGER_2 # Gamepad top/back trigger right (second), it could be a trailing button
  GAMEPAD_BUTTON_MIDDLE_LEFT     # Gamepad center buttons, left one (i.e. PS3: Select)
  GAMEPAD_BUTTON_MIDDLE # Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
  GAMEPAD_BUTTON_MIDDLE_RIGHT    # Gamepad center buttons, right one (i.e. PS3: Start)
  GAMEPAD_BUTTON_LEFT_THUMB      # Gamepad joystick pressed button left
  GAMEPAD_BUTTON_RIGHT_THUMB     # Gamepad joystick pressed button right
converter GamepadButton2int32*(self: GamepadButton): int32 = self.int32
# Gamepad axis
type GamepadAxis* = enum
  GAMEPAD_AXIS_LEFT_X = 0  # Gamepad left stick X axis
  GAMEPAD_AXIS_LEFT_Y = 1  # Gamepad left stick Y axis
  GAMEPAD_AXIS_RIGHT_X = 2 # Gamepad right stick X axis
  GAMEPAD_AXIS_RIGHT_Y = 3 # Gamepad right stick Y axis
  GAMEPAD_AXIS_LEFT_TRIGGER = 4 # Gamepad back trigger left, pressure level: [1..-1]
  GAMEPAD_AXIS_RIGHT_TRIGGER = 5 # Gamepad back trigger right, pressure level: [1..-1]
converter GamepadAxis2int32*(self: GamepadAxis): int32 = self.int32
# Material map index
type MaterialMapIndex* = enum
  MATERIAL_MAP_ALBEDO = 0 # Albedo material (same as: MATERIAL_MAP_DIFFUSE)
  MATERIAL_MAP_METALNESS  # Metalness material (same as: MATERIAL_MAP_SPECULAR)
  MATERIAL_MAP_NORMAL     # Normal material
  MATERIAL_MAP_ROUGHNESS  # Roughness material
  MATERIAL_MAP_OCCLUSION  # Ambient occlusion material
  MATERIAL_MAP_EMISSION   # Emission material
  MATERIAL_MAP_HEIGHT     # Heightmap material
  MATERIAL_MAP_CUBEMAP    # Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_IRRADIANCE # Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_PREFILTER  # Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
  MATERIAL_MAP_BRDF       # Brdf material
converter MaterialMapIndex2int32*(self: MaterialMapIndex): int32 = self.int32
template MATERIAL_MAP_DIFFUSE*(): auto = MATERIAL_MAP_ALBEDO
template MATERIAL_MAP_SPECULAR*(): auto = MATERIAL_MAP_METALNESS
# Shader location index
type ShaderLocationIndex* = enum
  SHADER_LOC_VERTEX_POSITION = 0 # Shader location: vertex attribute: position
  SHADER_LOC_VERTEX_TEXCOORD01   # Shader location: vertex attribute: texcoord01
  SHADER_LOC_VERTEX_TEXCOORD02   # Shader location: vertex attribute: texcoord02
  SHADER_LOC_VERTEX_NORMAL       # Shader location: vertex attribute: normal
  SHADER_LOC_VERTEX_TANGENT      # Shader location: vertex attribute: tangent
  SHADER_LOC_VERTEX_COLOR        # Shader location: vertex attribute: color
  SHADER_LOC_MATRIX_MVP          # Shader location: matrix uniform: model-view-projection
  SHADER_LOC_MATRIX_VIEW         # Shader location: matrix uniform: view (camera transform)
  SHADER_LOC_MATRIX_PROJECTION   # Shader location: matrix uniform: projection
  SHADER_LOC_MATRIX_MODEL        # Shader location: matrix uniform: model (transform)
  SHADER_LOC_MATRIX_NORMAL       # Shader location: matrix uniform: normal
  SHADER_LOC_VECTOR_VIEW         # Shader location: vector uniform: view
  SHADER_LOC_COLOR_DIFFUSE       # Shader location: vector uniform: diffuse color
  SHADER_LOC_COLOR_SPECULAR      # Shader location: vector uniform: specular color
  SHADER_LOC_COLOR_AMBIENT       # Shader location: vector uniform: ambient color
  SHADER_LOC_MAP_ALBEDO # Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
  SHADER_LOC_MAP_METALNESS # Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
  SHADER_LOC_MAP_NORMAL          # Shader location: sampler2d texture: normal
  SHADER_LOC_MAP_ROUGHNESS       # Shader location: sampler2d texture: roughness
  SHADER_LOC_MAP_OCCLUSION       # Shader location: sampler2d texture: occlusion
  SHADER_LOC_MAP_EMISSION        # Shader location: sampler2d texture: emission
  SHADER_LOC_MAP_HEIGHT          # Shader location: sampler2d texture: height
  SHADER_LOC_MAP_CUBEMAP         # Shader location: samplerCube texture: cubemap
  SHADER_LOC_MAP_IRRADIANCE      # Shader location: samplerCube texture: irradiance
  SHADER_LOC_MAP_PREFILTER       # Shader location: samplerCube texture: prefilter
  SHADER_LOC_MAP_BRDF            # Shader location: sampler2d texture: brdf
converter ShaderLocationIndex2int32*(self: ShaderLocationIndex): int32 = self.int32
template SHADER_LOC_MAP_DIFFUSE*(): auto = SHADER_LOC_MAP_ALBEDO
template SHADER_LOC_MAP_SPECULAR*(): auto = SHADER_LOC_MAP_METALNESS
# Shader uniform data type
type ShaderUniformDataType* = enum
  SHADER_UNIFORM_FLOAT = 0 # Shader uniform type: float
  SHADER_UNIFORM_VEC2      # Shader uniform type: vec2 (2 float)
  SHADER_UNIFORM_VEC3      # Shader uniform type: vec3 (3 float)
  SHADER_UNIFORM_VEC4      # Shader uniform type: vec4 (4 float)
  SHADER_UNIFORM_INT       # Shader uniform type: int
  SHADER_UNIFORM_IVEC2     # Shader uniform type: ivec2 (2 int)
  SHADER_UNIFORM_IVEC3     # Shader uniform type: ivec3 (3 int)
  SHADER_UNIFORM_IVEC4     # Shader uniform type: ivec4 (4 int)
  SHADER_UNIFORM_SAMPLER2D # Shader uniform type: sampler2d
converter ShaderUniformDataType2int32*(self: ShaderUniformDataType): int32 = self.int32
# Shader attribute data types
type ShaderAttributeDataType* = enum
  SHADER_ATTRIB_FLOAT = 0 # Shader attribute type: float
  SHADER_ATTRIB_VEC2      # Shader attribute type: vec2 (2 float)
  SHADER_ATTRIB_VEC3      # Shader attribute type: vec3 (3 float)
  SHADER_ATTRIB_VEC4      # Shader attribute type: vec4 (4 float)
converter ShaderAttributeDataType2int32 * (
  self: ShaderAttributeDataType): int32 = self.int32
# Pixel formats
# NOTE: Support depends on OpenGL version and platform
type PixelFormat* = enum
  PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1 # 8 bit per pixel (no alpha)
  PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA    # 8*2 bpp (2 channels)
  PIXELFORMAT_UNCOMPRESSED_R5G6B5        # 16 bpp
  PIXELFORMAT_UNCOMPRESSED_R8G8B8        # 24 bpp
  PIXELFORMAT_UNCOMPRESSED_R5G5B5A1      # 16 bpp (1 bit alpha)
  PIXELFORMAT_UNCOMPRESSED_R4G4B4A4      # 16 bpp (4 bit alpha)
  PIXELFORMAT_UNCOMPRESSED_R8G8B8A8      # 32 bpp
  PIXELFORMAT_UNCOMPRESSED_R32           # 32 bpp (1 channel - float)
  PIXELFORMAT_UNCOMPRESSED_R32G32B32     # 32*3 bpp (3 channels - float)
  PIXELFORMAT_UNCOMPRESSED_R32G32B32A32  # 32*4 bpp (4 channels - float)
  PIXELFORMAT_COMPRESSED_DXT1_RGB        # 4 bpp (no alpha)
  PIXELFORMAT_COMPRESSED_DXT1_RGBA       # 4 bpp (1 bit alpha)
  PIXELFORMAT_COMPRESSED_DXT3_RGBA       # 8 bpp
  PIXELFORMAT_COMPRESSED_DXT5_RGBA       # 8 bpp
  PIXELFORMAT_COMPRESSED_ETC1_RGB        # 4 bpp
  PIXELFORMAT_COMPRESSED_ETC2_RGB        # 4 bpp
  PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA   # 8 bpp
  PIXELFORMAT_COMPRESSED_PVRT_RGB        # 4 bpp
  PIXELFORMAT_COMPRESSED_PVRT_RGBA       # 4 bpp
  PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA   # 8 bpp
  PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA   # 2 bpp
converter PixelFormat2int32*(self: PixelFormat): int32 = self.int32
# Texture parameters: filter mode
# NOTE 1: Filtering considers mipmaps if available in the texture
# NOTE 2: Filter is accordingly set for minification and magnification
type TextureFilter* = enum
  TEXTURE_FILTER_POINT = 0      # No filter, just pixel aproximation
  TEXTURE_FILTER_BILINEAR       # Linear filtering
  TEXTURE_FILTER_TRILINEAR      # Trilinear filtering (linear with mipmaps)
  TEXTURE_FILTER_ANISOTROPIC_4X # Anisotropic filtering 4x
  TEXTURE_FILTER_ANISOTROPIC_8X # Anisotropic filtering 8x
  TEXTURE_FILTER_ANISOTROPIC_16X # Anisotropic filtering 16x
converter TextureFilter2int32*(self: TextureFilter): int32 = self.int32
# Texture parameters: wrap mode
type TextureWrap* = enum
  TEXTURE_WRAP_REPEAT = 0    # Repeats texture in tiled mode
  TEXTURE_WRAP_CLAMP         # Clamps texture to edge pixel in tiled mode
  TEXTURE_WRAP_MIRROR_REPEAT # Mirrors and repeats the texture in tiled mode
  TEXTURE_WRAP_MIRROR_CLAMP  # Mirrors and clamps to border the texture in tiled mode
converter TextureWrap2int32*(self: TextureWrap): int32 = self.int32
# Cubemap layouts
type CubemapLayout* = enum
  CUBEMAP_LAYOUT_AUTO_DETECT = 0 # Automatically detect layout type
  CUBEMAP_LAYOUT_LINE_VERTICAL   # Layout is defined by a vertical line with faces
  CUBEMAP_LAYOUT_LINE_HORIZONTAL # Layout is defined by an horizontal line with faces
  CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR # Layout is defined by a 3x4 cross with cubemap faces
  CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE # Layout is defined by a 4x3 cross with cubemap faces
  CUBEMAP_LAYOUT_PANORAMA        # Layout is defined by a panorama image (equirectangular map)
converter CubemapLayout2int32*(self: CubemapLayout): int32 = self.int32
# Font type, defines generation method
type FontType* = enum
  FONT_DEFAULT = 0 # Default font generation, anti-aliased
  FONT_BITMAP      # Bitmap font generation, no anti-aliasing
  FONT_SDF         # SDF font generation, requires external shader
converter FontType2int32*(self: FontType): int32 = self.int32
# Color blending modes (pre-defined)
type BlendMode* = enum
  BLEND_ALPHA = 0       # Blend textures considering alpha (default)
  BLEND_ADDITIVE        # Blend textures adding colors
  BLEND_MULTIPLIED      # Blend textures multiplying colors
  BLEND_ADD_COLORS      # Blend textures adding colors (alternative)
  BLEND_SUBTRACT_COLORS # Blend textures subtracting colors (alternative)
  BLEND_CUSTOM          # Belnd textures using custom src/dst factors (use rlSetBlendMode())
converter BlendMode2int32*(self: BlendMode): int32 = self.int32
# Gesture
# NOTE: It could be used as flags to enable only some gestures
type Gesture* = enum
  GESTURE_NONE = 0         # No gesture
  GESTURE_TAP = 1          # Tap gesture
  GESTURE_DOUBLETAP = 2    # Double tap gesture
  GESTURE_HOLD = 4         # Hold gesture
  GESTURE_DRAG = 8         # Drag gesture
  GESTURE_SWIPE_RIGHT = 16 # Swipe right gesture
  GESTURE_SWIPE_LEFT = 32  # Swipe left gesture
  GESTURE_SWIPE_UP = 64    # Swipe up gesture
  GESTURE_SWIPE_DOWN = 128 # Swipe down gesture
  GESTURE_PINCH_IN = 256   # Pinch in gesture
  GESTURE_PINCH_OUT = 512  # Pinch out gesture
converter Gesture2int32*(self: Gesture): int32 = self.int32
# Camera system modes
type CameraMode* = enum
  CAMERA_CUSTOM = 0   # Custom camera
  CAMERA_FREE         # Free camera
  CAMERA_ORBITAL      # Orbital camera
  CAMERA_FIRST_PERSON # First person camera
  CAMERA_THIRD_PERSON # Third person camera
converter CameraMode2int32*(self: CameraMode): int32 = self.int32
# Camera projection
type CameraProjection* = enum
  CAMERA_PERSPECTIVE = 0 # Perspective projection
  CAMERA_ORTHOGRAPHIC    # Orthographic projection
converter CameraProjection2int32*(self: CameraProjection): int32 = self.int32
# N-patch layout
type NPatchLayout* = enum
  NPATCH_NINE_PATCH = 0       # Npatch layout: 3x3 tiles
  NPATCH_THREE_PATCH_VERTICAL # Npatch layout: 1x3 tiles
  NPATCH_THREE_PATCH_HORIZONTAL # Npatch layout: 3x1 tiles
converter NPatchLayout2int32*(self: NPatchLayout): int32 = self.int32
# Callbacks to hook some internal functions
# WARNING: This callbacks are intended for advance users
type TraceLogCallback* = proc()
type LoadFileDataCallback* = proc(): uint8
type SaveFileDataCallback* = proc(): bool
type LoadFileTextCallback* = proc(): char
type SaveFileTextCallback* = proc(): bool
# ------------------------------------------------------------------------------------
# Global Variables Definition
# ------------------------------------------------------------------------------------
# It's lonely here...
# ------------------------------------------------------------------------------------
# Window and Graphics Device Functions (Module: core)
# ------------------------------------------------------------------------------------
# Window-related functions
proc InitWindow*(width: int32; height: int32; title: cstring) {.RLAPI,
    importc: "InitWindow".} # Initialize window and OpenGL context
proc WindowShouldClose*(): bool {.RLAPI,
    importc: "WindowShouldClose".} # Check if KEY_ESCAPE pressed or Close icon pressed
proc CloseWindow*() {.RLAPI, importc: "CloseWindow".} # Close window and unload OpenGL context
proc IsWindowReady*(): bool {.RLAPI, importc: "IsWindowReady".} # Check if window has been initialized successfully
proc IsWindowFullscreen*(): bool {.RLAPI,
    importc: "IsWindowFullscreen".} # Check if window is currently fullscreen
proc IsWindowHidden*(): bool {.RLAPI, importc: "IsWindowHidden".} # Check if window is currently hidden (only PLATFORM_DESKTOP)
proc IsWindowMinimized*(): bool {.RLAPI,
    importc: "IsWindowMinimized".} # Check if window is currently minimized (only PLATFORM_DESKTOP)
proc IsWindowMaximized*(): bool {.RLAPI,
    importc: "IsWindowMaximized".} # Check if window is currently maximized (only PLATFORM_DESKTOP)
proc IsWindowFocused*(): bool {.RLAPI, importc: "IsWindowFocused".} # Check if window is currently focused (only PLATFORM_DESKTOP)
proc IsWindowResized*(): bool {.RLAPI, importc: "IsWindowResized".} # Check if window has been resized last frame
proc IsWindowState*(flag: uint32): bool {.RLAPI,
    importc: "IsWindowState".} # Check if one specific window flag is enabled
proc SetWindowState*(flags: uint32) {.RLAPI,
    importc: "SetWindowState".} # Set window configuration state using flags
proc ClearWindowState*(flags: uint32) {.RLAPI,
    importc: "ClearWindowState".} # Clear window configuration state flags
proc ToggleFullscreen*() {.RLAPI, importc: "ToggleFullscreen".} # Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
proc MaximizeWindow*() {.RLAPI, importc: "MaximizeWindow".} # Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
proc MinimizeWindow*() {.RLAPI, importc: "MinimizeWindow".} # Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
proc RestoreWindow*() {.RLAPI, importc: "RestoreWindow".} # Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
proc SetWindowIcon*(image: Image) {.RLAPI,
    importc: "SetWindowIcon".} # Set icon for window (only PLATFORM_DESKTOP)
proc SetWindowTitle*(title: cstring) {.RLAPI,
    importc: "SetWindowTitle".} # Set title for window (only PLATFORM_DESKTOP)
proc SetWindowPosition*(x: int32; y: int32) {.RLAPI,
    importc: "SetWindowPosition".} # Set window position on screen (only PLATFORM_DESKTOP)
proc SetWindowMonitor*(monitor: int32) {.RLAPI,
    importc: "SetWindowMonitor".} # Set monitor for the current window (fullscreen mode)
proc SetWindowMinSize*(width: int32; height: int32) {.RLAPI,
    importc: "SetWindowMinSize".} # Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
proc SetWindowSize*(width: int32; height: int32) {.RLAPI,
    importc: "SetWindowSize".} # Set window dimensions
proc GetWindowHandle*(): pointer {.RLAPI,
    importc: "GetWindowHandle".} # Get native window handle
proc GetScreenWidth*(): int32 {.RLAPI, importc: "GetScreenWidth".} # Get current screen width
proc GetScreenHeight*(): int32 {.RLAPI, importc: "GetScreenHeight".} # Get current screen height
proc GetMonitorCount*(): int32 {.RLAPI, importc: "GetMonitorCount".} # Get number of connected monitors
proc GetCurrentMonitor*(): int32 {.RLAPI,
    importc: "GetCurrentMonitor".} # Get current connected monitor
proc GetMonitorPosition*(monitor: int32): Vector2 {.RLAPI,
    importc: "GetMonitorPosition".} # Get specified monitor position
proc GetMonitorWidth*(monitor: int32): int32 {.RLAPI,
    importc: "GetMonitorWidth".} # Get specified monitor width (max available by monitor)
proc GetMonitorHeight*(monitor: int32): int32 {.RLAPI,
    importc: "GetMonitorHeight".} # Get specified monitor height (max available by monitor)
proc GetMonitorPhysicalWidth*(monitor: int32): int32 {.RLAPI,
    importc: "GetMonitorPhysicalWidth".} # Get specified monitor physical width in millimetres
proc GetMonitorPhysicalHeight*(monitor: int32): int32 {.RLAPI,
    importc: "GetMonitorPhysicalHeight".} # Get specified monitor physical height in millimetres
proc GetMonitorRefreshRate*(monitor: int32): int32 {.RLAPI,
    importc: "GetMonitorRefreshRate".} # Get specified monitor refresh rate
proc GetWindowPosition*(): Vector2 {.RLAPI,
    importc: "GetWindowPosition".} # Get window position XY on monitor
proc GetWindowScaleDPI*(): Vector2 {.RLAPI,
    importc: "GetWindowScaleDPI".} # Get window scale DPI factor
proc GetMonitorName*(monitor: int32): cstring {.RLAPI,
    importc: "GetMonitorName".} # Get the human-readable, UTF-8 encoded name of the primary monitor
proc SetClipboardText*(text: cstring) {.RLAPI,
    importc: "SetClipboardText".} # Set clipboard text content
proc GetClipboardText*(): cstring {.RLAPI,
    importc: "GetClipboardText".} # Get clipboard text content
# Custom frame control functions
# NOTE: Those functions are intended for advance users that want full control over the frame processing
# By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timming + PollInputEvents()
# To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
proc SwapScreenBuffer*() {.RLAPI, importc: "SwapScreenBuffer".} # Swap back buffer with front buffer (screen drawing)
proc PollInputEvents*() {.RLAPI, importc: "PollInputEvents".} # Register all input events
proc WaitTime*(ms: float32) {.RLAPI, importc: "WaitTime".} # Wait for some milliseconds (halt program execution)
# Cursor-related functions
proc ShowCursor*() {.RLAPI, importc: "ShowCursor".} # Shows cursor
proc HideCursor*() {.RLAPI, importc: "HideCursor".} # Hides cursor
proc IsCursorHidden*(): bool {.RLAPI, importc: "IsCursorHidden".} # Check if cursor is not visible
proc EnableCursor*() {.RLAPI, importc: "EnableCursor".} # Enables cursor (unlock cursor)
proc DisableCursor*() {.RLAPI, importc: "DisableCursor".} # Disables cursor (lock cursor)
proc IsCursorOnScreen*(): bool {.RLAPI, importc: "IsCursorOnScreen".} # Check if cursor is on the screen
# Drawing-related functions
proc ClearBackground*(color: Color) {.RLAPI,
    importc: "ClearBackground".} # Set background color (framebuffer clear color)
proc BeginDrawing*() {.RLAPI, importc: "BeginDrawing".} # Setup canvas (framebuffer) to start drawing
proc EndDrawing*() {.RLAPI, importc: "EndDrawing".} # End canvas drawing and swap buffers (double buffering)
proc BeginMode2D*(camera: Camera2D) {.RLAPI,
    importc: "BeginMode2D".} # Begin 2D mode with custom camera (2D)
proc EndMode2D*() {.RLAPI, importc: "EndMode2D".} # Ends 2D mode with custom camera
proc BeginMode3D*(camera: Camera3D) {.RLAPI,
    importc: "BeginMode3D".} # Begin 3D mode with custom camera (3D)
proc EndMode3D*() {.RLAPI, importc: "EndMode3D".} # Ends 3D mode and returns to default 2D orthographic mode
proc BeginTextureMode*(target: RenderTexture2D) {.RLAPI,
    importc: "BeginTextureMode".} # Begin drawing to render texture
proc EndTextureMode*() {.RLAPI, importc: "EndTextureMode".} # Ends drawing to render texture
proc BeginShaderMode*(shader: Shader) {.RLAPI,
    importc: "BeginShaderMode".} # Begin custom shader drawing
proc EndShaderMode*() {.RLAPI, importc: "EndShaderMode".} # End custom shader drawing (use default shader)
proc BeginBlendMode*(mode: int32) {.RLAPI,
    importc: "BeginBlendMode".} # Begin blending mode (alpha, additive, multiplied, subtract, custom)
proc EndBlendMode*() {.RLAPI, importc: "EndBlendMode".} # End blending mode (reset to default: alpha blending)
proc BeginScissorMode*(x: int32; y: int32; width: int32; height: int32) {.RLAPI,
    importc: "BeginScissorMode".} # Begin scissor mode (define screen area for following drawing)
proc EndScissorMode*() {.RLAPI, importc: "EndScissorMode".} # End scissor mode
proc BeginVrStereoMode*(config: VrStereoConfig) {.RLAPI,
    importc: "BeginVrStereoMode".} # Begin stereo rendering (requires VR simulator)
proc EndVrStereoMode*() {.RLAPI, importc: "EndVrStereoMode".} # End stereo rendering (requires VR simulator)
# VR stereo config functions for VR simulator
proc LoadVrStereoConfig*(device: VrDeviceInfo): VrStereoConfig {.RLAPI,
    importc: "LoadVrStereoConfig".} # Load VR stereo config for VR simulator device parameters
proc UnloadVrStereoConfig*(config: VrStereoConfig) {.RLAPI,
    importc: "UnloadVrStereoConfig".} # Unload VR stereo config
# Shader management functions
# NOTE: Shader functionality is not available on OpenGL 1.1
proc LoadShader*(vsFileName: cstring; fsFileName: cstring): Shader {.RLAPI,
    importc: "LoadShader".} # Load shader from files and bind default locations
proc LoadShaderFromMemory*(vsCode: cstring; fsCode: cstring): Shader {.RLAPI,
    importc: "LoadShaderFromMemory".} # Load shader from code strings and bind default locations
proc GetShaderLocation*(shader: Shader; uniformName: cstring): int32 {.RLAPI,
    importc: "GetShaderLocation".} # Get shader uniform location
proc GetShaderLocationAttrib*(shader: Shader; attribName: cstring): int32 {.
    RLAPI, importc: "GetShaderLocationAttrib".} # Get shader attribute location
proc SetShaderValue*(shader: Shader; locIndex: int32; value: pointer;
    uniformType: int32) {.RLAPI, importc: "SetShaderValue".} # Set shader uniform value
proc SetShaderValueV*(shader: Shader; locIndex: int32; value: pointer;
    uniformType: int32; count: int32) {.RLAPI,
    importc: "SetShaderValueV".} # Set shader uniform value vector
proc SetShaderValueMatrix*(shader: Shader; locIndex: int32; mat: Matrix) {.
    RLAPI, importc: "SetShaderValueMatrix".} # Set shader uniform value (matrix 4x4)
proc SetShaderValueTexture*(shader: Shader; locIndex: int32;
    texture: Texture2D) {.RLAPI,
    importc: "SetShaderValueTexture".} # Set shader uniform value for texture (sampler2d)
proc UnloadShader*(shader: Shader) {.RLAPI,
    importc: "UnloadShader".} # Unload shader from GPU memory (VRAM)
# Screen-space-related functions
proc GetMouseRay*(mousePosition: Vector2; camera: Camera): Ray {.RLAPI,
    importc: "GetMouseRay".} # Get a ray trace from mouse position
proc GetCameraMatrix*(camera: Camera): Matrix {.RLAPI,
    importc: "GetCameraMatrix".} # Get camera transform matrix (view matrix)
proc GetCameraMatrix2D*(camera: Camera2D): Matrix {.RLAPI,
    importc: "GetCameraMatrix2D".} # Get camera 2d transform matrix
proc GetWorldToScreen*(position: Vector3; camera: Camera): Vector2 {.RLAPI,
    importc: "GetWorldToScreen".} # Get the screen space position for a 3d world space position
proc GetWorldToScreenEx*(position: Vector3; camera: Camera; width: int32;
    height: int32): Vector2 {.RLAPI,
    importc: "GetWorldToScreenEx".} # Get size position for a 3d world space position
proc GetWorldToScreen2D*(position: Vector2; camera: Camera2D): Vector2 {.RLAPI,
    importc: "GetWorldToScreen2D".} # Get the screen space position for a 2d camera world space position
proc GetScreenToWorld2D*(position: Vector2; camera: Camera2D): Vector2 {.RLAPI,
    importc: "GetScreenToWorld2D".} # Get the world space position for a 2d camera screen space position
# Timing-related functions
proc SetTargetFPS*(fps: int32) {.RLAPI, importc: "SetTargetFPS".} # Set target FPS (maximum)
proc GetFPS*(): int32 {.RLAPI, importc: "GetFPS".} # Get current FPS
proc GetFrameTime*(): float32 {.RLAPI, importc: "GetFrameTime".} # Get time in seconds for last frame drawn (delta time)
proc GetTime*(): float64 {.RLAPI, importc: "GetTime".} # Get elapsed time in seconds since InitWindow()
# Misc. functions
proc GetRandomValue*(min: int32; max: int32): int32 {.RLAPI,
    importc: "GetRandomValue".} # Get a random value between min and max (both included)
proc SetRandomSeed*(seed: uint32) {.RLAPI,
    importc: "SetRandomSeed".} # Set the seed for the random number generator
proc TakeScreenshot*(fileName: cstring) {.RLAPI,
    importc: "TakeScreenshot".} # Takes a screenshot of current screen (filename extension defines format)
proc SetConfigFlags*(flags: uint32) {.RLAPI,
    importc: "SetConfigFlags".} # Setup init configuration flags (view FLAGS)
proc TraceLog*(logLevel: int32; text: cstring) {.RLAPI, varargs,
    importc: "TraceLog".} # Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
proc SetTraceLogLevel*(logLevel: int32) {.RLAPI,
    importc: "SetTraceLogLevel".} # Set the current threshold (minimum) log level
proc MemAlloc*(size: int32): pointer {.RLAPI,
    importc: "MemAlloc".} # Internal memory allocator
proc MemRealloc*(ptrx: pointer; size: int32): pointer {.RLAPI,
    importc: "MemRealloc".} # Internal memory reallocator
proc MemFree*(ptrx: pointer) {.RLAPI, importc: "MemFree".} # Internal memory free
# Set custom callbacks
# WARNING: Callbacks setup is intended for advance users
proc SetTraceLogCallback*(callback: TraceLogCallback) {.RLAPI,
    importc: "SetTraceLogCallback".} # Set custom trace log
proc SetLoadFileDataCallback*(callback: LoadFileDataCallback) {.RLAPI,
    importc: "SetLoadFileDataCallback".} # Set custom file binary data loader
proc SetSaveFileDataCallback*(callback: SaveFileDataCallback) {.RLAPI,
    importc: "SetSaveFileDataCallback".} # Set custom file binary data saver
proc SetLoadFileTextCallback*(callback: LoadFileTextCallback) {.RLAPI,
    importc: "SetLoadFileTextCallback".} # Set custom file text data loader
proc SetSaveFileTextCallback*(callback: SaveFileTextCallback) {.RLAPI,
    importc: "SetSaveFileTextCallback".} # Set custom file text data saver
# Files management functions
proc LoadFileData*(fileName: cstring; bytesRead: uint32): uint8 {.RLAPI,
    importc: "LoadFileData".} # Load file data as byte array (read)
proc UnloadFileData*(data: uint8) {.RLAPI,
    importc: "UnloadFileData".} # Unload file data allocated by LoadFileData()
proc SaveFileData*(fileName: cstring; data: pointer;
    bytesToWrite: uint32): bool {.RLAPI,
    importc: "SaveFileData".} # Save data to file from byte array (write), returns true on success
proc LoadFileText*(fileName: cstring): ptr char {.RLAPI,
    importc: "LoadFileText".} # Load text data from file (read), returns a '\0' terminated string
proc UnloadFileText*(text: ptr char) {.RLAPI,
    importc: "UnloadFileText".} # Unload file text data allocated by LoadFileText()
proc SaveFileText*(fileName: cstring; text: ptr char): bool {.RLAPI,
    importc: "SaveFileText".} # Save text data to file (write), string must be '\0' terminated, returns true on success
proc FileExists*(fileName: cstring): bool {.RLAPI,
    importc: "FileExists".} # Check if file exists
proc DirectoryExists*(dirPath: cstring): bool {.RLAPI,
    importc: "DirectoryExists".} # Check if a directory path exists
proc IsFileExtension*(fileName: cstring; ext: cstring): bool {.RLAPI,
    importc: "IsFileExtension".} # Check file extension (including point: .png, .wav)
proc GetFileExtension*(fileName: cstring): cstring {.RLAPI,
    importc: "GetFileExtension".} # Get pointer to extension for a filename string (includes dot: '.png')
proc GetFileName*(filePath: cstring): cstring {.RLAPI,
    importc: "GetFileName".} # Get pointer to filename for a path string
proc GetFileNameWithoutExt*(filePath: cstring): cstring {.RLAPI,
    importc: "GetFileNameWithoutExt".} # Get filename string without extension (uses static string)
proc GetDirectoryPath*(filePath: cstring): cstring {.RLAPI,
    importc: "GetDirectoryPath".} # Get full path for a given fileName with path (uses static string)
proc GetPrevDirectoryPath*(dirPath: cstring): cstring {.RLAPI,
    importc: "GetPrevDirectoryPath".} # Get previous directory path for a given path (uses static string)
proc GetWorkingDirectory*(): cstring {.RLAPI,
    importc: "GetWorkingDirectory".} # Get current working directory (uses static string)
proc GetDirectoryFiles*(dirPath: cstring; count: pointer): cstringArray {.RLAPI,
    importc: "GetDirectoryFiles".} # Get filenames in a directory path (memory should be freed)
proc ClearDirectoryFiles*() {.RLAPI, importc: "ClearDirectoryFiles".} # Clear directory files paths buffers (free memory)
proc ChangeDirectory*(dir: cstring): bool {.RLAPI,
    importc: "ChangeDirectory".} # Change working directory, return true on success
proc IsFileDropped*(): bool {.RLAPI, importc: "IsFileDropped".} # Check if a file has been dropped into window
proc GetDroppedFiles*(count: pointer): cstringArray {.RLAPI,
    importc: "GetDroppedFiles".} # Get dropped files names (memory should be freed)
proc ClearDroppedFiles*() {.RLAPI, importc: "ClearDroppedFiles".} # Clear dropped files paths buffer (free memory)
proc GetFileModTime*(fileName: cstring): int32 {.RLAPI,
    importc: "GetFileModTime".} # Get file modification time (last write time)
proc CompressData*(data: uint8; dataLength: int32;
    compDataLength: pointer): uint8 {.RLAPI,
    importc: "CompressData".} # Compress data (DEFLATE algorithm)
proc DecompressData*(compData: uint8; compDataLength: int32;
    dataLength: pointer): uint8 {.RLAPI,
    importc: "DecompressData".} # Decompress data (DEFLATE algorithm)
# Persistent storage management
proc SaveStorageValue*(position: uint32; value: int32): bool {.RLAPI,
    importc: "SaveStorageValue".} # Save integer value to storage file (to defined position), returns true on success
proc LoadStorageValue*(position: uint32): int32 {.RLAPI,
    importc: "LoadStorageValue".} # Load integer value from storage file (from defined position)
proc OpenURL*(url: cstring) {.RLAPI, importc: "OpenURL".} # Open URL with default system browser (if available)
# ------------------------------------------------------------------------------------
# Input Handling Functions (Module: core)
# ------------------------------------------------------------------------------------
# Input-related functions: keyboard
proc IsKeyPressed*(key: int32): bool {.RLAPI,
    importc: "IsKeyPressed".} # Check if a key has been pressed once
proc IsKeyDown*(key: int32): bool {.RLAPI,
    importc: "IsKeyDown".} # Check if a key is being pressed
proc IsKeyReleased*(key: int32): bool {.RLAPI,
    importc: "IsKeyReleased".} # Check if a key has been released once
proc IsKeyUp*(key: int32): bool {.RLAPI,
    importc: "IsKeyUp".} # Check if a key is NOT being pressed
proc SetExitKey*(key: int32) {.RLAPI, importc: "SetExitKey".} # Set a custom key to exit program (default is ESC)
proc GetKeyPressed*(): int32 {.RLAPI, importc: "GetKeyPressed".} # Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
proc GetCharPressed*(): int32 {.RLAPI, importc: "GetCharPressed".} # Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
# Input-related functions: gamepads
proc IsGamepadAvailable*(gamepad: int32): bool {.RLAPI,
    importc: "IsGamepadAvailable".} # Check if a gamepad is available
proc IsGamepadName*(gamepad: int32; name: cstring): bool {.RLAPI,
    importc: "IsGamepadName".} # Check gamepad name (if available)
proc GetGamepadName*(gamepad: int32): cstring {.RLAPI,
    importc: "GetGamepadName".} # Get gamepad internal name id
proc IsGamepadButtonPressed*(gamepad: int32; button: int32): bool {.RLAPI,
    importc: "IsGamepadButtonPressed".} # Check if a gamepad button has been pressed once
proc IsGamepadButtonDown*(gamepad: int32; button: int32): bool {.RLAPI,
    importc: "IsGamepadButtonDown".} # Check if a gamepad button is being pressed
proc IsGamepadButtonReleased*(gamepad: int32; button: int32): bool {.RLAPI,
    importc: "IsGamepadButtonReleased".} # Check if a gamepad button has been released once
proc IsGamepadButtonUp*(gamepad: int32; button: int32): bool {.RLAPI,
    importc: "IsGamepadButtonUp".} # Check if a gamepad button is NOT being pressed
proc GetGamepadButtonPressed*(): int32 {.RLAPI,
    importc: "GetGamepadButtonPressed".} # Get the last gamepad button pressed
proc GetGamepadAxisCount*(gamepad: int32): int32 {.RLAPI,
    importc: "GetGamepadAxisCount".} # Get gamepad axis count for a gamepad
proc GetGamepadAxisMovement*(gamepad: int32; axis: int32): float32 {.RLAPI,
    importc: "GetGamepadAxisMovement".} # Get axis movement value for a gamepad axis
proc SetGamepadMappings*(mappings: cstring): int32 {.RLAPI,
    importc: "SetGamepadMappings".} # Set internal gamepad mappings (SDL_GameControllerDB)
# Input-related functions: mouse
proc IsMouseButtonPressed*(button: int32): bool {.RLAPI,
    importc: "IsMouseButtonPressed".} # Check if a mouse button has been pressed once
proc IsMouseButtonDown*(button: int32): bool {.RLAPI,
    importc: "IsMouseButtonDown".} # Check if a mouse button is being pressed
proc IsMouseButtonReleased*(button: int32): bool {.RLAPI,
    importc: "IsMouseButtonReleased".} # Check if a mouse button has been released once
proc IsMouseButtonUp*(button: int32): bool {.RLAPI,
    importc: "IsMouseButtonUp".} # Check if a mouse button is NOT being pressed
proc GetMouseX*(): int32 {.RLAPI, importc: "GetMouseX".} # Get mouse position X
proc GetMouseY*(): int32 {.RLAPI, importc: "GetMouseY".} # Get mouse position Y
proc GetMousePosition*(): Vector2 {.RLAPI,
    importc: "GetMousePosition".} # Get mouse position XY
proc GetMouseDelta*(): Vector2 {.RLAPI, importc: "GetMouseDelta".} # Get mouse delta between frames
proc SetMousePosition*(x: int32; y: int32) {.RLAPI,
    importc: "SetMousePosition".} # Set mouse position XY
proc SetMouseOffset*(offsetX: int32; offsetY: int32) {.RLAPI,
    importc: "SetMouseOffset".} # Set mouse offset
proc SetMouseScale*(scaleX: float32; scaleY: float32) {.RLAPI,
    importc: "SetMouseScale".} # Set mouse scaling
proc GetMouseWheelMove*(): float32 {.RLAPI,
    importc: "GetMouseWheelMove".} # Get mouse wheel movement Y
proc SetMouseCursor*(cursor: int32) {.RLAPI, importc: "SetMouseCursor".} # Set mouse cursor
# Input-related functions: touch
proc GetTouchX*(): int32 {.RLAPI, importc: "GetTouchX".} # Get touch position X for touch point 0 (relative to screen size)
proc GetTouchY*(): int32 {.RLAPI, importc: "GetTouchY".} # Get touch position Y for touch point 0 (relative to screen size)
proc GetTouchPosition*(index: int32): Vector2 {.RLAPI,
    importc: "GetTouchPosition".} # Get touch position XY for a touch point index (relative to screen size)
proc GetTouchPointId*(index: int32): int32 {.RLAPI,
    importc: "GetTouchPointId".} # Get touch point identifier for given index
proc GetTouchPointCount*(): int32 {.RLAPI,
    importc: "GetTouchPointCount".} # Get number of touch points
proc GetTouchEvent*(): int32 {.RLAPI, importc: "GetTouchEvent".} # Get last touch event registered
# ------------------------------------------------------------------------------------
# Gestures and Touch Handling Functions (Module: rgestures)
# ------------------------------------------------------------------------------------
proc SetGesturesEnabled*(flags: uint32) {.RLAPI,
    importc: "SetGesturesEnabled".} # Enable a set of gestures using flags
proc IsGestureDetected*(gesture: int32): bool {.RLAPI,
    importc: "IsGestureDetected".} # Check if a gesture have been detected
proc GetGestureDetected*(): int32 {.RLAPI,
    importc: "GetGestureDetected".} # Get latest detected gesture
proc GetGestureHoldDuration*(): float32 {.RLAPI,
    importc: "GetGestureHoldDuration".} # Get gesture hold time in milliseconds
proc GetGestureDragVector*(): Vector2 {.RLAPI,
    importc: "GetGestureDragVector".} # Get gesture drag vector
proc GetGestureDragAngle*(): float32 {.RLAPI,
    importc: "GetGestureDragAngle".} # Get gesture drag angle
proc GetGesturePinchVector*(): Vector2 {.RLAPI,
    importc: "GetGesturePinchVector".} # Get gesture pinch delta
proc GetGesturePinchAngle*(): float32 {.RLAPI,
    importc: "GetGesturePinchAngle".} # Get gesture pinch angle
# ------------------------------------------------------------------------------------
# Camera System Functions (Module: rcamera)
# ------------------------------------------------------------------------------------
proc SetCameraMode*(camera: Camera; mode: int32) {.RLAPI,
    importc: "SetCameraMode".} # Set camera mode (multiple camera modes available)
proc UpdateCamera*(camera: ptr Camera) {.RLAPI,
    importc: "UpdateCamera".} # Update camera position for selected mode
proc SetCameraPanControl*(keyPan: int32) {.RLAPI,
    importc: "SetCameraPanControl".} # Set camera pan key to combine with mouse movement (free camera)
proc SetCameraAltControl*(keyAlt: int32) {.RLAPI,
    importc: "SetCameraAltControl".} # Set camera alt key to combine with mouse movement (free camera)
proc SetCameraSmoothZoomControl*(keySmoothZoom: int32) {.RLAPI,
    importc: "SetCameraSmoothZoomControl".} # Set camera smooth zoom key to combine with mouse (free camera)
proc SetCameraMoveControls*(keyFront: int32; keyBack: int32; keyRight: int32;
    keyLeft: int32; keyUp: int32; keyDown: int32) {.RLAPI,
    importc: "SetCameraMoveControls".} # Set camera move controls (1st person and 3rd person cameras)
# ------------------------------------------------------------------------------------
# Basic Shapes Drawing Functions (Module: shapes)
# ------------------------------------------------------------------------------------
# Set texture and rectangle to be used on shapes drawing
# NOTE: It can be useful when using basic shapes and one single font,
# defining a font char white rectangle would allow drawing everything in a single draw call
proc SetShapesTexture*(texture: Texture2D; source: Rectangle) {.RLAPI,
    importc: "SetShapesTexture".} # Set texture and rectangle to be used on shapes drawing
# Basic shapes drawing functions
proc DrawPixel*(posX: int32; posY: int32; color: Color) {.RLAPI,
    importc: "DrawPixel".} # Draw a pixel
proc DrawPixelV*(position: Vector2; color: Color) {.RLAPI,
    importc: "DrawPixelV".} # Draw a pixel (Vector version)
proc DrawLine*(startPosX: int32; startPosY: int32; endPosX: int32;
    endPosY: int32; color: Color) {.RLAPI, importc: "DrawLine".} # Draw a line
proc DrawLineV*(startPos: Vector2; endPos: Vector2; color: Color) {.RLAPI,
    importc: "DrawLineV".} # Draw a line (Vector version)
proc DrawLineEx*(startPos: Vector2; endPos: Vector2; thick: float32;
    color: Color) {.RLAPI, importc: "DrawLineEx".} # Draw a line defining thickness
proc DrawLineBezier*(startPos: Vector2; endPos: Vector2; thick: float32;
    color: Color) {.RLAPI,
    importc: "DrawLineBezier".} # Draw a line using cubic-bezier curves in-out
proc DrawLineBezierQuad*(startPos: Vector2; endPos: Vector2;
    controlPos: Vector2; thick: float32; color: Color) {.RLAPI,
    importc: "DrawLineBezierQuad".} # Draw line using quadratic bezier curves with a control point
proc DrawLineBezierCubic*(startPos: Vector2; endPos: Vector2;
    startControlPos: Vector2; endControlPos: Vector2; thick: float32;
    color: Color) {.RLAPI,
    importc: "DrawLineBezierCubic".} # Draw line using cubic bezier curves with 2 control points
proc DrawLineStrip*(points: ptr Vector2; pointCount: int32; color: Color) {.
    RLAPI, importc: "DrawLineStrip".} # Draw lines sequence
proc DrawCircle*(centerX: int32; centerY: int32; radius: float32;
    color: Color) {.RLAPI, importc: "DrawCircle".} # Draw a color-filled circle
proc DrawCircleSector*(center: Vector2; radius: float32; startAngle: float32;
    endAngle: float32; segments: int32; color: Color) {.RLAPI,
    importc: "DrawCircleSector".} # Draw a piece of a circle
proc DrawCircleSectorLines*(center: Vector2; radius: float32;
    startAngle: float32; endAngle: float32; segments: int32; color: Color) {.
    RLAPI, importc: "DrawCircleSectorLines".} # Draw circle sector outline
proc DrawCircleGradient*(centerX: int32; centerY: int32; radius: float32;
    color1: Color; color2: Color) {.RLAPI,
    importc: "DrawCircleGradient".} # Draw a gradient-filled circle
proc DrawCircleV*(center: Vector2; radius: float32; color: Color) {.RLAPI,
    importc: "DrawCircleV".} # Draw a color-filled circle (Vector version)
proc DrawCircleLines*(centerX: int32; centerY: int32; radius: float32;
    color: Color) {.RLAPI, importc: "DrawCircleLines".} # Draw circle outline
proc DrawEllipse*(centerX: int32; centerY: int32; radiusH: float32;
    radiusV: float32; color: Color) {.RLAPI, importc: "DrawEllipse".} # Draw ellipse
proc DrawEllipseLines*(centerX: int32; centerY: int32; radiusH: float32;
    radiusV: float32; color: Color) {.RLAPI,
    importc: "DrawEllipseLines".} # Draw ellipse outline
proc DrawRing*(center: Vector2; innerRadius: float32; outerRadius: float32;
    startAngle: float32; endAngle: float32; segments: int32; color: Color) {.
    RLAPI, importc: "DrawRing".} # Draw ring
proc DrawRingLines*(center: Vector2; innerRadius: float32; outerRadius: float32;
    startAngle: float32; endAngle: float32; segments: int32; color: Color) {.
    RLAPI, importc: "DrawRingLines".} # Draw ring outline
proc DrawRectangle*(posX: int32; posY: int32; width: int32; height: int32;
    color: Color) {.RLAPI, importc: "DrawRectangle".} # Draw a color-filled rectangle
proc DrawRectangleV*(position: Vector2; size: Vector2; color: Color) {.RLAPI,
    importc: "DrawRectangleV".} # Draw a color-filled rectangle (Vector version)
proc DrawRectangleRec*(rec: Rectangle; color: Color) {.RLAPI,
    importc: "DrawRectangleRec".} # Draw a color-filled rectangle
proc DrawRectanglePro*(rec: Rectangle; origin: Vector2; rotation: float32;
    color: Color) {.RLAPI,
    importc: "DrawRectanglePro".} # Draw a color-filled rectangle with pro parameters
proc DrawRectangleGradientV*(posX: int32; posY: int32; width: int32;
    height: int32; color1: Color; color2: Color) {.RLAPI,
    importc: "DrawRectangleGradientV".} # Draw a vertical-gradient-filled rectangle
proc DrawRectangleGradientH*(posX: int32; posY: int32; width: int32;
    height: int32; color1: Color; color2: Color) {.RLAPI,
    importc: "DrawRectangleGradientH".} # Draw a horizontal-gradient-filled rectangle
proc DrawRectangleGradientEx*(rec: Rectangle; col1: Color; col2: Color;
    col3: Color; col4: Color) {.RLAPI,
    importc: "DrawRectangleGradientEx".} # Draw a gradient-filled rectangle with custom vertex colors
proc DrawRectangleLines*(posX: int32; posY: int32; width: int32; height: int32;
    color: Color) {.RLAPI, importc: "DrawRectangleLines".} # Draw rectangle outline
proc DrawRectangleLinesEx*(rec: Rectangle; lineThick: float32; color: Color) {.
    RLAPI, importc: "DrawRectangleLinesEx".} # Draw rectangle outline with extended parameters
proc DrawRectangleRounded*(rec: Rectangle; roundness: float32; segments: int32;
    color: Color) {.RLAPI,
    importc: "DrawRectangleRounded".} # Draw rectangle with rounded edges
proc DrawRectangleRoundedLines*(rec: Rectangle; roundness: float32;
    segments: int32; lineThick: float32; color: Color) {.RLAPI,
    importc: "DrawRectangleRoundedLines".} # Draw rectangle with rounded edges outline
proc DrawTriangle*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color) {.RLAPI,
    importc: "DrawTriangle".} # Draw a color-filled triangle (vertex in counter-clockwise order!)
proc DrawTriangleLines*(v1: Vector2; v2: Vector2; v3: Vector2; color: Color) {.
    RLAPI,
    importc: "DrawTriangleLines".} # Draw triangle outline (vertex in counter-clockwise order!)
proc DrawTriangleFan*(points: ptr Vector2; pointCount: int32; color: Color) {.
    RLAPI,
    importc: "DrawTriangleFan".} # Draw a triangle fan defined by points (first vertex is the center)
proc DrawTriangleStrip*(points: ptr Vector2; pointCount: int32; color: Color) {.
    RLAPI, importc: "DrawTriangleStrip".} # Draw a triangle strip defined by points
proc DrawPoly*(center: Vector2; sides: int32; radius: float32;
    rotation: float32; color: Color) {.RLAPI,
    importc: "DrawPoly".} # Draw a regular polygon (Vector version)
proc DrawPolyLines*(center: Vector2; sides: int32; radius: float32;
    rotation: float32; color: Color) {.RLAPI,
    importc: "DrawPolyLines".} # Draw a polygon outline of n sides
proc DrawPolyLinesEx*(center: Vector2; sides: int32; radius: float32;
    rotation: float32; lineThick: float32; color: Color) {.RLAPI,
    importc: "DrawPolyLinesEx".} # Draw a polygon outline of n sides with extended parameters
# Basic shapes collision detection functions
proc CheckCollisionRecs*(rec1: Rectangle; rec2: Rectangle): bool {.RLAPI,
    importc: "CheckCollisionRecs".} # Check collision between two rectangles
proc CheckCollisionCircles*(center1: Vector2; radius1: float32;
    center2: Vector2; radius2: float32): bool {.RLAPI,
    importc: "CheckCollisionCircles".} # Check collision between two circles
proc CheckCollisionCircleRec*(center: Vector2; radius: float32;
    rec: Rectangle): bool {.RLAPI,
    importc: "CheckCollisionCircleRec".} # Check collision between circle and rectangle
proc CheckCollisionPointRec*(point: Vector2; rec: Rectangle): bool {.RLAPI,
    importc: "CheckCollisionPointRec".} # Check if point is inside rectangle
proc CheckCollisionPointCircle*(point: Vector2; center: Vector2;
    radius: float32): bool {.RLAPI,
    importc: "CheckCollisionPointCircle".} # Check if point is inside circle
proc CheckCollisionPointTriangle*(point: Vector2; p1: Vector2; p2: Vector2;
    p3: Vector2): bool {.RLAPI,
    importc: "CheckCollisionPointTriangle".} # Check if point is inside a triangle
proc CheckCollisionLines*(startPos1: Vector2; endPos1: Vector2;
    startPos2: Vector2; endPos2: Vector2; collisionPoint: ptr Vector2): bool {.
    RLAPI,
    importc: "CheckCollisionLines".} # Check the collision between two lines defined by two points each, returns collision point by reference
proc GetCollisionRec*(rec1: Rectangle; rec2: Rectangle): Rectangle {.RLAPI,
    importc: "GetCollisionRec".} # Get collision rectangle for two rectangles collision
# ------------------------------------------------------------------------------------
# Texture Loading and Drawing Functions (Module: textures)
# ------------------------------------------------------------------------------------
# Image loading functions
# NOTE: This functions do not require GPU access
proc LoadImage*(fileName: cstring): Image {.RLAPI,
    importc: "LoadImage".} # Load image from file into CPU memory (RAM)
proc LoadImageRaw*(fileName: cstring; width: int32; height: int32;
    format: int32; headerSize: int32): Image {.RLAPI,
    importc: "LoadImageRaw".} # Load image from RAW file data
proc LoadImageAnim*(fileName: cstring; frames: pointer): Image {.RLAPI,
    importc: "LoadImageAnim".} # Load image sequence from file (frames appended to image.data)
proc LoadImageFromMemory*(fileType: cstring; fileData: UncheckedArray[byte];
    dataSize: int32): Image {.RLAPI,
    importc: "LoadImageFromMemory".} # Load image from memory buffer, fileType refers to extension: i.e. '.png'
proc LoadImageFromTexture*(texture: Texture2D): Image {.RLAPI,
    importc: "LoadImageFromTexture".} # Load image from GPU texture data
proc LoadImageFromScreen*(): Image {.RLAPI,
    importc: "LoadImageFromScreen".} # Load image from screen buffer and (screenshot)
proc UnloadImage*(image: Image) {.RLAPI,
    importc: "UnloadImage".} # Unload image from CPU memory (RAM)
proc ExportImage*(image: Image; fileName: cstring): bool {.RLAPI,
    importc: "ExportImage".} # Export image data to file, returns true on success
proc ExportImageAsCode*(image: Image; fileName: cstring): bool {.RLAPI,
    importc: "ExportImageAsCode".} # Export image as code file defining an array of bytes, returns true on success
# Image generation functions
proc GenImageColor*(width: int32; height: int32; color: Color): Image {.RLAPI,
    importc: "GenImageColor".} # Generate image: plain color
proc GenImageGradientV*(width: int32; height: int32; top: Color;
    bottom: Color): Image {.RLAPI,
    importc: "GenImageGradientV".} # Generate image: vertical gradient
proc GenImageGradientH*(width: int32; height: int32; left: Color;
    right: Color): Image {.RLAPI,
    importc: "GenImageGradientH".} # Generate image: horizontal gradient
proc GenImageGradientRadial*(width: int32; height: int32; density: float32;
    inner: Color; outer: Color): Image {.RLAPI,
    importc: "GenImageGradientRadial".} # Generate image: radial gradient
proc GenImageChecked*(width: int32; height: int32; checksX: int32;
    checksY: int32; col1: Color; col2: Color): Image {.RLAPI,
    importc: "GenImageChecked".} # Generate image: checked
proc GenImageWhiteNoise*(width: int32; height: int32; factor: float32): Image {.
    RLAPI, importc: "GenImageWhiteNoise".} # Generate image: white noise
proc GenImageCellular*(width: int32; height: int32; tileSize: int32): Image {.
    RLAPI,
    importc: "GenImageCellular".} # Generate image: cellular algorithm, bigger tileSize means bigger cells
# Image manipulation functions
proc ImageCopy*(image: Image): Image {.RLAPI,
    importc: "ImageCopy".} # Create an image duplicate (useful for transformations)
proc ImageFromImage*(image: Image; rec: Rectangle): Image {.RLAPI,
    importc: "ImageFromImage".} # Create an image from another image piece
proc ImageText*(text: cstring; fontSize: int32; color: Color): Image {.RLAPI,
    importc: "ImageText".} # Create an image from text (default font)
proc ImageTextEx*(font: Font; text: cstring; fontSize: float32;
    spacing: float32; tint: Color): Image {.RLAPI,
    importc: "ImageTextEx".} # Create an image from text (custom sprite font)
proc ImageFormat*(image: ptr Image; newFormat: int32) {.RLAPI,
    importc: "ImageFormat".} # Convert image data to desired format
proc ImageToPOT*(image: ptr Image; fill: Color) {.RLAPI,
    importc: "ImageToPOT".} # Convert image to POT (power-of-two)
proc ImageCrop*(image: ptr Image; crop: Rectangle) {.RLAPI,
    importc: "ImageCrop".} # Crop an image to a defined rectangle
proc ImageAlphaCrop*(image: ptr Image; threshold: float32) {.RLAPI,
    importc: "ImageAlphaCrop".} # Crop image depending on alpha value
proc ImageAlphaClear*(image: ptr Image; color: Color; threshold: float32) {.
    RLAPI, importc: "ImageAlphaClear".} # Clear alpha channel to desired color
proc ImageAlphaMask*(image: ptr Image; alphaMask: Image) {.RLAPI,
    importc: "ImageAlphaMask".} # Apply alpha mask to image
proc ImageAlphaPremultiply*(image: ptr Image) {.RLAPI,
    importc: "ImageAlphaPremultiply".} # Premultiply alpha channel
proc ImageResize*(image: ptr Image; newWidth: int32; newHeight: int32) {.RLAPI,
    importc: "ImageResize".} # Resize image (Bicubic scaling algorithm)
proc ImageResizeNN*(image: ptr Image; newWidth: int32; newHeight: int32) {.
    RLAPI, importc: "ImageResizeNN".} # Resize image (Nearest-Neighbor scaling algorithm)
proc ImageResizeCanvas*(image: ptr Image; newWidth: int32; newHeight: int32;
    offsetX: int32; offsetY: int32; fill: Color) {.RLAPI,
    importc: "ImageResizeCanvas".} # Resize canvas and fill with color
proc ImageMipmaps*(image: ptr Image) {.RLAPI,
    importc: "ImageMipmaps".} # Compute all mipmap levels for a provided image
proc ImageDither*(image: ptr Image; rBpp: int32; gBpp: int32; bBpp: int32;
    aBpp: int32) {.RLAPI,
    importc: "ImageDither".} # Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
proc ImageFlipVertical*(image: ptr Image) {.RLAPI,
    importc: "ImageFlipVertical".} # Flip image vertically
proc ImageFlipHorizontal*(image: ptr Image) {.RLAPI,
    importc: "ImageFlipHorizontal".} # Flip image horizontally
proc ImageRotateCW*(image: ptr Image) {.RLAPI,
    importc: "ImageRotateCW".} # Rotate image clockwise 90deg
proc ImageRotateCCW*(image: ptr Image) {.RLAPI,
    importc: "ImageRotateCCW".} # Rotate image counter-clockwise 90deg
proc ImageColorTint*(image: ptr Image; color: Color) {.RLAPI,
    importc: "ImageColorTint".} # Modify image color: tint
proc ImageColorInvert*(image: ptr Image) {.RLAPI,
    importc: "ImageColorInvert".} # Modify image color: invert
proc ImageColorGrayscale*(image: ptr Image) {.RLAPI,
    importc: "ImageColorGrayscale".} # Modify image color: grayscale
proc ImageColorContrast*(image: ptr Image; contrast: float32) {.RLAPI,
    importc: "ImageColorContrast".} # Modify image color: contrast (-100 to 100)
proc ImageColorBrightness*(image: ptr Image; brightness: int32) {.RLAPI,
    importc: "ImageColorBrightness".} # Modify image color: brightness (-255 to 255)
proc ImageColorReplace*(image: ptr Image; color: Color; replace: Color) {.RLAPI,
    importc: "ImageColorReplace".} # Modify image color: replace color
proc LoadImageColors*(image: Image): ptr Color {.RLAPI,
    importc: "LoadImageColors".} # Load color data from image as a Color array (RGBA - 32bit)
proc LoadImagePalette*(image: Image; maxPaletteSize: int32;
    colorCount: pointer): ptr Color {.RLAPI,
    importc: "LoadImagePalette".} # Load colors palette from image as a Color array (RGBA - 32bit)
proc UnloadImageColors*(colors: ptr Color) {.RLAPI,
    importc: "UnloadImageColors".} # Unload color data loaded with LoadImageColors()
proc UnloadImagePalette*(colors: ptr Color) {.RLAPI,
    importc: "UnloadImagePalette".} # Unload colors palette loaded with LoadImagePalette()
proc GetImageAlphaBorder*(image: Image; threshold: float32): Rectangle {.RLAPI,
    importc: "GetImageAlphaBorder".} # Get image alpha border rectangle
proc GetImageColor*(image: Image; x: int32; y: int32): Color {.RLAPI,
    importc: "GetImageColor".} # Get image pixel color at (x, y) position
# Image drawing functions
# NOTE: Image software-rendering functions (CPU)
proc ImageClearBackground*(dst: ptr Image; color: Color) {.RLAPI,
    importc: "ImageClearBackground".} # Clear image background with given color
proc ImageDrawPixel*(dst: ptr Image; posX: int32; posY: int32; color: Color) {.
    RLAPI, importc: "ImageDrawPixel".} # Draw pixel within an image
proc ImageDrawPixelV*(dst: ptr Image; position: Vector2; color: Color) {.RLAPI,
    importc: "ImageDrawPixelV".} # Draw pixel within an image (Vector version)
proc ImageDrawLine*(dst: ptr Image; startPosX: int32; startPosY: int32;
    endPosX: int32; endPosY: int32; color: Color) {.RLAPI,
    importc: "ImageDrawLine".} # Draw line within an image
proc ImageDrawLineV*(dst: ptr Image; start: Vector2; endx: Vector2;
    color: Color) {.RLAPI,
    importc: "ImageDrawLineV".} # Draw line within an image (Vector version)
proc ImageDrawCircle*(dst: ptr Image; centerX: int32; centerY: int32;
    radius: int32; color: Color) {.RLAPI,
    importc: "ImageDrawCircle".} # Draw circle within an image
proc ImageDrawCircleV*(dst: ptr Image; center: Vector2; radius: int32;
    color: Color) {.RLAPI,
    importc: "ImageDrawCircleV".} # Draw circle within an image (Vector version)
proc ImageDrawRectangle*(dst: ptr Image; posX: int32; posY: int32; width: int32;
    height: int32; color: Color) {.RLAPI,
    importc: "ImageDrawRectangle".} # Draw rectangle within an image
proc ImageDrawRectangleV*(dst: ptr Image; position: Vector2; size: Vector2;
    color: Color) {.RLAPI,
    importc: "ImageDrawRectangleV".} # Draw rectangle within an image (Vector version)
proc ImageDrawRectangleRec*(dst: ptr Image; rec: Rectangle; color: Color) {.
    RLAPI, importc: "ImageDrawRectangleRec".} # Draw rectangle within an image
proc ImageDrawRectangleLines*(dst: ptr Image; rec: Rectangle; thick: int32;
    color: Color) {.RLAPI,
    importc: "ImageDrawRectangleLines".} # Draw rectangle lines within an image
proc ImageDraw*(dst: ptr Image; src: Image; srcRec: Rectangle;
    dstRec: Rectangle; tint: Color) {.RLAPI,
    importc: "ImageDraw".} # Draw a source image within a destination image (tint applied to source)
proc ImageDrawText*(dst: ptr Image; text: cstring; posX: int32; posY: int32;
    fontSize: int32; color: Color) {.RLAPI,
    importc: "ImageDrawText".} # Draw text (using default font) within an image (destination)
proc ImageDrawTextEx*(dst: ptr Image; font: Font; text: cstring;
    position: Vector2; fontSize: float32; spacing: float32; tint: Color) {.
    RLAPI,
    importc: "ImageDrawTextEx".} # Draw text (custom sprite font) within an image (destination)
# Texture loading functions
# NOTE: These functions require GPU access
proc LoadTexture*(fileName: cstring): Texture2D {.RLAPI,
    importc: "LoadTexture".} # Load texture from file into GPU memory (VRAM)
proc LoadTextureFromImage*(image: Image): Texture2D {.RLAPI,
    importc: "LoadTextureFromImage".} # Load texture from image data
proc LoadTextureCubemap*(image: Image; layout: int32): TextureCubemap {.RLAPI,
    importc: "LoadTextureCubemap".} # Load cubemap from image, multiple image cubemap layouts supported
proc LoadRenderTexture*(width: int32; height: int32): RenderTexture2D {.RLAPI,
    importc: "LoadRenderTexture".} # Load texture for rendering (framebuffer)
proc UnloadTexture*(texture: Texture2D) {.RLAPI,
    importc: "UnloadTexture".} # Unload texture from GPU memory (VRAM)
proc UnloadRenderTexture*(target: RenderTexture2D) {.RLAPI,
    importc: "UnloadRenderTexture".} # Unload render texture from GPU memory (VRAM)
proc UpdateTexture*(texture: Texture2D; pixels: pointer) {.RLAPI,
    importc: "UpdateTexture".} # Update GPU texture with new data
proc UpdateTextureRec*(texture: Texture2D; rec: Rectangle; pixels: pointer) {.
    RLAPI, importc: "UpdateTextureRec".} # Update GPU texture rectangle with new data
# Texture configuration functions
proc GenTextureMipmaps*(texture: ptr Texture2D) {.RLAPI,
    importc: "GenTextureMipmaps".} # Generate GPU mipmaps for a texture
proc SetTextureFilter*(texture: Texture2D; filter: int32) {.RLAPI,
    importc: "SetTextureFilter".} # Set texture scaling filter mode
proc SetTextureWrap*(texture: Texture2D; wrap: int32) {.RLAPI,
    importc: "SetTextureWrap".} # Set texture wrapping mode
# Texture drawing functions
proc DrawTexture*(texture: Texture2D; posX: int32; posY: int32; tint: Color) {.
    RLAPI, importc: "DrawTexture".} # Draw a Texture2D
proc DrawTextureV*(texture: Texture2D; position: Vector2; tint: Color) {.RLAPI,
    importc: "DrawTextureV".} # Draw a Texture2D with position defined as Vector2
proc DrawTextureEx*(texture: Texture2D; position: Vector2; rotation: float32;
    scale: float32; tint: Color) {.RLAPI,
    importc: "DrawTextureEx".} # Draw a Texture2D with extended parameters
proc DrawTextureRec*(texture: Texture2D; source: Rectangle; position: Vector2;
    tint: Color) {.RLAPI,
    importc: "DrawTextureRec".} # Draw a part of a texture defined by a rectangle
proc DrawTextureQuad*(texture: Texture2D; tiling: Vector2; offset: Vector2;
    quad: Rectangle; tint: Color) {.RLAPI,
    importc: "DrawTextureQuad".} # Draw texture quad with tiling and offset parameters
proc DrawTextureTiled*(texture: Texture2D; source: Rectangle; dest: Rectangle;
    origin: Vector2; rotation: float32; scale: float32; tint: Color) {.RLAPI,
    importc: "DrawTextureTiled".} # Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
proc DrawTexturePro*(texture: Texture2D; source: Rectangle; dest: Rectangle;
    origin: Vector2; rotation: float32; tint: Color) {.RLAPI,
    importc: "DrawTexturePro".} # Draw a part of a texture defined by a rectangle with 'pro' parameters
proc DrawTextureNPatch*(texture: Texture2D; nPatchInfo: NPatchInfo;
    dest: Rectangle; origin: Vector2; rotation: float32; tint: Color) {.RLAPI,
    importc: "DrawTextureNPatch".} # Draws a texture (or part of it) that stretches or shrinks nicely
proc DrawTexturePoly*(texture: Texture2D; center: Vector2; points: ptr Vector2;
    texcoords: ptr Vector2; pointCount: int32; tint: Color) {.RLAPI,
    importc: "DrawTexturePoly".} # Draw a textured polygon
# Color/pixel related functions
proc Fade*(color: Color; alpha: float32): Color {.RLAPI,
    importc: "Fade".} # Get color with alpha applied, alpha goes from 0.0f to 1.0f
proc ColorToInt*(color: Color): int32 {.RLAPI,
    importc: "ColorToInt".} # Get hexadecimal value for a Color
proc ColorNormalize*(color: Color): Vector4 {.RLAPI,
    importc: "ColorNormalize".} # Get Color normalized as float [0..1]
proc ColorFromNormalized*(normalized: Vector4): Color {.RLAPI,
    importc: "ColorFromNormalized".} # Get Color from normalized values [0..1]
proc ColorToHSV*(color: Color): Vector3 {.RLAPI,
    importc: "ColorToHSV".} # Get HSV values for a Color, hue [0..360], saturation/value [0..1]
proc ColorFromHSV*(hue: float32; saturation: float32; value: float32): Color {.
    RLAPI,
    importc: "ColorFromHSV".} # Get a Color from HSV values, hue [0..360], saturation/value [0..1]
proc ColorAlpha*(color: Color; alpha: float32): Color {.RLAPI,
    importc: "ColorAlpha".} # Get color with alpha applied, alpha goes from 0.0f to 1.0f
proc ColorAlphaBlend*(dst: Color; src: Color; tint: Color): Color {.RLAPI,
    importc: "ColorAlphaBlend".} # Get src alpha-blended into dst color with tint
proc GetColor*(hexValue: uint32): Color {.RLAPI,
    importc: "GetColor".} # Get Color structure from hexadecimal value
proc GetPixelColor*(srcPtr: pointer; format: int32): Color {.RLAPI,
    importc: "GetPixelColor".} # Get Color from a source pixel pointer of certain format
proc SetPixelColor*(dstPtr: pointer; color: Color; format: int32) {.RLAPI,
    importc: "SetPixelColor".} # Set color formatted into destination pixel pointer
proc GetPixelDataSize*(width: int32; height: int32; format: int32): int32 {.
    RLAPI, importc: "GetPixelDataSize".} # Get pixel data size in bytes for certain format
# ------------------------------------------------------------------------------------
# Font Loading and Text Drawing Functions (Module: text)
# ------------------------------------------------------------------------------------
# Font loading/unloading functions
proc GetFontDefault*(): Font {.RLAPI, importc: "GetFontDefault".} # Get the default Font
proc LoadFont*(fileName: cstring): Font {.RLAPI,
    importc: "LoadFont".} # Load font from file into GPU memory (VRAM)
proc LoadFontEx*(fileName: cstring; fontSize: int32; fontChars: pointer;
    glyphCount: int32): Font {.RLAPI,
    importc: "LoadFontEx".} # Load font from file with extended parameters
proc LoadFontFromImage*(image: Image; key: Color; firstChar: int32): Font {.
    RLAPI, importc: "LoadFontFromImage".} # Load font from Image (XNA style)
proc LoadFontFromMemory*(fileType: cstring; fileData: UncheckedArray[byte];
    dataSize: int32; fontSize: int32; fontChars: pointer;
    glyphCount: int32): Font {.RLAPI,
    importc: "LoadFontFromMemory".} # Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
proc LoadFontData*(fileData: UncheckedArray[byte]; dataSize: int32;
    fontSize: int32; fontChars: pointer; glyphCount: int32;
    typex: int32): ptr GlyphInfo {.RLAPI,
    importc: "LoadFontData".} # Load font data for further use
proc GenImageFontAtlas*(chars: ptr ptr GlyphInfo; recs: ptr Rectangle;
    glyphCount: int32; fontSize: int32; padding: int32;
    packMethod: int32): Image {.RLAPI,
    importc: "GenImageFontAtlas".} # Generate image font atlas using chars info
proc UnloadFontData*(chars: ptr GlyphInfo; glyphCount: int32) {.RLAPI,
    importc: "UnloadFontData".} # Unload font chars info data (RAM)
proc UnloadFont*(font: Font) {.RLAPI, importc: "UnloadFont".} # Unload Font from GPU memory (VRAM)
# Text drawing functions
proc DrawFPS*(posX: int32; posY: int32) {.RLAPI, importc: "DrawFPS".} # Draw current FPS
proc DrawText*(text: cstring; posX: int32; posY: int32; fontSize: int32;
    color: Color) {.RLAPI, importc: "DrawText".} # Draw text (using default font)
proc DrawTextEx*(font: Font; text: cstring; position: Vector2;
    fontSize: float32; spacing: float32; tint: Color) {.RLAPI,
    importc: "DrawTextEx".} # Draw text using font and additional parameters
proc DrawTextPro*(font: Font; text: cstring; position: Vector2; origin: Vector2;
    rotation: float32; fontSize: float32; spacing: float32; tint: Color) {.
    RLAPI, importc: "DrawTextPro".} # Draw text using Font and pro parameters (rotation)
proc DrawTextCodepoint*(font: Font; codepoint: int32; position: Vector2;
    fontSize: float32; tint: Color) {.RLAPI,
    importc: "DrawTextCodepoint".} # Draw one character (codepoint)
# Text font info functions
proc MeasureText*(text: cstring; fontSize: int32): int32 {.RLAPI,
    importc: "MeasureText".} # Measure string width for default font
proc MeasureTextEx*(font: Font; text: cstring; fontSize: float32;
    spacing: float32): Vector2 {.RLAPI,
    importc: "MeasureTextEx".} # Measure string size for Font
proc GetGlyphIndex*(font: Font; codepoint: int32): int32 {.RLAPI,
    importc: "GetGlyphIndex".} # Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
proc GetGlyphInfo*(font: Font; codepoint: int32): GlyphInfo {.RLAPI,
    importc: "GetGlyphInfo".} # Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
proc GetGlyphAtlasRec*(font: Font; codepoint: int32): Rectangle {.RLAPI,
    importc: "GetGlyphAtlasRec".} # Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
# Text codepoints management functions (unicode characters)
proc LoadCodepoints*(text: cstring; count: pointer): pointer {.RLAPI,
    importc: "LoadCodepoints".} # Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
proc UnloadCodepoints*(codepoints: pointer) {.RLAPI,
    importc: "UnloadCodepoints".} # Unload codepoints data from memory
proc GetCodepointCount*(text: cstring): int32 {.RLAPI,
    importc: "GetCodepointCount".} # Get total number of codepoints in a UTF-8 encoded string
proc GetCodepoint*(text: cstring; bytesProcessed: pointer): int32 {.RLAPI,
    importc: "GetCodepoint".} # Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
proc CodepointToUTF8*(codepoint: int32; byteSize: pointer): cstring {.RLAPI,
    importc: "CodepointToUTF8".} # Encode one codepoint into UTF-8 byte array (array length returned as parameter)
proc TextCodepointsToUTF8*(codepoints: pointer; length: int32): ptr char {.
    RLAPI,
    importc: "TextCodepointsToUTF8".} # Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)
# Text strings management functions (no UTF-8 strings, only byte chars)
# NOTE: Some strings allocate memory internally for returned strings, just be careful!
proc TextCopy*(dst: ptr char; src: cstring): int32 {.RLAPI,
    importc: "TextCopy".} # Copy one string to another, returns bytes copied
proc TextIsEqual*(text1: cstring; text2: cstring): bool {.RLAPI,
    importc: "TextIsEqual".} # Check if two text string are equal
proc TextLength*(text: cstring): uint32 {.RLAPI,
    importc: "TextLength".} # Get text length, checks for '\0' ending
proc TextFormat*(text: cstring): cstring {.RLAPI, varargs,
    importc: "TextFormat".} # Text formatting with variables (sprintf() style)
proc TextSubtext*(text: cstring; position: int32; length: int32): cstring {.
    RLAPI, importc: "TextSubtext".} # Get a piece of a text string
proc TextReplace*(text: ptr char; replace: cstring; by: cstring): ptr char {.
    RLAPI, importc: "TextReplace".} # Replace text string (WARNING: memory must be freed!)
proc TextInsert*(text: cstring; insert: cstring; position: int32): ptr char {.
    RLAPI,
    importc: "TextInsert".} # Insert text in a position (WARNING: memory must be freed!)
proc TextJoin*(textList: cstring; count: int32; delimiter: cstring): cstring {.
    RLAPI, importc: "TextJoin".} # Join text strings with delimiter
proc TextSplit*(text: cstring; delimiter: char; count: pointer): cstring {.
    RLAPI, importc: "TextSplit".} # Split text into multiple strings
proc TextAppend*(text: ptr char; append: cstring; position: pointer) {.RLAPI,
    importc: "TextAppend".} # Append text at specific position and move cursor!
proc TextFindIndex*(text: cstring; find: cstring): int32 {.RLAPI,
    importc: "TextFindIndex".} # Find first text occurrence within a string
proc TextToUpper*(text: cstring): cstring {.RLAPI,
    importc: "TextToUpper".} # Get upper case version of provided string
proc TextToLower*(text: cstring): cstring {.RLAPI,
    importc: "TextToLower".} # Get lower case version of provided string
proc TextToPascal*(text: cstring): cstring {.RLAPI,
    importc: "TextToPascal".} # Get Pascal case notation version of provided string
proc TextToInteger*(text: cstring): int32 {.RLAPI,
    importc: "TextToInteger".} # Get integer value from text (negative values not supported)
# ------------------------------------------------------------------------------------
# Basic 3d Shapes Drawing Functions (Module: models)
# ------------------------------------------------------------------------------------
# Basic geometric 3D shapes drawing functions
proc DrawLine3D*(startPos: Vector3; endPos: Vector3; color: Color) {.RLAPI,
    importc: "DrawLine3D".} # Draw a line in 3D world space
proc DrawPoint3D*(position: Vector3; color: Color) {.RLAPI,
    importc: "DrawPoint3D".} # Draw a point in 3D space, actually a small line
proc DrawCircle3D*(center: Vector3; radius: float32; rotationAxis: Vector3;
    rotationAngle: float32; color: Color) {.RLAPI,
    importc: "DrawCircle3D".} # Draw a circle in 3D world space
proc DrawTriangle3D*(v1: Vector3; v2: Vector3; v3: Vector3; color: Color) {.
    RLAPI,
    importc: "DrawTriangle3D".} # Draw a color-filled triangle (vertex in counter-clockwise order!)
proc DrawTriangleStrip3D*(points: ptr Vector3; pointCount: int32;
    color: Color) {.RLAPI,
    importc: "DrawTriangleStrip3D".} # Draw a triangle strip defined by points
proc DrawCube*(position: Vector3; width: float32; height: float32;
    length: float32; color: Color) {.RLAPI, importc: "DrawCube".} # Draw cube
proc DrawCubeV*(position: Vector3; size: Vector3; color: Color) {.RLAPI,
    importc: "DrawCubeV".} # Draw cube (Vector version)
proc DrawCubeWires*(position: Vector3; width: float32; height: float32;
    length: float32; color: Color) {.RLAPI, importc: "DrawCubeWires".} # Draw cube wires
proc DrawCubeWiresV*(position: Vector3; size: Vector3; color: Color) {.RLAPI,
    importc: "DrawCubeWiresV".} # Draw cube wires (Vector version)
proc DrawCubeTexture*(texture: Texture2D; position: Vector3; width: float32;
    height: float32; length: float32; color: Color) {.RLAPI,
    importc: "DrawCubeTexture".} # Draw cube textured
proc DrawCubeTextureRec*(texture: Texture2D; source: Rectangle;
    position: Vector3; width: float32; height: float32; length: float32;
    color: Color) {.RLAPI,
    importc: "DrawCubeTextureRec".} # Draw cube with a region of a texture
proc DrawSphere*(centerPos: Vector3; radius: float32; color: Color) {.RLAPI,
    importc: "DrawSphere".} # Draw sphere
proc DrawSphereEx*(centerPos: Vector3; radius: float32; rings: int32;
    slices: int32; color: Color) {.RLAPI,
    importc: "DrawSphereEx".} # Draw sphere with extended parameters
proc DrawSphereWires*(centerPos: Vector3; radius: float32; rings: int32;
    slices: int32; color: Color) {.RLAPI, importc: "DrawSphereWires".} # Draw sphere wires
proc DrawCylinder*(position: Vector3; radiusTop: float32; radiusBottom: float32;
    height: float32; slices: int32; color: Color) {.RLAPI,
    importc: "DrawCylinder".} # Draw a cylinder/cone
proc DrawCylinderWires*(position: Vector3; radiusTop: float32;
    radiusBottom: float32; height: float32; slices: int32; color: Color) {.
    RLAPI, importc: "DrawCylinderWires".} # Draw a cylinder/cone wires
proc DrawPlane*(centerPos: Vector3; size: Vector2; color: Color) {.RLAPI,
    importc: "DrawPlane".} # Draw a plane XZ
proc DrawRay*(ray: Ray; color: Color) {.RLAPI, importc: "DrawRay".} # Draw a ray line
proc DrawGrid*(slices: int32; spacing: float32) {.RLAPI,
    importc: "DrawGrid".} # Draw a grid (centered at (0, 0, 0))
# ------------------------------------------------------------------------------------
# Model 3d Loading and Drawing Functions (Module: models)
# ------------------------------------------------------------------------------------
# Model management functions
proc LoadModel*(fileName: cstring): Model {.RLAPI,
    importc: "LoadModel".} # Load model from files (meshes and materials)
proc LoadModelFromMesh*(mesh: Mesh): Model {.RLAPI,
    importc: "LoadModelFromMesh".} # Load model from generated mesh (default material)
proc UnloadModel*(model: Model) {.RLAPI,
    importc: "UnloadModel".} # Unload model (including meshes) from memory (RAM and/or VRAM)
proc UnloadModelKeepMeshes*(model: Model) {.RLAPI,
    importc: "UnloadModelKeepMeshes".} # Unload model (but not meshes) from memory (RAM and/or VRAM)
proc GetModelBoundingBox*(model: Model): BoundingBox {.RLAPI,
    importc: "GetModelBoundingBox".} # Compute model bounding box limits (considers all meshes)
# Model drawing functions
proc DrawModel*(model: Model; position: Vector3; scale: float32; tint: Color) {.
    RLAPI, importc: "DrawModel".} # Draw a model (with texture if set)
proc DrawModelEx*(model: Model; position: Vector3; rotationAxis: Vector3;
    rotationAngle: float32; scale: Vector3; tint: Color) {.RLAPI,
    importc: "DrawModelEx".} # Draw a model with extended parameters
proc DrawModelWires*(model: Model; position: Vector3; scale: float32;
    tint: Color) {.RLAPI,
    importc: "DrawModelWires".} # Draw a model wires (with texture if set)
proc DrawModelWiresEx*(model: Model; position: Vector3; rotationAxis: Vector3;
    rotationAngle: float32; scale: Vector3; tint: Color) {.RLAPI,
    importc: "DrawModelWiresEx".} # Draw a model wires (with texture if set) with extended parameters
proc DrawBoundingBox*(box: BoundingBox; color: Color) {.RLAPI,
    importc: "DrawBoundingBox".} # Draw bounding box (wires)
proc DrawBillboard*(camera: Camera; texture: Texture2D; position: Vector3;
    size: float32; tint: Color) {.RLAPI, importc: "DrawBillboard".} # Draw a billboard texture
proc DrawBillboardRec*(camera: Camera; texture: Texture2D; source: Rectangle;
    position: Vector3; size: Vector2; tint: Color) {.RLAPI,
    importc: "DrawBillboardRec".} # Draw a billboard texture defined by source
proc DrawBillboardPro*(camera: Camera; texture: Texture2D; source: Rectangle;
    position: Vector3; up: Vector3; size: Vector2; origin: Vector2;
    rotation: float32; tint: Color) {.RLAPI,
    importc: "DrawBillboardPro".} # Draw a billboard texture defined by source and rotation
# Mesh management functions
proc UploadMesh*(mesh: ptr Mesh; dynamic: bool) {.RLAPI,
    importc: "UploadMesh".} # Upload mesh vertex data in GPU and provide VAO/VBO ids
proc UpdateMeshBuffer*(mesh: Mesh; index: int32; data: pointer; dataSize: int32;
    offset: int32) {.RLAPI,
    importc: "UpdateMeshBuffer".} # Update mesh vertex data in GPU for a specific buffer index
proc UnloadMesh*(mesh: Mesh) {.RLAPI, importc: "UnloadMesh".} # Unload mesh data from CPU and GPU
proc DrawMesh*(mesh: Mesh; material: Material; transform: Matrix) {.RLAPI,
    importc: "DrawMesh".} # Draw a 3d mesh with material and transform
proc DrawMeshInstanced*(mesh: Mesh; material: Material; transforms: ptr Matrix;
    instances: int32) {.RLAPI,
    importc: "DrawMeshInstanced".} # Draw multiple mesh instances with material and different transforms
proc ExportMesh*(mesh: Mesh; fileName: cstring): bool {.RLAPI,
    importc: "ExportMesh".} # Export mesh data to file, returns true on success
proc GetMeshBoundingBox*(mesh: Mesh): BoundingBox {.RLAPI,
    importc: "GetMeshBoundingBox".} # Compute mesh bounding box limits
proc GenMeshTangents*(mesh: ptr Mesh) {.RLAPI,
    importc: "GenMeshTangents".} # Compute mesh tangents
proc GenMeshBinormals*(mesh: ptr Mesh) {.RLAPI,
    importc: "GenMeshBinormals".} # Compute mesh binormals
# Mesh generation functions
proc GenMeshPoly*(sides: int32; radius: float32): Mesh {.RLAPI,
    importc: "GenMeshPoly".} # Generate polygonal mesh
proc GenMeshPlane*(width: float32; length: float32; resX: int32;
    resZ: int32): Mesh {.RLAPI,
    importc: "GenMeshPlane".} # Generate plane mesh (with subdivisions)
proc GenMeshCube*(width: float32; height: float32; length: float32): Mesh {.
    RLAPI, importc: "GenMeshCube".} # Generate cuboid mesh
proc GenMeshSphere*(radius: float32; rings: int32; slices: int32): Mesh {.RLAPI,
    importc: "GenMeshSphere".} # Generate sphere mesh (standard sphere)
proc GenMeshHemiSphere*(radius: float32; rings: int32; slices: int32): Mesh {.
    RLAPI, importc: "GenMeshHemiSphere".} # Generate half-sphere mesh (no bottom cap)
proc GenMeshCylinder*(radius: float32; height: float32; slices: int32): Mesh {.
    RLAPI, importc: "GenMeshCylinder".} # Generate cylinder mesh
proc GenMeshCone*(radius: float32; height: float32; slices: int32): Mesh {.
    RLAPI, importc: "GenMeshCone".} # Generate cone/pyramid mesh
proc GenMeshTorus*(radius: float32; size: float32; radSeg: int32;
    sides: int32): Mesh {.RLAPI, importc: "GenMeshTorus".} # Generate torus mesh
proc GenMeshKnot*(radius: float32; size: float32; radSeg: int32;
    sides: int32): Mesh {.RLAPI, importc: "GenMeshKnot".} # Generate trefoil knot mesh
proc GenMeshHeightmap*(heightmap: Image; size: Vector3): Mesh {.RLAPI,
    importc: "GenMeshHeightmap".} # Generate heightmap mesh from image data
proc GenMeshCubicmap*(cubicmap: Image; cubeSize: Vector3): Mesh {.RLAPI,
    importc: "GenMeshCubicmap".} # Generate cubes-based map mesh from image data
# Material loading/unloading functions
proc LoadMaterials*(fileName: cstring; materialCount: pointer): ptr Material {.
    RLAPI, importc: "LoadMaterials".} # Load materials from model file
proc LoadMaterialDefault*(): Material {.RLAPI,
    importc: "LoadMaterialDefault".} # Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
proc UnloadMaterial*(material: Material) {.RLAPI,
    importc: "UnloadMaterial".} # Unload material from GPU memory (VRAM)
proc SetMaterialTexture*(material: ptr Material; mapType: int32;
    texture: Texture2D) {.RLAPI,
    importc: "SetMaterialTexture".} # Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
proc SetModelMeshMaterial*(model: ptr Model; meshId: int32;
    materialId: int32) {.RLAPI, importc: "SetModelMeshMaterial".} # Set material for a mesh
# Model animations loading/unloading functions
proc LoadModelAnimations*(fileName: cstring;
    animCount: uint32): ptr ModelAnimation {.RLAPI,
    importc: "LoadModelAnimations".} # Load model animations from file
proc UpdateModelAnimation*(model: Model; anim: ModelAnimation; frame: int32) {.
    RLAPI, importc: "UpdateModelAnimation".} # Update model animation pose
proc UnloadModelAnimation*(anim: ModelAnimation) {.RLAPI,
    importc: "UnloadModelAnimation".} # Unload animation data
proc UnloadModelAnimations*(animations: proc(): ModelAnimation;
    count: uint32) {.RLAPI, importc: "UnloadModelAnimations".} # Unload animation array data
proc IsModelAnimationValid*(model: Model; anim: ModelAnimation): bool {.RLAPI,
    importc: "IsModelAnimationValid".} # Check model animation skeleton match
# Collision detection functions
proc CheckCollisionSpheres*(center1: Vector3; radius1: float32;
    center2: Vector3; radius2: float32): bool {.RLAPI,
    importc: "CheckCollisionSpheres".} # Check collision between two spheres
proc CheckCollisionBoxes*(box1: BoundingBox; box2: BoundingBox): bool {.RLAPI,
    importc: "CheckCollisionBoxes".} # Check collision between two bounding boxes
proc CheckCollisionBoxSphere*(box: BoundingBox; center: Vector3;
    radius: float32): bool {.RLAPI,
    importc: "CheckCollisionBoxSphere".} # Check collision between box and sphere
proc GetRayCollisionSphere*(ray: Ray; center: Vector3;
    radius: float32): RayCollision {.RLAPI,
    importc: "GetRayCollisionSphere".} # Get collision info between ray and sphere
proc GetRayCollisionBox*(ray: Ray; box: BoundingBox): RayCollision {.RLAPI,
    importc: "GetRayCollisionBox".} # Get collision info between ray and box
proc GetRayCollisionModel*(ray: Ray; model: Model): RayCollision {.RLAPI,
    importc: "GetRayCollisionModel".} # Get collision info between ray and model
proc GetRayCollisionMesh*(ray: Ray; mesh: Mesh;
    transform: Matrix): RayCollision {.RLAPI,
    importc: "GetRayCollisionMesh".} # Get collision info between ray and mesh
proc GetRayCollisionTriangle*(ray: Ray; p1: Vector3; p2: Vector3;
    p3: Vector3): RayCollision {.RLAPI,
    importc: "GetRayCollisionTriangle".} # Get collision info between ray and triangle
proc GetRayCollisionQuad*(ray: Ray; p1: Vector3; p2: Vector3; p3: Vector3;
    p4: Vector3): RayCollision {.RLAPI,
    importc: "GetRayCollisionQuad".} # Get collision info between ray and quad
# ------------------------------------------------------------------------------------
# Audio Loading and Playing Functions (Module: audio)
# ------------------------------------------------------------------------------------
# Audio device management functions
proc InitAudioDevice*() {.RLAPI, importc: "InitAudioDevice".} # Initialize audio device and context
proc CloseAudioDevice*() {.RLAPI, importc: "CloseAudioDevice".} # Close the audio device and context
proc IsAudioDeviceReady*(): bool {.RLAPI,
    importc: "IsAudioDeviceReady".} # Check if audio device has been initialized successfully
proc SetMasterVolume*(volume: float32) {.RLAPI,
    importc: "SetMasterVolume".} # Set master volume (listener)
# Wave/Sound loading/unloading functions
proc LoadWave*(fileName: cstring): Wave {.RLAPI,
    importc: "LoadWave".} # Load wave data from file
proc LoadWaveFromMemory*(fileType: cstring; fileData: UncheckedArray[byte];
    dataSize: int32): Wave {.RLAPI,
    importc: "LoadWaveFromMemory".} # Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
proc LoadSound*(fileName: cstring): Sound {.RLAPI,
    importc: "LoadSound".} # Load sound from file
proc LoadSoundFromWave*(wave: Wave): Sound {.RLAPI,
    importc: "LoadSoundFromWave".} # Load sound from wave data
proc UpdateSound*(sound: Sound; data: pointer; sampleCount: int32) {.RLAPI,
    importc: "UpdateSound".} # Update sound buffer with new data
proc UnloadWave*(wave: Wave) {.RLAPI, importc: "UnloadWave".} # Unload wave data
proc UnloadSound*(sound: Sound) {.RLAPI, importc: "UnloadSound".} # Unload sound
proc ExportWave*(wave: Wave; fileName: cstring): bool {.RLAPI,
    importc: "ExportWave".} # Export wave data to file, returns true on success
proc ExportWaveAsCode*(wave: Wave; fileName: cstring): bool {.RLAPI,
    importc: "ExportWaveAsCode".} # Export wave sample data to code (.h), returns true on success
# Wave/Sound management functions
proc PlaySound*(sound: Sound) {.RLAPI, importc: "PlaySound".} # Play a sound
proc StopSound*(sound: Sound) {.RLAPI, importc: "StopSound".} # Stop playing a sound
proc PauseSound*(sound: Sound) {.RLAPI, importc: "PauseSound".} # Pause a sound
proc ResumeSound*(sound: Sound) {.RLAPI, importc: "ResumeSound".} # Resume a paused sound
proc PlaySoundMulti*(sound: Sound) {.RLAPI,
    importc: "PlaySoundMulti".} # Play a sound (using multichannel buffer pool)
proc StopSoundMulti*() {.RLAPI, importc: "StopSoundMulti".} # Stop any sound playing (using multichannel buffer pool)
proc GetSoundsPlaying*(): int32 {.RLAPI,
    importc: "GetSoundsPlaying".} # Get number of sounds playing in the multichannel
proc IsSoundPlaying*(sound: Sound): bool {.RLAPI,
    importc: "IsSoundPlaying".} # Check if a sound is currently playing
proc SetSoundVolume*(sound: Sound; volume: float32) {.RLAPI,
    importc: "SetSoundVolume".} # Set volume for a sound (1.0 is max level)
proc SetSoundPitch*(sound: Sound; pitch: float32) {.RLAPI,
    importc: "SetSoundPitch".} # Set pitch for a sound (1.0 is base level)
proc WaveFormat*(wave: ptr Wave; sampleRate: int32; sampleSize: int32;
    channels: int32) {.RLAPI, importc: "WaveFormat".} # Convert wave data to desired format
proc WaveCopy*(wave: Wave): Wave {.RLAPI, importc: "WaveCopy".} # Copy a wave to a new wave
proc WaveCrop*(wave: ptr Wave; initSample: int32; finalSample: int32) {.RLAPI,
    importc: "WaveCrop".} # Crop a wave to defined samples range
proc LoadWaveSamples*(wave: Wave): float32 {.RLAPI,
    importc: "LoadWaveSamples".} # Load samples data from wave as a floats array
proc UnloadWaveSamples*(samples: float32) {.RLAPI,
    importc: "UnloadWaveSamples".} # Unload samples data loaded with LoadWaveSamples()
# Music management functions
proc LoadMusicStream*(fileName: cstring): Music {.RLAPI,
    importc: "LoadMusicStream".} # Load music stream from file
proc LoadMusicStreamFromMemory*(fileType: cstring; data: uint8;
    dataSize: int32): Music {.RLAPI,
    importc: "LoadMusicStreamFromMemory".} # Load music stream from data
proc UnloadMusicStream*(music: Music) {.RLAPI,
    importc: "UnloadMusicStream".} # Unload music stream
proc PlayMusicStream*(music: Music) {.RLAPI,
    importc: "PlayMusicStream".} # Start music playing
proc IsMusicStreamPlaying*(music: Music): bool {.RLAPI,
    importc: "IsMusicStreamPlaying".} # Check if music is playing
proc UpdateMusicStream*(music: Music) {.RLAPI,
    importc: "UpdateMusicStream".} # Updates buffers for music streaming
proc StopMusicStream*(music: Music) {.RLAPI, importc: "StopMusicStream".} # Stop music playing
proc PauseMusicStream*(music: Music) {.RLAPI,
    importc: "PauseMusicStream".} # Pause music playing
proc ResumeMusicStream*(music: Music) {.RLAPI,
    importc: "ResumeMusicStream".} # Resume playing paused music
proc SeekMusicStream*(music: Music; position: float32) {.RLAPI,
    importc: "SeekMusicStream".} # Seek music to a position (in seconds)
proc SetMusicVolume*(music: Music; volume: float32) {.RLAPI,
    importc: "SetMusicVolume".} # Set volume for music (1.0 is max level)
proc SetMusicPitch*(music: Music; pitch: float32) {.RLAPI,
    importc: "SetMusicPitch".} # Set pitch for a music (1.0 is base level)
proc GetMusicTimeLength*(music: Music): float32 {.RLAPI,
    importc: "GetMusicTimeLength".} # Get music time length (in seconds)
proc GetMusicTimePlayed*(music: Music): float32 {.RLAPI,
    importc: "GetMusicTimePlayed".} # Get current music time played (in seconds)
# AudioStream management functions
proc LoadAudioStream*(sampleRate: uint32; sampleSize: uint32;
    channels: uint32): AudioStream {.RLAPI,
    importc: "LoadAudioStream".} # Load audio stream (to stream raw audio pcm data)
proc UnloadAudioStream*(stream: AudioStream) {.RLAPI,
    importc: "UnloadAudioStream".} # Unload audio stream and free memory
proc UpdateAudioStream*(stream: AudioStream; data: pointer;
    frameCount: int32) {.RLAPI,
    importc: "UpdateAudioStream".} # Update audio stream buffers with data
proc IsAudioStreamProcessed*(stream: AudioStream): bool {.RLAPI,
    importc: "IsAudioStreamProcessed".} # Check if any audio stream buffers requires refill
proc PlayAudioStream*(stream: AudioStream) {.RLAPI,
    importc: "PlayAudioStream".} # Play audio stream
proc PauseAudioStream*(stream: AudioStream) {.RLAPI,
    importc: "PauseAudioStream".} # Pause audio stream
proc ResumeAudioStream*(stream: AudioStream) {.RLAPI,
    importc: "ResumeAudioStream".} # Resume audio stream
proc IsAudioStreamPlaying*(stream: AudioStream): bool {.RLAPI,
    importc: "IsAudioStreamPlaying".} # Check if audio stream is playing
proc StopAudioStream*(stream: AudioStream) {.RLAPI,
    importc: "StopAudioStream".} # Stop audio stream
proc SetAudioStreamVolume*(stream: AudioStream; volume: float32) {.RLAPI,
    importc: "SetAudioStreamVolume".} # Set volume for audio stream (1.0 is max level)
proc SetAudioStreamPitch*(stream: AudioStream; pitch: float32) {.RLAPI,
    importc: "SetAudioStreamPitch".} # Set pitch for audio stream (1.0 is base level)
proc SetAudioStreamBufferSizeDefault*(size: int32) {.RLAPI,
    importc: "SetAudioStreamBufferSizeDefault".} # Default size for new audio streams
const KEY_MENU* = 82

include raylib_util
