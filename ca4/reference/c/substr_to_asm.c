#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * substring(char * s, int i, int a) {
	char *str, c;

	// Keep track of size of allocated memory
	int size = 20;

	// Track current lenght of string
	int len = 0;

	// Allocate initial room for the string
	str = (char *) malloc(size * sizeof(char));

	while (i < a) {
		// Get char from input
		c = s[i];

		// Exit from loop if newline or EOF
		if (c == EOF) {
			break;
		}

		// Add char to string
		str[len] = c;
		len++;

		// If null char, set str to empty string and break
		if (c == '\0') {
			len = 0;
			break;
		}

		// Realloc string if needed
		if (len == size) {
			// Increase size of string by 20
			size = size + 20;

			// Realloc the string to the bigger size
			str = realloc(str, size * sizeof(char));
		}
		i++;
	}

	str = strndup(str, len);
	return str;
}

int main() {
	char * s = "Hello, world!";
	int i = 1;
	int l = 2;
	s = substring(s, i, l);
	printf("%s", s);
	return 0;
}