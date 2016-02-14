/* A.J. Varshneya
 * ajv4dg@virginia.edu
 * CS4501 - Language Design & Implementation
 * 1/25/16
 * rosetta.c
 */

/* Notes
 * - Using adjacency matrix instead of adjacency list now (we can use a 2D array in C)
 * - We have 'for' loops now (unlike cool)! yay
 * - IO/memory management make life difficult
 * - So does doing everything with arrays (probably a poor decision in hindsight)
 */

 /* Links that were helpful:
  * Wikipedia topsort algorithms: https://en.wikipedia.org/wiki/Topological_sorting
  * DFS-based topsort algorithm: http://www.inf.ed.ac.uk/teaching/courses/cs2/LectureNotes/CS2Bh/ADS/ads10.pdf
  * strcmp: http://www.cplusplus.com/reference/cstring/strcmp/
  * strcpy: http://www.cplusplus.com/reference/cstring/strcpy/
  */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cycle;
int v_index;
int sorted_index;
int max_len;
int max_vertices;

// Returns a character buffer representing the input list
char * read_input() {
	// Buffer and data sizes
	size_t buffer_size = 128;
	size_t data_size = 1024;

	// Init pointer to buffer, getline does memory allocation
	char * buffer = NULL;

	// Allocate memory for data
	char * data = (char *) malloc(sizeof(char)*data_size);

	// Getline until EOF, concatenating lines to data
	while(getline(&buffer, &buffer_size, stdin) != -1)
	{
		strcat(data, buffer);
	}

	// Return a copy of data
	return strdup(data);
}

// Returns the index of a string in an array of strings
int get_index(char * arr[], char * s, int len) {
	char * str = strdup(s);

	int i = 0;
	for ( ; i < len; i++)
	{
		if(!strcmp(str, arr[i]))
		{
			free(str);
			return i;
		}
	}

	free(str);
	str = NULL;
	return -1;
}

// Returns whether the array of strings contains a particular string
int contains(char * arr[], char * s, int len) {
	char * str = strdup(s);

	int i;

	for (i = 0; i < len; i++) 
	{
		if (!strcmp(str, arr[i]))
		{
			free(str);
			return 1;
		}
	}

	free(str);
	str = NULL;
	return 0;
}

// Determines the maximum length string separated by '\n' characters in the buffer
int max_str_len(char * b) {
	char * buffer = strdup(b);
	// sizeof(char) = 1
	int max_len = 1;

	char * pch;
	pch = strtok(buffer, "\n");

	while (pch != NULL)
	{
		if (max_len < strlen(pch))
		{
			max_len = strlen(pch);
		}
		pch = strtok(NULL, "\n");
	}

	free(buffer);
	buffer = NULL;

	return max_len;
}

// Determines the number of strings serparated by '\n' characters in the buffer
int buffer_count(char * b) {
	char * buffer = strdup(b);
	int n = 0;
	int i = 0;
	char c = buffer[0];
	while(c != '\0') 
	{
		if (c == '\n')
		{
			n++;
		}
		c = buffer[i++];
	}

	free(buffer);
	buffer = NULL;
	return n;
}

void visit(int * graph[], char * vertices[], int src_index, int marks[], char * sorted[]) {
	//printf("Visiting... %s\n", vertices[src_index]);

	// Mark the vertex grey
	marks[src_index] = 1;

	char * str = malloc(max_len);

  	int touched[v_index];
  	memset(touched, 0, v_index*sizeof(int));

	int done = 0;
	while(!done && !cycle) {
		// Init str as empty
		strcpy(str, "");

		// Get the min-named untouched (NOT unvisited) vertex adjacent to current vertex
		int i = 0;
		for ( ; i < v_index; i++)
		{
			// First pass, take first adjacent, untouched, nonempty node
			if (!strcmp(str, "")) {
				if ((graph[src_index][i] == 1) &&
					(touched[i] == 0) &&
					strcmp(vertices[i], "")) {

					strcpy(str, vertices[i]);
				}
			} else {
				// Remaining passes, pick smallest, adjacent, untouched, nonempty node
				if ((strcmp(str, vertices[i]) < 0) &&
					(graph[src_index][i] == 1) &&
					(touched[i] == 0) &&
					strcmp(vertices[i], "")) {

					strcpy(str, vertices[i]);
				}
			}
		}

		// Retrieve index of vertex we just picked
		int min_index = get_index(vertices, str, v_index);
			
		// Check that it exists
		if (strcmp(str, "") && min_index != -1) {
			touched[min_index] = 1;

			// Visit the vertex if it is white, cycle if grey
			if (marks[min_index] == 0) {

				// Visit this node
				visit(graph, vertices, min_index, marks, sorted);
			}
			else if (marks[min_index] == 1) {
				cycle = 1;
			}
		} else {
			// Finished when there are no more untouched adjacent nodes
			done = 1;
		}
	}

	free(str);

	str = NULL;

	// Mark this node black
	marks[src_index] = 2;

	// Add the node to the sorted list
	strcpy(sorted[sorted_index], vertices[src_index]);
	sorted_index += 1;
}

int main() {
	// Read in file
	char * buffer = read_input();

	// Determine longest string, maximum number of vertices
	max_len = max_str_len(buffer);
	max_vertices = buffer_count(buffer);

	int i;
	int j;

  	// Tokenize the buffer delimed by '\n' 

	// Copy buffer to temp for strtok usage
  	char * temp = strdup(buffer);

  	// Initialize split buffer
	char * split_buffer[max_vertices];
	for (i = 0; i < max_vertices; i++)
  		split_buffer[i] = malloc(max_len);

  	// Tokenize
  	int b_index = 0;
	char * pch = strtok(temp, "\n");
	while (pch != NULL)
	{
		strcpy(split_buffer[b_index++], pch);
		pch = strtok(NULL, "\n");
	}

	// Construct array of unique vertices from buffer
	char * vertices[max_vertices];
	for (i = 0; i < max_vertices; i++)
  		vertices[i] = malloc(max_len);	

	v_index = 0;
	temp = strdup(buffer);
	pch = strtok(temp, "\n");
	
	while (pch != NULL)
	{
		int len = sizeof(vertices)/sizeof(vertices[0]);
		if (!contains(vertices, pch, len)) 
		{
			strcpy(vertices[v_index++], pch);
		}
		pch = strtok(NULL, "\n");
	}

	// Done with buffer
	free(buffer);
	buffer = NULL;

	// Create adjacency matrix
	int * graph[v_index];
	for (i = 0; i < v_index; i++) {
		graph[i] = malloc(v_index*sizeof(int));
	}

	// Iterate over split buffer to generate adjacency matrix
	for (i = 0; i < max_vertices; i+=2) {
		if (strcmp(split_buffer[i], "")) {

			int len = sizeof(vertices)/sizeof(vertices[0]);

			// Get dst/src from buffer, lookup indices
			char * dst = split_buffer[i];
			char * src = split_buffer[i+1];

			int dst_index = get_index(vertices, dst, v_index);
			int src_index = get_index(vertices, src, v_index);

			// Set edge in adjacency matrix
			graph[src_index][dst_index] = 1;

		}
	}

	// Done with split buffer
	for (i = 0; i < max_vertices; i++)
  		free(split_buffer[i]);

	// Top sort w/ dfs-based solution

  	// Create array for coloring, zero init
  	int marks[v_index];
	memset(marks, 0, v_index*sizeof(int));

	// Create array to keep track of vertices we have visited so we can iterate over them in order
	int touched[v_index];
  	memset(touched, 0, v_index*sizeof(int));

  	// Create array for sorted nodes to be added to
  	sorted_index = 0;
  	char * sorted[v_index];
  	for (i = 0; i < v_index; i++)
  		sorted[i] = malloc(max_len);

  	cycle = 0;

	char * str = malloc(max_len);

	int done = 0;
	while (!done && !cycle) {
		strcpy(str, "");

  		// Iterate over vertices in lexical order
		int i;
		for (i = 0 ; i < v_index; i++)
		{
			// First pass, take first untouched, nonempty node
			if (!strcmp(str, "")) {
				if ((touched[i] == 0) &&
					strcmp(vertices[i], "")) {

					strcpy(str, vertices[i]);
				}
			} else {
				// Remaining passes, pick smallest, untouched, nonempty node
				if ((strcmp(str, vertices[i]) < 0) &&
					(touched[i] == 0) &&
					strcmp(vertices[i], "")) {

					strcpy(str, vertices[i]);
				}
			}
		}

		// Get index of selected node
		int max_index = get_index(vertices, str, v_index);

		// Check if node exists
		if (strcmp(str, "") && max_index != -1) {
			touched[max_index] = 1;
			if (marks[max_index] == 0) {
				// Visit this node
				visit(graph, vertices, max_index, marks, sorted);			
			}
		} else {
			// No more nodes to iterate over
			done = 1;
		}
	}

  	if (!cycle) {
  		// Print vertices in reverse since we postpended
	  	for (i = v_index - 1; i >= 0; i--) {
	  		printf("%s\n", sorted[i]);
	  	}
	} else {
		printf("cycle\n");
	}

	// Done with vertices
	for (i = 0; i < max_vertices; i++)
		free(vertices[i]);

	// Done with graph
	for (i = 0; i < v_index; i++)
		free(graph[i]);

	// Done with sorted array
	for (i = 0; i < v_index; i++)
  		free(sorted[i]);

	return 0;
}
