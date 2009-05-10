#ifndef _WX_GOOGLE_TRANSLATE_H
#define _WX_GOOGLE_TRANSLATE_H

#include <wx/wx.h>

class wxGoogleTranslate
{
	/// \brief Language Info
	struct wxGoogleTranslateLanguageInfo
	{
		/// \brief Full language name
		wxString languageName;
		/// \brief Language code
		wxString languageCode;
	};

	/// \brief Stores information about all supported languages
	static wxGoogleTranslateLanguageInfo m_LanguageInfoArray[];
	/**
	\brief Parses JSON response from Google Translate service
	\param response contains JSON response from Google Translate service
	\param translatedText contains translated text if parsing of JSON response was correct
	\param translateionDetails contains additional information from Google Translate service
		   usually it is error message
    \param translationStatus contains parsing status (error code)
	\return true if translation and parsing was successfull, otherwise false
	*/
	static bool ParseJSONResponse(const wxString & response,
		wxString & translatedText,
		wxString & translateionDetails,
		int & translationStatus);
public:
	/// \brief Returns the list of all suported languages
	/// \param result array for storing language names
	static void GetLanguages(wxArrayString & result);
	/**
	\brief Returns language code by language name
	\param languageName language name
	\return language code on success or empty string on error
	*/
	static wxString GetLanguageCode(const wxString & languageName);
	/**
	\brief Translates given text with Google Translate service
	\param source string to translate
	\param result translation result
	\param sourceLanguageCode source language code
	\param resultLanguageCode destination language code
	\param translationDetails error message
	\param errorCode error code
	\return true on success, otherwise false
	*/
	static bool Translate(const wxString & source, 
		wxString & result, 
		const wxString & sourceLanguageCode, 
		const wxString & resultLanguageCode,
		wxString & translationDetails,
		int & errorCode);
};

#endif
