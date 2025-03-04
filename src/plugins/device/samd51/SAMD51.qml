/*
 * Copyright (c) 2017, Atmel Corporation.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 */

import SAMBA 3.2
import SAMBA.Applet 3.2
import SAMBA.Device.SAMD51 3.2

/*!
	\qmltype SAMV71
	\inqmlmodule SAMBA.Device.SAMV71
	\brief Contains chip-specific information about SAMU70 devices.

	This QML type contains configuration, applets and tools for supporting
	the SAMV71 device family (SAME70 / SAMS70 / SAMV70 / SAMV71).

	\section1 Applets

	SAM-BA uses small programs called "Applets" to initialize the device or
	flash external memories. Please see SAMBA::Applet for more information on the
	applet mechanism.

	\section2 Low-Level Applet

	This applet is in charge of configuring the device clocks.

	It is only needed when using JTAG for communication with the device.
	When communication using USB or Serial via the SAM-BA Monitor, the clocks are
	already configured by the ROM-code.

	The only supported command is "init".

	\section2 External RAM Applet

	This applet is in charge of configuring the external RAM.

	The Low-Level applet must have been initialized first.

	The only supported command is "init".

	Note: The external RAM is not needed for correct operation of the other
	applets. It is only provided as a way to upload and run user programs
	from external RAM.

	\section2 InternalFlash Applet

	This applet is used to read/write internal flash memory.

	Supported commands are "init", "read", "write" and "blockErase".

	\section1 Configuration

	When creating an instance of the SAMU70 type, some configuration can
	be supplied. The configuration parameters are then used during applet
	initialization where relevant.

	\section2 Preset Board selection

	A set of pre-configured values can be selected by instanciating
	sub-classes of SAMU70.  The following preset boards are available:

	\table
	\header \li Command-Line Name \li QML Name        \li Board Name
    \row    \li samd51-labyrinth  \li SAMVD51Labyrinth \li SAMD51 Labyrinth
	\endtable

	\section2 Custom configuration

	Each configuration value can be set individually.  Please see
	SAMV71Config for details on the configuration values.

	For example, the following QML snipplet configures a device to output
	console traces on UART0 IOSet 1:

	\qml
	SAMA5D2 {
		config {
			serial {
				instance: 0
				ioset: 1
			}
		}
	}
	\endqml

*/
Device {
    family: "samd51"

    name: "samd51"

    aliases: ["samd51"]

    description: "SAMD51"

	/*!
		\brief The device configuration used by applets (peripherals, I/O sets, etc.)
		\sa SAMV71Config
	*/
	property alias config: config

	applets: [
        /*
		SAMV71BootConfigApplet {
			codeUrl: Qt.resolvedUrl("applets/applet-bootconfig_samv71-generic_sram.bin")
			codeAddr: 0x20401000
			mailboxAddr: 0x20401004
			entryAddr: 0x20401080
		},
		LowlevelApplet {
			codeUrl: Qt.resolvedUrl("applets/applet-lowlevel_samv71-generic_sram.bin")
			codeAddr: 0x20401000
			mailboxAddr: 0x20401004
			entryAddr: 0x20401080
		},
		ExtRamApplet {
			codeUrl: Qt.resolvedUrl("applets/applet-extram_samv71-generic_sram.bin")
			codeAddr: 0x20401000
			mailboxAddr: 0x20401004
			entryAddr: 0x20401080
		},
        */
		InternalFlashApplet {
            codeUrl: Qt.resolvedUrl("applets/flash.bin")
            codeAddr: 0x20001000
            mailboxAddr: 0x20001040
            entryAddr: 0x20001000
		},
		ResetApplet {
            codeUrl: Qt.resolvedUrl("applets/reset.bin")
            codeAddr: 0x20001000
            mailboxAddr: 0x20001040
            entryAddr: 0x20001000
		}
	]

	/*!
		\brief Initialize the SAMV7 device using the current connection.

		This method calls checkDeviceID.
	*/
	function initialize() {
		checkDeviceID()
	}

	/*!
		\brief Checks that the device is a SAME70/S70/V70/V71.

		Reads CHIPID_CIDR register using the current connection and display
		a warning if its value does not match the expected value.
	*/
	function checkDeviceID() {
		// read ARCH field of CHIPID_CIDR register
        var temp = connection.readu32(0x41002018)
        var arch = ((connection.readu32(0x41002018) >>> 20) & 0xff) >>> 0
        if (temp !== 1611005956)
            print("Warning: Invalid CIDR, no known SAME70/S70/V70/V71 chip detected!")
	}

    SAMD51Config {
		id: config
	}
}
