// Scintilla source code edit control
/** @file LexBasic.cxx
 ** Lexer for BlitzBasic and PureBasic.
 ** Converted to lexer object and added further folding features/properties by "Udo Lechner" <dlchnr(at)gmx(dot)net>
 **/
// Copyright 1998-2003 by Neil Hodgson <neilh@scintilla.org>
// The License.txt file describes the conditions under which this software may be distributed.

// This tries to be a unified Lexer/Folder for all the BlitzBasic/BlitzMax/PurBasic basics
// and derivatives. Once they diverge enough, might want to split it into multiple
// lexers for more code clearity.
//
// Mail me (elias <at> users <dot> sf <dot> net) for any bugs.

// Folding only works for simple things like functions or types.

// You may want to have a look at my ctags lexer as well, if you additionally to coloring
// and folding need to extract things like label tags in your editor.

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <assert.h>
#include <ctype.h>

#include <string>
#include <map>

#include "ILexer.h"
#include "Scintilla.h"
#include "SciLexer.h"

#include "WordList.h"
#include "LexAccessor.h"
#include "StyleContext.h"
#include "CharacterSet.h"
#include "LexerModule.h"
#include "OptionSet.h"

#ifdef SCI_NAMESPACE
using namespace Scintilla;
#endif

// for rem block
#define SCE_B_COMMENTREM 19

#define wxSCI_LEX_BLITZMAX 222


/* Bits:
 * 1  - whitespace
 * 2  - operator
 * 4  - identifier
 * 8  - decimal digit
 * 16 - hex digit
 * 32 - bin digit
 */
static int character_classification[128] =
{
    0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  1,  0,  0,  1,  0,  0,
    0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
    1,  2,  0,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  10, 2,
    60, 60, 28, 28, 28, 28, 28, 28, 28, 28, 2,  2,  2,  2,  2,  2,
    2,  20, 20, 20, 20, 20, 20, 4,  4,  4,  4,  4,  4,  4,  4,  4,
    4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  2,  2,  2,  2,  4,
    2,  20, 20, 20, 20, 20, 20, 4,  4,  4,  4,  4,  4,  4,  4,  4,
    4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  2,  2,  2,  2,  0
};

static bool IsWordStart(int ch) {
	return (IsASCII(ch) && (isalpha(ch) || ch == '_')) || !IsASCII(ch);
}

static bool IsSpace(int c) {
	return c < 128 && (character_classification[c] & 1);
}

static bool IsOperator(int c) {
	return c < 128 && (character_classification[c] & 2);
}

static bool IsIdentifier(int c) {
	return c < 128 && (character_classification[c] & 4);
}

static bool IsDigit(int c) {
	return c < 128 && (character_classification[c] & 8);
}

static bool IsHexDigit(int c) {
	return c < 128 && (character_classification[c] & 16);
}

static bool IsBinDigit(int c) {
	return c < 128 && (character_classification[c] & 32);
}

static int LowerCase(int c)
{
	if (c >= 'A' && c <= 'Z')
		return 'a' + c - 'A';
	return c;
}

static int CheckBMFoldPoint(char const *token, int &level) {
	if (!strcmp(token, "rem") ||
			!strcmp(token, "function") ||
			!strcmp(token, "type") ||
			!strcmp(token, "method")) {
		level |= SC_FOLDLEVELHEADERFLAG;
		return 1;
	}
	if (!strcmp(token, "end rem") ||
			!strcmp(token, "endrem") ||
			!strcmp(token, "end function") ||
    	    !strcmp(token, "endfunction") ||
        	!strcmp(token, "end type") ||
		 	!strcmp(token, "endtype") ||
			!strcmp(token, "end method") ||
        	!strcmp(token, "endmethod")) {
		return -1;
	}
	return 0;
}

static bool CheckBMEndRem(char const *token) {
	const char * k;
	const char * n;
	int i = 0;

	// endrem
	if (strlen(token) == 6) {
		k = token;
		n = "endrem";
		while (i++ < 6) {
			if (*k++ != *n++) return false;
		}
		return true;
	}
	
	// end rem
	if (strlen(token) == 7) {
		k = token;
		n = "end rem";
		while (i++ < 7) {
			if (*k++ != *n++) return false;
		}
		return true;
	}
	return false;
}

// An individual named option for use in an OptionSet

// Options used for LexerMax
struct OptionsBasic {
	bool fold;
	bool foldSyntaxBased;
	bool foldCommentExplicit;
	std::string foldExplicitStart;
	std::string foldExplicitEnd;
	bool foldExplicitAnywhere;
	bool foldCompact;
	OptionsBasic() {
		fold = false;
		foldSyntaxBased = true;
		foldCommentExplicit = false;
		foldExplicitStart = "";
		foldExplicitEnd   = "";
		foldExplicitAnywhere = false;
		foldCompact = true;
	}
};

static const char * const blitzmaxWordListDesc[] = {
	"BlitzMax Keywords",
	"user1",
	0
};

struct OptionSetBasic : public OptionSet<OptionsBasic> {
	OptionSetBasic(const char * const wordListDescriptions[]) {
		DefineProperty("fold", &OptionsBasic::fold);

		DefineProperty("fold.basic.syntax.based", &OptionsBasic::foldSyntaxBased,
			"Set this property to 0 to disable syntax based folding.");

		DefineProperty("fold.basic.comment.explicit", &OptionsBasic::foldCommentExplicit,
			"This option enables folding explicit fold points when using the Basic lexer. "
			"Explicit fold points allows adding extra folding by placing a ;{ (BB/PB) or '{ (FB) comment at the start "
			"and a ;} (BB/PB) or '} (FB) at the end of a section that should be folded.");

		DefineProperty("fold.basic.explicit.start", &OptionsBasic::foldExplicitStart,
			"The string to use for explicit fold start points, replacing the standard ;{ (BB/PB) or '{ (FB).");

		DefineProperty("fold.basic.explicit.end", &OptionsBasic::foldExplicitEnd,
			"The string to use for explicit fold end points, replacing the standard ;} (BB/PB) or '} (FB).");

		DefineProperty("fold.basic.explicit.anywhere", &OptionsBasic::foldExplicitAnywhere,
			"Set this property to 1 to enable explicit fold points anywhere, not just in line comments.");

		DefineProperty("fold.compact", &OptionsBasic::foldCompact);

		DefineWordListSets(wordListDescriptions);
	}
};

class LexerMax : public ILexer {
	char comment_char;
	int (*CheckFoldPoint)(char const *, int &);
	WordList keywordlists[2];
	OptionsBasic options;
	OptionSetBasic osBasic;
public:
	LexerMax(char comment_char_, int (*CheckFoldPoint_)(char const *, int &), const char * const wordListDescriptions[]) :
	           comment_char(comment_char_),
	           CheckFoldPoint(CheckFoldPoint_),
	           osBasic(wordListDescriptions) {
	}
	virtual ~LexerMax() {
	}
	void SCI_METHOD Release() {
		delete this;
	}
	int SCI_METHOD Version() const {
		return lvOriginal;
	}
	const char * SCI_METHOD PropertyNames() {
		return osBasic.PropertyNames();
	}
	int SCI_METHOD PropertyType(const char *name) {
		return osBasic.PropertyType(name);
	}
	const char * SCI_METHOD DescribeProperty(const char *name) {
		return osBasic.DescribeProperty(name);
	}
	int SCI_METHOD PropertySet(const char *key, const char *val);
	const char * SCI_METHOD DescribeWordListSets() {
		return osBasic.DescribeWordListSets();
	}
	int SCI_METHOD WordListSet(int n, const char *wl);
	void SCI_METHOD Lex(unsigned int startPos, int length, int initStyle, IDocument *pAccess);
	void SCI_METHOD Fold(unsigned int startPos, int length, int initStyle, IDocument *pAccess);

	void * SCI_METHOD PrivateCall(int, void *) {
		return 0;
	}
	static ILexer *LexerFactoryBlitzMax() {
		return new LexerMax('\'', CheckBMFoldPoint, blitzmaxWordListDesc);
	}
};

int SCI_METHOD LexerMax::PropertySet(const char *key, const char *val) {
	if (osBasic.PropertySet(&options, key, val)) {
		return 0;
	}
	return -1;
}

int SCI_METHOD LexerMax::WordListSet(int n, const char *wl) {
	WordList *wordListN = 0;
	switch (n) {
	case 0:
		wordListN = &keywordlists[0];
		break;
	case 1:
		wordListN = &keywordlists[1];
		break;
	}
	int firstModification = -1;
	if (wordListN) {
		WordList wlNew;
		wlNew.Set(wl);
		if (*wordListN != wlNew) {
			wordListN->Set(wl);
			firstModification = 0;
		}
	}
	return firstModification;
}

void SCI_METHOD LexerMax::Lex(unsigned int startPos, int length, int initStyle, IDocument *pAccess) {
	LexAccessor styler(pAccess);

	StyleContext sc(startPos, length, initStyle, styler);

	int endPos = startPos + length;
	char word[256];
	

	for (; sc.More(); sc.Forward()) {


		// Determine if the current state should terminate.
		switch (sc.state) {
			case SCE_B_OPERATOR:
				sc.SetState(SCE_B_DEFAULT);
				break;
			case SCE_B_COMMENT:
				if (sc.atLineEnd) {
					sc.SetState(SCE_B_DEFAULT);
				}
				break;
			case SCE_B_NUMBER:
				if (!IsDigit(sc.ch)) {
					sc.SetState(SCE_B_DEFAULT);
				}
				break;
			case SCE_B_HEXNUMBER:
				if (!IsHexDigit(sc.ch)) {
					sc.SetState(SCE_B_DEFAULT);
				}
				break;
			case SCE_B_STRING:
				if (sc.ch == '"') {
					sc.ForwardSetState(SCE_B_DEFAULT);
				}
				if (sc.atLineEnd) {
					sc.ChangeState(SCE_B_ERROR);
					sc.SetState(SCE_B_DEFAULT);
				}
				break;
			case SCE_B_IDENTIFIER:
				if (!IsIdentifier(sc.ch)) {
					char s[100];
					int kstates[2] = {
						SCE_B_KEYWORD,
						SCE_B_KEYWORD2
					};
					sc.GetCurrentLowered(s, sizeof(s));
    				if (strcmp(s, "rem") == 0) {
	   				    sc.ChangeState(SCE_B_COMMENTREM);
	                } else {
						for (int i = 0; i < 2; i++) {
							if (keywordlists[i].InList(s)) {
								sc.ChangeState(kstates[i]);
								break;
							}
						}
						sc.SetState(SCE_B_DEFAULT);
					}
				}
				break;
			case SCE_B_COMMENTREM:
				// check if this line has endrem or end rem... indicating finish of rem block
				if (sc.atLineStart) {
					bool go;
					int wordlen = 0;
					for (int i = sc.currentPos; i < endPos; i++) {
						int c = styler.SafeGetCharAt(i);

						if (wordlen) { // are we scanning a token already?
							word[wordlen] = static_cast<char>(LowerCase(c));
							if (!IsIdentifier(c)) { // done with token
								if (wordlen > 8) {
									break;
								}
								word[wordlen] = '\0';
								go = CheckBMEndRem(word);
								if (!go) {
									// skip linebreaks..
									if (c == '\n' || c == '\r') {
									  wordlen = 0;
									  continue;
									}
									// Treat any whitespace as single blank, for
									// things like "End   Function".
									if (IsSpace(c) && IsIdentifier(word[wordlen - 1])) {
										word[wordlen] = ' ';
										if (wordlen < 255)
											wordlen++;
									}
									else {  // done with this line
										break;
									}
								} else {
									sc.Forward(i - sc.currentPos);
									sc.SetState(SCE_B_DEFAULT);
									break;
								}
							} else if (wordlen < 255) {
								wordlen++;
							}
						} else { // start scanning at first non-whitespace character
							if (!IsSpace(c)) {
								if (IsIdentifier(c)) {
									word[0] = static_cast<char>(LowerCase(c));
									wordlen = 1;
								} else // done with this line
									break;
							}
						}
					}
				}
				break;
		}


		// Determine if a new state should be entered.
		if (sc.state == SCE_B_DEFAULT || sc.state == SCE_B_ERROR) {
			if (sc.Match("'")) {
				sc.SetState(SCE_B_COMMENT);
				sc.Forward();
			} else if (sc.Match('"')) {
				sc.SetState(SCE_B_STRING);
			} else if (IsADigit(sc.ch)) {
				sc.SetState(SCE_B_NUMBER);
			} else if (sc.Match('$') && IsHexDigit(sc.chNext)) {
				sc.SetState(SCE_B_HEXNUMBER);
				sc.Forward();
			} else if (IsWordStart(sc.ch)) {
				sc.SetState(SCE_B_IDENTIFIER);
			} else if (isoperator(static_cast<char>(sc.ch))) {
				sc.SetState(SCE_B_OPERATOR);
				if (sc.ch == '.' && sc.chNext == '.') sc.Forward(); // Range operator
			}
		}
	}

	sc.Complete();
}


void SCI_METHOD LexerMax::Fold(unsigned int startPos, int length, int /* initStyle */, IDocument *pAccess) {

	if (!options.fold)
		return;

	LexAccessor styler(pAccess);

	int line = styler.GetLine(startPos);
	int level = styler.LevelAt(line);
	int go = 0, done = 0;
	int endPos = startPos + length;
	char word[256];
	int wordlen = 0;
	const bool userDefinedFoldMarkers = !options.foldExplicitStart.empty() && !options.foldExplicitEnd.empty();
	int cNext = styler[startPos];

	// Scan for tokens at the start of the line (they may include
	// whitespace, for tokens like "End Function"
	for (int i = startPos; i < endPos; i++) {
		int c = cNext;
		cNext = styler.SafeGetCharAt(i + 1);
		bool atEOL = (c == '\r' && cNext != '\n') || (c == '\n');
		if (options.foldSyntaxBased && !done && !go) {
			if (wordlen) { // are we scanning a token already?
				word[wordlen] = static_cast<char>(LowerCase(c));
				if (!IsIdentifier(c)) { // done with token
					word[wordlen] = '\0';
					go = CheckFoldPoint(word, level);
					if (!go) {
						// Treat any whitespace as single blank, for
						// things like "End   Function".
						if (IsSpace(c) && IsIdentifier(word[wordlen - 1])) {
							word[wordlen] = ' ';
							if (wordlen < 255)
								wordlen++;
						}
						else // done with this line
							done = 1;
					}
				} else if (wordlen < 255) {
					wordlen++;
				}
			} else { // start scanning at first non-whitespace character
				if (!IsSpace(c)) {
					if (IsIdentifier(c)) {
						word[0] = static_cast<char>(LowerCase(c));
						wordlen = 1;
					} else // done with this line
						done = 1;
				}
			}
		}
		if (options.foldCommentExplicit && ((styler.StyleAt(i) == SCE_B_COMMENT) || options.foldExplicitAnywhere)) {
			if (userDefinedFoldMarkers) {
				if (styler.Match(i, options.foldExplicitStart.c_str())) {
 					level |= SC_FOLDLEVELHEADERFLAG;
					go = 1;
				} else if (styler.Match(i, options.foldExplicitEnd.c_str())) {
 					go = -1;
 				}
			} else {
				if (c == comment_char) {
					if (cNext == '{') {
						level |= SC_FOLDLEVELHEADERFLAG;
						go = 1;
					} else if (cNext == '}') {
						go = -1;
					}
				}
 			}
 		}
		if (atEOL) { // line end
			if (!done && wordlen == 0 && options.foldCompact) // line was only space
				level |= SC_FOLDLEVELWHITEFLAG;
			if (level != styler.LevelAt(line))
				styler.SetLevel(line, level);
			level += go;
			line++;
			// reset state
			wordlen = 0;
			level &= ~SC_FOLDLEVELHEADERFLAG;
			level &= ~SC_FOLDLEVELWHITEFLAG;
			go = 0;
			done = 0;
		}
	}
}

LexerModule lmBlitzMax(wxSCI_LEX_BLITZMAX, LexerMax::LexerFactoryBlitzMax, "blitzmax", blitzmaxWordListDesc);
