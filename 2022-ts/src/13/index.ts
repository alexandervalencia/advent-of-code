class Device {
  packetPairs: Packet[][];

  constructor(input: string) {
    this.packetPairs = input
      .split("\n\n")
      .map((pair) => pair.split("\n").map((data) => new Packet(data)));
  }
}
export default Device;

class Packet {
  data: string;

  constructor(input: string) {
    this.data = JSON.parse(input);
  }
}
