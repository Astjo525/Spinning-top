#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>

#include <iostream>
#include <vector>
#include <stdio.h>
#include <string>
#include <cstring>
#include <algorithm>

#include "objloader.h"


//Funktion som �ndrar GLFW-f�nstrets storlek n�r f�nstret �ndras
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
	//S�tt storlek p� renderingsf�nstret (s� OpenGL vet att anpassa koordinater till f�nster)
	glViewport(0, 0, width, height);
}

int main()
{
	//Initialisera GLFW
	glfwInit();

	//Detta skulle s�tta krav p� glfw versionen 
	//glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	//glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);


	//Skapa ett GLFW-f�nster 
	GLFWwindow* window = glfwCreateWindow(640, 480, "TestingTesting", NULL, NULL);
	if (window == NULL) {
		std::cout << "Failed to create GLFW window" << std::endl;
		glfwTerminate();
		return -1;
	}
	glfwMakeContextCurrent(window); //Kr�vs f�r att anv�nda OpenGL API:t

	//Initilisera GLAD som "manages function pointers" f�r OpenGL
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
		std::cout << "Failed to initialize GLAD" << std::endl;
		return -1;
	}

	//GLFW ska kalla p� framebuffer_size_callback n�r f�nstret �ndrar storkel
	glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

	std::vector< glm::vec3 > vertices;
	std::vector< glm::vec2 > uvs;
	std::vector< glm::vec3 > normals; // Won't be used at the moment.
	bool res = loadOBJ("testing.obj", vertices, uvs, normals);

	//glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(glm::vec3), &vertices[0], GL_STATIC_DRAW);

	//Redering loop
	//S� att inte en bild ritas sedan st�ngs f�nstret
	while (!glfwWindowShouldClose(window)) {

		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		glfwSwapBuffers(window); //Byter f�rgbuffer, dvs visar output p� sk�rmen
		glfwPollEvents(); //Kollar om events �r triggade
	}

	glfwTerminate();
	return 0;
}
