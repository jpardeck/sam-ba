import SAMBA 3.2
import SAMBA.Connection.Serial 3.2
import SAMBA.Device.SAMD51 3.2

SerialConnection {
	//port: "ttyACM0"
    port: "COM20"
    baudRate: 115200

    device: SAMD51Labyrinth {
	}

	onConnectionOpened: {
		// initialize internal flash applet
		initializeApplet("internalflash")

        // erase all memory
        applet.erase(0x8000, applet.memorySize - 0x8000)

		// write files
        applet.write(0x8000, "program.bin")

		// initialize boot config applet
        initializeApplet("reset")
	}
}
