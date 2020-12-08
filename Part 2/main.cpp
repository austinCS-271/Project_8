extern "C" void writeMessage(char* message);

int main(int argc, char** argv) {

	char str[13] = "hello there!";

	writeMessage(str);

	return 0;

}