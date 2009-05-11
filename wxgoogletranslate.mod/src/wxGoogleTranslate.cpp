#include "wxGoogleTranslate.h"
#include <wx/url.h>
#include <wx/sstream.h>
#include <wx/jsonval.h>
#include <wx/jsonreader.h>

wxString HexFromInt(const int &value)
{
  wxString szHexHolder;

  if( value < 16)
    szHexHolder.Printf(wxT("0%x"), value );
  else
    szHexHolder.Printf(wxT("%x"), value );

  return szHexHolder.MakeUpper();
}

wxString URLEncode(const wxString &value)
{
  wxString szToReturn = wxT("");
  unsigned int nPos = 0;

  while( value.length() > nPos ) 
  {
    wxChar cChar = value.GetChar(nPos);

    if( (cChar >= wxT('0') && cChar <= wxT('9')) || 
		(cChar >= wxT('a') && cChar <= wxT('z')) || 
		(cChar >= wxT('A') && cChar <= wxT('Z')) || 
		(cChar == wxT('-')) || (cChar == wxT('@')) || 
		(cChar == wxT('*')) || (cChar == wxT('_')) )
    {
      szToReturn.Append( cChar );
    }
    else
    {
      switch( cChar )
      {
        case wxT(' '):  szToReturn.Append(wxT('+')); break;
        case wxT('\n'): szToReturn.Append(wxT("%0D%0A")); break;
        default:
        {
          if (cChar <= 127) {
            szToReturn.Append(wxT("%"));
            szToReturn += HexFromInt( cChar );
          } else {
            szToReturn.Append( cChar );
          }
        }
      }
    }
    nPos++;
  }
  return szToReturn;
}

wxGoogleTranslate::wxGoogleTranslateLanguageInfo 
	wxGoogleTranslate::m_LanguageInfoArray[] =
{
	{wxT("AFRIKAANS"),				wxT("af")},
	{wxT("ALBANIAN"),				wxT("sq")},
	{wxT("AMHARIC"),				wxT("am")},
	{wxT("ARABIC"),					wxT("ar")},
	{wxT("ARMENIAN"),				wxT("hy")},
	{wxT("AZERBAIJANI"),			wxT("az")},
	{wxT("BASQUE"),					wxT("eu")},
	{wxT("BELARUSIAN"),				wxT("be")},
	{wxT("BENGALI"),				wxT("bn")},
	{wxT("BIHARI"),					wxT("bh")},
	{wxT("BULGARIAN"),				wxT("bg")},
	{wxT("BURMESE"),				wxT("my")},
	{wxT("CATALAN"),				wxT("ca")},
	{wxT("CHEROKEE"),				wxT("chr")},
	{wxT("CHINESE"),				wxT("zh")},
	{wxT("CHINESE_SIMPLIFIED"),		wxT("zh-CN")},
	{wxT("CHINESE_TRADITIONAL"),	wxT("zh-TW")},
	{wxT("CROATIAN"),				wxT("hr")},
	{wxT("CZECH"),					wxT("cs")},
	{wxT("DANISH"),					wxT("da")},
	{wxT("DHIVEHI"),				wxT("dv")},
	{wxT("DUTCH"),					wxT("nl")},  
	{wxT("ENGLISH"),				wxT("en")},
	{wxT("ESPERANTO"),				wxT("eo")},
	{wxT("ESTONIAN"),				wxT("et")},
	{wxT("FILIPINO"),				wxT("tl")},
	{wxT("FINNISH"),				wxT("fi")},
	{wxT("FRENCH"),					wxT("fr")},
	{wxT("GALICIAN"),				wxT("gl")},
	{wxT("GEORGIAN"),				wxT("ka")},
	{wxT("GERMAN"),					wxT("de")},
	{wxT("GREEK"),					wxT("el")},
	{wxT("GUARANI"),				wxT("gn")},
	{wxT("GUJARATI"),				wxT("gu")},
	{wxT("HEBREW"),					wxT("iw")},
	{wxT("HINDI"),					wxT("hi")},
	{wxT("HUNGARIAN"),				wxT("hu")},
	{wxT("ICELANDIC"),				wxT("is")},
	{wxT("INDONESIAN"),				wxT("id")},
	{wxT("INUKTITUT"),				wxT("iu")},
	{wxT("ITALIAN"),				wxT("it")},
	{wxT("JAPANESE"),				wxT("ja")},
	{wxT("KANNADA"),				wxT("kn")},
	{wxT("KAZAKH"),					wxT("kk")},
	{wxT("KHMER"),					wxT("km")},
	{wxT("KOREAN"),					wxT("ko")},
	{wxT("KURDISH"),				wxT("ku")},
	{wxT("KYRGYZ"),					wxT("ky")},
	{wxT("LAOTHIAN"),				wxT("lo")},
	{wxT("LATVIAN"),				wxT("lv")},
	{wxT("LITHUANIAN"),				wxT("lt")},
	{wxT("MACEDONIAN"),				wxT("mk")},
	{wxT("MALAY"),					wxT("ms")},
	{wxT("MALAYALAM"),				wxT("ml")},
	{wxT("MALTESE"),				wxT("mt")},
	{wxT("MARATHI"),				wxT("mr")},
	{wxT("MONGOLIAN"),				wxT("mn")},
	{wxT("NEPALI"),					wxT("ne")},
	{wxT("NORWEGIAN"),				wxT("no")},
	{wxT("ORIYA"),					wxT("or")},
	{wxT("PASHTO"),					wxT("ps")},
	{wxT("PERSIAN"),				wxT("fa")},
	{wxT("POLISH"),					wxT("pl")},
	{wxT("PORTUGUESE"),				wxT("pt-PT")},
	{wxT("PUNJABI"),				wxT("pa")},
	{wxT("ROMANIAN"),				wxT("ro")},
	{wxT("RUSSIAN"),				wxT("ru")},
	{wxT("SANSKRIT"),				wxT("sa")},
	{wxT("SERBIAN"),				wxT("sr")},
	{wxT("SINDHI"),					wxT("sd")},
	{wxT("SINHALESE"),				wxT("si")},
	{wxT("SLOVAK"),					wxT("sk")},
	{wxT("SLOVENIAN"),				wxT("sl")},
	{wxT("SPANISH"),				wxT("es")},
	{wxT("SWAHILI"),				wxT("sw")},
	{wxT("SWEDISH"),				wxT("sv")},
	{wxT("TAJIK"),					wxT("tg")},
	{wxT("TAMIL"),					wxT("ta")},
	{wxT("TAGALOG"),				wxT("tl")},
	{wxT("TELUGU"),					wxT("te")},
	{wxT("THAI"),					wxT("th")},
	{wxT("TIBETAN"),				wxT("bo")},
	{wxT("TURKISH"),				wxT("tr")},
	{wxT("UKRAINIAN"),				wxT("uk")},
	{wxT("URDU"),					wxT("ur")},
	{wxT("UZBEK"),					wxT("uz")},
	{wxT("UIGHUR"),					wxT("ug")},
	{wxT("VIETNAMESE"),				wxT("vi")},
	{wxT("UNKNOWN"),				wxEmptyString}
};

void wxGoogleTranslate::GetLanguages(wxArrayString & result)
{
	result.Clear();
	int count = sizeof(m_LanguageInfoArray) / 
		sizeof(wxGoogleTranslateLanguageInfo);
	for(int i = 0; i < count; i++)
	{
		result.Add(m_LanguageInfoArray[i].languageName);
	}
}

wxString wxGoogleTranslate::GetLanguageCode(const wxString & languageName)
{
	int count = sizeof(m_LanguageInfoArray) / 
		sizeof(wxGoogleTranslateLanguageInfo);
	for(int i = 0; i < count; i++)
	{
		if(m_LanguageInfoArray[i].languageName.Lower().IsSameAs(
			languageName.Lower()))
		{
			return m_LanguageInfoArray[i].languageCode;
		}
	}
	return wxEmptyString;
}

bool wxGoogleTranslate::ParseJSONResponse(const wxString & response,
		wxString & translatedText,
		wxString & translateionDetails,
		int & translationStatus)
{
	do
	{
		wxJSONValue  root;
		wxJSONReader reader;
		if(reader.Parse(response, &root) > 0) break;
		translatedText = 
			root[wxT("responseData")][wxT("translatedText")].AsString();
		translateionDetails = 
			root[wxT("responseDetails")].AsString();
		translationStatus = 
			root[wxT("responseStatus")].AsInt();
		return true;
	}
	while(false);
	return false;
}

bool wxGoogleTranslate::Translate(const wxString & source, 
		wxString & result, 
		const wxString & sourceLanguageCode, 
		const wxString & resultLanguageCode,
		wxString & translationDetails,
		int & errorCode)
{
	do
	{
		wxString urlEncodedSource = 
			URLEncode(wxString::FromAscii(source.ToUTF8()));
		wxString srcURL = wxString::Format(
			wxT("%s?v=1.0&q=%s&langpair=%s%%7C%s"),
			wxT("http://ajax.googleapis.com/ajax/services/language/translate"),
			urlEncodedSource.GetData(),
			sourceLanguageCode.GetData(),
			resultLanguageCode.GetData());
		wxURL url = srcURL;
		if(url.GetError() != wxURL_NOERR) break;
		wxInputStream * in = url.GetInputStream();
		if(!in) break;
		wxString response;
		wxStringOutputStream out(&response);
		in->Read(out);
		wxDELETE(in);
		if(response.IsEmpty()) break;
		if(!wxGoogleTranslate::ParseJSONResponse(response, result, 
			translationDetails, errorCode)) break;
		return true;
	}
	while(false);
	return false;
}
