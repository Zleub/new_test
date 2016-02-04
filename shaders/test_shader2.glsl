#define M_PI 3.1415926535897932384626433832795

extern float x;
extern float y;
extern float width;
extern float height;
extern float resolution;
extern float test;

// extern float time;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	// int _x
	// int _y

	float x = pow( int(((screen_coords.x - x) - width / 2) / resolution), 2) ;
	float y = pow( int(((screen_coords.y - y) - height / 2) / resolution), 2) ;

	vec4 toto = texture2D(texture, texture_coords);

	float t = 0. ;
	float u = 0. ;
	float v = 0. ;


	if ((sin(x * y) * 2 + log(x * y) ) < test) {
		t = 217 / 255. ;
		u = 196 / 255. ;
		v =  21 / 255. ;
	}
	else if (cos(x + y) * 2 - log(x + y) < test) {
		t =  45 / 255. ;
		u = 136 / 255. ;
		v =  45 / 255. ;
	}
	else {
		return toto;
	}
	// u = tan(x + y) / tan(x * y) / 12;

	vec3 test = vec3(t, u, v);

	return vec4( toto.r * test.r, toto.g * test.g, toto.b * test.b, toto.a);
}
