#include <stdint.h>

#include <machine/platform.h>

#define VIDEO_BUFFER 0xb8000
#define VIDEO_COLS 80
#define VIDEO_LINES 24
#define VIDEO_SIZE (VIDEO_COLS * VIDEO_LINES)

static uint16_t *video_region = (uint16_t *)VIDEO_BUFFER;
static uint8_t video_position = 0;

static void consolePrintChar(char ch) {
  video_region[video_position] = 0x0700 | ch;
  video_position++;
}

static void consoleNextLine() {
  video_position += VIDEO_COLS - (video_position % VIDEO_COLS);
}

void consolePrint(const char *str) {
  char *ptr = str;

  while (ptr && *ptr) {
    switch (*ptr) {
    case '\n':
      consoleNextLine();
      break;
    default:
      consolePrintChar(*ptr);
      break;
    }

    ptr++;
  }
}

void consoleClear() {
  for (int i = 0; i < VIDEO_SIZE; i++) {
    video_region[i] = 0x0720;
  }

  video_position = 0;
}
