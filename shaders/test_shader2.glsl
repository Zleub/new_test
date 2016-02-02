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


	if ((cos(x + y) - log(x - y) ) > test) {
		t = 170. / 255  ;
		u = 57. / 255  ;
		v = 57. / 255 ;
	}
	else if (cos(x * y) - log(x + y) < test) {
		t = 122. / 255  ;
		u = 159. / 255  ;
		v = 53. / 255 ;
	}
	else {
		return toto;
	}
	// u = tan(x + y) / tan(x * y) / 12;

	vec3 test = vec3(t, u, v) * cos(x + y);

	return vec4( toto.r * test.r, toto.g * test.g, toto.b * test.b, toto.a);
}
