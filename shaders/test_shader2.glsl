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

	vec4 t_color = texture2D(texture, texture_coords);

	float t_grey = (t_color.r + t_color.g + t_color.b) / 3.3;
	vec4 grey = vec4(
		t_grey,
		t_grey,
		t_grey,
		t_color.a
	);

	float t = 0.5 ;
	float u = 0.5 ;
	float v = 0.5 ;


	if ((sin(x * y) * 2 + log(x + y) ) < test) {
		t = 219 / 255. ;
		u =   0 / 255. ;
		v =   0 / 255. ;
	}
	else if (cos(x + y) * 2 - log(x + y) > test) {
		t = 136 / 255. ;
		u = 204 / 255. ;
		v =   0 / 255. ;
	}
	// else {
	// 	return grey ;
	// }
	// u = tan(x + y) / tan(x * y) / 12;

	vec3 test = vec3(t, u, v);

	return vec4(
		t_grey * test.r,
		t_grey * test.g,
		t_grey * test.b,
		t_color.a
	);
}
