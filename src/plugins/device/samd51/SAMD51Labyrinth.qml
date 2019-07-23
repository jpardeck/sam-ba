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

import QtQuick 2.3
import SAMBA.Device.SAMD51 3.2

/*!
    \qmltype SAMD51Labyrinth
    \inqmlmodule SAMBA.Device.SAMD51
    \brief Contains a specialization of the SAMD51 QML type for the
           SAMD51 Labyrinth board.
*/
SAMD51 {
    name: "samd51-labyrinth"

	aliases: []

    description: "SAMD51 Labyrinth"

	config {
		serial {
			instance: 6 /* USART1 */
			ioset: 1
		}
	}
}
