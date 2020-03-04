const gameFont = 'UbuntuMono';
const prefHiScore = 'hiScore';
const prefUserName = 'userName';
const defaultName = 'Unnamed';
const prefSoundEffects = 'soundEffects';
const prefMusic = 'music';
const raster = 32.0;
const chickenSpeed = 4;
const grain = [0, 1, 2, 3];
const spawn = [4, 5];
const mediPack = [6, 7];
const opener = [8, 9];
const passageClosed = [10, 13];
const passageOpened = [17, 16];
const maxLevel = 10;
enum Direction {
  none, left, down, right, up
}
const hiScoreServer ="192.168.178.42";
const hiScoreServerPort = 8888;