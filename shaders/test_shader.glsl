#define M_PI 3.1415926535897932384626433832795

uniform float x;
uniform float y;
uniform float width;
uniform float height;
// uniform float size;
uniform float resolution;

// uniform float time;

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
	// if ( (x + y) < (pow(size / resolution, 2)) ) {
		t = cos(x * y);
		// u = tan(x + y) / tan(x * y);
		// v = tan(x + y) / tan(x * y);
	// }

	vec3 test = vec3(t, u, v);

	return vec4( toto.r * test.r, toto.g * test.g, toto.b * test.b, toto.a);
}
