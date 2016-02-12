uniform vec4 entity ;
uniform float time ;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	vec4 e = entity;
	float t = time;

	float res = 4;

	if (time < screen_coords.x)
		return vec4(1., 0., 0., 1.) ;

	return color * texture2D(texture, texture_coords);
}
