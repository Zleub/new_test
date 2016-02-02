--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  proc_demo:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-11 15:50:56
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-02 02:02:58
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

time = 1
ctime = 0
pause = false

function love.load()
	imageA = love.graphics.newImage('human_base.png')
	imageB = love.graphics.newImage('rpgbaseformatted.png')

	imageA:setFilter('nearest')
	imageB:setFilter('nearest')


	shader = love.graphics.newShader( [[
		#define M_PI 3.1415926535897932384626433832795

		extern float x;
		extern float y;
		extern float width;
		extern float height;
		extern float size;
		extern float resolution;

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
			if ( (x + y) < (pow(size / resolution, 2)) ) {
				t = tan(x * y);
				// u = tan(x + y) / tan(x * y);
				// v = tan(x + y) / tan(x * y);
			}

			vec4 test = vec4(t, u, v, 1);

			return toto;
		}
	]] )

	cmp = 1
	canvas = love.graphics.newCanvas(800, 600)
end

function love.wheelmoved(x, y)
	cmp = cmp + y
	if cmp < 1 then cmp = 1 end
end

function love.keypressed(key)
	if key == 'space' and pause then
		pause = false
	elseif key == 'space' then
		pause = true
	end
end

function love.update(dt)
	if not pause then time = time + dt end

	if math.floor(time) > ctime then ctime = math.floor(time) end

	shader:send("x", 0)
	shader:send("y", 0)
	-- shader:send("time", ctime)
	shader:send("width", 800)
	shader:send("height", 600)
	shader:send("size", math.min(love.graphics.getWidth(), love.graphics.getHeight()) / 3)
	shader:send("resolution", cmp)


	love.graphics.setCanvas(canvas)
		love.graphics.setShader(shader)
		love.graphics.clear()
		love.graphics.rectangle('fill',
			0, 0,
			love.graphics.getWidth(), love.graphics.getHeight()
		)
		love.graphics.setShader()
	love.graphics.setCanvas()

	-- shaderB:send("x", love.graphics.getWidth() / 2)
	-- shaderB:send("y", love.graphics.getHeight() / 2)
	-- shaderB:send("width", love.graphics.getWidth() / 2)
	-- shaderB:send("height", love.graphics.getHeight() / 2)
	-- shaderB:send("size", love.graphics.getHeight() / 4)
	-- shaderB:send("resolution", cmp)
end

function love.draw()
	-- love.graphics.draw(imageA, 0, 0, 0, cmp, cmp)
	-- love.graphics.draw(imageB, 0, imageA:getHeight() * cmp, 0, cmp, cmp)

	-- love.graphics.setShader(shader)
	-- love.graphics.rectangle('fill',
	-- 	0, 0,
	-- 	love.graphics.getWidth(), love.graphics.getHeight()
	-- )


	-- love.graphics.setShader()

	love.graphics.draw(canvas)
	love.graphics.print('res: '..cmp, 0, 0)
	love.graphics.print('time: '..ctime, 0, 12)

end
