#version 330 core
out vec3 color;
in vec3 vertex_normal;
in vec3 vertex_pos;
in vec2 vertex_tex;
uniform vec3 campos;

uniform sampler2D tex;  //day
uniform sampler2D tex2;	//specular
uniform sampler2D tex3; //clouds
uniform sampler2D tex4; //night

void main()
{

//diffuse
vec3 lp = vec3(1000, -400, 500);
vec3 n = normalize(vertex_normal);
vec3 ld = normalize(lp - vertex_pos);
float diffuse = clamp(dot(n, ld), 0, 1);

//specular
vec3 lightColor = vec3(1, 1, 1);
vec3 cd = normalize(campos - vertex_pos);
vec3 h = normalize(cd + ld);
float spec = dot(n, h);
spec = clamp(spec, 0, 1);
spec = pow(spec, 30);

//color
vec3 dayColor = texture(tex, vertex_tex).rgb;
vec3 nightColor = texture(tex4, vertex_tex).rgb;
vec3 ocean = texture(tex2, vertex_tex).rgb;
vec3 clouds = texture(tex3, vertex_tex).rgb;
vec3 baseColor = (dayColor - nightColor) * diffuse + nightColor + dayColor*0.001;

color = baseColor + clouds*0.1 + clouds*diffuse*0.9 + ocean*spec*1.5;
}