extern Image img;
extern vec4 entity ;
extern float time ;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	// Image i = img;
	vec4 e = entity;
	vec2 s = screen_coords;
	float t = time;

	float res = 16;

	float row_len = e.z / res;
	float row = mod(time * 10, row_len ) ;
	float col =  (- row + time * 10) / row_len ;

	if (e.y + (col + 1) * res < s.y)
		return color * texture2D(texture, texture_coords) ;
		// return vec4(0., 0., 0., 1.);
	if (e.x + row * res < s.x && e.y + col * res < s.y)
		return color * texture2D(texture, texture_coords) ;
		// return vec4(0., 0., 0., 1.) ;

	vec4 i = texture2D(img, texture_coords);
	float b = (i.r + i.g + i.b) / 3 ;
	if (b > 0.5)
		return vec4(0., 0., 0., 1.) ;

	return color * texture2D(texture, texture_coords) ;
}
