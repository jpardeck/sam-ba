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

#include "sambacore.h"
#include "sambafile.h"
#include <QUrl>
#include <QCoreApplication>
#include <QFileInfo>

SambaFile::SambaFile(QObject* parent)
	: QObject(parent)
{
}

SambaFileInstance* SambaFile::open(const QString& pathOrUrl, bool write)
{
	SambaFileInstance* file = new SambaFileInstance(this);
    QString path = QCoreApplication::applicationDirPath();
    QUrl url(pathOrUrl);
    QFileInfo info(pathOrUrl);

    if (!url.isLocalFile() && !info.isAbsolute())
    {
        path = path + "/" + pathOrUrl;
    }
    else
    {
        path = pathOrUrl;
    }

    if (!file->open(path, write)) {
		qCDebug(sambaLogCore, "Error: Could not open file '%s' for %s",
		        pathOrUrl.toLocal8Bit().constData(),
		        write ? "writing" : "reading");

		delete file;
		return nullptr;
	}

	return file;
}

qint64 SambaFile::size(const QString& pathOrUrl) const
{
	QUrl url(pathOrUrl, QUrl::StrictMode);
	QFile file;

	if (url.isValid() && url.isLocalFile()) {
		file.setFileName(url.toLocalFile());
	} else {
		file.setFileName(pathOrUrl);
	}

	return file.size();
}
