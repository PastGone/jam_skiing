shader_type canvas_item;
uniform sampler2D mytexture;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	COLOR = texture(TEXTURE,UV);
	
	vec4 mycolor=texture(mytexture,UV);
	COLOR=vec4(mycolor.r,mycolor.g,mycolor.b,COLOR.a);
	}

