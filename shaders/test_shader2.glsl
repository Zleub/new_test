#define M_PI 3.1415926535897932384626433832795

uniform float x;
uniform float y;
uniform float width;
uniform float height;
uniform float resolution;
uniform float test;

// uniform float time;

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

	float t = 0.3 ;
	float u = 0.3 ;
	float v = 0.3 ;


	if (sin(x * y) * 2 + log(x + y) < test) {
		t = 219 / 255. ;
		u =   0 / 255. ;
		v =   0 / 255. ;
	}
	else if (cos(x + y) * 2 - log(x + y) > test) {
		t = 136 / 255. ;
		u = 204 / 255. ;
		v =   0 / 255. ;
	}
	else {
		return vec4(
		0.,
		0.,
		0.,
		0.
	);
	}
	// u = tan(x + y) / tan(x * y) / 12;

	vec3 new_color = vec3(t, u, v);

	return vec4(
		t_color.r * new_color.r,
		t_color.g * new_color.g,
		t_color.b * new_color.b,
		t_color.a
	);
}
