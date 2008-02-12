#include <windows.h>
#include <winioctl.h>
//#include <tchar.h>
#include <stdio.h>

// Prototypes

BOOL EjectVolume(char *cDriveLetter);

HANDLE OpenVolume(char *cDriveLetter);
BOOL LockVolume(HANDLE hVolume);
BOOL DismountVolume(HANDLE hVolume);
BOOL PreventRemovalOfVolume(HANDLE hVolume, BOOL fPrevent);
BOOL AutoEjectVolume(HANDLE hVolume);
BOOL CloseVolume(HANDLE hVolume);

LPTSTR szVolumeFormat = TEXT("\\\\.\\%s:");
LPTSTR szRootFormat = TEXT("%s:\\");
LPTSTR szErrorFormat = TEXT("Error %d: %s\n");

void ReportError(LPTSTR szMsg)
{
	printf( szErrorFormat, GetLastError(), szMsg );
}

HANDLE OpenVolume(char *cDriveLetter)
{
	HANDLE hVolume;
	UINT uDriveType;
	char *szVolumeName[8];
	char *szRootName[5];
	DWORD dwAccessFlags;

	sprintf(szRootName, szRootFormat, cDriveLetter);

	printf("Drive Letter = %s\n", szRootName );

	uDriveType = GetDriveType(szRootName);
	switch(uDriveType) {
		case DRIVE_REMOVABLE:
			dwAccessFlags = GENERIC_READ | GENERIC_WRITE;
			break;
		case DRIVE_CDROM:
			dwAccessFlags = GENERIC_READ;
			break;
		default:
			printf("Cannot eject.  Drive type is incorrect.\n");
			return INVALID_HANDLE_VALUE;
	}

	wsprintf(szVolumeName, szVolumeFormat, cDriveLetter);

	hVolume = CreateFile(	szVolumeName,
							dwAccessFlags,
							FILE_SHARE_READ | FILE_SHARE_WRITE,
							NULL,
							OPEN_EXISTING,
							0,
							NULL );

	if (hVolume == INVALID_HANDLE_VALUE)
		ReportError(TEXT("CreateFile"));

	return hVolume;
}


BOOL CloseVolume(HANDLE hVolume)
{

	return CloseHandle(hVolume);
}


#define LOCK_TIMEOUT        10000       // 10 Seconds
#define LOCK_RETRIES        20

BOOL LockVolume(HANDLE hVolume)
{
	DWORD dwBytesReturned;
	DWORD dwSleepAmount;
	int nTryCount;

	dwSleepAmount = LOCK_TIMEOUT / LOCK_RETRIES;

	// Do this in a loop until a timeout period has expired
	for (nTryCount = 0; nTryCount < LOCK_RETRIES; nTryCount++) {
		if (DeviceIoControl(	hVolume,
								FSCTL_LOCK_VOLUME,
								NULL, 0,
								NULL, 0,
								&dwBytesReturned,
								NULL))
		return TRUE;


		Sleep(dwSleepAmount);
	}

	return FALSE;
}


BOOL DismountVolume(HANDLE hVolume)
{
	DWORD dwBytesReturned;

	return DeviceIoControl(	hVolume,
							FSCTL_DISMOUNT_VOLUME,
							NULL, 0,
							NULL, 0,
							&dwBytesReturned,
							NULL);
}


BOOL PreventRemovalOfVolume(HANDLE hVolume, BOOL fPreventRemoval)
{
	DWORD dwBytesReturned;
	PREVENT_MEDIA_REMOVAL PMRBuffer;

	PMRBuffer.PreventMediaRemoval = fPreventRemoval;

	return DeviceIoControl(	hVolume,
							IOCTL_STORAGE_MEDIA_REMOVAL,
							&PMRBuffer, sizeof(PREVENT_MEDIA_REMOVAL),
							NULL, 0,
							&dwBytesReturned,
							NULL);
}


AutoEjectVolume(HANDLE hVolume)
{
	DWORD dwBytesReturned;

	return DeviceIoControl(	hVolume,
							IOCTL_STORAGE_EJECT_MEDIA,
							NULL, 0,
							NULL, 0,
							&dwBytesReturned,
							NULL);
}


BOOL EjectVolume(char *cDriveLetter)
{
	HANDLE hVolume;

	BOOL fRemoveSafely = FALSE;
	BOOL fAutoEject = FALSE;

	// Open the volume.
	hVolume = OpenVolume(cDriveLetter);
	if (hVolume == INVALID_HANDLE_VALUE)
		return FALSE;

	// Lock and dismount the volume.
	if (LockVolume(hVolume) && DismountVolume(hVolume)) {

		fRemoveSafely = TRUE;

		// Set prevent removal to false and eject the volume.
		if (PreventRemovalOfVolume(hVolume, FALSE) &&
			AutoEjectVolume(hVolume))
			fAutoEject = TRUE;
	}

	// Close the volume so other processes can use the drive.
	if (!CloseVolume(hVolume))
		return FALSE;

	if (fAutoEject)
		printf("Media in Drive %s has been ejected safely.\n", cDriveLetter );
	else {
		if (fRemoveSafely)
			printf("Media in Drive %s can be safely removed.\n", cDriveLetter);
	}

	return TRUE;
}

void Usage()
{
	printf("Usage: Eject <drive letter>\n\n");
	return;
}

